//
//  SubjectModel.m
//  BlackCat
//
//  Created by bestseller on 15/10/19.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "SubjectModel.h"

@implementation SubjectModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"cancelId":@"_id",@"name":@"name",@"subjectId":@"subjectid"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
