//
//  SubjectThreeModel.m
//  studentDriving
//
//  Created by bestseller on 15/11/7.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "SubjectThreeModel.h"

@implementation SubjectThreeModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"finishcourse":@"finishcourse",@"progress":@"progress",@"reservation":@"reservation",@"totalcourse":@"totalcourse"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
