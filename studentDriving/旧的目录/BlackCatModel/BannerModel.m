//
//  BannerModel.m
//  studentDriving
//
//  Created by bestseller on 15/11/4.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"infoId":@"_id",@"createtime":@"createtime",@"headportrait":@"headportrait",@"is_using":@"is_using",@"linkurl":@"linkurl",@"newsname":@"newsname",@"newtype":@"newtype"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
