//
//  DVVUserManager.m
//  studentDriving
//
//  Created by 大威 on 15/12/24.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DVVUserManager.h"
#import "DVVOpenControllerFromSideMenu.h"
#import "YBLoginController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "JZAutoLoginController.h"

@implementation DVVUserManager

// 获得登录窗体
+ (UIViewController *)loginController {
    
    static JZAutoLoginController *loginVC = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        loginVC = [JZAutoLoginController new];
    });
    return loginVC;
}

// 打开登录窗体
+ (void)userNeedLogin {
    
    if ([AcountManager isLogin]) {

        [UIApplication sharedApplication].keyWindow.rootViewController = [[JZAutoLoginController alloc] init];

    }else{
        
        JZAutoLoginController *vc = [[JZAutoLoginController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
        
    }
    
}

// 用户登录成功后调用此方法打开主页
+ (void)userLoginSucces {
    
    if ([AcountManager isLogin]) {
        
        [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];

    }else{
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [[ViewController alloc] init];

    }

}

+ (void)loginSuccsssAndSetupMainVc
{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[ViewController alloc] init];
}

// 用户退出登录后调用此方法
+ (void)userLogout {
    [DVVOpenControllerFromSideMenu openControllerWithControllerType:kOpenControllerTypeHomeMainController];
    [self userNeedLogin];
}

// 用户需要随便看看时调用此方法
+ (void)userNeedBrowsing {
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[ViewController alloc] init];
    
    //    [[self loginController].navigationController dismissViewControllerAnimated:YES completion:nil];
    //    [[self loginController].navigationController popToRootViewControllerAnimated:YES];
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
