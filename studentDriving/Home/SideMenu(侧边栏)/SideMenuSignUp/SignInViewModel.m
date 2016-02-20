//
//  SignInViewModel.m
//  studentDriving
//
//  Created by 大威 on 16/1/8.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SignInViewModel.h"
#import "JENetwoking.h"
#import "ToolHeader.h"
#import "AcountManager.h"
#import "SignInDataModel.h"
#import "YYModel.h"
#import "NSString+CurrentTimeDay.h"

@implementation SignInViewModel

- (void)dvvNetworkRequestRefresh {
    
    NSString *interface = @"courseinfo/getmyreservation";
    NSString *url = [NSString stringWithFormat:BASEURL, interface];
    
    NSString *userId = [AcountManager manager].userid;
    // 详细地址
//    NSString *locationAddress = [AcountManager manager].locationAddress;
    // 学员现在的科目ID
    NSInteger subjectId = [[AcountManager manager].userSubject.subjectId integerValue];
    
    NSDictionary *paramsDict = @{ @"userid": userId,
                                  @"subjectid": [NSString stringWithFormat:@"%li",subjectId],
                                  @"reservationstate": @"3" };
    
    [JENetwoking startDownLoadWithUrl:url postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        if ([self checkErrorWithData:data]) {
            [self dvvRefreshSuccess];
            [self showMsg:@"今天没有预约"];
            return ;
        }
        
        NSLog(@"%@", data);
        _dataArray = [NSMutableArray array];
        _todayArray = [NSMutableArray array];
        NSArray *array = [data objectForKey:@"data"];
        for (NSDictionary *dict in array) {
            
            SignInDataModel *dataModel = [SignInDataModel yy_modelWithDictionary:dict];
            [self.dataArray addObject:dataModel];
//            [self.todayArray addObject:dataModel];
        }
        
        NSString *formatString = @"yyyy-MM-dd";
        NSString *todayTime = [self dateFromLocalWithFormatString:formatString];
        
        // 判断所有的开始学习的时间中有没有今天的
        for (SignInDataModel *item in self.dataArray) {
            
            NSString *beginTime = [self getLocalDateFormateUTCDate:item.beginTime format:formatString];
            
            NSLog(@"%@ === %@",todayTime, beginTime);
            
            // 如果有，则保存下来
            if ([beginTime isEqualToString:todayTime]) {
                
                NSString *format = @"HH:mm";
                NSString *time = [self getLocalDateFormateUTCDate:item.beginTime format:format];
                NSString *beginString = [NSString stringWithFormat:@"%@", time];
                item.beginTime = beginString;
                NSString *endString = [self getLocalDateFormateUTCDate:item.endTime format:format];
                item.endTime = endString;
                
                // 判断当前的时间是否可以签到
                NSString *currentHH = [self dateFromLocalWithFormatString:@"HH"];
                NSString *currentMM = [self dateFromLocalWithFormatString:@"mm"];
                NSString *beginHH = [item.beginTime substringToIndex:2];
                NSString *endHH = [item.endTime substringToIndex:2];
                
                // 在开始前的15分钟之内
                if ([currentHH integerValue] < [beginHH integerValue]) {
                    if (1 == ([beginHH integerValue] - [currentHH integerValue])) {
                        
                        if (60 - [currentMM integerValue] <= 15) {
                            item.signInStatus = YES;
                        }
                    }
                }
                
                NSLog(@"%@---%@---%@", currentHH, beginHH, endHH);
                // 学车过程中
                if ([currentHH integerValue] <= [endHH integerValue] && [currentHH integerValue] >= [beginHH integerValue]) {
                        item.signInStatus = YES;
                }
//                    else { // 结束后15分钟
//                    if (1 == [currentHH integerValue] - [endHH integerValue]) {
//                        if ([currentMM integerValue] <= 15) {
//                            item.signInStatus = YES;
//                        }
//                    }
//                }
                
                [self.todayArray addObject:item];
                
            }
        }
        
        if (!self.todayArray.count) {
            [self dvvRefreshSuccess];
            [self showMsg:@"您今天没有预约"];
            return ;
        }
        
        [self dvvRefreshSuccess];
        
    } withFailure:^(id data) {
        
        [self dvvRefreshError];
        NSLog(@"%@", data);
    }];
}

#pragma mark 检测是否有数据
- (BOOL)checkErrorWithData:(id)data {
    
    DYNSLog(@"%@",data);
    if (!data) {
        return YES;
    }
    NSDictionary *dict = data;
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if (![[dict objectForKey:@"type"] integerValue]) {
        return YES;
    }
    if (![[dict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
        return YES;
    }
    NSArray *array = [dict objectForKey:@"data"];
    if (!array.count) {
        return YES;
    }
    
    return NO;
}
- (void)showMsg:(NSString *)message {
    
    ToastAlertView *toast = [[ToastAlertView alloc] initWithTitle:message];
    [toast show];
}
- (NSString *)dateFromLocalWithFormatString:(NSString *)formatString {
    
    NSDate *localDate = [NSDate new];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter stringFromDate:localDate];
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
- (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate format:(NSString *)formatString {
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
