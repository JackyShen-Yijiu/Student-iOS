//
//  DriveSchoolinfo.m
//  BlackCat
//
//  Created by 董博 on 15/10/17.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "DriveSchoolinfo.h"

@implementation DriveSchoolinfo
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"driveSchoolId":@"id",@"name":@"name"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
