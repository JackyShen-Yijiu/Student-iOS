//
//	UserSettingModel.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "UserSettingModel.h"

@implementation UserSettingModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"reservationreminder":@"reservationreminder",
             @"newmessagereminder":@"newmessagereminder",
             @"classremind":@"classremind" };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
@end