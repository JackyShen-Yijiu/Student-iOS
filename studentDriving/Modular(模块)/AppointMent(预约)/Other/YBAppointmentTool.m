//
//  YBAppointmentTool.m
//  studentDriving
//
//  Created by 大威 on 16/3/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointmentTool.h"

@implementation YBAppointmentTool


+ (BOOL)checkSignInWithBeginTime:(NSString *)beginTime
                         endTime:(NSString *)endTime {
    
    // 将后台传回的时间转化为HH:mm格式的
    NSString *format = @"HH:mm";
    NSString *beginString = [self getLocalDateFormateUTCDate:beginTime format:format];
    
    NSString *endString = [self getLocalDateFormateUTCDate:endTime format:format];
    
    // 判断当前的时间是否可以签到
    NSString *currentHH = [self dateFromLocalWithFormatString:@"HH"];
    NSString *currentMM = [self dateFromLocalWithFormatString:@"mm"];
    NSString *beginHH = [beginString substringToIndex:2];
    NSString *endHH = [endString substringToIndex:2];
    
    BOOL flage = NO;
    // 在开始前的15分钟之内
    if ([currentHH integerValue] < [beginHH integerValue]) {
        if (1 == ([beginHH integerValue] - [currentHH integerValue])) {
            
            if (60 - [currentMM integerValue] <= 15) {
                flage = YES;
            }
        }
    }
    
    NSLog(@"currentHH: %@---beginHH: %@---endHH: %@", currentHH, beginHH, endHH);
    // 学车过程中
    if ([currentHH integerValue] < [endHH integerValue] && [currentHH integerValue] >= [beginHH integerValue]) {
        flage = YES;
    }
    
    return flage;
}

+ (BOOL)checkCancelAppointmentWithBeginTime:(NSString *)beginTime {
    
    NSString *yyyyStr = [self getLocalDateFormateUTCDate:beginTime format:@"yyyy"];
    NSString *MMStr = [self getLocalDateFormateUTCDate:beginTime format:@"MM"];
    NSString *ddStr = [self getLocalDateFormateUTCDate:beginTime format:@"dd"];
    NSString *HHStr = [self getLocalDateFormateUTCDate:beginTime format:@"HH"];
    
    NSString *currentyyyyStr = [self dateFromLocalWithFormatString:@"yyyy"];
    NSString *currentMMStr = [self dateFromLocalWithFormatString:@"MM"];
    NSString *currentddStr = [self dateFromLocalWithFormatString:@"dd"];
    NSString *currentHHStr = [self dateFromLocalWithFormatString:@"HH"];
    
    BOOL flage = NO;
    //判断年份
    if ([yyyyStr integerValue] >= [currentyyyyStr integerValue]) {
        // 判断月份
        if ([MMStr integerValue] >= [currentMMStr integerValue]) {
            // 判断天
            if ([ddStr integerValue] >= [currentddStr integerValue]) {
                // 相差一天的情况
                if (1 == [ddStr integerValue] - [currentddStr integerValue]) {
                    
                    if (24 - [currentHHStr integerValue] + [HHStr integerValue] > 24) {
                        flage = YES;
                    }
                }else {
                    if ([ddStr integerValue] - [currentddStr integerValue] > 1) {
                        flage = YES;
                    }
                }
            }
        }
    }
    return flage;
}


+ (NSString *)dateFromLocalWithFormatString:(NSString *)formatString {
    
    NSDate *localDate = [NSDate new];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter stringFromDate:localDate];
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate format:(NSString *)formatString {
    //    NSLog(@"utc = %@",utcDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:formatString];
    //    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

@end
