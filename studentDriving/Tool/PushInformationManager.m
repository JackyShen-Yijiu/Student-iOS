//
//  PushInformationManager.m
//  studentDriving
//
//  Created by bestseller on 15/11/11.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "PushInformationManager.h"
#import "AcountManager.h"
#import "MyWalletViewController.h"
#import "AppointmentDetailViewController.h"
#import "DVVOpenControllerFromSideMenu.h"
@implementation PushInformationManager

+ (void)receivePushInformation:(NSDictionary *)pushInformation {
    
    DYNSLog(@"推送统一处理消息");
    if (pushInformation == nil) {
        return;
    }
    NSString *type = [NSString stringWithFormat:@"%@", pushInformation[@"type"]];
    
    if ([type isEqualToString:@"userapplysuccess"]) {
        
        NSLog(@"kuserapplysuccess 报名成功");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kuserapplysuccess" object:nil];
        
    }else if ([type isEqualToString:@"reservationsuccess"]) {
        
        //reservationid
        DYNSLog(@"接受到教练确认订单信息");
        NSString *string = [NSString stringWithFormat:@"%@",pushInformation[@"data"][@"reservationid"]];
        AppointmentDetailViewController *detail = [[AppointmentDetailViewController alloc] init];
        detail.isPushInformation = YES;
        detail.infoId = string;
        detail.state = AppointmentStateCoachConfirm;
        [[HMControllerManager slideMainNavController] pushViewController:detail animated:YES];
        
        
    }else if ([type isEqualToString:@"reservationcancel"]) {
        
        DYNSLog(@"接受到教练取消订单信息");
        NSString *string = [NSString stringWithFormat:@"%@",pushInformation[@"data"][@"reservationid"]];
        AppointmentDetailViewController *detail = [[AppointmentDetailViewController alloc] init];
        detail.isPushInformation = YES;
        detail.infoId = string;
        detail.state = AppointmentStateCoachCancel;
        [[HMControllerManager slideMainNavController] pushViewController:detail animated:YES];
        
    }else if ([type isEqualToString:@"reservationcoachcomment"]) {
        
        NSLog(@"reservationcoachcomment");
        
    }else if ([type isEqualToString:@"walletupdate"]) {
        
//        MyWalletViewController *detail = [[MyWalletViewController alloc] init];
        [DVVOpenControllerFromSideMenu openControllerWithControllerType:kOpenControllerTypeMyWalletViewController];
        
    }
    
    
    
}

@end
