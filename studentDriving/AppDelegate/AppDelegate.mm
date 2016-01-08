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
#import "ToolHeader.h"
#import "AppDelegate+DealJPushMessage.h"
#import "AppDelegate+DealTool.h"
#import "EaseMob.h"
#import "AppDelegate+EaseMob.h"
#import "ChatListViewController.h"
#import <UMengAnalytics-NO-IDFA/MobClick.h>
#import "RESideMenu.h"
#import "MenuController.h"
#import "YBWelcomeController.h"
#import "DVVSideMenu.h"

#import "DVVUserManager.h"
#import "DVVOpenControllerFromSideMenu.h"
#import "AFNetworkActivityLogger.h"
// 容错处理
#import "LJException.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 容错处理
    [LJException startExtern];
    
    [[AFNetworkActivityLogger sharedLogger] startLogging];

    _connectionState = eEMConnectionConnected;

    [MobClick startWithAppkey:@"564cba17e0f55ae100005919" reportPolicy:BATCH   channelId:@""];
    
    [self configBaiduMap];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
#pragma mark - 处理工具及样式
    [self dealTool];
#pragma mark - 监听网络
    [NetMonitor manager];
    
#pragma mark - JPush
    [self JPushApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    //注册环信聊天
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    // 打开主页
    [DVVOpenControllerFromSideMenu openControllerWithControllerType:kOpenControllerTypeHomeMainController];
    
    // 检测是否打开登录页
    if (![AcountManager isLogin]) {
        [(UINavigationController *)(self.window.rootViewController) pushViewController:[DVVUserManager loginController] animated:NO];
    }
    
    // 引导页
//    [YBWelcomeController removeSavedVersion];
    if ([YBWelcomeController isShowWelcome]) {
        [YBWelcomeController show];
    }
    
    // 设置StatusBarStyle为白色（需要在在infor.plist中加入key:UIViewControllerBasedStatusBarAppearance 并设置其值为NO）
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}


- (void)configBaiduMap {
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"qiKrc3cgNa2iFSWexjqstZ22" generalDelegate:self];
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


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    DYNSLog(@"UILocalNotification = %@",notification);
    
    NSString *info = notification.userInfo[@"ConversationChatter"];
    if (info) {
        [_main dealInfo:notification.userInfo];
    }
#pragma mark - JPush推送
    [self JPushApplication:application didReceiveLocalNotification:notification];
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
#pragma mark - JPush注册token require
    [APService registerDeviceToken:deviceToken];
    
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    DYNSLog(@"userInfo = %@",userInfo);
    NSString *info = userInfo[@"ConversationChatter"];
    if (info) {
        ChatListViewController *chatlist = [[ChatListViewController alloc] init];
        [[HMControllerManager slideMainNavController] pushViewController:chatlist animated:YES];
    }
#pragma mark - JPush接受推送消息 require
    [self JPushApplication:application didReceiveRemoteNotification:userInfo];
    
    
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
    completionHandler(UIBackgroundFetchResultNewData);
    //推送消息统一处理
#warning YJG APP在前台接受到消息推送，处理消息逻辑
#warning YJG APP在在后台，点击消息提醒，唤醒APP，处理消息逻辑

#warning YJG 服务器发送 APP在前台接受到消息推送，处理消息逻辑
/*
 {
 "_j_msgid" = 1612910701;
 aps =     {
   alert = "\U60a8\U5df2\U6210\U529f\U62a5\U540d\U9a7e\U6821\Uff0c\U8d76\U5feb\U5f00\U542f\U5b66\U8f66\U4e4b\U65c5\U5427";
   badge = 1;
   sound = "sound.caf";
 };
 data =     {
   userid = 5644b9549aedea5c3e02a4ac;
 };
 type = userapplysuccess;
 }
 */
    DYNSLog(@"userInfo = %@",userInfo);
#pragma mark - 推送消息统一接受JPush
    [self JPushfetchCompletionHandlerApplication:application didReceiveRemoteNotification:userInfo];
    
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
    
    // 当程序由后台进入前台后，调用检查活动的方法，检查今天是否有活动
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kCheckActivity" object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)didReceiveMessage:(EMMessage *)message
{
    
    NSLog(@"message.messageBodies:%@",message.messageBodies);
    
    if (([UIApplication sharedApplication].applicationState == UIApplicationStateActive) && [[NSUserDefaults standardUserDefaults] boolForKey:@"isInChatVc"]==YES) {
        return;
    }
    
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    notification.alertBody = [NSString stringWithFormat:@"%@",@"你有一条新消息,快点击查看吧"];
    
    notification.alertAction = NSLocalizedString(@"打开", @"打开");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
        
    });
    
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount;

}

@end
