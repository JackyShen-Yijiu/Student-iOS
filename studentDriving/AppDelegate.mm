//
//  AppDelegate.m
//  BlackCat
//
//  Created by bestseller on 15/9/1.
//  Copyright (c) 2015年 lord. All rights reserved.
// http://www.mm131.com/xinggan/

//http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/0013743256916071d599b3aed534aaab22a0db6c4e07fd0000
/*
 七牛    https://portal.qiniu.com/用户名simplewy@126.com
  密码p@ssw0rd！
 手机：17710632338
 汪渊
 北京交安通达信息技术有限公司
 -----------------------------------------------------------极光推送   https://www.jpush.cn/用户名 ：  BlackCat密码  p@ssw0rd！
 qq：63535754
 -------------------------------------------------环信   https://console.easemob.com/
 企业id Black-Cat用户名  Black-Cat密码   p@ssw0rd！-------------------------------------------------友盟  http://www.umeng.com/users/sign_up
 用户名simplewy@126.com
  密码p@ssw0rd！手机：17710632338
 
 百度：jatd_app@126.com,密码jatd2015
 汪渊
 北京交安通达信息技术有限公司
 
 //友盟
 564cba17e0f55ae100005919
 
 */
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "ToolHeader.h"
#import "AppDelegate+DealJPushMessage.h"
#import "AppDelegate+DealTool.h"
#import <EaseMobHeaders.h>
#import "AppDelegate+EaseMob.h"
#import "ChatListViewController.h"
#import <UMengAnalytics-NO-IDFA/MobClick.h>
@interface AppDelegate ()
@property (strong, nonatomic)  MainViewController *main;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _connectionState = eEMConnectionConnected;

    [MobClick startWithAppkey:@"564cba17e0f55ae100005919" reportPolicy:BATCH   channelId:@""];

    
    [self configBaiduMap];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.main = [[MainViewController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:_main];
    
    self.window.rootViewController = mainNav;
    
    
    
    [self.window makeKeyAndVisible];
    
    if (![AcountManager isLogin]) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.window.rootViewController presentViewController:login animated:YES completion:nil];
    }
    
    
#pragma mark - 处理工具及样式
    [self dealTool];
#pragma mark - 监听网络
    [NetMonitor manager];
#pragma mark - JPush
    [self JPushApplication:application didFinishLaunchingWithOptions:launchOptions];

    
    //注册环信聊天
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    
    
    return YES;
}


- (void)configBaiduMap {
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"PSwEai4xM5aEtgHIsyqiTOrW" generalDelegate:self];
    if (!ret) {
        NSLog(@"初始化失败 = %d",ret);
    }
}

- (void)onGetNetworkState:(int)iError{
    NSLog(@"%d",iError);
}

- (void)onGetPermissionState:(int)iError {
    NSLog(@"%d",iError);
}

//-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//    DYNSLog(@"test");
//    if (self.allowRotation) {
//        return UIInterfaceOrientationMaskAll;
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    DYNSLog(@"UILocalNotification = %@",notification);
    NSString *info = notification.userInfo[@"ConversationChatter"];
    if (info) {
        [_main dealInfo:notification.userInfo];
    }
#pragma mark - JPush推送
    [self JPushApplication:application didReceiveLocalNotification:notification];
    
    return;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
#pragma mark - JPush注册token require
    [self JPushApplication:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];


    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    DYNSLog(@"userInfo = %@",userInfo);
    NSString *info = userInfo[@"ConversationChatter"];
    if (info) {
        ChatListViewController *chatlist = [[ChatListViewController alloc] init];
        UINavigationController *nav = (UINavigationController *) [UIApplication sharedApplication].keyWindow.rootViewController;
        [nav pushViewController:chatlist animated:YES];
    }
#pragma mark - JPush接受推送消息 require
    [self JPushApplication:application didReceiveRemoteNotification:userInfo];
    
    
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    DYNSLog(@"userInfo = %@",userInfo);
#pragma mark - 推送消息统一接受JPush
    [self JPushfetchCompletionHandlerApplication:application didReceiveRemoteNotification:userInfo];
    
    
    
    
    
    
    completionHandler(UIBackgroundFetchResultNewData);
    //推送消息统一处理
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
