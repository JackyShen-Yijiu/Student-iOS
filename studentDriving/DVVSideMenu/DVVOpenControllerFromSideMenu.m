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
#import "SignInListController.h"
#import "MoneyShopController.h"
#import "JGActivityViewController.h"
#import "ComplaintController.h"
#import "ShuttleBusController.h"

@implementation DVVOpenControllerFromSideMenu

+ (void)openControllerWithControllerType:(kOpenControllerType)controllerType {
    
    switch (controllerType) {
            break;
        case kOpenControllerTypeHomeMainController:// 主页
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
        case kOpenControllerTypeDrivingViewController:// 查找驾校
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
        case kOpenControllerTypeChatListViewController:// 消息
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
        case kOpenControllerTypeShuttleBusController:// 消息
        {
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                break;
            }
            if (![AcountManager manager].applyschool.infoId) {
                [self showMsg:@"您还没有预约"];
                return ;
            }
            
            ShuttleBusController *controller = [ShuttleBusController new];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
            [naviVC pushViewController:controller animated:YES];
        }
            break;
        case kOpenControllerTypeMyWalletViewController:// 钱包
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
            
        case kOpenControllerTypeHomeActivityController:// 活动
        {
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                break;
            }
            
            JGActivityViewController *controller = [JGActivityViewController new];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
            [naviVC pushViewController:controller animated:YES];
//            
//            NSString *urlString = [NSString stringWithFormat:@"getactivity"];
//            NSString *url = [NSString stringWithFormat:BASEURL,urlString];
//            NSLog(@"userCity === %@", [AcountManager manager].userCity);
//            NSString *userCity = [AcountManager manager].userCity;
//            if (!userCity) {
//                userCity = @"";
//            }
//            [JENetwoking startDownLoadWithUrl:url postParam:@{ @"cityname": userCity } WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
//                NSLog(@"%@",data);
//                [self loadActivityWithData:data];
//            } withFailure:^(id data) {
//                [self showMsg:@"网络错误"];
//            }];
        }
            break;
        
        case kOpenControllerTypeComplaintController:// 投诉
        {
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                break;
            }
            
            ComplaintController *controller = [ComplaintController new];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
            [naviVC pushViewController:controller animated:YES];
            
        }
            break;
            
        case kOpenControllerTypeSignInViewController:// 签到
        {
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                break;
            }
            
            SignInListController *controller = [SignInListController new];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
            [naviVC pushViewController:controller animated:YES];
            
        }
            break;
            
        case kOpenControllerTypeUserCenterViewController:// 我
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
        case kOpenControllerTypeDiscountWalletController:// 兑换劵
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
        case kOpenControllerTypeMoneyShopController:// 可取现金额
        {
            if (![AcountManager isLogin]) {
                [DVVUserManager userNeedLogin];
                break;
            }
            
            MoneyShopController *controller = [MoneyShopController new];
            
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
    
    static HomeActivityController *activityVC = nil;
    activityVC = [HomeActivityController new];
    activityVC.title = title;
    activityVC.activityUrl = contentUrl;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
//    [naviVC pushViewController:activityVC animated:YES];
    [window addSubview:activityVC.view];
}

+ (void)showMsg:(NSString *)msg {
    ToastAlertView *toast = [[ToastAlertView alloc] initWithTitle:msg];
    [toast show];
}

@end
