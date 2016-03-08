//
//  VipserverModel.m
//  studentDriving
//
//  Created by bestseller on 15/11/8.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "VipserverModel.h"

@implementation VipserverModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"infoId":@"_id",@"msgId":@"id",@"color":@"color",@"name":@"name"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
