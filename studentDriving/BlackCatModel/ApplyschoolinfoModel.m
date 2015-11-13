//
//  ApplyschoolinfoModel.m
//  studentDriving
//
//  Created by bestseller on 15/10/27.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "ApplyschoolinfoModel.h"

@implementation ApplyschoolinfoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"infoId":@"id",@"name":@"name"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
