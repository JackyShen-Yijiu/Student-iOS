//
//  CoachDetail.m
//  BlackCat
//
//  Created by bestseller on 15/10/19.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "CoachDetail.h"
#import <MTLValueTransformer.h>

@implementation CoachDetail

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"seniority":@"Seniority",@"address":@"address",@"carmodel":@"carmodel",@"coachid":@"coachid",@"commentcount":@"commentcount",@"createtime":@"createtime",@"displaycoachid":@"displaycoachid",@"driveschoolinfo":@"driveschoolinfo",@"email":@"email",@"headportrait":@"headportrait",@"introduction":@"introduction",@"invitationcode":@"invitationcode",@"is_lock":@"is_lock",@"is_shuttle":@"is_shuttle",@"is_validation":@"is_validation",@"logintime":@"logintime",@"mobile":@"mobile",@"name":@"name",@"passrate":@"passrate",@"platenumber":@"platenumber",@"shuttlemsg":@"shuttlemsg",@"starlevel":@"starlevel",@"studentcoount":@"studentcoount",@"subject":@"subject",@"trainFieldInfo":@"trainfieldlinfo",@"validationstate":@"validationstate",@"worktimedesc":@"worktimedesc",@"trainfield":@"trainfield",@"tagslist":@"tagslist",@"serverclasslist":@"serverclasslist"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
+ (NSValueTransformer *)subjectJSONTransformer {
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSMutableArray *mubArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in value) {
            NSError *error = nil;
            SubjectModel *model = [MTLJSONAdapter modelOfClass: SubjectModel.class fromJSONDictionary:dic error:&error];
            [mubArray addObject:model];
        }
        
        return mubArray;
    }];
    
}

- (NSArray *)serverclasslist
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    [tempArray addObjectsFromArray:_serverclasslist];
    [tempArray addObjectsFromArray:_serverclasslist];
    [tempArray addObjectsFromArray:_serverclasslist];
    [tempArray addObjectsFromArray:_serverclasslist];
    [tempArray addObjectsFromArray:_serverclasslist];
    [tempArray addObjectsFromArray:_serverclasslist];

    return [tempArray copy];
}

//- (NSArray *)tagslist
//{
//    NSMutableArray *tempArray = [NSMutableArray array];
//    
//    [tempArray addObjectsFromArray:_tagslist];
//    [tempArray addObjectsFromArray:_tagslist];
//    [tempArray addObjectsFromArray:_tagslist];
//    [tempArray addObjectsFromArray:_tagslist];
//    [tempArray addObjectsFromArray:_tagslist];
//    [tempArray addObjectsFromArray:_tagslist];
//    [tempArray addObjectsFromArray:_tagslist];
//    [tempArray addObjectsFromArray:_tagslist];
//    [tempArray addObjectsFromArray:_tagslist];
//
//    return [tempArray copy];
//}

- (NSString *)introduction
{
    return @"我是一个人生闷气，我的人生是不是很多，我的人生是不是很多，我就是我距离近我是一个人生闷气，我的人生是不是很多，我的人生是不是很多，我就是我距离近我是一个人生闷气，我的人生是不是很多，我的人生是不是很多，我就是我距离近我是一个人生闷气，我的人生是不是很多，我的人生是不是很多，我就是我距离近我是一个人生闷气，我的人生是不是很多，我的人生是不是很多，我就是我距离近我是一个人生闷气，我的人生是不是很多，我的人生是不是很多，我就是我距离近";
}

@end
