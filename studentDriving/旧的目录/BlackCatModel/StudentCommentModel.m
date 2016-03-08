//
//  StudentCommentModel.m
//  studentDriving
//
//  Created by bestseller on 15/10/30.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "StudentCommentModel.h"

@implementation StudentCommentModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"infoId":@"_id",@"comment":@"comment",@"userid":@"userid",@"finishtime":@"finishtime",@"timestamp":@"timestamp"};

}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
