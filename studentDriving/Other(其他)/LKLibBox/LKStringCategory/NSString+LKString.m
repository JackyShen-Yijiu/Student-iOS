//
//  NSString+LKString.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/19.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "NSString+LKString.h"
#import "NSDateFormatter+LKDateFormatter.h"


@implementation NSString (LKString)
+ (NSString *)getYearLocalDateFormateUTCDate:(NSString *)utcDate style:(LKDateStyle)dataStyle{
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    switch (dataStyle) {
        case 0:
            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
            break;
        case 1:
            [dateFormatter setDateFormat:@"MM/dd HH:mm"];
            break;
        case 2:
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];

            break;
            
        default:
            break;
    }
    //输出格式
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}
+ (NSString *)getNowTimeWithStyle:(LKDateStyle)dataStyle {
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    NSDateFormatter * dateFormatter = [NSDateFormatter sharedDateFormatter];
    switch (dataStyle) {
        case 0:
            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
            break;
        case 1:
            [dateFormatter setDateFormat:@"MM/dd HH:mm"];
            break;
        case 2:
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];
            
            break;
            
        default:
            break;
    }

    NSString * nowTime = [dateFormatter stringFromDate:currentDate];
    
    return nowTime;
}

+ (NSString *)currentTimeDay {
    
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    [dateFormatter setDateFormat:@"yyyyMMdd/HHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}
+ (NSString *)currentDay {
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

+ (NSString *)getDayWithAddCountWithDisplay: (NSUInteger)count {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    time = time + count * 86400;
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    [dateFormatter setDateFormat:@"M月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
    
}
+ (NSString *)getDayWithAddCountWithData: (NSUInteger)count {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    time = time + count * 86400;
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
    
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate {
    //    NSLog(@"utc = %@",utcDate);
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

+ (NSString *)getHourLocalDateFormateUTCDate:(NSString *)utcDate {
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

+ (NSString *)getLitteLocalDateFormateUTCDate:(NSString *)utcDate {
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

+ (NSString *)getHourLocalDateFormateDate:(NSString *)date {
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    //输入格式
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:date];
    //输出格式
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

@end
