//
//  TrainFieldlnfoModel.m
//  BlackCat
//
//  Created by bestseller on 15/10/19.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "TrainFieldInfoModel.h"

@implementation TrainFieldInfoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"TrainFieldInfoModelId":@"_id",@"name":@"name"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
