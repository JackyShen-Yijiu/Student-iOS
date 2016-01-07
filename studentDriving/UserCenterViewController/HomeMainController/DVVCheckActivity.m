//
//  DVVCheckActivity.m
//  studentDriving
//
//  Created by 大威 on 16/1/7.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCheckActivity.h"

#define kDVVCheckActivity @"kDVVCheckActivity"

@implementation DVVCheckActivity

#pragma mark 检查今天是否需要显示活动
+ (BOOL)checkActivity {
    
    BOOL flage = NO;
    
    NSString *lastShowActivityTime = [[NSUserDefaults standardUserDefaults] objectForKey:kDVVCheckActivity];
    // 如果数据为空则说明没显示过活动
    if (!lastShowActivityTime) {
        flage = YES;
    }
    NSString *formatString = @"yyyy-MM-dd";
    NSString *currentTime = [DVVCheckActivity dateFromLocalWithFormatString:formatString];
    // 上次保存的时间和本次保存的时间一样，则说明今天已经显示过活动
    if ([lastShowActivityTime isEqualToString:currentTime]) {
        flage = NO;
    }
    
    // 如果今天需要显示活动，则保存今天显示活动的时间
    if (flage) {
        [[NSUserDefaults standardUserDefaults] setObject:currentTime forKey:kDVVCheckActivity];
    }
    return flage;
}

#pragma mark 测试时先调用此方法
+ (void)test {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDVVCheckActivity];
}

+ (NSString *)dateFromLocalWithFormatString:(NSString *)formatString {
    
    NSDate *localDate = [NSDate new];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter stringFromDate:localDate];
}

@end
