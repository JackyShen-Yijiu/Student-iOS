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
#import "HomeActivityController.h"
#import "JENetwoking.h"
#import "ToastAlertView.h"
#import "SearchCoachController.h"
#import "DiscountWalletController.h"
#import "SignInViewController.h"

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
        case 1:// 查找驾校/教练
        {
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                break;
            }
            
            UIViewController *controller = nil;
            if ([AcountManager manager].userLocationShowType == kLocationShowTypeDriving) {
                controller = [DrivingViewController new];
            }else {
                controller = [SearchCoachController new];
            }
            
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
            
        case 4:// 活动
        {
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                break;
            }
            
            NSString *urlString = [NSString stringWithFormat:@"getactivity"];
            NSString *url = [NSString stringWithFormat:BASEURL,urlString];
            NSLog(@"userCity === %@", [AcountManager manager].userCity);
            [JENetwoking startDownLoadWithUrl:url postParam:@{ @"cityname": [AcountManager manager].userCity } WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
                NSLog(@"%@",data);
                [self loadActivityWithData:data];
            } withFailure:^(id data) {
                [self showMsg:@"网络错误"];
            }];
        }
            break;
            
        case 5:// 签到
        {
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                break;
            }
            
            SignInViewController *controller = [SignInViewController new];
            
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
        case 10:// 兑换劵
        {
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                break;
            }
            
            DiscountWalletController *controller = [DiscountWalletController new];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
            [naviVC pushViewController:controller animated:YES];
        }
            break;
        case 11:// 积分商城
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

            
        default:
            break;
    }
}

+ (void)loadActivityWithData:(id)data {
    
    NSDictionary *rootDict = data;
    if (![rootDict objectForKey:@"type"]) {
        [self showMsg:@"暂时还没有活动哟"];
        return ;
    }
    if (![[rootDict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
        [self showMsg:@"暂时还没有活动哟"];
        return ;
    }
    NSArray *array = [rootDict objectForKey:@"data"];
    if (![array isKindOfClass:[NSArray class]]) {
        [self showMsg:@"暂时还没有活动哟"];
        return ;
    }
    NSDictionary *paramsDict = [array firstObject];
    if (![paramsDict isKindOfClass:[NSDictionary class]]) {
        [self showMsg:@"暂时还没有活动哟"];
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
    
    HomeActivityController *activityVC = [HomeActivityController new];
    activityVC.title = title;
    activityVC.activityUrl = contentUrl;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
    [naviVC pushViewController:activityVC animated:YES];
}

+ (void)showMsg:(NSString *)msg {
    ToastAlertView *toast = [[ToastAlertView alloc] initWithTitle:msg];
    [toast show];
}

@end
