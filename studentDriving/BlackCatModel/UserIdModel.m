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
    return @{@"userId":@"_id",@"headportrait":@"headportrait",@"name":@"name",@"carmodel":@"carmodel",@"applyclasstypeinfo":@"applyclasstypeinfo"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end

/*
 
 "_id": "564e1242aa5c58b901e4961a",
 "applyclasstypeinfo": {
     "id": "562dd1fd1cdf5c60873625f3",
     "name": "一步互联网驾校快班",
     "price": 4700
 },
 "carmodel": {
     "name": "小型汽车手动挡",
     "modelsid": 1,
     "code": "C1"
 },
 "headportrait": {
     "height": "",
     "width": "",
     "thumbnailpic": "",
     "originalpic": "http://7xnjg0.com1.z0.glb.clouddn.com/20160119/102159-564e1242aa5c58b901e4961a.png"
 },
 "name": "亚飞学员端"
 
 */