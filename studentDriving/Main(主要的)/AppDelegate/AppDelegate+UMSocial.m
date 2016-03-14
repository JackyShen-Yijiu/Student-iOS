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
    [UMSocialWechatHandler setWXAppId:@"wxb815a53dcb2faf06" appSecret:@"2637931343bdd1d1991fcef1b28a187a" url:@"http://www.ybxch.com/"];
    
    // 添加QQ
    [UMSocialQQHandler setQQWithAppId:@"1105047313" appKey:@"V2WpihDDnIaxxXwL" url:@"http://www.ybxch.com/"];
    
    // 添加新浪微博分享
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"16181237" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
}



@end
