//
//  NSString+LKString.h
//  Headmaster
//
//  Created by 雷凯 on 16/5/19.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
///  返回的时间格式
typedef NS_ENUM(NSInteger, LKDateStyle) {
    ///  yyyy/MM/dd HH:mm
    LKDateStyleDefault = 0,
    ///  MM/dd HH:mm
    LKDateStyleNoHaveYear = 1,
    ///  yyyy/MM/dd
    LKDateStyleNoHaveTime = 2
};

@interface NSString (LKString)
///  转换UTC时间
+ (NSString *)getYearLocalDateFormateUTCDate:(NSString *)utcDate style:(LKDateStyle)dataStyle;
///  获取当前时间
+ (NSString *)getNowTimeWithStyle:(LKDateStyle)dataStyle;

+ (NSString *)currentTimeDay;
+ (NSString *)currentDay;
+ (NSString *)getDayWithAddCountWithDisplay: (NSUInteger)count;
+ (NSString *)getDayWithAddCountWithData: (NSUInteger)count;
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate;
+ (NSString *)getHourLocalDateFormateUTCDate:(NSString *)utcDate ;
+ (NSString *)getLitteLocalDateFormateUTCDate:(NSString *)utcDate;
+ (NSString *)getHourLocalDateFormateDate:(NSString *)date;
@end
