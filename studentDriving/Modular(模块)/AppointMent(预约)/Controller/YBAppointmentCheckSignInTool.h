//
//  YBAppointmentCheckSignInTool.h
//  studentDriving
//
//  Created by 大威 on 16/3/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBAppointmentCheckSignInTool : NSObject

/**
 *
 *
 *  @return YES:可以签到
 */
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

@end
