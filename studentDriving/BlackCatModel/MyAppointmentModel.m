//
//  MyAppointmentModel.m
//  BlackCat
//
//  Created by bestseller on 15/10/25.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MyAppointmentModel.h"
#import <MTLValueTransformer.h>
#import "NSString+CurrentTimeDay.h"
@implementation MyAppointmentModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"infoId":@"_id",@"classdatetimedesc":@"classdatetimedesc",@"begintime":@"begintime",@"coachid":@"coachid",@"coursehour":@"coursehour",@"courseprocessdesc":@"courseprocessdesc",@"endtime":@"endtime",@"is_coachcomment":@"is_coachcomment",@"is_comment":@"is_comment",@"is_complaint":@"is_complaint",@"is_shuttle":@"is_shuttle",@"reservationcourse":@"reservationcourse",@"reservationcreatetime":@"reservationcreatetime",@"reservationstate":@"reservationstate",@"shuttleaddress":@"shuttleaddress",@"subjectModel":@"subject",@"trainfieldid":@"trainfieldid",@"userid":@"userid"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}

+ (NSValueTransformer *)reservationcreatetimeJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString * value, BOOL *success, NSError *__autoreleasing *error) {
        NSString *resultString = [NSString getHourLocalDateFormateUTCDate:value];
        return resultString;
    }];
}
+ (NSValueTransformer *)begintimeJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString * value, BOOL *success, NSError *__autoreleasing *error) {
        NSString *resultString = [NSString getYearLocalDateFormateUTCDate:value];
        return resultString;
    }];
}
@end
