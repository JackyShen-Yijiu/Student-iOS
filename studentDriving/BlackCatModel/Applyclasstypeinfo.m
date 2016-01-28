//
//  Applyclasstypeinfo.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "Applyclasstypeinfo.h"

@implementation Applyclasstypeinfo
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"ID":@"id",@"name":@"name",@"price":@"price"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end

/*
 "applyclasstypeinfo": {
     "id": "562dd1fd1cdf5c60873625f3",
     "name": "一步互联网驾校快班",
     "price": 4700
 },
*/