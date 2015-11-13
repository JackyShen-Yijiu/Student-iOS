//
//  SchoolInfo.m
//  studentDriving
//
//  Created by bestseller on 15/11/3.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "SchoolInfo.h"

@implementation SchoolInfo
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"address":@"address",@"latitude":@"latitude",@"longitude":@"longitude",@"name":@"name",@"schoolid":@"schoolid"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
