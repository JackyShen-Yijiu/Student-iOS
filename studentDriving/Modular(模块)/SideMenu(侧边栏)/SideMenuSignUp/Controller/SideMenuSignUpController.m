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
#import "ShowWarningBG.h"
#import "SignInViewController.h"
#import "DVVNoDataPromptView.h"

@interface SideMenuSignUpController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) SignInViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DVVNoDataPromptView *DvvView;
@end

@implementation SideMenuSignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今天的预约";
    self.view.backgroundColor = RGBColor(249, 249, 249);
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *lineFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.3)];
    lineFooterView.backgroundColor = HM_LINE_COLOR ;
    self.tableView.tableFooterView = lineFooterView;
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self configViewModel];
    [self configRefresh];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}


#pragma mark - config ViewModel
- (void)configViewModel {
    
    _viewModel = [SignInViewModel new];
    __weak typeof(self) ws = self;
    // 请求到数据的回调
    [_viewModel dvv_setRefreshSuccessBlock:^{
        [ws.tableView reloadData];
    }];
    // 服务器返回的数据为空时的回调
    [_viewModel dvv_setNilResponseObjectBlock:^{
        self.DvvView = [[DVVNoDataPromptView alloc] initWithTitle:@"没有找到您的预约信息" image:[UIImage imageNamed:@"YBNocountentimage_sign"] subTitle:nil];
        [self.view addSubview:self.DvvView];
    }];
    // 网络成功或错误都调用的回调 (一般在这里隐藏HUD)
    [_viewModel dvv_setNetworkCallBackBlock:^{
        [MBProgressHUD hideHUDForView:ws.view animated:YES];
        [ws.tableView.mj_header endRefreshing];
        [ws.tableView.mj_footer endRefreshing];
    }];
    // 网络错误回调
    [_viewModel dvv_setNetworkErrorBlock:^{
        [ws showTotasViewWithMes:@"网络错误"];
    }];
    
    // 开始请求网络数据
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_viewModel dvv_networkRequestRefresh];
    
}

#pragma mark - config refresh
- (void)configRefresh {
    
    __weak typeof(self) ws = self;
    // 刷新
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws.viewModel dvv_networkRequestRefresh];
    }];
    
    self.tableView.mj_header = refreshHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _viewModel.todayArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SignInDataModel *dataModel = _viewModel.todayArray[indexPath.row];
    
    if (!dataModel.signInStatus) {
        [self showTotasViewWithMes:@"请在规定的时间内签到"];
        return ;
    }
    SignInViewController *vc = [SignInViewController new];
    vc.dataModel = dataModel;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
