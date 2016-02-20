//
//  DVVUserManager.m
//  studentDriving
//
//  Created by 大威 on 15/12/24.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DVVUserManager.h"
#import "DVVOpenControllerFromSideMenu.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@implementation DVVUserManager

// 获得登录窗体
+ (UIViewController *)loginController {
    
    static LoginViewController *loginVC = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        loginVC = [LoginViewController new];
    });
    return loginVC;
}

// 打开登录窗体
+ (void)userNeedLogin {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [(UINavigationController *)(window.rootViewController) pushViewController:[self loginController] animated:YES];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [(UINavigationController *)(window.rootViewController) dismissViewControllerAnimated:YES completion:nil];
//    [(UINavigationController *)(window.rootViewController) pushViewController:[self loginController] animated:YES];
    
}

// 用户登录成功后调用此方法打开主页
+ (void)userLoginSucces {
    
    [[self loginController].navigationController popToRootViewControllerAnimated:NO];
    //[self showNaviBar];
}

// 用户退出登录后调用此方法
+ (void)userLogout {
    [DVVOpenControllerFromSideMenu openControllerWithControllerType:kOpenControllerTypeHomeMainController];
    [self userNeedLogin];
}

// 用户需要随便看看时调用此方法
+ (void)userNeedBrowsing {
    
    [[self loginController].navigationController popToRootViewControllerAnimated:YES];
//    [self showNaviBar];
}

// 显示naviBar
+ (void)showNaviBar {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
    naviVC.navigationBarHidden = NO;
}

+ (void)pushController:(UIViewController *)controller {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
    [naviVC pushViewController:controller animated:YES];
}

@end
