//
//  SubjectTwoModel.m
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "SubjectTwoModel.h"

@implementation SubjectTwoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"finishcourse":@"finishcourse",@"progress":@"progress",@"reservation":@"reservation",@"totalcourse":@"totalcourse",@"missingcourse":@"missingcourse"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
