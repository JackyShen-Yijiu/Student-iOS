//
//  DVVAppointmentController.m
//  studentDriving
//
//  Created by 大威 on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointmentListController.h"
#import "YBAppointmentHeaderView.h"
#import "YBAppointmentSectionHeaderView.h"
#import "YBAppointmentListCell.h"
#import "YBCompletedAppointmentListController.h"
#import "YBAppointmentListViewModel.h"
#import "DVVToast.h"

static NSString *kSectionHeaderIdentifier = @"kHeaderIdentifier";
static NSString *kCellIdentifier = @"kCellIdentifier";

@interface YBAppointmentListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) YBAppointmentListViewModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YBAppointmentHeaderView *headerView;
@property (nonatomic, strong) YBAppointmentSectionHeaderView *footerView;

@property (nonatomic, assign) BOOL isShowTodayAppointment;
@property (nonatomic, assign) BOOL isShowNextAppointment;

@end

@implementation YBAppointmentListController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约列表";
    self.edgesForExtendedLayout = NO;
    
    _isShowTodayAppointment = YES;
    _isShowNextAppointment = YES;
    
    [self.view addSubview:self.tableView];
    
    [self configViewModel];
}


#pragma mark - action

#pragma mark 跳转到已完成的预约
- (void)completedAppointmentAction {
    
    YBCompletedAppointmentListController *vc = [YBCompletedAppointmentListController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sectionHeaderAction:(UIButton *)button {
    if (0 == button.tag) {
        _isShowTodayAppointment = !_isShowTodayAppointment;
        [_tableView reloadData];
    }else if (1 == button.tag) {
        _isShowNextAppointment = !_isShowNextAppointment;
        [_tableView reloadData];
    }
}

#pragma mark - config view model

- (void)configViewModel {
    
    _viewModel = [YBAppointmentListViewModel new];
    __weak typeof(self) ws = self;
    [_viewModel dvv_setRefreshSuccessBlock:^{
        [ws.tableView reloadData];
    }];
    
    [_viewModel dvv_setNilResponseObjectBlock:^{
//        [ws obj_showTotasViewWithMes:@"没有数据"];
    }];
    [_viewModel dvv_setNetworkErrorBlock:^{
//        [ws obj_showTotasViewWithMes:@"网络错误"];
    }];
    [_viewModel dvv_setNetworkCallBackBlock:^{
        [DVVToast hideFromView:ws.view];
    }];
    
    // 开始请求数据
    [DVVToast showFromView:ws.view OffSetY:-64];
    [_viewModel dvv_networkRequestRefresh];
}


#pragma mark - tableView delegate and data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (0 == section) {
        if (_isShowTodayAppointment) {
            return _viewModel.todayArray.count;
//            return 5;
        }else {
            return 0;
        }
    }else {
        if (_isShowNextAppointment) {
            return _viewModel.nextArray.count;
//            return 4;
        }else {
            return 0;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YBAppointmentSectionHeaderView *headerView = [[YBAppointmentSectionHeaderView alloc] initWithReuseIdentifier:kSectionHeaderIdentifier];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.button.tag = section;
    [headerView.button addTarget:self action:@selector(sectionHeaderAction:) forControlEvents:UIControlEventTouchUpInside];
    if (0 == section) {
        headerView.titleLabel.text = @"今日的预约";
        if (_viewModel.todayArray.count) {
            headerView.statusLabel.hidden = YES;
            headerView.arrowImageView.hidden = NO;
            headerView.button.userInteractionEnabled = YES;
        }else {
            headerView.statusLabel.hidden = NO;
            headerView.arrowImageView.hidden = YES;
            headerView.button.userInteractionEnabled = NO;
        }
        if (_isShowTodayAppointment) {
            headerView.arrowImageView.image = [UIImage imageNamed:@"more_down"];
        }else {
            headerView.arrowImageView.image = [UIImage imageNamed:@"more_right"];
        }
    }else if (1 == section) {
        headerView.titleLabel.text = @"未来的预约";
        if (_viewModel.nextArray.count) {
            headerView.statusLabel.hidden = YES;
            headerView.arrowImageView.hidden = NO;
            headerView.button.userInteractionEnabled = YES;
        }else {
            headerView.statusLabel.hidden = NO;
            headerView.arrowImageView.hidden = YES;
            headerView.button.userInteractionEnabled = NO;
        }
        if (_isShowNextAppointment) {
            headerView.arrowImageView.image = [UIImage imageNamed:@"more_down"];
        }else {
            headerView.arrowImageView.image = [UIImage imageNamed:@"more_right"];
        }
    }
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return  view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YBAppointmentListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (0 == indexPath.section) {
        // 隐藏最后一个cell的线
        if (indexPath.row == _viewModel.todayArray.count - 1) {
            cell.lineImageView.hidden = YES;
        }else {
            cell.lineImageView.hidden = NO;
        }
        [cell refreshData:_viewModel.todayArray[indexPath.row] appointmentTime:0];
    }else if (1 == indexPath.section) {
        if (indexPath.row == _viewModel.nextArray.count - 1) {
            cell.lineImageView.hidden = YES;
        }else {
            cell.lineImageView.hidden = NO;
        }
        [cell refreshData:_viewModel.nextArray[indexPath.row] appointmentTime:1];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        
        
    }else if (1 == indexPath.section) {
        
        
    }
}


#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, 0, kSystemWide, [UIScreen mainScreen].bounds.size.height - 64 - 49);
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YBAppointmentListCell class] forCellReuseIdentifier:kCellIdentifier];
        [_tableView registerClass:[YBAppointmentSectionHeaderView class] forHeaderFooterViewReuseIdentifier:kSectionHeaderIdentifier];
        
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.footerView;
    }
    return _tableView;
}

- (YBAppointmentHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [YBAppointmentHeaderView new];
        _headerView.frame = CGRectMake(0, 0, kSystemWide, 118);
    }
    return _headerView;
}

- (YBAppointmentSectionHeaderView *)footerView {
    if (!_footerView) {
        _footerView = [YBAppointmentSectionHeaderView new];
        _footerView.frame = CGRectMake(0, 0, kSystemWide, 44);
        _footerView.titleLabel.text = @"已完成的预约";
        [_footerView.button addTarget:self action:@selector(completedAppointmentAction) forControlEvents:UIControlEventTouchUpInside];
        _footerView.statusLabel.hidden = YES;
    }
    return _footerView;
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
