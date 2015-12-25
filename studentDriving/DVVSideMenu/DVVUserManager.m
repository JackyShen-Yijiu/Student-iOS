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

// 用户是在打开APP时直接登录，还是通过随便看看登录（0：）
#define kUserBrowsingState @"kUserBrowsingState"

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
+ (void)openLoginController {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [(UINavigationController *)(window.rootViewController) pushViewController:[self loginController] animated:YES];
}

// 用户登录成功后调用此方法打开主页
+ (void)userLoginSucces {
    
    if ([self isBrowsing]) {
        [DVVOpenControllerFromSideMenu openControllerWithIndex:1];
    }else {
        [[self loginController].navigationController popToRootViewControllerAnimated:YES];
        // 显示naviBar
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
        naviVC.navigationBarHidden = NO;
    }
    // 取消用户的随便看看状态
    [self cancelUserBrowsingState];
}

// 用户需要随便看看时调用此方法
+ (void)userNeedBrowsing {
    
    // 保存用户的状态
    [self setUserIsBrowsingState];
    
    [[self loginController].navigationController popToRootViewControllerAnimated:YES];
    // 显示naviBar
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
    naviVC.navigationBarHidden = NO;
}

// 检测是否是通过随便看看进入的登录页
+ (BOOL)isBrowsing {
    
    NSString *browsingState = [[NSUserDefaults standardUserDefaults] objectForKey:kUserBrowsingState];
    if (browsingState) {
        if ([browsingState integerValue]) {
            return 1;
        }else {
            return 0;
        }
    }else {
        return 0;
    }
}

// 存储用户处于随便看看状态
+ (void)setUserIsBrowsingState {
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:kUserBrowsingState];
}
// 取消用户的随便看看状态
+ (void)cancelUserBrowsingState {
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:kUserBrowsingState];
}

@end
