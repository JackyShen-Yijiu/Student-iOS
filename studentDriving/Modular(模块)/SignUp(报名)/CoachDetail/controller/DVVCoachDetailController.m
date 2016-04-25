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

#import "JZMainSignUpController.h"
#import "JZShuttleBusController.h"

#import "JZCoachDetailHeaderView.h"


#import "DVVCoachCommentViewModel.h"

#import "DVVCoachCommentCell.h"

#import <MJRefresh/MJRefresh.h>

#define kCellIdentifier @"kCellIdentifier"

static NSString *kCommentCoachCellIdentifier = @"kCellIdentifier";

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

@property (nonatomic, strong) JZCoachDetailHeaderView *toolBarView;

@property (nonatomic, assign) BOOL isShowIntroduction;

@property (nonatomic, strong) DVVNoDataPromptView *noDataPromptView;

@property (nonatomic, assign) BOOL networkSuccess;

//@property (nonatomic, strong) DVVCoachCommentViewModel *viewModelCoachComment;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) BOOL isShowClassDetail;

@property (nonatomic, assign) BOOL isShowCommentDetail;

@end

@implementation DVVCoachDetailController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = NO;
    _isShowClassDetail = YES;
    _isShowCommentDetail = YES;
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;

    self.title = _coachName;
    
    // 测试时打开此注释
//    _coachID = @"569d98e11a4e7c693a023499";
    
    // 添加有上角的班车和拨打电话
    [self addNaviRightButton];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];
    
    [self configViewModel];
    [self initRefresh];
    
    
//    [self configViewModelCoachComment];
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
    for(UIView *subview in view.subviews) {
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
    
    JZShuttleBusController *busVC = [JZShuttleBusController new];
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
    NSLog(@"dmData.schoolinfo.name = %@,%@",dmData.schoolinfo.name,dmData.schoolinfo.schoolid);
    JZMainSignUpController *vc = [JZMainSignUpController new];
    vc.isFormCoach = YES;
    vc.detailDMData = _viewModel.dmData;
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

- (void)initRefresh{
    
      __weak typeof(self) ws = self;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        [ws networkRequestLoadMore];
   
   
    }];
  
   self.tableView.mj_footer = footer;
}


#pragma mark - config view model
- (void)configViewModel {
    
    __weak typeof(self) ws = self;
    _viewModel = [DVVCoachDetailViewModel new];
    _viewModel.coachID = _coachID;
    
    [_viewModel dvv_setRefreshSuccessBlock:^{
        
        _networkSuccess = YES;
        ws.tableView.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
        // 使导航栏透明
        [self naviTransparent];
        
        ws.courseCell.classTypeView.coachID = ws.viewModel.dmData.coachid;
        ws.courseCell.classTypeView.coachName = ws.viewModel.dmData.name;
        [self networkRequestRefresh];
       
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
        return 3;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 4;
    }
    if (1 == section) {
        if (_isShowClassDetail) {
            return _viewModel.classTypeListArray.count;
        }else{
            return 0;
        }
        
    }else{
        NSLog(@"_dataArray.count = %lu",_dataArray.count);
        if (_isShowCommentDetail) {
            return _dataArray.count;
        }else{
            return 0;
        }
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (0 == section || 1 == section) {
        return 10;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (1 == section || 2 == section) {
        return 40;
    }else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (1 == section) {
        JZCoachDetailHeaderView *headerView = [[JZCoachDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 40)];
        headerView.titleLabel.text = @"课程收费";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isShowClassType)];
        [headerView addGestureRecognizer:tap];
        headerView.isShowClassTypeDetail = _isShowClassDetail;
        return headerView;

    }
    if (2 == section) {
        JZCoachDetailHeaderView *headerView = [[JZCoachDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 40)];
        headerView.titleLabel.text = @"学员评价";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isShowComment)];
        [headerView addGestureRecognizer:tap];
        headerView.isShowCommentDetail = _isShowCommentDetail;
        return headerView;
        
           }else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row || 1 == indexPath.row) {
            if (0 == indexPath.row) {
                return 40;
            }else {
                return [DVVCoachDetailInfoCell dynamicHeight:_viewModel.dmData type:1];
            }
        }else if (2 == indexPath.row) {
            return 40;
        }else {
            return [DVVCoachDetailIntroductionCell dynamicHeight:_viewModel.dmData isShowMore:_isShowIntroduction];
        }
    }
    else {
        // 课程费用、教练信息
//        return [self.courseCell dynamicHeight:_viewModel.dmData.serverclasslist];
         return 100;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row ) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerOfSectionone"];
            if (cell ==nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headerOfSectionone"];
                JZCoachDetailHeaderView *headerView = [[JZCoachDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 40)];
                headerView.titleLabel.text = @"基本信息";
                headerView.arrowImgView.hidden = YES;
                headerView.lineView.hidden = YES;
                [cell addSubview:headerView];
               
            }
            return cell;
        }
        if (1 == indexPath.row) {
            DVVCoachDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
            if (1 == indexPath.row) {
                cell.tag = 1;
            }
            [cell refreshData:_viewModel.dmData];
            return cell;
        }
        if (2 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerOfSectionTwo"];
            if (cell ==nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headerOfSectionTwo"];
                JZCoachDetailHeaderView *headerView = [[JZCoachDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 40)];
//                headerView.backgroundColor = [UIColor cyanColor];
                headerView.titleLabel.text = @"介绍";
                headerView.arrowImgView.hidden = YES;
                headerView.lineView.hidden = YES;
                [cell addSubview:headerView];

            }
            return cell;
            
    }else {
    DVVCoachDetailIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:introductionCellID];
    [cell refreshData:_viewModel.dmData];
    return cell;

        }
    }
    if (1 == indexPath.section) {
        
        ClassTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        if (!cell) {
            cell = [[ClassTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
//            [cell.signUpButton addTarget:self action:@selector(signUpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.signUpButton.tag = indexPath.row;
        [cell refreshData:_viewModel.classTypeListArray[indexPath.row]];
        __weak typeof(self) ws = self;
                [cell dvvCoachClassTypeView_setSignUpButtonActionBlock:^(ClassTypeDMData *dmData) {
                    [ws signUpButtonAction:dmData];
                }];
        
        return cell;

    }
    if (2 == indexPath.section) {
        DVVCoachCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentCoachCellIdentifier];
        if (!cell) {
            cell = [[DVVCoachCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCommentCoachCellIdentifier];
        }
        [cell refreshData:_dataArray[indexPath.row]];
        return cell;
        
    }

    return nil;

}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (0 == indexPath.section) {
//        if (0 == indexPath.row || 1 == indexPath.row) {
//            if (0 == indexPath.row) {
//                
//                return [DVVCoachDetailInfoCell dynamicHeight:_viewModel.dmData type:0];
//            }else {
//                return [DVVCoachDetailInfoCell dynamicHeight:_viewModel.dmData type:1];
//            }
//        }else if (2 == indexPath.row) {
//            return [DVVCoachDetailIntroductionCell dynamicHeight:_viewModel.dmData isShowMore:_isShowIntroduction];
//        }else {
//            return [DVVCoachDetailTagCell dynamicHeight:_viewModel.dmData];
//        }
//    }else {
//        // 课程费用、教练信息
//        return [self.courseCell dynamicHeight:_viewModel.dmData.serverclasslist];
//    }
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (0 == indexPath.section) {
//        if (0 == indexPath.row || 1 == indexPath.row) {
//            DVVCoachDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
//            if (1 == indexPath.row) {
//                cell.tag = 1;
//            }
//            [cell refreshData:_viewModel.dmData];
//            return cell;
//        }
//        if (2 == indexPath.row) {
//            DVVCoachDetailIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:introductionCellID];
//            
//            [cell refreshData:_viewModel.dmData];
//            return cell;
//        }else {
//            DVVCoachDetailTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellID];
//            [cell refreshData:_viewModel.dmData];
//            return cell;
//        }
//    }else {
//        
//        return _courseCell;
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        if (3 == indexPath.row) {
            _isShowIntroduction = !_isShowIntroduction;
            [_tableView reloadData];
        }
    }
    // 跳转到班型详情页面
    if (1 == indexPath.section) {
        SchoolClassDetailController *schoolClassDetailVC = [[SchoolClassDetailController alloc] init];
        schoolClassDetailVC.classTypeDMData = _viewModel.classTypeListArray[indexPath.row];;
        [self.navigationController pushViewController:schoolClassDetailVC animated:YES];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat centerY = [UIScreen mainScreen].bounds.size.width*0.7  - 25;
    CGFloat centerX = [UIScreen mainScreen].bounds.size.width - 16 - 63/2.f;
    CGFloat height = [UIScreen mainScreen].bounds.size.width*0.7;
    
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
            _headerView.collectionImageView.size = CGSizeMake(48, 20);
            _headerView.collectionImageView.center = CGPointMake(centerX, centerY);
            _headerView.collectionImageView.alpha = 1;
            
            _headerView.alphaView.backgroundColor = [UIColor clearColor];
        }];
    }
    
//    // 取消tableView底部的弹簧效果的方法
//    CGFloat maxOffsetY = _tableView.contentSize.height - _tableView.bounds.size.height;
//    if (offsetY > maxOffsetY) {
//        _tableView.contentOffset = CGPointMake(0, maxOffsetY);
//    }
    _tableView.backgroundColor = [UIColor clearColor];
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

//- (DVVCoachDetailCourseCell *)courseCell {
//    if (!_courseCell) {
//        _courseCell = [[DVVCoachDetailCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:courseCellID];
//        _courseCell.tableView = self.tableView;
//        _courseCell.coachID = _coachID;
//        
//        _courseCell.classTypeView.coachID = _viewModel.dmData.coachid;
//        _courseCell.classTypeView.coachName = _viewModel.dmData.name;
//        _courseCell.classTypeView.schoolID = _viewModel.dmData.driveschoolinfo.ID;
//        _courseCell.classTypeView.schoolName = _viewModel.dmData.driveschoolinfo.name;
//        
//        __weak typeof(self) ws = self;
//        [_courseCell.classTypeView dvvCoachClassTypeView_setSignUpButtonActionBlock:^(ClassTypeDMData *dmData) {
//            [ws signUpButtonAction:dmData];
//        }];
//        [_courseCell.classTypeView dvvCoachClassTypeView_setCellDidSelectBlock:^(ClassTypeDMData *dmData) {
//            [ws classTypeCellDidSelectAction:dmData];
//        }];
//        
//        // 评论的点击事件
//        [_courseCell.commentView.bottomButton addTarget:self action:@selector(moreCommentAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _courseCell;
//}


- (DVVNoDataPromptView *)noDataPromptView {
    if (!_noDataPromptView) {
        _noDataPromptView = [[DVVNoDataPromptView alloc] initWithTitle:@"加载失败" image:[UIImage imageNamed:@"app_error_robot"]];
    }
    return _noDataPromptView;
}

- (void)addNaviRightButton {
    
    // 添加有上角的班车和拨打电话
    _phoneButton = [UIButton new];
    [_phoneButton setImage:[UIImage imageNamed:@"JZ_cellphone"] forState:UIControlStateNormal];
    _phoneButton.bounds = CGRectMake(0, 0, 24, 44);
    [_phoneButton addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbiPhone = [[UIBarButtonItem alloc] initWithCustomView:_phoneButton];
    self.navigationItem.rightBarButtonItem = bbiPhone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)networkRequestRefresh {
    _index = 1;
    [self networkRequestWithIndex:_index isRefresh:YES];
}
- (void)networkRequestLoadMore {
    [self networkRequestWithIndex:++_index isRefresh:NO];
}

- (void)networkRequestWithIndex:(NSUInteger)index isRefresh:(BOOL)isRefresh {
    
    NSString *string = [NSString stringWithFormat:BASEURL, @"courseinfo/getusercomment/2"];
    NSString *url = [NSString stringWithFormat:@"%@/%@/%lu", string, _coachID, _index];
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
    
        
        NSLog(@"DVVCoachCommentDMRootClass: %@", data);
        DVVCoachCommentDMRootClass *dmRoot = [DVVCoachCommentDMRootClass yy_modelWithJSON:data];
        
        if (!dmRoot.type) {
            return ;
        }
        NSLog(@"dmRoot.type = %lu dmRoot.data.count = %lu isRefresh = %d  index = %lu", dmRoot.type,dmRoot.data.count,isRefresh,_index);
        if (dmRoot.type && !dmRoot.data.count && !isRefresh) {
            [self obj_showTotasViewWithMes:@"已经全部加载完毕"];
            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        }
        
        if (isRefresh) {
            [_dataArray removeAllObjects];

        }
        
        for (NSDictionary *dict in dmRoot.data) {
            DVVCoachCommentDMData *dmData = [DVVCoachCommentDMData yy_modelWithDictionary:dict];
            [_dataArray addObject:dmData];
        }
//        // 存储高度
//        for (DVVCoachCommentDMData *dmData in _dataArray) {
//            CGFloat height = [DVVCoachCommentCell dynamicHeight:dmData];
//            [_heightArray addObject:@(height)];
//        }
        
        if (isRefresh) {
            [self.tableView reloadData];
        }else {
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }
        
    } withFailure:^(id data) {
        [self.tableView.mj_footer endRefreshing];
    }];
}
// 是否显示班型信息
- (void)isShowClassType{
    _isShowClassDetail = !_isShowClassDetail;
    [self.tableView reloadData];
}
// 是否显示评论信息
- (void)isShowComment{
    
    _isShowCommentDetail = !_isShowCommentDetail;
    [self.tableView reloadData];
    [self.tableView.mj_footer endRefreshing];
    
}
@end
