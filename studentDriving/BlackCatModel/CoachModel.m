//
//  CoachModel.m
//  BlackCat
//
//  Created by 董博 on 15/10/17.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "CoachModel.h"

@implementation CoachModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"Seniority":@"Seniority",@"coachid":@"coachid",@"distance":@"distance",@"name":@"name",@"driveschoolinfo":@"driveschoolinfo",@"headportrait":@"headportrait",@"is_shuttle":@"is_shuttle",@"latitude":@"latitude",@"longitude":@"longitude",@"passrate":@"passrate",@"starlevel":@"starlevel"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
