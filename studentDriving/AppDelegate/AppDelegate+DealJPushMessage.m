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
    NSString *type = [NSString stringWithFormat:@"%@", userInfo[@"type"]];
    NSLog(@"_______%ld",(long)application.applicationState);
    if (application.applicationState == UIApplicationStateActive) {
        
        [BLPFAlertView showAlertWithTitle:@"提示" message:userInfo[@"aps"][@"alert"] cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
            DYNSLog(@"selected = %ld",selectedOtherButtonIndex);
            if (selectedOtherButtonIndex == 0) {
                [PushInformationManager receivePushInformation:userInfo];
            }
        }];
        
    }else if ([type isEqualToString:@"newversion"]) {
        
        [BLPFAlertView showAlertWithTitle:@"提示" message:userInfo[@"aps"][@"alert"] cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
            DYNSLog(@"selected = %ld",selectedOtherButtonIndex);
            if (selectedOtherButtonIndex == 0) {
                NSLog(@"跳转到appstore更新版本....待处理");
            }
        }];
    }
    else {
        [PushInformationManager receivePushInformation:userInfo];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
#endif
    [APService handleRemoteNotification:userInfo];
}


@end
