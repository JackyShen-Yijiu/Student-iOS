//
//  AppDelegate+DealJPushMessage.m
//  studentDriving
//
//  Created by bestseller on 15/11/13.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "AppDelegate+DealJPushMessage.h"
#import "ToolHeader.h"
#import "PFAlertView.h"
#import "PushInformationManager.h"
@implementation AppDelegate (DealJPushMessage)
#pragma mark - JPush 载入

- (void)JPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert) categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert) categories:nil];
    }
    // Required
    [APService setupWithOption:launchOptions];
    if ([AcountManager manager].userid) {
        [APService setAlias:[AcountManager manager].userid callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    }
}
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
     tags, alias];
    DYNSLog(@"TagsAlias回调:%@", callbackString);
}
#pragma mark - 接受到本地通知
- (void)JPushApplication:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
}

#pragma mark - 注册token
- (void)JPushApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
     [APService registerDeviceToken:deviceToken];
}
#pragma mark - 接受推送消息
- (void)JPushApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];

}
#pragma mark - 统一处理消息
- (void)JPushfetchCompletionHandlerApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    NSString *type = [NSString stringWithFormat:@"%@", userInfo[@"data"][@"type"]];
    if (application.applicationState == UIApplicationStateActive) {
        [PFAlertView showAlertWithTitle:@"提示" message:userInfo[@"aps"][@"alert"] cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
            DYNSLog(@"selected = %ld",selectedOtherButtonIndex);
            if (selectedOtherButtonIndex == 0) {
                [PushInformationManager receivePushInformation:userInfo];
            }
        }];
    }else if ([type isEqualToString:@"newversion"]) {
        [PFAlertView showAlertWithTitle:@"提示" message:userInfo[@"aps"][@"alert"] cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
            DYNSLog(@"selected = %ld",selectedOtherButtonIndex);
            if (selectedOtherButtonIndex == 0) {
                
            }
        }];
    }
    else {
        [PushInformationManager receivePushInformation:userInfo];
    }
#endif
    [APService handleRemoteNotification:userInfo];
}


@end
