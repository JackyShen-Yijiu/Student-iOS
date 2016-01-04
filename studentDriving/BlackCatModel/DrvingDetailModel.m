//
//  DrvingDetailModel.m
//  BlackCat
//
//  Created by bestseller on 15/10/9.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "DrvingDetailModel.h"

@implementation DrvingDetailModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"address":@"address",@"hours":@"hours",@"introduction":@"introduction",@"latitude":@"latitude",@"logoimg":@"logoimg",@"longitude":@"longitude",@"name":@"name",@"passingrate":@"passingrate",@"phone":@"phone",@"pictures":@"pictures",@"registertime":@"registertime",@"responsible":@"responsible",@"schoolid":@"schoolid",@"websit":@"websit"};
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
