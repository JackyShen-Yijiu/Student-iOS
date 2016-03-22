//
//  DrivingModel.m
//  BlackCat
//
//  Created by bestseller on 15/10/9.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "DrivingModel.h"
/*
 
 
 {
 data =     (
 {
 address = "\U5317\U4eac\U5e02\U5317\U4eac\U5e02\U987a\U4e49\U533aS305(\U987a\U5e73\U8def)";
 latitude = "40.124455";
 logoimg =             {
 height = "";
 originalpic = "http://7xnjg0.com1.z0.glb.clouddn.com/1452582492696.jpg";
 thumbnailpic = "";
 width = "";
 };
 longitude = "116.54538";
 name = "\U65f6\U661f\U5b87\U9a7e\U6821";
 passingrate = 90;
 schoolid = 56947dcd5180e10078ed6b3b;
 },
 {
 address = "\U5185\U8499\U53e4\U81ea\U6cbb\U533a\U547c\U548c\U6d69\U7279\U5e02\U8d5b\U7f55\U533a\U5174\U5b89\U5357\U8def";
 latitude = "40.812331";
 logoimg =             {
 height = "";
 originalpic = "http://7xnjg0.com1.z0.glb.clouddn.com/1455889912045.jpg";
 thumbnailpic = "";
 width = "";
 };
 longitude = "111.715293";
 name = "\U4e00\U6b65\U9a7e\U6821 \U547c\U548c\U6d69\U7279\U5206\U6821";
 passingrate = 90;
 schoolid = 56c71e1cde346bda5466f8f1;
 }
 );
 msg = "";
 type = 1;
 }

 */
@implementation DrivingModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{ @"address":@"address",
              @"distance":@"distance",
              @"logoimg":@"logoimg",
              @"latitude":@"latitude",
              @"longitude":@"longitude",
              @"maxprice":@"maxprice",
              @"minprice":@"minprice",
              @"name":@"name",
              @"passingrate":@"passingrate",
              @"schoolid":@"schoolid",
              @"coachcount": @"coachcount",
              @"schoollevel": @"schoollevel" };
}

+ (NSValueTransformer *)logoimgJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:Logoimg.class];
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end
