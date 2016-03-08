//
//  AppDelegate+DealJPushMessage.m
//  studentDriving
//
//  Created by bestseller on 15/11/13.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "AppDelegate+DealJPushMessage.h"
#import "ToolHeader.h"
#import "BLPFAlertView.h"
#import "PushInformationManager.h"

@implementation AppDelegate (DealJPushMessage)
#pragma mark - JPush 载入

- (void)JPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        DYNSLog(@"launchOptions");
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert) categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert) categories:nil];
    }
    // Required
    [APService setupWithOption:launchOptions];

    if ([AcountManager manager].userid) {
        NSString *str = @"";
        if ([AcountManager manager].applyschool.infoId != nil && ![[AcountManager manager].applyschool.infoId isEqualToString:@""]) {
            str = [AcountManager manager].applyschool.infoId;
        }
        NSSet *set = [NSSet setWithObjects:str, nil];
        [APService setTags:set alias:[AcountManager manager].userid callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
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

#pragma mark - 接受推送消息
- (void)JPushApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];

}
#pragma mark - 统一处理消息
- (void)JPushfetchCompletionHandlerApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSLog(@"JPushfetchCompletionHandlerApplication userInfo:%@",userInfo);
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    
    [[NSNotificationCenter defaultCenter] postNotificationName:YBNotif_HandleNotification object:nil userInfo:userInfo];
    
#endif
    
}

@end
