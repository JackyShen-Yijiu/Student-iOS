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
    return @{@"commentcontent":@"commentcontent",@"starlevel":@"starlevel",@"commenttime":@"commenttime"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
