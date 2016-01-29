//
//  DrivingDetailController.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailController.h"
#import "DrivingDetailAddressCell.h"
#import "DrivingDetailInfoCell.h"
#import "DrivingDetailShuttleBusCell.h"
#import "DrivingDetailBriefIntroductionCell.h"
#import "DrivingDetailTrainingGroundCell.h"
#import "DrivingDetailSignUpCell.h"
#import "DrivingDetailViewModel.h"

@interface DrivingDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isShowMore;

@property (nonatomic, strong) DrivingDetailViewModel *viewModel;

@end

@implementation DrivingDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"驾校详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    [self configViewModel];
}

#pragma mark - config view model
- (void)configViewModel {
    
    _viewModel = [DrivingDetailViewModel new];
    [_viewModel dvvSetRefreshSuccessBlock:^{
        
        [_tableView reloadData];
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
        [self obj_showTotasViewWithMes:@"加载失败"];
    }];
    
    [_viewModel dvvSetNilResponseObjectBlock:^{
        [self obj_showTotasViewWithMes:@"没有数据"];
    }];
    [_viewModel dvvSetNetworkErrorBlock:^{
        [self obj_showTotasViewWithMes:@"网络错误"];
    }];
    
    [_viewModel dvvNetworkRequestRefresh];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel.dmData) {
        return 2;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        // 地址和名称
        return [DrivingDetailAddressCell defaultHeight];
    }else if (1 == indexPath.row){
        // 驾校信息
        return [DrivingDetailInfoCell defaultHeight];
    }else if (2 == indexPath.row) {
        // 班车路线
        return [DrivingDetailShuttleBusCell dynamicHeight:@"用于计算动态高度的内容"];
    }else if (3 == indexPath.row) {
        // 驾校简介
        
    }else if (4 == indexPath.row) {
        // 训练场
    }else if (5 == indexPath.row) {
        // 报名（班型和教练信息）
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        DrivingDetailAddressCell *cell = [[DrivingDetailAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kAddressCell"];
        [cell refreshData:_viewModel.dmData];
        return cell;
    }
    if (1 == indexPath.row) {
        DrivingDetailInfoCell *cell = [[DrivingDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kInfoCell"];
        [cell refreshData:_viewModel.dmData];
        return cell;
    }
    if (2 == indexPath.row) {
        DrivingDetailShuttleBusCell *cell = [[DrivingDetailShuttleBusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kShuttleBusCell"];
        [cell refreshData:_viewModel.dmData];
        return cell;
    }
    return nil;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = self.view.bounds;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UITableView new];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
