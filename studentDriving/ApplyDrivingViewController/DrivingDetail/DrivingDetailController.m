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
#import "DrivingDetailBriefIntroductionCell.h"
#import "DrivingDetailTrainingGroundCell.h"
#import "DrivingDetailSignUpCell.h"
#import "DrivingDetailViewModel.h"

#import "ShuttleBusController.h"
#import "CoachListController.h"
#import "DVVToast.h"

#import "SchoolClassDetailController.h"
#import "SignUpController.h"
#import "serverclasslistModel.h"
#import "YBAPPMacro.h"
#import "DrivingDetailTableHeaderView.h"
#import "DrivingDetailLocationCell.h"

@interface DrivingDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) DrivingDetailTableHeaderView *tableHeaderView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) __block BOOL isShowMore;

@property (nonatomic, strong) DrivingDetailViewModel *viewModel;

// 这个要动态调高度，放里面不好动态调  而且也没有复用性   所以放这里
@property (nonatomic, strong) DrivingDetailAddressCell *addressCell;
@property (nonatomic, strong) DrivingDetailSignUpCell *signUpCell;
@property (nonatomic, strong) DrivingDetailBriefIntroductionCell *introductionCell;

@end

@implementation DrivingDetailController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = NO;
    self.title = @"驾校详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@", _schoolID);

    // 测试时打开
//    _schoolID = @"562dcc3ccb90f25c3bde40da";
    
    [self.view addSubview:self.tableView];
    
    [self configViewModel];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - config view model
- (void)configViewModel {
    
    _viewModel = [DrivingDetailViewModel new];
    _viewModel.schoolID = _schoolID;
    __weak typeof(self) ws = self;
    [_viewModel dvvSetRefreshSuccessBlock:^{
        [ws.tableView reloadData];
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
        [ws obj_showTotasViewWithMes:@"加载失败"];
    }];
    
    [_viewModel dvvSetNilResponseObjectBlock:^{
        [ws obj_showTotasViewWithMes:@"没有数据"];
    }];
    [_viewModel dvvSetNetworkErrorBlock:^{
        [ws obj_showTotasViewWithMes:@"网络错误"];
    }];
    [_viewModel dvvSetNetworkCallBackBlock:^{
        [DVVToast hideFromView:ws.tableView];
    }];
    
    [DVVToast showFromView:self.tableView];
    [_viewModel dvvNetworkRequestRefresh];
}

#pragma mark - action

#pragma mark 更多教练
- (void)allCoachInSchoolAction:(UIButton *)sender {
    
    if (sender.tag) {
        return ;
    }
    CoachListController *coachListVC = [CoachListController new];
    coachListVC.schoolID = _schoolID;
    [self.navigationController pushViewController:coachListVC animated:YES];
}
#pragma mark 班型cell单击事件
- (void)classTypeCellDidSelectAction:(ClassTypeDMData *)dmData {
    SchoolClassDetailController *schoolClassDetailVC = [[SchoolClassDetailController alloc] init];
    schoolClassDetailVC.classTypeDMData = dmData;
    [self.navigationController pushViewController:schoolClassDetailVC animated:YES];
}
#pragma mark 班型cell中的报名按钮单击事件
- (void)signInButtonAction:(ClassTypeDMData *)dmData {
    if ([[AcountManager manager].userApplystate isEqualToString:@"0"]) {
        SignUpController *signUpVC = [[SignUpController alloc] init];
        serverclasslistModel *classlistModel = [[serverclasslistModel alloc] init];
        classlistModel.price = dmData.price;
        classlistModel._id = dmData.calssid;
        signUpVC.signUpFormDetail = SignUpFormSchoolDetail;
        signUpVC.classTypeDMDataModel = dmData;
        signUpVC.serverclasslistModel = classlistModel;
        [self.navigationController pushViewController:signUpVC animated:YES];
    }else if ([[AcountManager manager].userApplystate isEqualToString:@"1"]){
        [self obj_showTotasViewWithMes:@"报名正在申请中!"];
    }else if ([[AcountManager manager].userApplystate isEqualToString:@"2"]){
        [self obj_showTotasViewWithMes:@"您已经报过名!"];
    }
    
}
#pragma mark 教练cell的点击事件
- (void)coachListViewCellDidSelectAction:(CoachListDMData *)dmData {
    
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel.dmData) {
        return 5;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (0 == indexPath.row) {
        return [DrivingDetailLocationCell defaultHeight];
    }else if (1 == indexPath.row){
        // 驾校信息
        return [DrivingDetailInfoCell defaultHeight];
    }else if (2 == indexPath.row) {
        // 驾校简介
        return [DrivingDetailBriefIntroductionCell dynamicHeight:_viewModel.dmData.introduction isShowMore:_isShowMore];
    }else if (3 == indexPath.row) {
        // 训练场
        return [DrivingDetailTrainingGroundCell dynamicHeight:_viewModel.dmData];
    }else {
        // 报名（班型和教练信息）
        return [self.signUpCell dynamicHeight];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row) {
        DrivingDetailLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kLocationCell"];
        if (!cell) {
            cell = [[DrivingDetailLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kLocationCell"];
        }
        [cell refreshData:_viewModel.dmData];
        return cell;
    }
    // 驾校信息
    if (1 == indexPath.row) {
        DrivingDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kInfoCell"];
        if (!cell) {
            cell = [[DrivingDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kInfoCell"];
        }
        [cell refreshData:_viewModel.dmData];
        return cell;
    }
    // 驾校简介
    if (2 == indexPath.row) {
        
        [self.introductionCell refreshData:_viewModel.dmData];
        return _introductionCell;
    }
    // 训练场
    if (3 == indexPath.row) {
        DrivingDetailTrainingGroundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kTrainingCell"];
        if (!cell) {
            cell = [[DrivingDetailTrainingGroundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kTrainingCell"];
        }
        [cell refreshData:_viewModel.dmData];
        return cell;
    }
    // 报名（班型和教练信息）
    return self.signUpCell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 49 - 64);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UITableView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.tableHeaderView = self.tableHeaderView;
    }
    return _tableView;
}

- (DrivingDetailTableHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [DrivingDetailTableHeaderView new];
        _tableHeaderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [DrivingDetailTableHeaderView defaultHeight]);
        _tableHeaderView.schoolID = _schoolID;
    }
    return _tableHeaderView;
}

- (DrivingDetailBriefIntroductionCell *)introductionCell {
    if (!_introductionCell) {
        _introductionCell = [[DrivingDetailBriefIntroductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kIntroCell"];
        __weak typeof(self) ws = self;
        [_introductionCell setShowMoreButtonTouchDownBlock:^(BOOL isShowMore) {
            
            ws.isShowMore = isShowMore;
            [ws.tableView reloadData];
            
//            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:3 inSection:0];
//            [ws.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    return _introductionCell;
}

- (DrivingDetailSignUpCell *)signUpCell {
    if (!_signUpCell) {
        _signUpCell = [[DrivingDetailSignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kSignUpCell"];
        __weak typeof(self) ws = self;
        [_signUpCell.classTypeView setClassTypeSignUpButtonActionBlock:^(ClassTypeDMData *dmData) {
            [ws signInButtonAction:dmData];
        }];
        [_signUpCell.classTypeView setClassTypeViewCellDidSelectBlock:^(ClassTypeDMData *dmData) {
            [ws classTypeCellDidSelectAction:dmData];
        }];
        [_signUpCell.coachListView setCoachListViewCellDidSelectBlock:^(CoachListDMData *dmData) {
            [ws coachListViewCellDidSelectAction:dmData];
        }];
        [_signUpCell.coachListView.bottomButton addTarget:self action:@selector(allCoachInSchoolAction:) forControlEvents:UIControlEventTouchUpInside];
        _signUpCell.tableView = self.tableView;
        _signUpCell.schoolID = _schoolID;
    }
    return _signUpCell;
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
