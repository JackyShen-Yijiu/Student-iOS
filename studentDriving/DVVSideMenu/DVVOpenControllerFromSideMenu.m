//
//  DVVOpenControllerFromSideMenu.m
//  DVVSideMenu
//
//  Created by 大威 on 15/12/22.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "DVVOpenControllerFromSideMenu.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HomeMainController.h"
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
            UINavigationController *naviController = nil;
            
            DrivingViewController *controller = [DrivingViewController new];
            naviController = [[UINavigationController alloc]initWithRootViewController:controller];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = naviController;
            [window makeKeyAndVisible];
        }
            break;
        case 2:// 消息
        {
            UINavigationController *naviController = nil;
            
            ChatListViewController *controller = [ChatListViewController new];
            naviController = [[UINavigationController alloc]initWithRootViewController:controller];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = naviController;
            [window makeKeyAndVisible];
        }
            break;
        case 3:// 钱包
        {
            UINavigationController *naviController = nil;
            
            MyWalletViewController *controller = [MyWalletViewController new];
            naviController = [[UINavigationController alloc]initWithRootViewController:controller];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = naviController;
            [window makeKeyAndVisible];
        }
            break;
        case 4:// 我
        {
            UINavigationController *naviController = nil;
            
            UserCenterViewController *controller = [UserCenterViewController new];
            naviController = [[UINavigationController alloc]initWithRootViewController:controller];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = naviController;
            [window makeKeyAndVisible];
        }
            break;
            
        default:
            break;
    }
}

@end
