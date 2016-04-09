//
//  NSDateFormatter+shareDate.m
//  dataPickerView复习
//
//  Created by 雷凯 on 16/4/8.
//  Copyright © 2016年 leifaxian. All rights reserved.
//

#import "NSDateFormatter+shareDate.h"

@implementation NSDateFormatter (shareDate)
+ (instancetype)sharedDateFormatter
{
    static NSDateFormatter *_dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[self alloc] init];
    });
    return _dateFormatter;
}
@end
