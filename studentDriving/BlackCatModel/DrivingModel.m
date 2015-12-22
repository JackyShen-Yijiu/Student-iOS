//
//  DrivingModel.m
//  BlackCat
//
//  Created by bestseller on 15/10/9.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "DrivingModel.h"

@implementation DrivingModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"address":@"address",@"distance":@"distance",@"logoimg":@"logoimg",@"latitude":@"latitude",@"longitude":@"longitude",@"maxprice":@"maxprice",@"minprice":@"minprice",@"name":@"name",@"passingrate":@"passingrate",@"schoolid":@"schoolid",@"coachcount":@"coachcount"};
}

+ (NSValueTransformer *)logoimgJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:Logoimg.class];
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
