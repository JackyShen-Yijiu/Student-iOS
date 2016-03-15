//
//  YBAppointmentInTool.h
//  studentDriving
//
//  Created by 大威 on 16/3/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBAppointmentTool : NSObject

/**
*  检查是否可以签到
*
*  @param beginTime 开始的时间（后台返回的UTC时间）
*  @param endTime   结束的时间（后台返回的UTC时间）
*
*  @return YES:可以签到
*/
+ (BOOL)checkSignInWithBeginTime:(NSString *)beginTime
                         endTime:(NSString *)endTime;

/**
 *  检查是否可以取消预约
 *
 *  @param beginTime 开始的时间（后台返回的UTC时间）
 *
 *  @return YES:可以签到
 */
+ (BOOL)checkCancelAppointmentWithBeginTime:(NSString *)beginTime;

@end
