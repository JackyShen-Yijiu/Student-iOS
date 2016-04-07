//
//  JGActivityModel.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JGActivityModel.h"

@implementation JGActivityModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"address":@"address",@"begindate":@"begindate",@"contenturl":@"contenturl",@"enddate":@"enddate",@"ID":@"id",@"name":@"name",@"titleimg":@"titleimg",@"activitystate":@"activitystate"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}

@end
