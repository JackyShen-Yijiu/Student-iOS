//
//  ExchangeRecordController.m
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZExchangeRecordController.h"
#import "JZExchangeRecordCell.h"

#import <MJRefresh/MJRefresh.h>
#import "JZRecordDetailController.h"


@interface JZExchangeRecordController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;


@property (nonatomic,strong) MJRefreshHeader *header;

@end

@implementation JZExchangeRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换记录";
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self.view addSubview:self.tableView];
    [self configViewModel];
    [self configRefresh];
}
- (void)viewWillAppear:(BOOL)animated{
    [self beginRefresh];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 122;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDexchange = @"ecchangeID";
    JZExchangeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:IDexchange];
    if (!cell) {
        cell = [[JZExchangeRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDexchange];
    }
    cell.recordModel = _viewModel.dataArray[indexPath.row];
    return cell;
}
#pragma mark - config refresh
- (void)configRefresh {
    
    __weak typeof(self) ws = self;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
                [ws.viewModel dvv_networkRequestRefresh];
            
        }];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
            [ws.viewModel dvv_networkRequestLoadMore];
        
    }];
    _tableView.mj_header = header;
    _tableView.mj_footer = footer;
    
}

#pragma mark - config view model
- (void)configViewModel {
    
    __weak typeof(self) ws = self;
    _viewModel= [JZRecordViewModel new];
    
    [_viewModel dvv_setRefreshSuccessBlock:^{
//        [ws.noDataPromptView remove];
        [ws.tableView reloadData];
    }];
    [_viewModel dvv_setLoadMoreSuccessBlock:^{
//        [ws.noDataPromptView remove];
        [ws.tableView reloadData];
    }];
    [_viewModel dvv_setNilResponseObjectBlock:^{
        if (ws.viewModel.dataArray.count) {
            [ws obj_showTotasViewWithMes:@"已经全部加载完毕"];
            ws.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        }else {
        //            [ws.tableView addSubview:self.noDataPromptView];
        }
    }];
    [_viewModel dvv_setNetworkCallBackBlock:^{
        [ws.tableView.mj_header endRefreshing];
        [ws.tableView.mj_footer endRefreshing];
        
    }];
    [_viewModel dvv_setNetworkErrorBlock:^{
//            [ws.tableView addSubview:ws.noDataPromptView];
        [ws obj_showTotasViewWithMes:@"网络错误"];
    }];
}
#pragma mark - public

- (void)beginRefresh {
    
    // 当刷新时，刷新下数据，避免驾校和教练切换时，点击cell崩溃
    [self.tableView reloadData];
    
    
    // 开始请求数据
//    [self.noDataPromptView remove];
        [_viewModel dvv_networkRequestRefresh];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JZRecordDetailController *recordDetailVC = [[JZRecordDetailController alloc] init];
    recordDetailVC.recordModel  = _viewModel.dataArray[indexPath.row];
    if (_isFormallOrder) {
        [self.pareVC.navigationController pushViewController:recordDetailVC animated:YES];
    }else{
        [self.navigationController pushViewController:recordDetailVC animated:YES];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }
#pragma mark --- Lazy加载
- (UITableView *)tableView
{
    if (_tableView == nil ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , kSystemHeight - 64) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
