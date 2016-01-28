//
//  CommentModel.m
//  studentDriving
//
//  Created by bestseller on 15/10/30.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"timelevel":@"timelevel",@"starlevel":@"starlevel",@"commenttime":@"commenttime",@"commentcontent":@"commentcontent",@"attitudelevel":@"attitudelevel",@"abilitylevel":@"abilitylevel"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
/*
 {
 "timelevel": 0,
 "starlevel": 0,
 "commenttime": "2016-01-21T12:15:15.816Z",
 "commentcontent": "基金经理",
 "attitudelevel": 0,
 "abilitylevel": 0
 },
 */