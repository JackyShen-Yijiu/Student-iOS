//
//  IWTabBarViewController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTabBarViewController.h"
#import "IWTabBarButton.h"

@interface IWTabBarViewController ()<IWTabBarDelegate,YBHomeBaseControllerDelegate>

@property (nonatomic,weak) IWTabBar *customTabbar;

@property (nonatomic, assign) NSUInteger curSelectedIndex;

@end

@implementation IWTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpSubViews];
    
    self.curSelectedIndex = 0;
    
     // 判断进度
     if ([AcountManager isLogin] && [AcountManager manager].userSubject) {
     
     if ([[AcountManager manager].userSubject.subjectId isEqual:@(1)]){

         [self changeVc:1];

     }else if ([[AcountManager manager].userSubject.subjectId isEqual:@(2)]){

         [self changeVc:2];

     }else if ([[AcountManager manager].userSubject.subjectId isEqual:@(3)]){

         [self changeVc:2];

     }else if ([[AcountManager manager].userSubject.subjectId isEqual:@(4)]){

         [self changeVc:1];
     
     }
     
     }
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 初始化tabbar
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    
}

- (void)setUpSubViews
{
    IWTabBar *customTabbar = [[IWTabBar alloc] init];
    customTabbar.frame = self.tabBar.bounds;
    customTabbar.delegate = self;
    [self.tabBar addSubview:customTabbar];
    self.customTabbar = customTabbar;
    
    self.baomingVC = [[YBSignUpViewController alloc] init];
    [self setUpTabbarVc:self.baomingVC title:@"报名" image:@"YBTabbarapply" selectedImage:@"YBTabbarapply_fill"];
    
    self.xuexiVC = [[YBStudyViewController alloc] init];
    [self setUpTabbarVc:self.xuexiVC title:@"学习" image:@"YBTabbarlearn" selectedImage:@"YBTabbarlearn_fill"];
    
    self.yuyueVC = [[YBAppointMentController alloc] init];
    [self setUpTabbarVc:self.yuyueVC title:@"预约" image:@"YBTabbarorder" selectedImage:@"YBTabbarorder_fill"];
    
    self.shangchengVC = [[YBMallViewController alloc] init];
    [self setUpTabbarVc:self.shangchengVC title:@"商城" image:@"YBTabbarshop" selectedImage:@"YBTabbarshop_fill"];
        
}

- (void)setUpTabbarVc:(YBHomeBaseController *)vc title:(NSString *)title image:(NSString *)img selectedImage:(NSString *)selectedImage
{
    
    vc.view.frame = [[UIScreen mainScreen] bounds];
    vc.delegate = self;
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:img];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 设置tabbar字体颜色
    //    self.tabBarController.tabBar.tintColor = YBNavigationBarBgColor;
    
    self.mainNav = [[WMNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:self.mainNav];
    
    NSDictionary *textAttributes1 = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.f],
                                      NSForegroundColorAttributeName: [UIColor whiteColor]
                                      };
    [[self.mainNav navigationBar]  setTitleTextAttributes:textAttributes1];
    
    // 添加内部按钮
    [self.customTabbar addTabBarButtonWithItem:vc.tabBarItem];
    
}


- (void)changeVc:(NSInteger)number
{
    NSArray *buttonArray = self.customTabbar.tabBarButtons;
    
    if (buttonArray && buttonArray.count > 1) {
        
        IWTabBarButton *button = [buttonArray objectAtIndex:number];
        self.customTabbar.selectedButton.selected = NO;
        button.selected = YES;
        self.customTabbar.selectedButton = button;
        
    }
    [self tabBar:self.customTabbar didSelectedButtonFrom:self.selectedIndex to:number];
    
}

- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(NSUInteger)from to:(NSUInteger)to
{

    NSLog(@"to:%lu",(unsigned long)to);
    self.vcType = to;
    self.selectedIndex = to;
    
}

- (void)leftBtnClicked
{
    if ([self.delegate respondsToSelector:@selector(IWTabBarViewControllerWithLeftBarDidClick)]) {
        [self.delegate IWTabBarViewControllerWithLeftBarDidClick];
    }
}

@end
