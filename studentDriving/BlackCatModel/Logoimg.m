//
//  logoimg.m
//  BlackCat
//
//  Created by bestseller on 15/10/9.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "Logoimg.h"

@implementation Logoimg
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"height":@"height",@"originalpic":@"originalpic",@"thumbnailpic":@"thumbnailpic",@"width":@"width"};
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
