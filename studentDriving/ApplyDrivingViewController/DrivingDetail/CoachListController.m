//
//  CoachListController.m
//  studentDriving
//
//  Created by 大威 on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "CoachListController.h"
#import "CoachListCell.h"
#import "MJRefresh.h"
#import "CoachListViewModel.h"

#define kCellID @"kCoachListCell"

@interface CoachListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CoachListViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CoachListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"教练列表";
    [self.view addSubview:self.tableView];
    [self configRefresh];
    [self configViewModel];
}

#pragma mark - config view model
- (void)configViewModel {
    
    _viewModel = [CoachListViewModel new];
    _viewModel.schoolID = _schoolID;
    __weak typeof(self) ws = self;
    [_viewModel dvvSetRefreshSuccessBlock:^{
        [ws.tableView reloadData];
    }];
    [_viewModel dvvSetLoadMoreSuccessBlock:^{
        [ws.tableView reloadData];
    }];
    [_viewModel dvvSetNilResponseObjectBlock:^{
        [self obj_showTotasViewWithMes:@"没有数据啦"];
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
        [self obj_showTotasViewWithMes:@"数据加载失败"];
    }];
    [_viewModel dvvSetLoadMoreErrorBlock:^{
        [self obj_showTotasViewWithMes:@"数据加载失败"];
    }];
    [_viewModel dvvSetNetworkErrorBlock:^{
        [self obj_showTotasViewWithMes:@"网络错误"];
    }];
    [_viewModel dvvSetNetworkCallBackBlock:^{
        [ws.tableView.mj_header endRefreshing];
        [ws.tableView.mj_footer endRefreshing];
    }];
    [_viewModel dvvNetworkRequestRefresh];
}

#pragma mark - config refresh
- (void)configRefresh {
    
    __weak typeof(self) ws = self;
    // 刷新
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws.viewModel dvvNetworkRequestRefresh];
    }];
    // 加载
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [ws.viewModel dvvNetworkRequestLoadMore];
    }];
    
    _tableView.mj_header = refreshHeader;
    _tableView.mj_footer = refreshFooter;

}

#pragma mark tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CoachListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    [cell refreshData:_viewModel.dataArray[indexPath.row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (1 == _type) {
        CoachListDMData *dmData = _viewModel.dataArray[indexPath.row];
        _complaintCoachNameLabel.text = dmData.name;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = self.view.bounds;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 95;
        _tableView.tableFooterView = [UITableView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[CoachListCell class] forCellReuseIdentifier:kCellID];
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
