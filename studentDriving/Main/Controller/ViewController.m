//
//  ViewController.m
//  QQSlideMenu
//
//  Created by wamaker on 15/6/10.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "ViewController.h"
#import "WMMenuViewController.h"
#import "WMOtherViewController.h"
#import "WMNavigationController.h"
#import "WMCommon.h"

#import "YBAppointMentController.h"
#import "YBSignUpViewController.h"
#import "YBStudyViewController.h"
#import "YBMallViewController.h"
#import "YBCommunityViewController.h"
#import "IWTabBarViewController.h"

//  侧边栏控制器
#import "YBComplaintController.h" // 我要投诉
#import "ChatListViewController.h" // 我的消息
#import "HomeAdvantageController.h" // 一步优势
#import "ShuttleBusController.h" // 我的驾校班车
#import "JGActivityViewController.h" // 活动
#import "SideMenuSignUpController.h" // 签到
#import "EditorMessageController.h" // 点击头像
#import "SetupViewController.h"


typedef NS_ENUM(NSInteger, kOpenControllerType) {
    
    kYBSignUpViewController,
    kYBStudyViewController,
    kYBAppointMentController,
    kYBMallViewController,
    kYBCommunityViewController,
    // 侧边栏推出界面
    kYBComplainViewController,
    
};

static const CGFloat viewSlideHorizonRatio = 0.8;
static const CGFloat viewHeightNarrowRatio = 0.80;
static const CGFloat menuStartNarrowRatio  = 0.70;

@interface ViewController () <YBHomeBaseControllerDelegate, WMMenuViewControllerDelegate,UITabBarControllerDelegate>

@property (assign, nonatomic) kOpenControllerType   vcType;// 控制器类型

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

@property (strong, nonatomic) WMNavigationController *mainNav;

@property (strong, nonatomic) YBSignUpViewController   *baomingVC;
@property (strong, nonatomic) YBStudyViewController   *xuexiVC;
@property (strong, nonatomic) YBAppointMentController   *yuyueVC;
@property (strong, nonatomic) YBMallViewController   *shangchengVC;
@property (strong, nonatomic) YBCommunityViewController   *shequVC;
// 侧边栏推出
@property (strong, nonatomic) YBComplaintController *complaintVC;

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 检测是否打开登录页
    if (![AcountManager isLogin]) {
        [DVVUserManager loginController].hidesBottomBarWhenPushed = YES;
        [self showHome];
        [self.baomingVC.navigationController pushViewController:[DVVUserManager loginController] animated:NO];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //self.view.backgroundColor = YBNavigationBarBgColor;
    
    self.common = [WMCommon getInstance];
    self.common.homeState = kStateHome;
    self.distance = 0;
    self.menuCenterXStart = self.common.screenW * menuStartNarrowRatio / 2.0;
    self.menuCenterXEnd = self.view.center.x;
    self.leftDistance = self.common.screenW * viewSlideHorizonRatio;
    
    // 设置背景
    UIImageView *mightView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.height)];
//    mightView.backgroundColor = [UIColor clearColor];
    mightView.image = [UIImage imageNamed:@"YBSliderBarImg.jpg"];
    [self.view addSubview:mightView];
    
    // 设置menu的view
    self.menuVC = [[WMMenuViewController alloc] init];
    self.menuVC.delegate = self;
    self.menuVC.iconDelegage = self;
    
    self.menuVC.view.frame = [[UIScreen mainScreen] bounds];
    //self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuStartNarrowRatio, menuStartNarrowRatio);
    self.menuVC.view.center = CGPointMake(self.menuCenterXStart, self.menuVC.view.center.y);
    [self.view addSubview:self.menuVC.view];
    
    // 设置遮盖
//    self.cover = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.cover.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"YBSliderBarImg"]];
//    [self.view addSubview:self.cover];
    
    // 添加tabBarController
    self.tabBarController = [[IWTabBarViewController alloc] init];
    self.tabBarController.delegate = self;
    
    self.baomingVC = [[YBSignUpViewController alloc] init];
    [self setUpTabbarVc:self.baomingVC title:@"报名" image:@"tab_buddy_nor" selectedImage:@"tab_buddy_nor"];

    self.xuexiVC = [[YBStudyViewController alloc] init];
    [self setUpTabbarVc:self.xuexiVC title:@"学习" image:@"tab_qworld_nor" selectedImage:@"tab_buddy_nor"];

    self.yuyueVC = [[YBAppointMentController alloc] init];
    [self setUpTabbarVc:self.yuyueVC title:@"预约" image:@"tab_recent_nor" selectedImage:@"tab_buddy_nor"];

    self.shangchengVC = [[YBMallViewController alloc] init];
    [self setUpTabbarVc:self.shangchengVC title:@"商城" image:@"tab_buddy_nor" selectedImage:@"tab_buddy_nor"];
//
//    self.shequVC = [[YBCommunityViewController alloc] init];
//    [self setUpTabbarVc:self.shequVC title:@"社区" image:@"tab_qworld_nor" selectedImage:@"tab_buddy_nor"];
//    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenSlide) name:KhiddenSlide object:nil];
}

- (void)hiddenSlide
{
    // 退出侧边栏
    if ([WMCommon getInstance].homeState==kStateMenu) {
        [self leftBtnClicked];
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSUInteger index = tabBarController.selectedIndex;
    
    NSLog(@"index:%lu",(unsigned long)index);
    self.vcType = index;
    
}

- (void)setUpTabbarVc:(YBHomeBaseController *)vc title:(NSString *)title image:(NSString *)img selectedImage:(NSString *)selectedImage
{
    
    vc.view.frame = [[UIScreen mainScreen] bounds];
    vc.delegate = self;

    self.mainNav = [[WMNavigationController alloc] initWithRootViewController:vc];
    
    self.mainNav.tabBarItem.title = title;
    self.mainNav.tabBarItem.image = [UIImage imageNamed:img];
//    self.mainNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_qworld_nor"];

    // 设置tabbar字体颜色
    self.tabBarController.tabBar.tintColor = YBNavigationBarBgColor;
    
    [self.tabBarController addChildViewController:self.mainNav];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.tabBarController.view addGestureRecognizer:pan];
    [self.view addSubview:self.tabBarController.view];
    
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
    
    NSLog(@"self.mainNav.viewControllers.count:%lu",(unsigned long)self.mainNav.viewControllers.count);
    
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
    // 禁止在主界面的时候向左滑动
    if (self.common.homeState == kStateHome && x < 0) {
        return;
    }
    
    CGFloat dis = self.distance + x;
    // 当手势停止时执行操作
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (dis >= self.common.screenW * viewSlideHorizonRatio / 2.0) {
            [self showMenu];
        } else {
            [self showHome];
        }
        return;
    }
    
    CGFloat proportion = (viewHeightNarrowRatio - 1) * dis / self.leftDistance + 1;
    if (proportion < viewHeightNarrowRatio || proportion > 1) {
        return;
    }
    self.tabBarController.view.center = CGPointMake(self.view.center.x + dis, self.view.center.y);
   // self.tabBarController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
    
    self.baomingVC.leftBtn.alpha = self.cover.alpha = 1 - dis / self.leftDistance;
    
    CGFloat menuProportion = dis * (1 - menuStartNarrowRatio) / self.leftDistance + menuStartNarrowRatio;
    CGFloat menuCenterMove = dis * (self.menuCenterXEnd - self.menuCenterXStart) / self.leftDistance;
    self.menuVC.view.center = CGPointMake(self.menuCenterXStart + menuCenterMove, self.view.center.y);
  //  self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuProportion, menuProportion);
    
}

/**
 *  展示侧边栏
 */
- (void)showMenu {
    self.distance = self.leftDistance;
    self.common.homeState = kStateMenu;
    [self doSlide:viewHeightNarrowRatio];
}

/**
 *  展示主界面
 */
- (void)showHome {
    self.distance = 0;
    self.common.homeState = kStateHome;
    [self doSlide:1];
}

/**
 *  实施自动滑动
 *
 *  @param proportion 滑动比例
 */
- (void)doSlide:(CGFloat)proportion {
    [UIView animateWithDuration:0.3 animations:^{
        self.tabBarController.view.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y);
        //self.tabBarController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        
        self.baomingVC.leftBtn.alpha = self.cover.alpha = proportion == 1 ? 1 : 0;
        
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
        //self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuProportion, menuProportion);
    } completion:^(BOOL finished) {

    }];
}

#pragma mark - WMHomeViewController代理方法
- (void)leftBtnClicked:(state)state
{
    if (state==kStateMenu) {
        [self showHome];
    }
    
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
- (void)didSelectItem:(NSString *)title indexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        // 我的消息
        ChatListViewController *chatListVC = [[ChatListViewController alloc] init];
        [self controller:chatListVC];
    }
    if (indexPath.row == 1) {
        // 活动
        if (![AcountManager isLogin]) {
            [DVVUserManager userNeedLogin];
            return;
        }
        
        JGActivityViewController *activityVC = [JGActivityViewController new];
        [self controller:activityVC];
    }
    if (indexPath.row == 2) {
        // 预约签到
        if (![AcountManager isLogin]) {
            [DVVUserManager userNeedLogin];
            return;
        }
        
        SideMenuSignUpController *signUpVC = [SideMenuSignUpController new];
        [self controller:signUpVC];
    }
    if (indexPath.row == 3) {
        // 我的驾校班车
        
        // 检测是否打开登录页
        if (![AcountManager isLogin]) {
            [DVVUserManager loginController].hidesBottomBarWhenPushed = YES;
            [self showHome];
            [self.baomingVC.navigationController pushViewController:[DVVUserManager loginController] animated:NO];
            return;
        }
        
        if (![AcountManager manager].applyschool.infoId) {
            [self obj_showTotasViewWithMes:@"您还没有预约"];
            return ;
        }
        
        ShuttleBusController *shuttleBusVC = [ShuttleBusController new];
        [self controller:shuttleBusVC];
    }
    if (indexPath.row == 4) {
        // 我的钱包
    }
    if (indexPath.row == 5) {
        // 我要投诉
        YBComplaintController *complaintVC = [[YBComplaintController alloc] init];
        [self controller:complaintVC];
    }
    if (indexPath.row == 6) {
        // 一步优势
        HomeAdvantageController *advantageVC = [[HomeAdvantageController alloc] init];
        [self controller:advantageVC];
    }
    if (indexPath.row == 7) {
        // 设置与帮助
        // 检测是否打开登录页
        if (![AcountManager isLogin]) {
            [DVVUserManager loginController].hidesBottomBarWhenPushed = YES;
            [self showHome];
            [self.baomingVC.navigationController pushViewController:[DVVUserManager loginController] animated:NO];
            return;
        }
        SetupViewController *setUpVC = [SetupViewController new];
        [self controller:setUpVC];

    }
    
}
// 点击头像编辑详情页
- (void)didSelectIconImage:(UITapGestureRecognizer *)gestureRecognizer{
    // 检测是否打开登录页
    if (![AcountManager isLogin]) {
        [DVVUserManager loginController].hidesBottomBarWhenPushed = YES;
        [self showHome];
        [self.baomingVC.navigationController pushViewController:[DVVUserManager loginController] animated:NO];
        return;
    }
    
//     EditorUserViewController *editorUserVC = [EditorUserViewController new];
    EditorMessageController *editorUserVC = [EditorMessageController new];
    [self controller:editorUserVC];

}
- (void)controller:(UIViewController *)itemVC{
    itemVC.hidesBottomBarWhenPushed = YES;
    [self showHome];
    switch (self.vcType) {
        case kYBSignUpViewController:
            [self.baomingVC.navigationController pushViewController:itemVC animated:NO];
            break;
        case kYBStudyViewController:
            [self.xuexiVC.navigationController pushViewController:itemVC animated:NO];
            break;
        case kYBAppointMentController:
            [self.yuyueVC.navigationController pushViewController:itemVC animated:NO];
            break;
        case kYBMallViewController:
            [self.shangchengVC.navigationController pushViewController:itemVC animated:NO];
            break;
        case kYBCommunityViewController:
            [self.shequVC.navigationController pushViewController:itemVC animated:NO];
            break;
        case kYBComplainViewController:
            [self.complaintVC.navigationController pushViewController:itemVC animated:NO];
            break;
        default:
            break;
    }

}
@end
