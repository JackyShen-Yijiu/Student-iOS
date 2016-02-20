//
//  SideMenuSignUpController.m
//  studentDriving
//
//  Created by zyt on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SideMenuSignUpController.h"
#import "SideMenuSignUpCell.h"
#import "MJRefresh.h"
#import "SignInViewModel.h"
#import "SignInDataModel.h"

@interface SideMenuSignUpController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) SignInViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SideMenuSignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今天的预约";
    self.view.backgroundColor = RGBColor(234, 234, 234);
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *lineFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    lineFooterView.backgroundColor = [UIColor colorWithHexString:@"bdbdbd"];
    self.tableView.tableFooterView = lineFooterView;
    [self configViewModel];
    [self configRefresh];
}

#pragma mark - config ViewModel
- (void)configViewModel {
    
    _viewModel = [SignInViewModel new];
    __weak typeof(self) ws = self;
    [_viewModel dvvSetRefreshSuccessBlock:^{
        
        [MBProgressHUD hideHUDForView:ws.view animated:YES];
        [ws.tableView.mj_header endRefreshing];
        [ws.tableView reloadData];
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
        [MBProgressHUD hideHUDForView:ws.view animated:YES];
        [ws showTotasViewWithMes:@"加载失败"];
    }];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // 请求网络数据
    [_viewModel dvvNetworkRequestRefresh];
}

#pragma mark - config refresh
- (void)configRefresh {
    
    // 刷新
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_viewModel dvvNetworkRequestRefresh];
    }];
    
    self.tableView.mj_header = refreshHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _viewModel.todayArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"signUpID";
    SideMenuSignUpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SideMenuSignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    SignInDataModel *dataModel = _viewModel.todayArray[indexPath.row];
    cell.dataModel = dataModel;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
@end
