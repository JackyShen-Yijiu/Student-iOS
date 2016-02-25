//
//  DVVCoachDetailCommentListController.m
//  studentDriving
//
//  Created by 大威 on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachDetailCommentListController.h"
#import "DVVCoachCommentViewModel.h"
#import "DVVCoachCommentCell.h"
#import <MJRefresh/MJRefresh.h>
#import "DVVToast.h"

static NSString *kCellIdentifier = @"kCellIdentifier";

@interface DVVCoachDetailCommentListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) DVVCoachCommentViewModel *viewModel;


@end

@implementation DVVCoachDetailCommentListController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"评论列表";
    
    [self.view addSubview:self.tableView];
    
    [self configViewModel];
    [self configRefresh];
    
    _viewModel.coachID = _coachID;
    [DVVToast show];
    [_viewModel dvv_networkRequestRefresh];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [DVVToast hide];
}

#pragma mark - config

#pragma mark config refresh
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

#pragma mark config viewModel
- (void)configViewModel {
    
    _viewModel = [DVVCoachCommentViewModel new];
    
    __weak typeof(self) ws = self;
    [_viewModel dvv_setRefreshSuccessBlock:^{
        [ws.tableView reloadData];
    }];
    [_viewModel dvv_setLoadMoreSuccessBlock:^{
        [ws.tableView reloadData];
    }];
    [_viewModel dvv_setNilResponseObjectBlock:^{
        
        if (ws.viewModel.dataArray.count) {
            [ws obj_showTotasViewWithMes:@"已经全部加载完毕"];
            ws.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        }else {
            [ws obj_showTotasViewWithMes:@"暂无数据"];
        }
    }];
    [_viewModel dvv_setNetworkCallBackBlock:^{
        [DVVToast hide];
        [ws.tableView.mj_header endRefreshing];
        [ws.tableView.mj_footer endRefreshing];
    }];
    [_viewModel dvv_setNetworkErrorBlock:^{
        [ws obj_showTotasViewWithMes:@"网络错误"];
    }];
}

#pragma mark - tableView delegate and data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_viewModel.heightArray[indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DVVCoachCommentCell *cell = [[DVVCoachCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    
    [cell refreshData:_viewModel.dataArray[indexPath.row]];
    
    return cell;
}

#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = self.view.bounds;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DVVCoachCommentCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
