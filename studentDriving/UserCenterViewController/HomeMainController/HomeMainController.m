//
//  HomeMainController.m
//  TestCar
//
//  Created by ytzhang on 15/12/13.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "HomeMainController.h"
#import "HomeMainView.h"
#import "HomeSpotView.h"
#import "ToolHeader.h"
#import "JENetwoking.h"
#import "DVVSideMenu.h"
#import "DVVUserManager.h"
#import "HomeCheckProgressView.h"

#import "ChatViewController.h"
#import "SignUpListViewController.h"
// 新报名界面
#import "SignUpController.h"
#import "VerifyPhoneController.h"
// 首页
#import "HomeAdvantageController.h"
#import "HomeFavourableController.h"
#import "HomeRewardController.h"
#import "DrivingViewController.h"
#import "JGActivityViewController.h"

// 科目一
#import "QuestionBankViewController.h"
#import "QuestionTestViewController.h"
#import "WrongQuestionViewController.h"

// 科目二
#import "BLAVPlayerViewController.h"
#import "BLAVDetailViewController.h"
#import "AppointmentViewController.h"
#import "AppointmentDrivingViewController.h"

#import "NSUserStoreTool.h"

#import <BaiduMapAPI/BMKLocationService.h>
#import <BaiduMapAPI/BMKGeocodeSearch.h>

#import "HomeActivityController.h"
#import "DVVCheckActivity.h"

#import "ComplaintController.h"
#import "ShuttleBusController.h"
#import "DrivingDetailController.h"

#import "DVVLocation.h"
#import "DrivingCityListView.h"

#import "APWaitEvaluationViewController.h"
#import "MyAppointmentModel.h"

// 科目三
static NSString *kinfomationCheck = @"userinfo/getmyapplystate";

static NSString *kConversationChatter = @"ConversationChatter";

static NSString *const kexamquestionUrl = @"info/examquestion";

static NSString *const kgetMyProgress = @"userinfo/getmyprogress";

static NSString *const kappointmentUrl = @"courseinfo/getmyreservation?userid=%@&subjectid=%@";

#define ksubject      @"subject"
#define ksubjectTwo   @"subjecttwo"
#define ksubjectThree @"subjectthree"

//#define carOffsetX   (((systemsW - 10) * 0.2) - 10)
#define systemsW   [[UIScreen mainScreen] bounds].size.width
#define systemsH  [[UIScreen mainScreen] bounds].size.height
#define CARFloat ((((systemsW - 260.0) / 5 ) + 50))

@interface HomeMainController () <UIScrollViewDelegate,HomeSpotViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

// 定位
@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;

@property (nonatomic,strong) HomeSpotView *homeSpotView;
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UIImageView *backImage;
@property (nonatomic,strong) HomeMainView  *homeMainView;
@property (nonatomic,strong) HomeMainView *subjectOneView;
@property (nonatomic,strong) HomeMainView *subjectTWoView;
@property (nonatomic,strong) HomeMainView *subjectThreeView;
@property (nonatomic,strong) HomeMainView *subjectFourView;
@property (nonatomic,assign) CGFloat imageX; //用于记录背景图片位置

@property (nonatomic,assign) CGFloat offsetX;

@property (copy, nonatomic) NSString *questionlisturl;
@property (copy, nonatomic) NSString *questiontesturl;
@property (copy, nonatomic) NSString *questionerrorurl;

@property (copy, nonatomic) NSString *questionFourlisturl;
@property (copy, nonatomic) NSString *questionFourtesturl;
@property (copy, nonatomic) NSString *questionFourerrorurl;

@property (nonatomic, strong) HomeActivityController *activityVC;
@property (nonatomic, strong) HomeCheckProgressView *homeCheckProgressView;
// 导航栏右侧的位置按钮
@property (nonatomic, strong) UILabel *locationLabel;
// 判断是否已经打开了城市列表
@property (nonatomic, assign) BOOL cityListShowFlage;

@end

@implementation HomeMainController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_locationService) {
        _locationService = nil;
    }
    if (_geoCodeSearch) {
        _geoCodeSearch = nil;
    }
    
//    [self.navigationController.navigationBar setBackgroundImage:nil
//                                                 forBarPosition:UIBarPositionAny
//                                                     barMetrics:UIBarMetricsDefault];
}

- (void)viewWillAppear:(BOOL)animated{
    //存值用来消除登出再登入时小车还在原位的问题；
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud integerForKey:@"isCarReset"] == 1) {
        self.mainScrollView.contentOffset =CGPointMake(0, 0);
        [ud setInteger:0 forKey:@"isCarReset"];
        [ud synchronize];
    }
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"透明"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self addLoadSubjectProress];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    UILabel *titleLabel = [UILabel new];
//    titleLabel.backgroundColor = [UIColor redColor];
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.text = @"快乐学车美一步";
//    titleLabel.textAlignment = 1;
//    titleLabel.font = [UIFont systemFontOfSize:17];
//    titleLabel.bounds = CGRectMake(0, 0, 119, 44);
//    self.navigationItem.titleView = titleLabel;
    
    self.title = @"快乐学车美一步";
    _offsetX = 0;
    self.view.backgroundColor = [UIColor clearColor];
    [self addSideMenuButton];
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 174)];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, 0);
    _mainScrollView.delegate = self;
     _mainScrollView.pagingEnabled = YES;
    [_mainScrollView setShowsHorizontalScrollIndicator:NO];

    // 添加UIImageView,用于当滑动时,背景滑动1/4
    _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, systemsW, systemsH)];
    _backImage.image = [UIImage imageNamed:@"bg"];
    _imageX = 0;
    [self.view addSubview:_backImage];
    
    
   
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 83, self.view.frame.size.width, 83)];

    self.homeSpotView.frame = CGRectMake(0,0, systemsW, 83);

    _homeSpotView.delegate = self;
    [view addSubview:_homeSpotView];
    [self.view addSubview:view];
    [self.view addSubview:_mainScrollView];
    

    
    // 点击时的回调
    [self addBackBlock];
    [self startSubjectFirstDownLoad];
    [self startSubjectFourDownLoad];
    
    // 定位服务
    [self locationManager];
    
    #pragma mark 当程序由后台进入前台后，调用检查活动的方法，检查今天是否有活动
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundCheckActivity) name:@"kCheckActivity" object:nil];
    
    
    // 添加导航栏右侧的定位按钮
    [self addNaviRightButton];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        [DVVCheckAppNewVersion checkAppNewVersion];
//        ComplaintController *complainVC = [ComplaintController new];
//        [self.navigationController pushViewController:complainVC animated:YES];
        
//        ShuttleBusController *busVC = [ShuttleBusController new];
//        [self.navigationController pushViewController:busVC animated:YES];
        
//        DrivingDetailController *detailVC = [DrivingDetailController new];
//        [self.navigationController pushViewController:detailVC animated:YES];
    });
    
//    [self changeScrollViewContentSize];
}

- (void)changeScrollViewContentSize {
    
    if (1 == [[AcountManager manager].userApplystate integerValue]) {
        
        _mainScrollView.contentSize = CGSizeMake(systemsW * 2, 0);
    }else if (1 == [[AcountManager manager].userApplystate integerValue]) {
        
        _mainScrollView.contentSize = CGSizeMake(systemsW * 3, 0);
    }
}


#pragma mark ----
- (void)startSubjectFirstDownLoad {
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kexamquestionUrl];
    
    __weak HomeMainController *weakSelf = self;
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *param = data[@"data"];
        NSDictionary *subjectOne = param[@"subjectone"];
        if (subjectOne) {
            weakSelf.questiontesturl = subjectOne[@"questiontesturl"];
            weakSelf.questionlisturl = subjectOne[@"questionlisturl"];
            weakSelf.questionerrorurl = subjectOne[@"questionerrorurl"];
        }
    }];
    
    
    
    
}
- (void)addLoadSubjectProress
{
    if (![AcountManager isLogin]) {
        return;
    }
    
    // 申请状态保存
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kinfomationCheck];
    NSDictionary *param = @{@"userid":[AcountManager manager].userid};
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        if (!data) {
            return ;
        }
         __weak typeof(self) ws = self;
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            
            NSDictionary *dataDic = [param objectForKey:@"data"];
            if (!dataDic || ![dataDic isKindOfClass:[NSDictionary class]]) {
                return;
            }
            
            if ([[dataDic objectForKey:@"applystate"] integerValue] == 0) {// 尚未报名
                
                [AcountManager saveUserApplyState:@"0"];
                NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
                // 如果之前已经点击过答对了,就直接跳转到验证学车进度
                if ([defauts objectForKey:@"CheckProgress"]) {
                    
                    VerifyPhoneController *verifyVC = [[VerifyPhoneController alloc] init];
                    [ws.navigationController pushViewController:verifyVC animated:YES];
                    
                }else{
                    // 弹出验证学车进度窗体
                    _homeCheckProgressView = [[HomeCheckProgressView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight)];
                    
                    _homeCheckProgressView.didClickBlock = ^(NSInteger tag){
                        // tag = 200 答对了
                        
                        if (200 == tag) {
                            // 验证学车进度
                            [ws.homeCheckProgressView removeFromSuperview];
                            NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
                            [defauts setObject:@"答对了" forKey:@"CheckProgress"];
                            [defauts synchronize];
                            VerifyPhoneController *verifyVC = [[VerifyPhoneController alloc] init];
                            [ws.navigationController pushViewController:verifyVC animated:YES];
                            
                        }else if(201 == tag){
                            // 设置报名信息验证不可进入;
                            NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
                            [defauts setObject:@"答错了" forKey:@"SingUp"];
                            [defauts synchronize];
                            [ws.homeCheckProgressView removeFromSuperview];
                        }
                    };
                    [[UIApplication sharedApplication].keyWindow addSubview:_homeCheckProgressView];

                }
                
            }else if ([[dataDic objectForKey:@"applystate"] integerValue] == 1) {// 已报名,尚未交钱
                
                [AcountManager saveUserApplyState:@"1"];
                
            }else if ([[dataDic objectForKey:@"applystate"] integerValue] == 2) {// 正常学习,
                
                [AcountManager saveUserApplyState:@"2"];
                
                // 判断是否有尚未评论的预约
                [self loadCommentList];
                
            }else {
                
                [AcountManager saveUserApplyState:@"3"];
            }
            
            [AcountManager saveUserApplyCount:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"applycount"]]];
            
        }else {
            
            NSLog(@"1:%s [data objectForKey:msg:%@",__func__,[data objectForKey:@"msg"]);
            
            [self showTotasViewWithMes:[data objectForKey:@"msg"]];
        }
    } withFailure:^(id data) {
        [self showTotasViewWithMes:@"网络错误"];
    }];
    
    // 获取首页状态
    NSString *getMyProgress = [NSString stringWithFormat:BASEURL,kgetMyProgress];
    [JENetwoking startDownLoadWithUrl:getMyProgress postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        if (!data) {
            return ;
        }
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            NSDictionary *dataDic = [param objectForKey:@"data"];
            if (!dataDic || ![dataDic isKindOfClass:[NSDictionary class]]) {
                return;
            }
            if ([dataDic objectForKey:@"subject"]) {
                [NSUserStoreTool storeWithId:[dataDic objectForKey:@"subject"] WithKey:ksubject];
            }
            
            if ([dataDic objectForKey:@"subjecttwo"]) {
                [NSUserStoreTool storeWithId:[dataDic objectForKey:@"subjecttwo"] WithKey:ksubjectTwo];
            }
            
            if ([dataDic objectForKey:@"subjectthree"]) {
                [NSUserStoreTool storeWithId:[dataDic objectForKey:@"subjectthree"] WithKey:ksubjectThree];
            }
            
            NSLog(@"__%@",[AcountManager manager].userSubject.name);
            NSLog(@"——%@",[AcountManager manager].subjecttwo.progress);
            NSLog(@"__%@",[AcountManager manager].subjectthree.progress);
            
        }else {
            
            NSLog(@"2:%s [data objectForKey:msg:%@",__func__,[data objectForKey:@"msg"]);

            [self showTotasViewWithMes:[data objectForKey:@"msg"]];
        }
    } withFailure:^(id data) {
        [self showTotasViewWithMes:@"网络错误"];
    }];

}

- (void)loadCommentList
{
    
    NSString *appointmentUrl = [NSString stringWithFormat:kappointmentUrl,[AcountManager manager].userid,@"-1"];

    NSString *downLoadUrl = [NSString stringWithFormat:BASEURL,appointmentUrl];
    DYNSLog(@"url = %@ %@",[AcountManager manager].userid,[AcountManager manager].userToken);
    
    __weak typeof (self) ws = self;
    [JENetwoking startDownLoadWithUrl:downLoadUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSArray *array = param[@"data"];

        if (type.integerValue == 1) {
            
            if (array && array.count==1) {// 跳转到预约详情
                
                APWaitEvaluationViewController *waitEvaluation = [[APWaitEvaluationViewController alloc] init];
                NSError *error = nil;
                waitEvaluation.model = [MTLJSONAdapter modelsOfClass:MyAppointmentModel.class fromJSONArray:array error:&error].firstObject;
                NSInteger num = 0;
                if ([[AcountManager manager].userSubject.name isEqualToString:@"科目二"]){
                    num = 2;
                }else if ([[AcountManager manager].userSubject.name isEqualToString:@"科目三"]){
                    num = 3;
                }
                waitEvaluation.markNum =  @(num);
                [self.navigationController pushViewController:waitEvaluation animated:YES];
                
            }else if (array && array.count>0){// 跳转到预约列表
                
                // 弹出验证学车进度窗体
                _homeCheckProgressView = [[HomeCheckProgressView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight)];
                _homeCheckProgressView.topLabel.text = @"您有未评价订单";
                _homeCheckProgressView.bottomLabel.text = @"给您的教练一个好评吧!";
                [_homeCheckProgressView.rightButtton setTitle:@"去评价" forState:UIControlStateNormal];
                [_homeCheckProgressView.wrongButton setTitle:@"去投诉" forState:UIControlStateNormal];
                
                _homeCheckProgressView.didClickBlock = ^(NSInteger tag){
                    // tag = 200 答对了
                    
                    AppointmentViewController *appointment = [[AppointmentViewController alloc] init];
                    
                    NSInteger num = 0;
                    if ([[AcountManager manager].userSubject.name isEqualToString:@"科目二"]){
                        appointment.title = @"科二预约列表";
                        num = 2;
                    }else if ([[AcountManager manager].userSubject.name isEqualToString:@"科目三"]){
                        appointment.title = @"科三预约列表";
                        num = 3;
                    }
                    
                    appointment.markNum = [NSNumber numberWithInteger:num];
                    [ws.navigationController pushViewController:appointment animated:YES];
                    
                    
                };
                [[UIApplication sharedApplication].keyWindow addSubview:_homeCheckProgressView];
                
            }
            
        }
    }];
    
}

- (void)startSubjectFourDownLoad
{
    NSString *urlString = [NSString stringWithFormat:BASEURL,kexamquestionUrl];
    
    __weak HomeMainController *weakSelf = self;
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *param = data[@"data"];
        NSDictionary *subjectOne = param[@"subjectfour"];
        weakSelf.questionFourtesturl = subjectOne[@"questiontesturl"];
        weakSelf.questionFourlisturl = subjectOne[@"questionlisturl"];
        weakSelf.questionFourerrorurl = subjectOne[@"questionerrorurl"];
        
    }];
 
}

#pragma mark --- 回调方法
- (void)addBackBlock
{
    __weak HomeMainController *mainVC = self;
    
    self.homeMainView.didClickBlock = ^(NSInteger tag){
        switch (tag) {
            case 101:
            {
//                HomeAdvantageController *homeAdvantageVC = [[HomeAdvantageController alloc] init];
//                [mainVC.navigationController pushViewController:homeAdvantageVC animated:YES];
                [mainVC obj_showTotasViewWithMes:@"此功能尚未开放!"];
            }
                break;
                case 102:

            {
//                HomeFavourableController *homeAdvantageVC = [[HomeFavourableController alloc] init];
//                [mainVC.navigationController pushViewController:homeAdvantageVC animated:YES];
                JGActivityViewController * activityVC = [[JGActivityViewController alloc] init];
                [mainVC.navigationController pushViewController:activityVC animated:YES];

            }
                break;
                case 103:
            {
                DrivingViewController *controller = [DrivingViewController new];
                [mainVC.navigationController pushViewController:controller animated:YES];

            }
                break;
            default:
                break;
        }
    
        NSLog(@"我被回调了tag = %lu",tag);
        
    };
    // 科目一回调
    self.subjectOneView.didClickBlock = ^(NSInteger tag)
    {
         NSLog(@"我被回调了tag = %lu",tag);
        
        switch (tag) {
            case 101:
            {
                QuestionTestViewController *questionVC = [[QuestionTestViewController alloc] init];
                questionVC.questiontesturl = mainVC.questiontesturl;
                [mainVC.navigationController pushViewController:questionVC animated:YES];
            }
                break;
            case 102:
            {
                WrongQuestionViewController *wrongQuestVC = [[WrongQuestionViewController alloc] init];
                wrongQuestVC.questionerrorurl = mainVC.questionerrorurl;
                NSLog(@"%@",wrongQuestVC.questionerrorurl);
                [mainVC.navigationController pushViewController:wrongQuestVC animated:YES];
            }
                break;
                case 103:
            {
                QuestionBankViewController *questBankVC = [[QuestionBankViewController alloc] init];
                questBankVC.questionlisturl = mainVC.questionlisturl;
                [mainVC.navigationController pushViewController:questBankVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    };
    // 科目二的回调
    self.subjectTWoView.didClickBlock = ^(NSInteger tag)
    {
        switch (tag) {
            case 101:
            {
                BLAVPlayerViewController *bLAVPlayweVC = [[BLAVPlayerViewController alloc] init];
                bLAVPlayweVC.title = @"科二课件";
                bLAVPlayweVC.markNum = [NSNumber numberWithInteger:2];
                [mainVC.navigationController pushViewController:bLAVPlayweVC animated:YES];
            }
                break;
                case 102:
            {
                NSLog(@"%@",[AcountManager manager].userApplystate);
                NSLog(@"%@",[AcountManager manager].userSubject.name);
                if ([[AcountManager manager].userApplystate isEqualToString:@"1"] || [[AcountManager manager].userApplystate isEqualToString:@"3"]) {
                    [mainVC showTotasViewWithMes:@"报名正在审核中!"];
                    return ;
                    
                } else if ([[AcountManager manager].userApplystate isEqualToString:@"2"] && [[AcountManager manager].userSubject.name isEqualToString:@"科目一"]){
                    [mainVC showTotasViewWithMes:@"您科一还没通过哦!"];
                    return;
                }else if ([[AcountManager manager].userApplystate isEqualToString:@"2"] && [[AcountManager manager].userSubject.name isEqualToString:@"科目二"]){
                    AppointmentDrivingViewController *appointVC = [[AppointmentDrivingViewController alloc] init];
                    [mainVC.navigationController pushViewController:appointVC animated:YES];
                }else if([[AcountManager manager].userSubject.name isEqualToString:@"科目三"] || [[AcountManager manager].userSubject.name isEqualToString:@"科目四"])
                    
                {
                    [mainVC showTotasViewWithMes:@"科目二您已经通过!"];
                }
            }
                break;
                case 103:
            {
                if ([[AcountManager manager].userApplystate isEqualToString:@"1"] || [[AcountManager manager].userApplystate isEqualToString:@"3"]) {
                    [mainVC showTotasViewWithMes:@"报名正在审核中!"];
                    return ;
                    
                }else if ([[AcountManager manager].userApplystate isEqualToString:@"2"] && [[AcountManager manager].userSubject.name isEqualToString:@"科目一"]){
                    [mainVC showTotasViewWithMes:@"您科一还没通过哦!"];
                    return;
                }else if ([[AcountManager manager].userApplystate isEqualToString:@"2"] && [[AcountManager manager].userSubject.name isEqualToString:@"科目二"])
                {
                    AppointmentViewController *appointment = [[AppointmentViewController alloc] init];
                    appointment.title = @"科二预约列表";
                    appointment.markNum = [NSNumber numberWithInteger:2];
                    [mainVC.navigationController pushViewController:appointment animated:YES];
                }else if([[AcountManager manager].userSubject.name isEqualToString:@"科目三"] || [[AcountManager manager].userSubject.name isEqualToString:@"科目四"])
                {
                    [mainVC showTotasViewWithMes:@"科目二您已经通过!"];
                    return;
                }
            }
                break;
                
            default:
                break;
        }
    };
    // 科目三的回调
    self.subjectThreeView.didClickBlock = ^(NSInteger tag)
    {
        NSLog(@"我被回调了tag = %lu",tag);
        switch (tag) {
            case 101:
            {
                BLAVPlayerViewController *bLAVPlayweVC = [[BLAVPlayerViewController alloc] init];
                bLAVPlayweVC.title = @"科三课件";
                bLAVPlayweVC.markNum = [NSNumber numberWithInteger:3];
                [mainVC.navigationController pushViewController:bLAVPlayweVC animated:YES];
            }
                break;
            case 102:
            {
               
                NSLog(@"%@",[AcountManager manager].userSubject.name);
                if ([[AcountManager manager].userApplystate isEqualToString:@"1"] || [[AcountManager manager].userApplystate isEqualToString:@"3"]) {
                    [mainVC showTotasViewWithMes:@"报名正在审核中!"];
                    return ;
                    
                }else if ([[AcountManager manager].userApplystate isEqualToString:@"2"] && [[AcountManager manager].userSubject.name isEqualToString:@"科目一"]){
                    [mainVC showTotasViewWithMes:@"您科一还没通过哦!"];
                    return;
                }else if([[AcountManager manager].userApplystate isEqualToString:@"2"] &&[[AcountManager manager].userSubject.name isEqualToString:@"科目三"]) {
                    AppointmentDrivingViewController *appointVC = [[AppointmentDrivingViewController alloc] init];
                    [mainVC.navigationController pushViewController:appointVC animated:YES];

                }else if([[AcountManager manager].userSubject.name isEqualToString:@"科目二"]){
                    [mainVC showTotasViewWithMes:@"您还没到科三进度!"];
                    return;
                }else if ([[AcountManager manager].userSubject.name isEqualToString:@"科目四"]) {
                    [mainVC showTotasViewWithMes:@"你已经通过科目三,不能再预约了!"];
                    return;
                }
            }
                break;
            case 103:
            {
                if ([[AcountManager manager].userApplystate isEqualToString:@"1"] ||[[AcountManager manager].userApplystate isEqualToString:@"3"]) {
                    [mainVC showTotasViewWithMes:@"报名正在审核中!"];
                    return ;
                    
                }else if ([[AcountManager manager].userApplystate isEqualToString:@"2"] && [[AcountManager manager].userSubject.name isEqualToString:@"科目一"]){
                    [mainVC showTotasViewWithMes:@"您科一还没通过哦!"];
                    return;
                }else if([[AcountManager manager].userSubject.name isEqualToString:@"科目二"]){
                    [mainVC showTotasViewWithMes:@"您还没到科三进度!"];
                    return;
                } else if ([[AcountManager manager].userSubject.name isEqualToString:@"科目三"]) {
                    AppointmentViewController *appointment = [[AppointmentViewController alloc] init];
                    appointment.title = @"科三预约列表";
                    appointment.markNum = [NSNumber numberWithInteger:3];
                    [mainVC.navigationController pushViewController:appointment animated:YES];
                    
                } else if ([[AcountManager manager].userSubject.name isEqualToString:@"科目四"]) {
                    [mainVC showTotasViewWithMes:@"你已经通过科目三,不能再预约了!"];
                    return;
                }
            }
                break;
                
            default:
                break;
        }

    };
    // 科目四的回调
    self.subjectFourView.didClickBlock = ^(NSInteger tag)
    {
        NSLog(@"我被回调了tag = %lu",tag);
        switch (tag) {
            case 102:
            {
                QuestionBankViewController *questionBank = [[QuestionBankViewController alloc] init];
                questionBank.questionlisturl = mainVC.questionFourlisturl;
                if ([AcountManager isLogin]) {
                    NSString *appendString = [NSString stringWithFormat:@"?userid=%@",[AcountManager manager].userid];
                    NSString *finalString = [mainVC.questionFourlisturl stringByAppendingString:appendString];
                    questionBank.questionlisturl = finalString;
                }
                questionBank.title = @"科四题库";
                [mainVC.navigationController pushViewController:questionBank animated:YES];

            }
                break;
                case 101:
            {
                QuestionTestViewController *questionTest = [[QuestionTestViewController alloc] init];
                if ([AcountManager isLogin]) {
                    NSString *appendString = [NSString stringWithFormat:@"?userid=%@",[AcountManager manager].userid];
                    NSString *finalString = [mainVC.questionFourtesturl stringByAppendingString:appendString];
                    questionTest.questiontesturl = finalString;
                }
                questionTest.title = @"科四模拟考试";
                [mainVC.navigationController pushViewController:questionTest animated:YES];

            }
                break;
                case 103:
            {
                WrongQuestionViewController *wrongQuestion = [[WrongQuestionViewController alloc] init];
                if (![AcountManager isLogin]) {
                    DYNSLog(@"islogin = %d",[AcountManager isLogin]);
                    [DVVUserManager userNeedLogin];
                    return;
                }else {
                    NSString *appendString = [NSString stringWithFormat:@"?userid=%@",[AcountManager manager].userid];
                    NSString *finalString = [mainVC.questionFourerrorurl stringByAppendingString:appendString];
                    wrongQuestion.questionerrorurl = finalString;
                }
                wrongQuestion.title = @"错题";
                [mainVC.navigationController pushViewController:wrongQuestion animated:YES];
                

            }
                break;
                
            default:
                break;
        }
    };
}

#pragma mark - UIScrollViewDelegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 打开注释背景移动
//    [self setBackImageOffet:scrollView.contentOffset.x];
    // 打开侧边栏
    if (scrollView.contentOffset.x < -50) {
        [self showSideMenu];
    }
    
    if (scrollView.contentOffset.x == 0) {
        [self carMore:scrollView.contentOffset.x];
        [_homeSpotView changLableColor:scrollView.contentOffset.x];
        if (!_homeMainView)
        {
            [_mainScrollView addSubview:self.homeMainView];
        }

    }
    if (0 < scrollView.contentOffset.x && scrollView.contentOffset.x  <= systemsW)
    {
        [self carMore:scrollView.contentOffset.x];
        if (scrollView.contentOffset.x == systemsW) {
            
            [_homeSpotView changLableColor:scrollView.contentOffset.x];
        }
        
        if (!_homeMainView)
        {
            [_mainScrollView addSubview:self.subjectOneView];
        }
    }
    if (systemsW  < scrollView.contentOffset.x && scrollView.contentOffset.x <= systemsW * 2)
    {
        // 如果没登录,滑到科目2,调到登录页面
        if (![AcountManager isLogin]) {
            [DVVUserManager userNeedLogin];
            self.mainScrollView.contentOffset = CGPointMake(systemsW, 0);
            return;
        }
//          如果没有报名,滑到科目2,跳转报名界面
        if ([[[AcountManager manager] userApplystate] isEqualToString:@"0"]) {
            DrivingViewController *controller = [DrivingViewController new];
            [self.navigationController pushViewController:controller animated:YES];
            self.mainScrollView.contentOffset = CGPointMake(systemsW, 0);
            return;
        }
        
        [self carMore:scrollView.contentOffset.x];
        if (scrollView.contentOffset.x == systemsW * 2)
        {
            [_homeSpotView changLableColor:scrollView.contentOffset.x];
        }

        if (!_subjectTWoView)
        {

            [_mainScrollView addSubview:self.subjectTWoView];
        }
    }
    if (systemsW * 2  < scrollView.contentOffset.x && scrollView.contentOffset.x <= systemsW * 3)
    {
      [self carMore:scrollView.contentOffset.x];
        if (scrollView.contentOffset.x == systemsW * 3)
        {
            
            [_homeSpotView changLableColor:scrollView.contentOffset.x];
        }
        if (!_subjectThreeView)
        {
            
            
            if (scrollView.contentOffset.x == systemsW * 3) {
                [self carMore:scrollView.contentOffset.x];
                [_homeSpotView changLableColor:scrollView.contentOffset.x];
            }

            [_mainScrollView addSubview:self.subjectThreeView];
            
        }
    }
    if (systemsW * 3  < scrollView.contentOffset.x  && scrollView.contentOffset.x<= systemsW * 4)
        {
            [self carMore:scrollView.contentOffset.x];
            if (scrollView.contentOffset.x == systemsW *4) {
                
                [_homeSpotView changLableColor:scrollView.contentOffset.x];
            }

            if (!_subjectFourView)
            {
                
                [_mainScrollView addSubview:self.subjectFourView];
            }
        }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_mainScrollView.contentOffset.x == systemsW) {
        if ([[[AcountManager manager] userApplystate] isEqualToString:@"0"]) {
            [self obj_showTotasViewWithMes:@"您还没有报名!"];
            return;
        }

    }
}
#pragma  mark --- 实现协议方法
- (void)horizontalMenuScrollPageIndex:(CGFloat)offSet
{

    NSLog(@"______________(((((((()))))))))))+++++++++++++++++++%f",offSet);

    NSLog(@"%f",systemsW);
    CGFloat contentOffsetX ;
    CGFloat width = self.view.frame.size.width;
//    contentOffsetX = offSet * width / carOffsetX;
    if (offSet == 10 ) {
        contentOffsetX = 0;
    }else if (offSet == CARFloat + 10){
        
        contentOffsetX = width;
    }else if (offSet == 2.0 * (CARFloat) + 10){
        
        contentOffsetX = width * 2;
    }else if (offSet == (3.0 * (CARFloat)) + 10){
        
        contentOffsetX = width *3;
    }else if (offSet == (4 * (CARFloat)) + 10){
        contentOffsetX = width * 4 ;
    }
    [UIView animateWithDuration:0.5 animations:^{
        
        _mainScrollView.contentOffset = CGPointMake(contentOffsetX, 0);
    }];

}
#pragma mark ----

- (void)carMore:(CGFloat )offset
{
    CGFloat width = self.view.frame.size.width;
    CGFloat carX ;
    carX = (offset  * (CARFloat)) / (width);
    [UIView animateWithDuration:10 animations:^{
        
    } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.3 animations:^{
        _homeSpotView.carView.frame = CGRectMake(carX + 10, _homeSpotView.carView.frame.origin.y, _homeSpotView.carView.frame.size.width,  _homeSpotView.carView.frame.size.height);

    }];
    }];
    
}

#pragma mark ---- 背景图片偏移
- (void)setBackImageOffet:(CGFloat)offSetImageX
{
       CGFloat width = self.view.frame.size.width;
    int i = (offSetImageX - _imageX) > 0 ? 1 : -1;
    CGFloat offX = _backImage.frame.size.width * 0.125 - 8;
    CGFloat resultX =  offX * offSetImageX / width  * i;
    _backImage.frame = CGRectMake(-resultX, _backImage.frame.origin.y, _backImage.frame.size.width, _backImage.frame.size.height);
    
    _imageX = _backImage.frame.origin.x;
    
}
- (void)dealInfo:(NSDictionary *)info {
    if (info) {
        NSArray *viewControllers = self.navigationController.viewControllers;
        [viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            if (obj != self)
            {
                if (![obj isKindOfClass:[ChatViewController class]])
                {
                    [self.navigationController popViewControllerAnimated:NO];
                }
                else
                {
                    NSString *conversationChatter = info[kConversationChatter];
                    ChatViewController *chatViewController = (ChatViewController *)obj;
                    if (![chatViewController.conversation.chatter isEqualToString:conversationChatter])
                    {
                        [self.navigationController popViewControllerAnimated:NO];
                        //                        EMMessageType messageType = [info[kMessageType] intValue];
                        chatViewController = [[ChatViewController alloc] initWithChatter:conversationChatter conversationType:eConversationTypeChat];
                        //                       chatViewController.title = conversationChatter;
                        [self.navigationController pushViewController:chatViewController animated:NO];
                        return ;
                    }
                }
            }
            else
            {
                ChatViewController *chatViewController = (ChatViewController *)obj;
                NSString *conversationChatter = info[kConversationChatter];
                //                EMMessageType messageType = [info[kMessageType] intValue];
                chatViewController = [[ChatViewController alloc] initWithChatter:conversationChatter conversationType:eConversationTypeChat];
                //                chatViewController.title = conversationChatter;
                [self.navigationController pushViewController:chatViewController animated:NO];
            }
            
        }];
        
    }
}

#pragma mark - 定位功能
- (void)locationManager {
    
    [self.locationService startUserLocationService];
//    [self didUpdateBMKUserLocation:nil];
}
#pragma mark 定位成功
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [self reverseGeoCodeWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
}
#pragma mark - 反地理编码
- (BOOL)reverseGeoCodeWithLatitude:(double)latitude
                         longitude:(double)longitude {
    
    // 存储定位到的经纬度
    [AcountManager manager].latitude = [NSString stringWithFormat:@"%f",latitude];
    [AcountManager manager].longitude = [NSString stringWithFormat:@"%f",longitude];
    
    CLLocationCoordinate2D point = (CLLocationCoordinate2D){ latitude, longitude };
//        CLLocationCoordinate2D point = (CLLocationCoordinate2D){39.929986, 116.395645};
    BMKReverseGeoCodeOption *reverseGeocodeOption = [BMKReverseGeoCodeOption new];
    reverseGeocodeOption.reverseGeoPoint = point;
    // 发起反向地理编码
    BOOL flage = [self.geoCodeSearch reverseGeoCode:reverseGeocodeOption];
    if (flage) {
        return YES;
    }else {
        return NO;
    }
}
#pragma mark 反地理编码回调
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //        NSLog(@"%@",result);
        NSLog(@"%@", result.address);
        
        BMKAddressComponent *addressComponent = result.addressDetail;
        //        NSLog(@"addressComponent.city===%@",addressComponent.city);
        // 存储定位到的城市名
        [AcountManager manager].userCity = addressComponent.city;
        // 存储详细地址
        [AcountManager manager].locationAddress = result.address;
//        [AcountManager manager].userCity = @"北京";

        // 检查是否有活动
//        [DVVCheckActivity test]; //测试活动时打开此注释
        if ([DVVCheckActivity checkActivity]) {
            [self checkActivityWithCityName:addressComponent.city];
//            [self checkActivityWithCityName:@"北京"];
        }
        
        [self getLocationShowTypeWithCity:addressComponent.city];
//        [self getLocationShowTypeWithCity:@"北京"];
        
        // 停止位置更新服务
        [self.locationService stopUserLocationService];
    }else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - 检查是否有活动
- (void)checkActivityWithCityName:(NSString *)cityName {
    
    NSString *urlString = [NSString stringWithFormat:@"getactivity"];
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    NSLog(@"userCity === %@", cityName);
    [JENetwoking startDownLoadWithUrl:url postParam:@{ @"cityname": cityName } WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSLog(@"%@",data);
        [self loadActivityWithData:data];
    } withFailure:^(id data) {
        NSLog(@"%@", data);
//        [self showMsg:@"获取活动错误"];
    }];
}
- (void)loadActivityWithData:(id)data {
    
    BOOL flage = NO;
    NSDictionary *rootDict = data;
    if (![rootDict objectForKey:@"type"]) {
        flage = YES;
    }
    if (![[rootDict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
        flage = YES;
    }
    NSArray *array = [rootDict objectForKey:@"data"];
    if (![array isKindOfClass:[NSArray class]]) {
        flage = YES;
    }
    NSDictionary *paramsDict = [array firstObject];
    if (![paramsDict isKindOfClass:[NSDictionary class]]) {
        flage = YES;
    }
    if (flage) {
//        [self showMsg:@"暂时还没有活动哟"];
        return ;
    }
    
    //                        id:item._id,
    //                    name:item.name,
    //                    titleimg:item.titleimg,
    //                    begindate:item.begindate,
    //                    contenturl:item.contenturl,
    //                    enddate:item.enddate,
    //                    address:item.address,
    NSString *title = @"一步活动";
    NSString *contentUrl = @"";
    if ([paramsDict objectForKey:@"name"]) {
        title = [paramsDict objectForKey:@"name"];
    }
    if ([paramsDict objectForKey:@"contenturl"]) {
        contentUrl = [paramsDict objectForKey:@"contenturl"];
    }
    
    _activityVC = [HomeActivityController new];
    _activityVC.title = title;
    _activityVC.activityUrl = contentUrl;
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
//    UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
//    [naviVC pushViewController:activityVC animated:NO];
    [window addSubview:_activityVC.view];
}

#pragma mark - 根据城市名获取用户所在的城市是以驾校为主还是以教练为主
- (void)getLocationShowTypeWithCity:(NSString *)cityName {
    
    NSString *interface = [NSString stringWithFormat:@"getlocationShowType"];
    NSString *url = [NSString stringWithFormat:BASEURL,interface];
    NSLog(@"userCity === %@", cityName);
    [JENetwoking startDownLoadWithUrl:url postParam:@{ @"cityname": cityName } WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSLog(@"%@",data);
        BOOL flage = YES;
        NSDictionary *rootDict = data;
        if (![rootDict objectForKey:@"type"]) {
            flage = NO;
        }
        if (![[rootDict objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            flage = NO;
        }
        if (!flage) {
            return ;
        }
        NSDictionary *paramsDict = [rootDict objectForKey:@"data"];
        if ([paramsDict objectForKey:@"showtype"]) {
            // 把用户所在城市驾校为主还是以教练为主的信息存储到AcountManager
            if ([[paramsDict objectForKey:@"showtype"] boolValue] == kLocationShowTypeDriving) {
                [AcountManager manager].userLocationShowType = kLocationShowTypeDriving;
            }else if ([[paramsDict objectForKey:@"showtype"] boolValue] == kLocationShowTypeCoach) {
                [AcountManager manager].userLocationShowType = kLocationShowTypeCoach;
            }
        }

    } withFailure:^(id data) {
//        [self showMsg:@"网络错误"];
    }];
}

#pragma mark 当程序由后台进入前台后，调用检查活动的方法，检查今天是否有活动
- (void)applicationWillEnterForegroundCheckActivity {
    
    NSString *cityName = [AcountManager manager].userCity;
    if (cityName) {
        if (!cityName.length) {
            return ;
        }
    }
    if ([DVVCheckActivity checkActivity]) {
        [self checkActivityWithCityName:cityName];
    }
}

- (void)addNaviRightButton {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.locationLabel];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - Lazy load
#pragma mark 地理编码
- (BMKGeoCodeSearch *)geoCodeSearch {
    if (!_geoCodeSearch) {
        _geoCodeSearch = [BMKGeoCodeSearch new];
        _geoCodeSearch.delegate = self;
    }
    return _geoCodeSearch;
}
#pragma mark 定位
- (BMKLocationService *)locationService {
    if (!_locationService) {
        [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        [BMKLocationService setLocationDistanceFilter:10000.0f];
        _locationService = [[BMKLocationService alloc] init];
        _locationService.delegate = self;
    }
    return _locationService;
}

- (HomeSpotView *)homeSpotView
{
    if (!_homeSpotView) {
        _homeSpotView = [[HomeSpotView alloc] init];
    }
    return _homeSpotView;
}
- (HomeMainView *)homeMainView {
    
    if (!_homeMainView) {
        _homeMainView = [[HomeMainView alloc] initWithFrame:CGRectMake(0, 0, systemsW, systemsH) SearchType:kSearchMainView];
        _homeMainView.backgroundColor = [UIColor clearColor];
        [_mainScrollView addSubview:_homeMainView];
    }
    return _homeMainView;
}
- (HomeMainView *)subjectOneView
{
    if (!_subjectOneView) {
        _subjectOneView = [[HomeMainView alloc] initWithFrame:CGRectMake(systemsW, 0, systemsW, systemsH) SearchType:KSubjectOneView];
        _subjectOneView.backgroundColor = [UIColor clearColor];
        [_mainScrollView addSubview:_subjectOneView];
    }
    return _subjectOneView;
}
- (HomeMainView *)subjectTWoView {
    
    if (!_subjectTWoView) {
        _subjectTWoView = [[HomeMainView alloc] initWithFrame:CGRectMake(systemsW * 2, 0, systemsW, systemsH) SearchType:KSubjectTwoView];
        _subjectTWoView.backgroundColor = [UIColor clearColor];
        [_mainScrollView addSubview:_subjectTWoView];
    }
    return _subjectTWoView;
}

- (HomeMainView *)subjectThreeView {
    
    if (!_subjectThreeView) {
        _subjectThreeView = [[HomeMainView alloc] initWithFrame:CGRectMake(systemsW * 3, 0, systemsW, systemsH) SearchType:KSubjectThreeView];
        _subjectThreeView.backgroundColor = [UIColor clearColor];
        [_mainScrollView addSubview:_subjectThreeView];
    }
    return _subjectThreeView;
}

- (HomeMainView *)subjectFourView {
    
    if (!_subjectFourView) {
        _subjectFourView = [[HomeMainView alloc] initWithFrame:CGRectMake(systemsW * 4, 0, systemsW, systemsH) SearchType:KSubjectFourView];
        _subjectFourView.backgroundColor = [UIColor clearColor];
        [_mainScrollView addSubview:_subjectFourView];
    }
    return _subjectFourView;
}
- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [UILabel new];
        _locationLabel.textAlignment = NSTextAlignmentRight;
        _locationLabel.textColor = [UIColor whiteColor];
        _locationLabel.font = [UIFont systemFontOfSize:14];
        
        [AcountManager manager].userSelectedCity = @"";
        [AcountManager manager].userSelectedLatitude = @"";
        [AcountManager manager].userSelectedLongitude = @"";

        if ([AcountManager manager].userSelectedCity.length) {
            _locationLabel.text = [AcountManager manager].userSelectedCity;
        }else {
            [self location];
        }
        _locationLabel.bounds = CGRectMake(0, 0, 60, 44);
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationLabelClickAction:)];
        [_locationLabel addGestureRecognizer:gesture];
        _locationLabel.userInteractionEnabled = YES;
    }
    return _locationLabel;
}
- (void)location {
    
    _locationLabel.text = @"定位中";
    [DVVLocation reverseGeoCode:^(BMKReverseGeoCodeResult *result,
                                  CLLocationCoordinate2D coordinate,
                                  NSString *city,
                                  NSString *address) {
        _locationLabel.text = city;
    } error:^{
        _locationLabel.text = @"定位失败";
    }];
}
- (void)locationLabelClickAction:(UITapGestureRecognizer *)tapGesture {
    
    if (_cityListShowFlage) {
        return ;
    }
    if ((_locationLabel.text&&[_locationLabel.text isEqualToString:@"定位失败"]) ||
        (_locationLabel.text&&[_locationLabel.text isEqualToString:@"定位中"])) {
        [self location];
        return ;
    }
    DrivingCityListView *view = [DrivingCityListView new];
    CGRect rect = self.view.bounds;
    view.frame = CGRectMake(rect.origin.x, 64, rect.size.width, rect.size.height);
    [self.view addSubview:view];
    [view setSelectedItemBlock:^(NSString *cityName, NSIndexPath *indexPath) {
        
        if (0 == indexPath.row) {
            [DVVLocation reverseGeoCode:^(BMKReverseGeoCodeResult *result, CLLocationCoordinate2D coordinate, NSString *city, NSString *address) {
                
                [self saveUserLocationInfoWithCity:city
                                           address:address
                                        coordinate:coordinate];
                _locationLabel.text = city;
                
            } error:^{
                [self obj_showTotasViewWithMes:@"修改失败"];
            }];
            return ;
        }
        
        [DVVLocation geoCodeWithCity:cityName address:cityName success:^(BMKGeoCodeResult *result, CLLocationCoordinate2D coordinate, double latitude, double longitude) {
            NSLog(@"latitude === %lf   longitude === %lf", latitude, longitude);
            [AcountManager manager].userSelectedLatitude = [NSString stringWithFormat:@"%lf", latitude];
            [AcountManager manager].userSelectedLongitude = [NSString stringWithFormat:@"%lf", longitude];
            [AcountManager manager].userSelectedCity = cityName;
            
            _locationLabel.text = cityName;
        } error:^{
            
            [self obj_showTotasViewWithMes:@"修改失败"];
        }];
    }];
    [view setRemovedBlock:^{
        _cityListShowFlage = NO;
    }];
    _cityListShowFlage = YES;
    [view show];
    
}

#pragma mark 保存用户当前定位到的城市信息
- (void)saveUserLocationInfoWithCity:(NSString *)city
                             address:(NSString *)address
                          coordinate:(CLLocationCoordinate2D)coordinate {
    
    [AcountManager manager].userCity = city;
    [AcountManager manager].locationAddress = address;
    [AcountManager manager].latitude = [NSString stringWithFormat:@"%lf", coordinate.latitude];
    [AcountManager manager].longitude = [NSString stringWithFormat:@"%lf", coordinate.longitude];
}

- (void)showMsg:(NSString *)msg {
    ToastAlertView *toast = [[ToastAlertView alloc] initWithTitle:msg];
    [toast show];
}

@end
