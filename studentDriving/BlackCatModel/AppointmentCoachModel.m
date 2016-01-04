//
//  AppointmentCoachModel.m
//  BlackCat
//
//  Created by bestseller on 15/10/22.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "AppointmentCoachModel.h"

@implementation AppointmentCoachModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"seniority":@"Seniority",@"coachid":@"coachid",@"driveschoolinfo":@"driveschoolinfo",@"headportrait":@"headportrait",@"is_shuttle":@"is_shuttle",@"latitude":@"latitude",@"longitude":@"longitude",@"name":@"name",@"passrate":@"passrate",@"starlevel":@"starlevel"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
