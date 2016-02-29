//
//  YBAppointMentDetailsController.m
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentDetailsController.h"
#import "YBAppointMentDetailsDataModel.h"
#import "DrivingDetailTableHeaderView.h"
#import "DVVToast.h"
#import "DVVCoachDetailInfoCell.h"
#import "DVVCoachDetailIntroductionCell.h"
#import "DVVCoachDetailTagCell.h"
#import "DVVCoachDetailCourseCell.h"
#import "DVVCoachDetailHeaderView.h"
#import "ShuttleBusController.h"
#import "HMCourseModel.h"
#import "DrivingDetailViewModel.h"
#import "YBAppointMentDetailsFootView.h"
#import "YBAppointMentDetailsCancleView.h"
#import "YBCancleAppointMentController.h"
#import "ChatViewController.h"

static NSString *infoCellID = @"kInfoCellID";
static NSString *introductionCellID = @"kIntroductionCellID";
static NSString *tagCellID = @"kTagCellID";
static NSString *courseCellID = @"kCourseCellID";

@interface YBAppointMentDetailsController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    UIImageView*navBarHairlineImageView;
}

@property (nonatomic, strong) DVVCoachDetailHeaderView *headerView;

@property (nonatomic, strong) YBAppointMentDetailsDataModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *shuttleBusButton;

@property (nonatomic, assign) BOOL isShowIntroduction;

@property (nonatomic,strong) YBAppointMentDetailsFootView *footView;
@property (nonatomic,strong) YBAppointMentDetailsCancleView *cancleFootView;

@end

@implementation YBAppointMentDetailsController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //self.title = @"教练详情";
    
    // 测试时打开此注释
    //    _coachID = @"569d98e11a4e7c693a023499";
    
    // 聊天
    [self addNaviRightButton];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];
    
    [self configViewModel];

    if (self.courseModel.courseStatue == KCourseStatueapplying) {// 预约中,取消预约
        [self.view addSubview:self.footView];
    }else if (self.courseModel.courseStatue == KCourseStatueapplyrefuse){// 教练拒绝或者取消->教练取消
        [self.view addSubview:self.cancleFootView];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden=NO;
    
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

#pragma mark 聊天
- (void)shuttleBusButtonAction {
    
    ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:_courseModel.userModel.coachid
                                                                    conversationType:eConversationTypeChat];
    chatController.title = _courseModel.userModel.name;
    [self.navigationController pushViewController:chatController animated:YES];
}



#pragma mark - config view model
- (void)configViewModel {
    
    __weak typeof(self) ws = self;
    _viewModel = [YBAppointMentDetailsDataModel new];
    _viewModel.appointMentID = _appointMentID;
    
    [_viewModel dvv_setRefreshSuccessBlock:^{
        
        [ws naviTransparent];
        [UIView animateWithDuration:0.3 animations:^{
            ws.headerView.alpha = 1;
        }];
        [ws.tableView reloadData];
        [ws.headerView refreshAppointMentData:ws.viewModel.dmData];
    }];
    [_viewModel dvv_setNilResponseObjectBlock:^{
        [ws obj_showTotasViewWithMes:@"暂无数据"];
    }];
    [_viewModel dvv_setNetworkCallBackBlock:^{
        [DVVToast hide];
    }];
    [_viewModel dvv_setNetworkErrorBlock:^{
        [ws obj_showTotasViewWithMes:@"网络错误"];
    }];
    [_viewModel dvv_networkRequestRefresh];
}

#pragma mark - tableView delegate datasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_viewModel.dmData) {
        return 1;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row==0) {
        cell.imageView.image = [UIImage imageNamed:@"ic_age"];
        cell.textLabel.text = _viewModel.dmData.courseprocessdesc;
    }else if (indexPath.row==1){
        cell.imageView.image = [UIImage imageNamed:@"ic_teaching_subjects"];
        cell.textLabel.text = _viewModel.dmData.learningcontent;
    }else if (indexPath.row==2){
        cell.imageView.image = [UIImage imageNamed:@"ic_car_type"];
        cell.textLabel.text = _viewModel.dmData.classdatetimedesc;
    }else if (indexPath.row==3){
        cell.imageView.image = [UIImage imageNamed:@"ic_school"];
        cell.textLabel.text = _viewModel.dmData.coachid.driveschoolinfo.name;
    }else if (indexPath.row==4){
        cell.imageView.image = [UIImage imageNamed:@"ic_training_grounds"];
        cell.textLabel.text = _viewModel.dmData.trainfieldlinfo.name;
    }else if (indexPath.row==5){
        cell.imageView.image = [UIImage imageNamed:@"schoolDetail_trainingGround_icon"];
        cell.textLabel.text = _viewModel.dmData.shuttleaddress;
    }
    
    return cell;
    
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
}


#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, [DrivingDetailTableHeaderView defaultHeight] - 64, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UITableView new];
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
        _headerView.alpha = 0;
        _headerView.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, [DVVCoachDetailHeaderView defaultHeight]);
        _headerView.coachID = _appointMentID;
        _headerView.collectionImageView.userInteractionEnabled = NO;
        _headerView.collectionImageView.hidden = YES;
    }
    return _headerView;
}

- (YBAppointMentDetailsFootView *)footView
{
    
    WS(ws);
    if (_footView == nil) {
        
        _footView = [[YBAppointMentDetailsFootView alloc] initWithFrame:CGRectMake(0, self.view.height-50-64, self.view.width, 50)];
        _footView.courseModel = _courseModel;
        _footView.didClick = ^{
            NSLog(@"取消预约");
            YBCancleAppointMentController *vc = [[YBCancleAppointMentController alloc] init];
            vc.courseModel = ws.courseModel;
            [ws.navigationController pushViewController:vc animated:YES];
        };
    }
    return _footView;
}

- (YBAppointMentDetailsCancleView *)cancleFootView
{
    if (_cancleFootView == nil) {
        
        _cancleFootView = [[YBAppointMentDetailsCancleView alloc] initWithFrame:CGRectMake(0, self.view.height-80-64, self.view.width, 80)];
        _cancleFootView.courseModel = _courseModel;
    }
    return _cancleFootView;
}

- (void)addNaviRightButton {
    
    _shuttleBusButton = [UIButton new];
    [_shuttleBusButton setImage:[UIImage imageNamed:@"Slide_Menu_Message_Normal"] forState:UIControlStateNormal];
    _shuttleBusButton.bounds = CGRectMake(0, 0, 24, 44);
    [_shuttleBusButton addTarget:self action:@selector(shuttleBusButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbiBus = [[UIBarButtonItem alloc] initWithCustomView:_shuttleBusButton];
    self.navigationItem.rightBarButtonItems = @[bbiBus];
    
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
