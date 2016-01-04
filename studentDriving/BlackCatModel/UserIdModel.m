//
//  UserIdModel.m
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "UserIdModel.h"

@implementation UserIdModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"userId":@"_id",@"headportrait":@"headportrait",@"name":@"name"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
