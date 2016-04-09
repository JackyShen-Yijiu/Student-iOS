//
//  AppDelegate+UMSocial.m
//  DVVTestUMSocial
//
//  Created by 大威 on 16/1/23.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import "AppDelegate+UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"

@implementation AppDelegate (UMSocial)

- (void)configUMSocial {
    
    // 配置友盟分享
    [UMSocialData setAppKey:umengAppkey];
    
    // 添加微信
    [UMSocialWechatHandler setWXAppId:weixinApp_ID appSecret:weixinApp_Secret url:@"http://www.jizhijiafu.cn/"];
    
    // 添加QQ
    [UMSocialQQHandler setQQWithAppId:@"1105167294" appKey:@"sk0sNHbwgipoGI00" url:@"http://www.jizhijiafu.cn/"];
    
    // 添加新浪微博分享
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1218454084" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
}



@end
