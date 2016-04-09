//
//  SignInListController.m
//  studentDriving
//
//  Created by 大威 on 16/1/8.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SignInListController.h"
#import "SignInViewModel.h"
#import "SignInDataModel.h"
#import "SignInViewController.h"
#import "SignInListCell.h"
#import "MJRefresh.h"

@interface SignInListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SignInViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SignInListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"今天的预约";
    
    [self.view addSubview:self.tableView];
    _tableView.backgroundColor = [UIColor whiteColor];
    
//    [self configViewModel];
//    [self configRefresh];
}

#pragma mark - config ViewModel
//- (void)configViewModel {
//    
//    _viewModel = [SignInViewModel new];
//    __weak typeof(self) ws = self;
//    [_viewModel dvvSetRefreshSuccessBlock:^{
//        
//        [MBProgressHUD hideHUDForView:ws.view animated:YES];
//        [ws.tableView.mj_header endRefreshing];
//        [ws.tableView reloadData];
//    }];
//    [_viewModel dvvSetRefreshErrorBlock:^{
//        [MBProgressHUD hideHUDForView:ws.view animated:YES];
//        [ws showTotasViewWithMes:@"加载失败"];
//    }];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    // 请求网络数据
//    [_viewModel dvvNetworkRequestRefresh];
//}
//
//#pragma mark - config refresh
//- (void)configRefresh {
//    
//    // 刷新
//    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [_viewModel dvvNetworkRequestRefresh];
//    }];
//    
//    self.tableView.mj_header = refreshHeader;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _viewModel.todayArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"kCell";
    
    SignInListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[SignInListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    SignInDataModel *dataModel = _viewModel.todayArray[indexPath.row];
    cell.coachNameLabel.text = dataModel.coachDataModel.name;
    cell.beginTimeLabel.text = [NSString stringWithFormat:@"%@-%@", dataModel.beginTime, dataModel.endTime];
//    cell.beginTimeLabel.text = @"12:00:00";
    cell.markLabel.text = dataModel.courseProcessDesc;
    if (dataModel.signInStatus) {
        cell.signInStatusLabel.text = @"可签到";
    }else {
        cell.signInStatusLabel.text = @"不可签到";
    }
    
    return cell;
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

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.frame = self.view.frame;
        _tableView.tableFooterView = [UIView new];
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
