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
#import "YBAppointController.h"
#import <MJRefresh/MJRefresh.h>
#import "YBAppointMentDetailsController.h"
#import "YBForceEvaluateViewController.h"
#import "APCommentViewController.h"
#import "MyAppointmentModel.h"
#import "JZComplaintView.h"
#import "JGPayTool.h"
#import "RatingBar.h"

@class RatingBar;
static NSString *kSectionHeaderIdentifier = @"kHeaderIdentifier";
static NSString *kCellIdentifier = @"kCellIdentifier";

@interface YBAppointmentListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) YBAppointmentListViewModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YBAppointmentHeaderView *headerView;
@property (nonatomic, strong) YBAppointmentSectionHeaderView *footerView;

@property (nonatomic, assign) BOOL isShowTodayAppointment;
@property (nonatomic, assign) BOOL isShowNextAppointment;

@property (nonatomic,strong) YBForceEvaluateViewController *feVc;

@property (nonatomic,strong) NSArray *commentListArray;

@property (nonatomic,assign) NSInteger number;// 科目几

@property (nonatomic,assign) BOOL isShowComplaintView;  // 是否显示强制评价界面

@property (nonatomic,strong) MJRefreshGifHeader *header;

@end

@implementation YBAppointmentListController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约列表";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"马上预约" target:self action:@selector(rightBarButtonItemDidClick)];
    
    self.edgesForExtendedLayout = NO;
    
    _isShowTodayAppointment = YES;
    _isShowNextAppointment = YES;
    _isShowComplaintView = YES;
    
    [self.view addSubview:self.tableView];
    
    [self configViewModel];
    [self configRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![AcountManager isLogin]) {
        [DVVUserManager userNeedLogin];
        return;
    }
    // 开始请求数据
//    [DVVToast showFromView:self.view OffSetY:-10];
    [_viewModel dvv_networkRequestRefresh];
}
- (void)viewDidAppear:(BOOL)animated{
    // 请求评论数据
    if (_isShowComplaintView) {
        [self loadCommentList];
        // 学车进度
        [self addLoadSubjectProress];
    }
    
}
- (void)rightBarButtonItemDidClick{
    
    if (![AcountManager isLogin]) {
        [DVVUserManager userNeedLogin];
        return;
    }
    
    
    NSLog(@"[AcountManager manager].userApplystate:%@",[AcountManager manager].userApplystate);
    
    // 0) {// 尚未报名
    if ([AcountManager manager].userApplystate && [[AcountManager manager].userApplystate isEqualToString:@"0"]) {
        UIAlertView  * alert = [[UIAlertView alloc] initWithTitle:@"抱歉,貌似您还没有报名;如果您已报名,请联系驾校或教练" message:@"" delegate:self cancelButtonTitle:@"前去报名" otherButtonTitles:@"再看看", nil];
        alert.tag = 100;
        [alert show];
        return;
    }
    // 1) {// 已报名,尚未交钱
    if (([AcountManager manager].userApplystate && [[AcountManager manager].userApplystate isEqualToString:@"1"])) {
        UIAlertView  * alert = [[UIAlertView alloc] initWithTitle:@"抱歉,您尚未付款，请尽快前往驾校支付费用" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alert show];
        return;
    }
    
    YBAppointController *vc = [[YBAppointController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100 && buttonIndex==0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveMainVcChange" object:self];
    }
}

#pragma mark - action

#pragma mark 跳转到已完成的预约
- (void)completedAppointmentAction {
    
    NSLog(@"_viewModel.completedArray:%@",_viewModel.completedArray);
    for (HMCourseModel *model in _viewModel.completedArray) {
        NSLog(@"model.sigintime:%@",model.sigintime);
    }
    YBCompletedAppointmentListController *vc = [YBCompletedAppointmentListController new];
    vc.dataArray = _viewModel.completedArray;
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
//        [DVVToast hideFromView:ws.view];
        [ws.tableView.mj_header endRefreshing];
    }];
    
//    // 开始请求数据
//    [DVVToast showFromView:ws.view OffSetY:-64];
//    [_viewModel dvv_networkRequestRefresh];
}

#pragma mark - config refresh

- (MJRefreshGifHeader *)header
{
    if (_header==nil) {
        
        // 设置正在刷新状态的动画图片
        NSMutableArray *refreshingImages = [NSMutableArray array];
        for (int i = 1; i<=5; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_student_0%d", i]];
            [refreshingImages addObject:image];
        }
        
        // 设置松开刷新状态的动画图片
        NSMutableArray *refreshingImages2 = [NSMutableArray array];
        for (int i = 1; i<=10; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_student_0%d", i+5]];
            [refreshingImages2 addObject:image];
        }
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        _header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(dvv_networkRequestRefresh)];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [_header setImages:refreshingImages forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        [_header setImages:refreshingImages2 forState:MJRefreshStateRefreshing];
        // 隐藏时间
        _header.lastUpdatedTimeLabel.hidden = YES;
        // 隐藏状态
        _header.stateLabel.hidden = YES;

    }
    return _header;
}

- (void)configRefresh {
    
    // 设置刷新控件
    self.tableView.mj_header = self.header;

}

- (void)dvv_networkRequestRefresh
{
    [self.viewModel dvv_networkRequestRefresh];
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
        headerView.titleLabel.text = @"今日预约";
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
        headerView.titleLabel.text = @"未来预约";
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
    view.backgroundColor = YBMainViewControlerBackgroundColor;
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
    
    HMCourseModel *model = nil;
    if (0 == indexPath.section) {
        
        model = _viewModel.todayArray[indexPath.row];
        
    }else if (1 == indexPath.section) {
        
        model = _viewModel.nextArray[indexPath.row];
    }
    
    YBAppointMentDetailsController *vc = [YBAppointMentDetailsController new];
    vc.courseModel = model;
    vc.appointMentID = model.courseId;
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ----- 请求评论数据
- (void)loadCommentList
{
    
    NSString *appointmentUrl = [NSString stringWithFormat:kappointmentUrl,[AcountManager manager].userid,(long)self.number];
    
    NSString *downLoadUrl = [NSString stringWithFormat:BASEURL,appointmentUrl];
    DYNSLog(@"url = %@ %@",[AcountManager manager].userid,[AcountManager manager].userToken);
    
    __weak typeof (self) ws = self;
    [JENetwoking startDownLoadWithUrl:downLoadUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *param = data;
        NSArray *commentListArray = param[@"data"];
        NSNumber *type = param[@"type"];
        // 测试数据
//        NSArray *commentListArray = @[@"你好,红啊呀"];
        
        if (type.integerValue == 1 && commentListArray.count > 0) {
            
            ws.commentListArray = commentListArray;
            
            [self.navigationController.view addSubview:ws.feVc.view];
            // 强制评价
//            [ws.tabBarController.view insertSubview:ws.feVc.view aboveSubview:((AppDelegate *)[UIApplication sharedApplication].delegate).window];
            
            NSError *error;
            MyAppointmentModel *model = [MTLJSONAdapter modelsOfClass:MyAppointmentModel.class fromJSONArray:ws.commentListArray error:&error].firstObject;
            ws.feVc.iconURL = model.coachid.headportrait.originalpic; // 教练头像
            ws.feVc.nameStr = model.coachid.name; // 教练姓名
        }
    }];
    
}
- (void)addLoadSubjectProress
{
    if (![AcountManager isLogin]) {
        return;
    }
    
    [self.headerView setUpData];
    self.number = [[AcountManager manager].userSubject.subjectId integerValue];
//    [self.courseDayTableView.mj_header beginRefreshing];
    
}

- (YBForceEvaluateViewController *)feVc
{
    if (_feVc==nil) {
        
        WS(ws);
        _feVc = [[YBForceEvaluateViewController alloc] init];
        _feVc.view.frame = ((AppDelegate *)[UIApplication sharedApplication].delegate).window.bounds;
        _feVc.moteblock = ^{
            
            NSLog(@"更多");
//            NSLog(@"_feVc.starBar.rating:%f",ws.feVc.starBar.rating);
            NSLog(@"feVc.reasonTextView.text:%@",ws.feVc.reasonTextView.text);
            
            if (self.commentListArray && self.commentListArray.count==1) {// 跳转到评论界面
            
                NSError *error = nil;
                MyAppointmentModel *model = [MTLJSONAdapter modelsOfClass:MyAppointmentModel.class fromJSONArray:ws.commentListArray error:&error].firstObject;
//
               
//                comment.model = model;
//                comment.hidesBottomBarWhenPushed = YES;
//                comment.isForceComment = YES;
//                [ws.navigationController pushViewController:comment animated:YES]; ------
                [ws.feVc.view removeFromSuperview];
                _isShowComplaintView = NO;
                JZComplaintView *moreComVC = [[JZComplaintView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight  - 50)];
                                    [ws.navigationController.view addSubview:moreComVC];
                moreComVC.iconImgUrl = model.coachid.headportrait.originalpic; // 教练头像
                moreComVC.coachName = model.coachid.name; // 教练姓名
                moreComVC.viewVC = ws;
                moreComVC.model = model;
            }
            
        };
        _feVc.commitBlock = ^{
            
            NSLog(@"提交");
            if (ws.feVc.reasonTextView.text.length == 0) {
                [ws obj_showTotasViewWithMes:@"请输入评价内容"];
                return ;
            }


//            NSLog(@"_feVc.starBar.rating:%f",ws.feVc.starBar.rating);
            NSLog(@"feVc.reasonTextView.text:%@",ws.feVc.reasonTextView.text);
            
            NSError *error = nil;
            
            MyAppointmentModel *model = [MTLJSONAdapter modelsOfClass:MyAppointmentModel.class fromJSONArray:ws.commentListArray error:&error].firstObject;

                    
           
                        [ws commitComment:ws.feVc.reasonTextView.text star:ws.feVc.starBar.rating model:model];
            
        };
        
    }
    return _feVc;
}

- (void)commitComment:(NSString *)comment star:(CGFloat)star model:(MyAppointmentModel *)model{
    
    NSLog(@"[AcountManager manager].userid:%@",[AcountManager manager].userid);
    NSLog(@"model.infoId:%@",model.infoId);
    
    if ([AcountManager manager].userid==nil && model.infoId == nil) {
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kuserCommentAppointment];
    
    NSDictionary *param = @{@"userid":[AcountManager manager].userid,
                            @"reservationid":model.infoId,
                            @"starlevel":[NSString stringWithFormat:@"%f",star],// 总体评论星级
                            @"abilitylevel":@"0",// 能力
                            @"timelevel":@"0",// 时间
                            @"attitudelevel":@"0",// 态度
                            @"hygienelevel":@"0",// 卫生
                            @"commentcontent":comment};
    NSLog(@"param:%@",param);
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        DYNSLog(@"%s data = %@",__func__,data);
        
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
        
        if (type.integerValue == 1) {
            [self obj_showTotasViewWithMes:@"评论成功"];
            [self.feVc.view removeFromSuperview];
//            [self.courseDayTableView.mj_header beginRefreshing];
        }else{
            [self obj_showTotasViewWithMes:msg];
        }
        
    }];
    
}


#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, 0, kSystemWide, [UIScreen mainScreen].bounds.size.height - 64 - 49);
        _tableView.backgroundColor = YBMainViewControlerBackgroundColor;
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
        _headerView.parentViewController = self;
        _headerView.frame = CGRectMake(0, 0, kSystemWide, 118);
    }
    return _headerView;
}

- (YBAppointmentSectionHeaderView *)footerView {
    if (!_footerView) {
        _footerView = [YBAppointmentSectionHeaderView new];
        _footerView.frame = CGRectMake(0, 0, kSystemWide, 44);
        _footerView.titleLabel.text = @"已完成预约";
        [_footerView.button addTarget:self action:@selector(completedAppointmentAction) forControlEvents:UIControlEventTouchUpInside];
        _footerView.statusLabel.hidden = YES;
    }
    return _footerView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
