//
//  AVPlayModel.m
//  studentDriving
//
//  Created by bestseller on 15/11/6.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "AVPlayModel.h"

@implementation AVPlayModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"infoId":@"_id",@"name":@"name",@"pictures":@"pictures",@"seqindex":@"seqindex",@"subject":@"subject",@"videourl":@"videourl"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
