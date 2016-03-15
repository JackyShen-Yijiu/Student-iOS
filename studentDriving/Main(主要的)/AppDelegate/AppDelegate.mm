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

#import "AppDelegate+DealJPushMessage.h"
#import "AppDelegate+DealTool.h"
#import "EaseMob.h"
#import "AppDelegate+EaseMob.h"
#import "ChatListViewController.h"
#import <UMengAnalytics-NO-IDFA/MobClick.h>
#import "YBWelcomeController.h"
#import "DVVSideMenu.h"

#import "DVVUserManager.h"
#import "DVVOpenControllerFromSideMenu.h"
#import "AFNetworkActivityLogger.h"
// 容错处理
#import "LJException.h"
#import "AppDelegate+UMSocial.h"
#import "AlipaySDK/AlipaySDK.h"
#import "AlixPayResult.h"
#import "WMCommon.h"
#import "ViewController.h"
#import "WXApi.h"

// 检查活动
#import "YBActivity.h"
// crash后给用户提示
#import "DVVCrashHandler.h"

@interface AppDelegate ()<UIAlertViewDelegate,WXApiDelegate>
{
    BOOL isReceiveMessage;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 添加crash后弹出提示
    dvv_installCrashExceptionHandler();
    
    // 容错处理
    [LJException startExtern];
    
    [[AFNetworkActivityLogger sharedLogger] startLogging];

    _connectionState = eEMConnectionConnected;

    [MobClick startWithAppkey:umengAppkey reportPolicy:BATCH   channelId:@""];
    
    // 配置百度地图
    [self configBaiduMap];
    // 配置友盟分享
    [self configUMSocial];
    
#pragma mark - 处理工具及样式
    [self dealTool];
#pragma mark - 监听网络
    [NetMonitor manager];
    
#pragma mark - JPush
    [self JPushApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    //注册环信聊天
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    WMCommon *common = [WMCommon getInstance];
    common.screenW = [[UIScreen mainScreen] bounds].size.width;
    common.screenH = [[UIScreen mainScreen] bounds].size.height;
    
    // 引导页
    if ([YBWelcomeController isShowWelcome]) {
        
        self.window.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = [[YBWelcomeController alloc] init];
        
    }else{
        
        if ([AcountManager isLogin]) {
            [DVVUserManager userLoginSucces];
        }else{
            [DVVUserManager userNeedLogin];
        }
        
    }
    
    BOOL isok = [WXApi registerApp:weixinApp_ID withDescription:@"微信支付2.0"];
    if (isok) {
        NSLog(@"微信注册成功");
    }else{
        NSLog(@"微信注册失败");
    }
    
    // 设置StatusBarStyle为白色（需要在在infor.plist中加入key:UIViewControllerBasedStatusBarAppearance 并设置其值为NO）
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}

- (void)configBaiduMap {
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:baiduMapAppkey generalDelegate:self];
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

- (void)didReceiveMessage:(EMMessage *)message
{
    
    NSLog(@"didReceiveMessage message.messageBodies:%@",message.messageBodies);
    
    if (([UIApplication sharedApplication].applicationState == UIApplicationStateActive)&&([[NSUserDefaults standardUserDefaults] boolForKey:@"isInChatVc"])) {
        return;
    }
    
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    notification.alertBody = [NSString stringWithFormat:@"%@",@"你有一条新消息,快点击查看吧"];
    notification.alertAction = NSLocalizedString(@"确定", @"确定");
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

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    DYNSLog(@"接收到环信推送通知UILocalNotification = %@",notification);
    
    NSString *info = notification.userInfo[@"ConversationChatter"];
    if (info) {
        [_main dealInfo:notification.userInfo];
    }
#pragma mark - JPush推送
    
    NSLog(@"[UIApplication sharedApplication].applicationState:%ld",(long)[UIApplication sharedApplication].applicationState);
    
        NSLog(@"----------");
        
        if (isReceiveMessage==NO) {
            isReceiveMessage=YES;
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"你有一条新消息,快点击查看吧" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
        

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    isReceiveMessage = NO;
    // 跳转到消息列表
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveMainChatMessage" object:self];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
#pragma mark - JPush注册token require
    [APService registerDeviceToken:deviceToken];
    
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];

}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    
//#pragma mark - JPush接受推送消息 require
//    [self JPushApplication:application didReceiveRemoteNotification:userInfo];
//}

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
    
    /*
     jpush后台自定义消息：
     {
     "_j_msgid" = 927937560;
     aps =     {
         alert = "\U6d4b\U8bd5\U63a8\U9001\U6d88\U606f";
         badge = 1;
         sound = default;
     };
     }
     */
    DYNSLog(@"userInfo = %@",userInfo);
#pragma mark - JPush推送消息统一接受
    [self JPushfetchCompletionHandlerApplication:application didReceiveRemoteNotification:userInfo];
#pragma mark - JPush接受推送消息 require
    [self JPushApplication:application didReceiveRemoteNotification:userInfo];
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    NSLog(@"openURL:%@",url);
    NSLog(@"url.host:%@",url.host);

    // 微信：openURL:wxb815a53dcb2faf06://pay/?returnKey=(null)&ret=-2
    // 微信: url.host:pay
    if (url.host && [url.host isEqualToString:@"pay"]) {// 微信支付
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    // yibuxuechePay://safepay/?%7B%22memo%22:%7B%22memo%22:%22%E7%94%A8%E6%88%B7%E4%B8%AD%E9%80%94%E5%8F%96%E6%B6%88%22,%22ResultStatus%22:%226001%22,%22result%22:%22%22%7D,%22requestType%22:%22safepay%22%7D
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        // 调用其他SDK，例如支付宝SDK等
        
        //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
        if ([url.host isEqualToString:@"safepay"]) {
            
            [[AlipaySDK defaultService]
             processOrderWithPaymentResult:url
             standbyCallback:^(NSDictionary *resultDic) {
                 
                 NSLog(@"application result = %@", resultDic);
                 
                 //结果处理
                 AlixPayResult* result = [AlixPayResult itemWithDictory:resultDic];
                 
                 if (result)
                 {
                     //                              状态返回9000为成功
                     if (result.statusCode == 9000)
                     {
                         /*
                          *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
                          */
                         NSLog(@"支付宝交易成功");
                         [self obj_showTotasViewWithMes:@"支付成功"];
                         
                         NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                         [user setBool:NO forKey:isPayErrorKey];
                         [user setObject:nil forKey:payErrorWithDictKey];
                         [user synchronize];
                         
                     }
                     else
                     {
                         //交易失败
                         NSLog(@"支付失败");
                         [self obj_showTotasViewWithMes:@"支付失败"];

                     }
                 }
                 else
                 {
                     //失败
                     NSLog(@"支付失败");
                     [self obj_showTotasViewWithMes:@"支付失败"];

                 }
                 
             }];
            
            return YES;
        }
        
    }
    
    return result;
}

- (void)onResp:(BaseResp *)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                
                [[NSNotificationCenter defaultCenter] postNotificationName:weixinpaySuccessNotification object:self];
                
                break;
                
            case WXErrCodeUserCancel:
                
                NSLog(@"用户点击取消");
                [[NSNotificationCenter defaultCenter] postNotificationName:weixinpayErrorNotification object:self];

                break;
                
            default:
                
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                
                [[NSNotificationCenter defaultCenter] postNotificationName:weixinpayErrorNotification object:self];
                
                break;
        }
    }
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
    //    
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
    [YBActivity checkActivity];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"kCheckActivity" object:nil];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
