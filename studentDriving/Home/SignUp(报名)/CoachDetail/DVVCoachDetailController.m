//
//  DVVCoachDetailController.m
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachDetailController.h"
#import "DVVCoachDetailViewModel.h"
#import "DrivingDetailTableHeaderView.h"
#import "DVVToast.h"
#import "DVVSignUpToolBarView.h"
#import "DVVCoachDetailInfoCell.h"
#import "DVVCoachDetailIntroductionCell.h"
#import "DVVCoachDetailTagCell.h"
#import "DVVCoachDetailCourseCell.h"
#import "DVVCoachDetailHeaderView.h"
#import "ShuttleBusController.h"
#import "DrivingDetailViewModel.h"
#import "SchoolClassDetailController.h"
#import "DVVSignUpDetailController.h"
#import "DVVCoachDetailCommentListController.h"
#import "DVVNoDataPromptView.h"

static NSString *infoCellID = @"kInfoCellID";
static NSString *introductionCellID = @"kIntroductionCellID";
static NSString *tagCellID = @"kTagCellID";
static NSString *courseCellID = @"kCourseCellID";

@interface DVVCoachDetailController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    UIImageView*navBarHairlineImageView;
}

@property (nonatomic, strong) DVVCoachDetailHeaderView *headerView;

@property (nonatomic, strong) DVVCoachDetailViewModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DVVCoachDetailCourseCell *courseCell;

@property (nonatomic, strong) UIButton *shuttleBusButton;
@property (nonatomic, strong) UIButton *phoneButton;

@property (nonatomic, strong) DVVSignUpToolBarView *toolBarView;

@property (nonatomic, assign) BOOL isShowIntroduction;

@property (nonatomic, strong) DVVNoDataPromptView *noDataPromptView;

@property (nonatomic, assign) BOOL networkSuccess;

@end

@implementation DVVCoachDetailController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    self.title = @"教练详情";
    
    // 测试时打开此注释
//    _coachID = @"569d98e11a4e7c693a023499";
    
    // 添加有上角的班车和拨打电话
    [self addNaviRightButton];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];
    
    [self configViewModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    
    if (_networkSuccess) {
        [self naviTransparent];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden=NO;
    
    // 取消导航栏的透明效果
    [self naviCancelTransparent];
    
    [DVVToast hide];
}

#pragma mark 使导航栏透明
- (void)naviTransparent {
    
    UINavigationBar *bar = self.navigationController.navigationBar;
    // 背景色
    [bar setBackgroundColor:[UIColor clearColor]];
    // 背景图片
    [bar setBackgroundImage:[UIImage imageNamed:@"透明"] forBarMetrics:UIBarMetricsDefault];
    // 打开透明效果
    [bar setTranslucent:YES];
}
#pragma mark 取消导航栏透明
- (void)naviCancelTransparent {
    
    UINavigationBar *bar = self.navigationController.navigationBar;
    // 背景色
    [bar setBackgroundColor:YBNavigationBarBgColor];
    // 背景图片
    [bar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    // 去掉透明效果
    [bar setTranslucent:NO];
}

- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView*subview in view.subviews) {
        UIImageView*imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

#pragma mark - action

#pragma mark - 拨打电话
- (void)callPhone {
    if (_viewModel.dmData.mobile && _viewModel.dmData.mobile.length) {
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@", _viewModel.dmData.mobile];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:callWebview];
    }else {
        [self obj_showTotasViewWithMes:@"暂无电话信息"];
    }
}

#pragma mark 班车路线
- (void)shuttleBusButtonAction {
    
    ShuttleBusController *busVC = [ShuttleBusController new];
    DrivingDetailViewModel *viewModel = [DrivingDetailViewModel new];
    viewModel.schoolID = _viewModel.dmData.driveschoolinfo.ID;
    [viewModel dvvSetRefreshSuccessBlock:^{
        NSLog(@"%lu", viewModel.dmData.schoolbusroute.count);
        if (!viewModel.dmData.schoolbusroute || !viewModel.dmData.schoolbusroute.count) {
            [self obj_showTotasViewWithMes:@"暂无班车信息"];
        }else {
            busVC.dataArray = viewModel.dmData.schoolbusroute;
            [self.navigationController pushViewController:busVC animated:YES];
        }
    }];
    [viewModel dvvNetworkRequestRefresh];
}


#pragma mark 课程选择、评价信息切换
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    if (0 == index) {
        [_courseCell courseButtonAction];
    }else {
        [_courseCell commentButtonAction];
    }
}

#pragma mark 班型cell单击事件
- (void)classTypeCellDidSelectAction:(ClassTypeDMData *)dmData {
    SchoolClassDetailController *schoolClassDetailVC = [[SchoolClassDetailController alloc] init];
    schoolClassDetailVC.classTypeDMData = dmData;
    [self.navigationController pushViewController:schoolClassDetailVC animated:YES];
}
#pragma mark 班型cell中的报名按钮单击事件
- (void)signUpButtonAction:(ClassTypeDMData *)dmData {
    
    DVVSignUpDetailController *vc = [DVVSignUpDetailController new];
    vc.dmData = dmData;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark 更多评论按钮的点击事件
- (void)moreCommentAction {
    
//    [self obj_showTotasViewWithMes:@"暂无更多评论"];
    DVVCoachDetailCommentListController *vc = [DVVCoachDetailCommentListController new];
    vc.coachID = _viewModel.coachID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - config view model
- (void)configViewModel {
    
    __weak typeof(self) ws = self;
    _viewModel = [DVVCoachDetailViewModel new];
    _viewModel.coachID = _coachID;
    
    [_viewModel dvv_setRefreshSuccessBlock:^{
        
        _networkSuccess = YES;
        ws.tableView.backgroundColor = [UIColor whiteColor];
        // 使导航栏透明
        [self naviTransparent];
        
        ws.courseCell.classTypeView.coachID = ws.viewModel.dmData.coachid;
        ws.courseCell.classTypeView.coachName = ws.viewModel.dmData.name;
        
        [ws.tableView reloadData];
        [ws.headerView refreshData:ws.viewModel.dmData];
        [UIView animateWithDuration:0.3 animations:^{
            ws.headerView.alpha = 1;
        }];
    }];
    [_viewModel dvv_setNilResponseObjectBlock:^{
        [ws.view addSubview:ws.noDataPromptView];
//        [ws obj_showTotasViewWithMes:@"暂无数据"];
    }];
    [_viewModel dvv_setNetworkCallBackBlock:^{
        [DVVToast hide];
    }];
    [_viewModel dvv_setNetworkErrorBlock:^{
//        [ws obj_showTotasViewWithMes:@"网络错误"];
        [ws.view addSubview:ws.noDataPromptView];
    }];
    [DVVToast show];
    [_viewModel dvv_networkRequestRefresh];
}

#pragma mark - tableView delegate datasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_viewModel.dmData) {
        return 2;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 4;
    }else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (1 == section) {
        return 44;
    }else {
        return 1;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (1 == section) {
        return self.toolBarView;
    }else {
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row || 1 == indexPath.row) {
            if (0 == indexPath.row) {
                return [DVVCoachDetailInfoCell dynamicHeight:_viewModel.dmData type:0];
            }else {
                return [DVVCoachDetailInfoCell dynamicHeight:_viewModel.dmData type:1];
            }
        }else if (2 == indexPath.row) {
            return [DVVCoachDetailIntroductionCell dynamicHeight:_viewModel.dmData isShowMore:_isShowIntroduction];
        }else {
            return [DVVCoachDetailTagCell dynamicHeight:_viewModel.dmData];
        }
    }else {
        // 课程费用、教练信息
        return [self.courseCell dynamicHeight:_viewModel.dmData.serverclasslist];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row || 1 == indexPath.row) {
            DVVCoachDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
            if (1 == indexPath.row) {
                cell.tag = 1;
            }
            [cell refreshData:_viewModel.dmData];
            return cell;
        }
        if (2 == indexPath.row) {
            DVVCoachDetailIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:introductionCellID];
            
            [cell refreshData:_viewModel.dmData];
            return cell;
        }else {
            DVVCoachDetailTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellID];
            [cell refreshData:_viewModel.dmData];
            return cell;
        }
    }else {
        
        return _courseCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        if (2 == indexPath.row) {
            _isShowIntroduction = !_isShowIntroduction;
            [_tableView reloadData];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat centerY = [UIScreen mainScreen].bounds.size.width*0.7;
    CGFloat centerX = [UIScreen mainScreen].bounds.size.width - 16 - 63/2.f;
    CGFloat height = centerY;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    NSLog(@"_tableView.frame.origin.y: %f",  _tableView.frame.origin.y);
    if (offsetY > 0) {
        NSLog(@"offsetY大于0");
        
        if (_tableView.frame.origin.y > 0) {
            
            CGFloat originY = _tableView.frame.origin.y - offsetY;
            if (originY < 0) {
                _headerView.frame = CGRectMake(0, - height, _headerView.frame.size.width, _headerView.frame.size.height);
                _tableView.frame = CGRectMake(0, 0, _tableView.frame.size.width, _tableView.frame.size.height);
            }else {
                _headerView.frame = CGRectMake(0, _headerView.frame.origin.y - offsetY, _headerView.frame.size.width, _headerView.frame.size.height);
                _tableView.frame = CGRectMake(0, _tableView.frame.origin.y - offsetY, _tableView.frame.size.width, _tableView.frame.size.height);
                _tableView.contentOffset = CGPointMake(0, 0);
            }
        }
    }
    if (offsetY < 0 ) {
        NSLog(@"offsetY小于0");
        if (_tableView.frame.origin.y < height - 64) {
            
            CGFloat originY = _tableView.frame.origin.y - offsetY;
            if (originY > height - 64) {
                _headerView.frame = CGRectMake(0, -64, _headerView.frame.size.width, _headerView.frame.size.height);
                _tableView.frame = CGRectMake(0, height - 64, _tableView.frame.size.width, _tableView.frame.size.height);
            }else {
                _headerView.frame = CGRectMake(0, _headerView.frame.origin.y - offsetY, _headerView.frame.size.width, _headerView.frame.size.height);
                _tableView.frame = CGRectMake(0, _tableView.frame.origin.y - offsetY, _tableView.frame.size.width, _tableView.frame.size.height);
                _tableView.contentOffset = CGPointMake(0, 0);
            }
        }
    }
    
    if (_tableView.frame.origin.y < 64) {
        
        [UIView animateWithDuration:0.3 animations:^{
            _headerView.collectionImageView.size = CGSizeMake(0, 0);
            _headerView.collectionImageView.center = CGPointMake(centerX, centerY);
            _headerView.collectionImageView.alpha = 0;
            
            _headerView.alphaView.backgroundColor = YBNavigationBarBgColor;
        }];
    }else {
        
        [UIView animateWithDuration:0.3 animations:^{
            _headerView.collectionImageView.size = CGSizeMake(63, 63);
            _headerView.collectionImageView.center = CGPointMake(centerX, centerY);
            _headerView.collectionImageView.alpha = 1;
            
            _headerView.alphaView.backgroundColor = [UIColor clearColor];
        }];
    }
    
    // 取消tableView底部的弹簧效果的方法
    CGFloat maxOffsetY = _tableView.contentSize.height - _tableView.bounds.size.height;
    if (offsetY > maxOffsetY) {
        _tableView.contentOffset = CGPointMake(0, maxOffsetY);
    }
}


#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.frame = CGRectMake(0, [DrivingDetailTableHeaderView defaultHeight] - 64, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[DVVCoachDetailInfoCell class] forCellReuseIdentifier:infoCellID];
        [_tableView registerClass:[DVVCoachDetailIntroductionCell class] forCellReuseIdentifier:introductionCellID];
        [_tableView registerClass:[DVVCoachDetailTagCell class] forCellReuseIdentifier:tagCellID];
    }
    return _tableView;
}

- (DVVCoachDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [DVVCoachDetailHeaderView new];
        _headerView.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, [DVVCoachDetailHeaderView defaultHeight]);
        _headerView.coachID = _coachID;
        _headerView.alpha = 0;
    }
    return _headerView;
}

- (DVVCoachDetailCourseCell *)courseCell {
    if (!_courseCell) {
        _courseCell = [[DVVCoachDetailCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:courseCellID];
        _courseCell.tableView = self.tableView;
        _courseCell.coachID = _coachID;
        
        _courseCell.classTypeView.coachID = _viewModel.dmData.coachid;
        _courseCell.classTypeView.coachName = _viewModel.dmData.name;
        _courseCell.classTypeView.schoolID = _viewModel.dmData.driveschoolinfo.ID;
        _courseCell.classTypeView.schoolName = _viewModel.dmData.driveschoolinfo.name;
        
        __weak typeof(self) ws = self;
        [_courseCell.classTypeView dvvCoachClassTypeView_setSignUpButtonActionBlock:^(ClassTypeDMData *dmData) {
            [ws signUpButtonAction:dmData];
        }];
        [_courseCell.classTypeView dvvCoachClassTypeView_setCellDidSelectBlock:^(ClassTypeDMData *dmData) {
            [ws classTypeCellDidSelectAction:dmData];
        }];
        
        // 评论的点击事件
        [_courseCell.commentView.bottomButton addTarget:self action:@selector(moreCommentAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _courseCell;
}

- (DVVSignUpToolBarView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [DVVSignUpToolBarView new];
        _toolBarView.backgroundColor = YBNavigationBarBgColor;
        _toolBarView.layer.shadowColor = [UIColor blackColor].CGColor;
        _toolBarView.layer.shadowOffset = CGSizeMake(0, 2);
        _toolBarView.layer.shadowOpacity = 0.3;
        _toolBarView.layer.shadowRadius = 2;
        _toolBarView.titleArray = @[ @"课程费用", @"学员评价" ];
        __weak typeof(self) ws = self;
        [_toolBarView dvvToolBarViewItemSelected:^(UIButton *button) {
            [ws dvvToolBarViewItemSelectedAction:button.tag];
        }];
    }
    return _toolBarView;
}

- (DVVNoDataPromptView *)noDataPromptView {
    if (!_noDataPromptView) {
        _noDataPromptView = [[DVVNoDataPromptView alloc] initWithTitle:@"加载失败" image:[UIImage imageNamed:@"app_error_robot"]];
    }
    return _noDataPromptView;
}

- (void)addNaviRightButton {
    
    // 添加有上角的班车和拨打电话
    _shuttleBusButton = [UIButton new];
    [_shuttleBusButton setImage:[UIImage imageNamed:@"bus_white_icon"] forState:UIControlStateNormal];
    _shuttleBusButton.bounds = CGRectMake(0, 0, 24, 44);
    [_shuttleBusButton addTarget:self action:@selector(shuttleBusButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _phoneButton = [UIButton new];
    [_phoneButton setImage:[UIImage imageNamed:@"phone_white_icon"] forState:UIControlStateNormal];
    _phoneButton.bounds = CGRectMake(0, 0, 24, 44);
    [_phoneButton addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbiBus = [[UIBarButtonItem alloc] initWithCustomView:_shuttleBusButton];
    UIBarButtonItem *bbiPhone = [[UIBarButtonItem alloc] initWithCustomView:_phoneButton];
    self.navigationItem.rightBarButtonItems = @[ bbiPhone, bbiBus ];
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
