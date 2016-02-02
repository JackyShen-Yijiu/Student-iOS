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

//        {
//            "_j_msgid" = 3729781907;
//            aps =     {
//                alert = "\U60a8\U9884\U7ea6\U7684\U8bfe\U7a0b\U5df2\U88ab\U63a5\U53d7\Uff0c\U8bf7\U5230\U9884\U7ea6\U8be6\U60c5\U91cc\U67e5\U770b";
//                badge = 1;
//                sound = "sound.caf";
//            };
//            data =     {
//                reservationid = 56b07580efe9248328d3428d;
//                userid = 56937987e6b6a92c09a54d6b;
//            };
//            type = reservationsuccess;
//        }

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
        [DVVUserManager pushController:detail];
        
        
    }else if ([type isEqualToString:@"reservationcancel"]) {
        
        DYNSLog(@"接受到教练取消订单信息");
        NSString *string = [NSString stringWithFormat:@"%@",pushInformation[@"data"][@"reservationid"]];
        AppointmentDetailViewController *detail = [[AppointmentDetailViewController alloc] init];
        detail.isPushInformation = YES;
        detail.infoId = string;
        detail.state = AppointmentStateCoachCancel;
        [DVVUserManager pushController:detail];
        
    }else if ([type isEqualToString:@"reservationcoachcomment"]) {
        // 获取到教练评价
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"有教练对您评价啦，赶快去查看吧！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
        
    }else if ([type isEqualToString:@"walletupdate"]) {
        // 钱包更新

//        MyWalletViewController *detail = [[MyWalletViewController alloc] init];
        [DVVOpenControllerFromSideMenu openControllerWithControllerType:kOpenControllerTypeMyWalletViewController];
    }else if ([type isEqualToString:@"systemmsg"]) {
        // 系统消息
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您有一条系统消息，赶快去查看吧！" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
//        [DVVOpenControllerFromSideMenu openControllerWithControllerType:kOpenControllerTypeChatListViewController];
    }
}

@end
