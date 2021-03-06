//
//	CoachDMData.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CoachDMData.h"

@interface CoachDMData ()
@end
@implementation CoachDMData

/**
 *  服务器给的是Seniority，而属性写的是seniority，用这个方法转换一下，才能解析到数据
 *
 *  @return 需要转换的数据字典
 */
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"seniority": @"Seniority",
              @"isShuttle": @"is_shuttle" };
}

- (NSString *)seniority
{
    // 判断字符串包含“年”字
    NSRange range = [_seniority rangeOfString:@"年"];
    if (range.length==0) return _seniority;
    
    return [_seniority substringToIndex:range.location];
    
}

@end