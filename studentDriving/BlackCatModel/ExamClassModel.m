//
//  ExamClassModel.m
//  BlackCat
//
//  Created by bestseller on 15/10/20.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "ExamClassModel.h"
#import <MTLValueTransformer.h>
@implementation ExamClassModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"applycount":@"applycount",@"begindate":@"begindate",@"classid":@"calssid",@"carmodel":@"carmodel",@"cartype":@"cartype",@"classchedule":@"classchedule",@"classdesc":@"classdesc",@"classname":@"classname",@"enddate":@"enddate",@"is_vip":@"is_vip",@"price":@"price",@"schoolinfo":@"schoolinfo",@"vipserverlist":@"vipserverlist"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
+ (NSValueTransformer *)vipserverlistJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSMutableArray *mubArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in value) {
            NSError *error = nil;
            VipserverModel *model = [MTLJSONAdapter modelOfClass: VipserverModel.class fromJSONDictionary:dic error:&error];
            [mubArray addObject:model];
        }
        
        return mubArray;
    }];
}
@end
