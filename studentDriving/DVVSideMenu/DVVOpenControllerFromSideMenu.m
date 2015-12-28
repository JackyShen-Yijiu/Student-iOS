//
//  DVVOpenControllerFromSideMenu.m
//  DVVSideMenu
//
//  Created by 大威 on 15/12/22.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "DVVOpenControllerFromSideMenu.h"
#import "AppDelegate.h"
#import "AcountManager.h"
#import "DVVUserManager.h"
#import "LoginViewController.h"
#import "DrivingViewController.h"
#import "ChatListViewController.h"
#import "MyWalletViewController.h"
#import "UserCenterViewController.h"

@implementation DVVOpenControllerFromSideMenu

+ (void)openControllerWithIndex:(NSUInteger)idx {
    
    switch (idx) {
            break;
        case 0:// 主页
        {
            static UINavigationController *naviController = nil;
            
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                HomeMainController *controller = [HomeMainController new];
                naviController = [[UINavigationController alloc]initWithRootViewController:controller];
            });
            
            UIWindow *window = [[UIApplication sharedApplication] delegate].window;
            window.rootViewController = naviController;
            [window makeKeyAndVisible];
        }
            break;
        case 1:// 查找驾校
        {
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                break;
            }
            
            DrivingViewController *controller = [DrivingViewController new];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
            [naviVC pushViewController:controller animated:YES];
        }
            break;
        case 2:// 消息
        {
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                break;
            }
            
            ChatListViewController *controller = [ChatListViewController new];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
            [naviVC pushViewController:controller animated:YES];
        }
            break;
        case 3:// 钱包
        {
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                break;
            }
            
            MyWalletViewController *controller = [MyWalletViewController new];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
            [naviVC pushViewController:controller animated:YES];
        }
            break;
        case 6:// 我
        {
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                break;
            }
            
            UserCenterViewController *controller = [UserCenterViewController new];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
            [naviVC pushViewController:controller animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
