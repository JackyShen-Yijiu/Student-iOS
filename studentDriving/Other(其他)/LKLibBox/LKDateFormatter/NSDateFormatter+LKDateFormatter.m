//
//  NSDateFormatter+LKDateFormatter.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/19.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "NSDateFormatter+LKDateFormatter.h"

@implementation NSDateFormatter (LKDateFormatter)
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
