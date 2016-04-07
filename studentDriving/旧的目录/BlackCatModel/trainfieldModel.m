//
//  trainfieldModel.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "trainfieldModel.h"

@implementation trainfieldModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"_id":@"_id",@"fieldname":@"fieldname",@"pictures":@"pictures",@"phone":@"phone"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}

@end
