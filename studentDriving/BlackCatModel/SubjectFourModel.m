//
//  SubjectFourModel.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SubjectFourModel.h"

@implementation SubjectFourModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"finishcourse":@"finishcourse",@"progress":@"progress",@"reservation":@"reservation",@"totalcourse":@"totalcourse",@"missingcourse":@"missingcourse"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
