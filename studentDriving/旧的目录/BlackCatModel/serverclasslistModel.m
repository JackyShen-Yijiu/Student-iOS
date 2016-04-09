//
//  serverclasslistModel.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "serverclasslistModel.h"

@implementation serverclasslistModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"_id":@"_id",@"cartype":@"cartype",@"price":@"price",@"onsaleprice":@"onsaleprice",@"classdesc":@"classdesc",@"carmodel":@"carmodel",@"classname":@"classname"};
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
