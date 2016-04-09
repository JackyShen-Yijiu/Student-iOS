//
//  tagslistModel.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "tagslistModel.h"

@implementation tagslistModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"_id":@"_id",@"color":@"color",@"tagname":@"tagname",@"tagtype":@"tagtype"};
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end