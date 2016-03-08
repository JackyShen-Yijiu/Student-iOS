//
//  ExamCarModel.m
//  BlackCat
//
//  Created by bestseller on 15/10/20.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "ExamCarModel.h"

@implementation ExamCarModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"code":@"code",@"modelsid":@"modelsid",@"name":@"name"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
