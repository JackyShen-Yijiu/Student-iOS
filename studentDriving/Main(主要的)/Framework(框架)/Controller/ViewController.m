//
//  ViewController.m
//  QQSlideMenu
//
//  Created by wamaker on 15/6/10.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "ViewController.h"
#import "WMMenuViewController.h"
#import "WMNavigationController.h"
#import "WMCommon.h"
#import "YBSignUpViewController.h"
#import "YBStudyViewController.h"
#import "YBMallViewController.h"
#import "YBCommunityViewController.h"
#import "IWTabBarViewController.h"
#import "YBMyWalletViewController.h"
//  侧边栏控制器
#import "YBComplaintController.h" // 我要投诉
#import "ChatListViewController.h" // 我的消息
#import "HomeAdvantageController.h" // 一步优势
#import "ShuttleBusController.h" // 我的驾校班车
#import "JGActivityViewController.h" // 活动
#import "SideMenuSignUpController.h" // 签到
#import "EditorMessageController.h" // 点击头像
#import "SetupViewController.h"
#import "BLPFAlertView.h"
#import "PushInformationManager.h"
#import "AppointmentDetailViewController.h"
#import "YBUserCenterController.h"
#import "MallOrderController.h"
#import "MyConsultationListController.h"
#import "YBForceEvaluateViewController.h"
#import "APCommentViewController.h"
#import "JZMainSignUpController.h"
#import "JZYListController.h"
#import "JZPayWayController.h"
#import "JZShuttleBusController.h"
#import "JZComplaintController.h"
#import "JZMyWalletViewController.h"

@interface ViewController () <WMMenuViewControllerDelegate,IWTabBarViewControllerDelegate>

@property (assign, nonatomic) state   sta;              // 状态(Home or Menu)
@property (assign, nonatomic) CGFloat distance;         // 距离左边的边距
@property (assign, nonatomic) CGFloat leftDistance;
@property (assign, nonatomic) CGFloat menuCenterXStart; // menu起始中点的X
@property (assign, nonatomic) CGFloat menuCenterXEnd;   // menu缩放结束中点的X
@property (assign, nonatomic) CGFloat panStartX;        // 拖动开始的x值

@property (strong, nonatomic) WMCommon               *common;
@property (strong, nonatomic) WMMenuViewController   *menuVC;
@property (strong, nonatomic) UIView                 *cover;

@property (strong, nonatomic) IWTabBarViewController     *tabBarController;

// 侧边栏推出
@property (strong, nonatomic) YBComplaintController *complaintVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    
    self.common = [WMCommon getInstance];
    self.common.homeState = kStateHome;
    self.distance = 0;
    self.menuCenterXStart = self.common.screenW * menuStartNarrowRatio / 2.0;
    self.menuCenterXEnd = self.view.center.x;
    self.leftDistance = self.common.screenW * viewSlideHorizonRatio;
    
    // 设置背景
    UIImageView *mightView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 198)];
    mightView.image = [UIImage imageNamed:@"background_mine"];
    [self.view addSubview:mightView];
    
    // 设置menu的view
    self.menuVC = [[WMMenuViewController alloc] init];
    self.menuVC.delegate = self;
    self.menuVC.iconDelegage = self;
//    CGSize size = [[UIScreen mainScreen] bounds].size;
//    self.menuVC.view.frame = CGRectMake(- size.width * 0.8, 0, size.width * 0.8, size.height);
    self.menuVC.view.frame = [[UIScreen mainScreen] bounds];
    self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuStartNarrowRatio, menuStartNarrowRatio);
    self.menuVC.view.center = CGPointMake(self.menuCenterXStart, self.menuVC.view.center.y);
    [self.view addSubview:self.menuVC.view];
    
    // 初始化子控制器
    self.tabBarController = [[IWTabBarViewController alloc] init];
    self.tabBarController.delegate = self;
    [self.view addSubview:self.tabBarController.view];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.tabBarController.view addGestureRecognizer:pan];
    
    // 隐藏侧边栏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenSlide) name:KhiddenSlide object:nil];
    
    // 注册接收到推送消息，跳转到对应的窗体的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivePushInfo:) name:YBNotif_HandleNotification object:nil];

    // 接收到聊天消息通知，跳转到消息列表
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMainChatMessage) name:@"receiveMainChatMessage" object:nil];

    // 尚未报名推送消息，跳转到对应的窗体的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMainVcChange) name:@"receiveMainVcChange" object:nil];
    
}

- (void)receiveMainVcChange
{
    [self.tabBarController changeVc:0];
}

- (void)receiveMainChatMessage
{
    ChatListViewController *chatListVC = [[ChatListViewController alloc] init];
    [self controller:chatListVC];
}

- (UIView *)cover
{
    if (_cover==nil) {
        _cover = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _cover.backgroundColor = [UIColor clearColor];
        _cover.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSlide)];
        [_cover addGestureRecognizer:tap];
    }
    return _cover;
}

/**
 *  设置statusbar的状态
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/**
 *  处理拖动事件
 *
 *  @param recognizer
 */
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    if (self.tabBarController.tabBar.hidden) return;
    
    NSLog(@"self.tabBarController.tabBar.hidden:%d",self.tabBarController.tabBar.hidden);
    
    // 当滑动水平X大于75时禁止滑动
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.panStartX = [recognizer locationInView:self.view].x;
    }
    if (self.common.homeState == kStateHome && self.panStartX >= 75) {
        return;
    }
    
    CGFloat x = [recognizer translationInView:self.view].x;
    NSLog(@"处理拖动事件x:%f",x);
    NSLog(@"self.common.homeState:%d",self.common.homeState);
    
    // 禁止在主界面的时候向左滑动
//    if (self.common.homeState == kStateHome && x < 0) {
//        return;
//    }
    
    CGFloat dis = self.distance + x;
    NSLog(@"处理拖动事件dis:%f",dis);
    
    // 当手势停止时执行操作
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"当手势停止时执行操作");
        if (dis >= self.common.screenW * viewSlideHorizonRatio / 2.0) {
            [self showMenu];
        } else {
            [self showHome];
        }
        return;
    }
    
    CGFloat proportion = (viewHeightNarrowRatio - 1) * dis / self.leftDistance + 1;
    NSLog(@"处理拖动事件proportion:%f",proportion);
    
    if (proportion < viewHeightNarrowRatio || proportion > 1) {
        return;
    }
    self.tabBarController.view.center = CGPointMake(self.view.center.x + dis, self.view.center.y);
    self.tabBarController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
    
    CGFloat menuProportion = dis * (1 - menuStartNarrowRatio) / self.leftDistance + menuStartNarrowRatio;
    CGFloat menuCenterMove = dis * (self.menuCenterXEnd - self.menuCenterXStart) / self.leftDistance;
    self.menuVC.view.center = CGPointMake(self.menuCenterXStart + menuCenterMove, self.view.center.y);
    self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuProportion, menuProportion);
    
}

- (void)hiddenSlide
{
    // 退出侧边栏
    if ([WMCommon getInstance].homeState==kStateMenu) {
        [self leftBtnClicked];
    }
}

/**
 *  展示侧边栏
 */
- (void)showMenu {
    
    self.distance = self.leftDistance;
    self.common.homeState = kStateMenu;
    [self doSlide:viewHeightNarrowRatio];
    [self.tabBarController.view addSubview:self.cover];

}

/**
 *  展示主界面
 */
- (void)showHome {
    
    self.distance = 0;
    self.common.homeState = kStateHome;
    [self doSlide:1];
    [UIView animateWithDuration:1.0 animations:^{
        [self.cover removeFromSuperview];
    }];
    
}

/**
 *  实施自动滑动
 *
 *  @param proportion 滑动比例
 */
- (void)doSlide:(CGFloat)proportion {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.tabBarController.view.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y);
        self.tabBarController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        
//        self.baomingVC.leftBtn.alpha = self.cover.alpha = (proportion == 1 ? 0.3 : 0);
        
        CGFloat menuCenterX;
        CGFloat menuProportion;
        if (proportion == 1) {
            menuCenterX = self.menuCenterXStart;
            menuProportion = menuStartNarrowRatio;
        } else {
            menuCenterX = self.menuCenterXEnd;
            menuProportion = 1;
        }
        self.menuVC.view.center = CGPointMake(menuCenterX, self.view.center.y);
        self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuProportion, menuProportion);
        
    } completion:^(BOOL finished) {

    }];
    
}

- (void)IWTabBarViewControllerWithLeftBarDidClick
{
    [self leftBtnClicked];
}

- (void)leftBtnClicked {
    
    switch (self.common.homeState) {
        case kStateHome:
            
            [self showMenu];

            break;
            
        case kStateMenu:
            
            [self showHome];

            break;
            
        default:
            break;
    }
    
}

#pragma mark - WMMenuViewController代理方法
- (void)didSelectItem:(NSString *)title indexPath:(NSIndexPath *)indexPath yCode:(NSString *)ycode{
    
    
    
    
    
//     self.listArray = @[@"优惠活动", @"我的钱包", @"我的消息", @"班车接收" ,@"预约签到",@"我要投诉",@"一步优势",@"设置与帮助"];
    
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            // 我的消息
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                return;
            }
            ChatListViewController *chatListVC = [[ChatListViewController alloc] init];
            [self controller:chatListVC];
        }else if (1 == indexPath.row) {
            // 我的订单
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                return;
            }

            MallOrderController *mallOrderVC = [[MallOrderController alloc] init];
            [self controller:mallOrderVC];
            
        }else if (2 == indexPath.row) {
            // 我的钱包
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                return;
            }
//            YBMyWalletViewController *vc = [[YBMyWalletViewController alloc] init];
            JZMyWalletViewController *vc = [[JZMyWalletViewController alloc] init];
        
            vc.Ycode = ycode;

            
            
            [self controller:vc];
        }
    }else if (1 == indexPath.section){
        if (0 == indexPath.row ) {
            // 班车接送
            // 检测是否打开登录页
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                return;
            }
            
            if (![AcountManager manager].applyschool.infoId) {
                [self obj_showTotasViewWithMes:@"您还没有报名"];
                return ;
            }
            
//            ShuttleBusController *shuttleBusVC = [ShuttleBusController new];
//            [self controller:shuttleBusVC];
            
            
            JZShuttleBusController *shuttleBusVC = [JZShuttleBusController new];
            [self controller:shuttleBusVC];
        }else if (1 == indexPath.row) {
            // 预约签到
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                return;
            }
            
            
            SideMenuSignUpController *signUpVC = [SideMenuSignUpController new];
            [self controller:signUpVC];

        }else if (2 == indexPath.row) {
            // 优惠活动
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                return;
            }
            
            JGActivityViewController *activityVC = [JGActivityViewController new];
            [self controller:activityVC];
        }else if (3 == indexPath.row) {
            // 用户设置
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                return;
            }
            SetupViewController *setUpVC = [SetupViewController new];
            [self controller:setUpVC];
        }
    }
    
    
    
}
// 点击头像编辑详情页
- (void)didSelectIconImage:(UITapGestureRecognizer *)gestureRecognizer{
    // 检测是否打开登录页
    if (![AcountManager isLogin]) {
        [DVVUserManager userNeedLogin];
        return;
    }
    
//     EditorUserViewController *editorUserVC = [EditorUserViewController new];
//    EditorMessageController *editorUserVC = [EditorMessageController new];
//    [self controller:editorUserVC];
    YBUserCenterController *vc = [YBUserCenterController new];
    [self controller:vc];
    

}
- (void)initWithButton:(UIButton *)btn{
    if (5000 == btn.tag) {
        // 投诉跳转
        if (![AcountManager isLogin]) {
                    [DVVUserManager userNeedLogin];
                    return;
                }
        if (![AcountManager manager].applyschool.infoId) {
            [self obj_showTotasViewWithMes:@"您还没有报名"];
            return ;
        }

                JZComplaintController *complaintVC = [[JZComplaintController alloc] init];
                [self controller:complaintVC];
        
    }else if (5001 == btn.tag) {
        // 咨询跳转
        if (![AcountManager isLogin]) {
            [DVVUserManager userNeedLogin];
            return;
        }
        MyConsultationListController *myconVC = [[MyConsultationListController alloc] init];
        [self controller:myconVC];
    }
}
- (void)controller:(UIViewController *)itemVC{
    itemVC.hidesBottomBarWhenPushed = YES;
    [self showHome];
    switch (self.tabBarController.vcType) {
        case kYBSignUpViewController:
            [self.tabBarController.baomingVC.navigationController pushViewController:itemVC animated:NO];
            break;
        case kYBStudyViewController:
            [self.tabBarController.xuexiVC.navigationController pushViewController:itemVC animated:NO];
            break;
        case kYBAppointMentController:
            [self.tabBarController.yuyueVC.navigationController pushViewController:itemVC animated:NO];
            break;
        case kYBMallViewController:
            [self.tabBarController.shangchengVC.navigationController pushViewController:itemVC animated:NO];
            break;
        case kYBCommunityViewController:
            [self.tabBarController.shequVC.navigationController pushViewController:itemVC animated:NO];
            break;
        
        default:
            break;
    }

}

#pragma mark - 推送
#pragma mark 接收到推送消息
- (void)receivePushInfo:(NSNotification *)notification {
    
//        {
//            "_j_msgid" = 3729781907;
//            aps =     {
//                alert = "\U60a8\U9884\U7ea6\U7684\U8bfe\U7a0b\U5df2\U88ab\U63a5\U53d7\Uff0c\U8bf7\U5230\U9884\U7ea6\U8be6\U60c5\U91cc\U67e5\U770b";
//                badge = 1;
//                sound = "sound.caf";
//            };
//            data =     {
//                reservationid = 56b07580efe9248328d3428d;
//                userid = 56937987e6b6a92c09a54d6b;
//            };
//            type = reservationsuccess;
//        }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0

    NSDictionary *userInfo = [notification userInfo];
    
    NSLog(@"receivePushInfo userInfo: %@", userInfo);
    
    // 判断数据是否有误
    if (!userInfo || ![userInfo isKindOfClass:[NSDictionary class]]) {
        return ;
    }
    NSString *type = [NSString stringWithFormat:@"%@", userInfo[@"type"]];
    if (!type || !type.length) {
        return ;
    }
    
    // 处理数据
    UIApplication *application = [UIApplication sharedApplication];
    NSLog(@"applicationState: %ld",(long)application.applicationState);
    
    if (application.applicationState == UIApplicationStateActive) {
        
        [BLPFAlertView showAlertWithTitle:@"提示" message:userInfo[@"aps"][@"alert"] cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
            
            DYNSLog(@"selected = %ld",(long)selectedOtherButtonIndex);
            // 当用户选择确定的时候才跳转对应的窗体
            if (selectedOtherButtonIndex == 0) {
                [self handlePushInfo:userInfo];
            }
        }];
        
    }else {
        [self handlePushInfo:userInfo];
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
#endif
}

#pragma mark 处理推送消息
- (void)handlePushInfo:(NSDictionary *)userInfo {
    
    DYNSLog(@"userInfo = %@",userInfo);
    
    // 跳到聊天界面
    NSString *info = userInfo[@"ConversationChatter"];
    if (info) {
        ChatListViewController *chatlist = [[ChatListViewController alloc] init];
        [self controller:chatlist];
        return ;
    }
    
    NSString *type = [NSString stringWithFormat:@"%@", userInfo[@"type"]];
    
    if ([type isEqualToString:@"newversion"]) {
        
        [BLPFAlertView showAlertWithTitle:@"提示" message:userInfo[@"aps"][@"alert"] cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
            
            DYNSLog(@"selected = %ld",(long)selectedOtherButtonIndex);
            if (selectedOtherButtonIndex == 0) {
                // 去更新版本
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/yi-bu-xue-che/id1060105429"]];
            }
        }];
        
    } else if ([type isEqualToString:@"userapplysuccess"]) {
        
        DYNSLog(@"kuserapplysuccess 报名成功");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kuserapplysuccess" object:nil];
        
    }else if ([type isEqualToString:@"reservationsuccess"]) {
        
        DYNSLog(@"接受到教练确认订单信息");
        [[NSNotificationCenter defaultCenter] postNotificationName:kAppointmentDetailRefresh object:self];
//        NSString *string = [NSString stringWithFormat:@"%@",userInfo[@"data"][@"reservationid"]];
//        AppointmentDetailViewController *detail = [[AppointmentDetailViewController alloc] init];
//        detail.isPushInformation = YES;
//        detail.infoId = string;
//        detail.state = AppointmentStateCoachConfirm;
//        
//        [self controller:detail];
        
        
    }else if ([type isEqualToString:@"reservationcancel"]) {
        
        DYNSLog(@"接受到教练取消订单信息");
      [[NSNotificationCenter defaultCenter] postNotificationName:kAppointmentDetailRefresh object:self];
//        NSString *string = [NSString stringWithFormat:@"%@",userInfo[@"data"][@"reservationid"]];
//        AppointmentDetailViewController *detail = [[AppointmentDetailViewController alloc] init];
//        detail.isPushInformation = YES;
//        detail.infoId = string;
//        detail.state = AppointmentStateCoachCancel;
//        
//        [self controller:detail];
        
    }else if ([type isEqualToString:@"reservationcoachcomment"]) {
        // 获取到教练评价
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"有教练对您评价啦，赶快去查看吧！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
        
    }else if ([type isEqualToString:@"walletupdate"]) {
        // 钱包更新
        
//        MyWalletViewController *detail = [[MyWalletViewController alloc] init];
        
    }else if ([type isEqualToString:@"systemmsg"]) {
        // 系统消息
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您有一条系统消息，赶快去查看吧！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

@end
