#import <UIKit/UIKit.h>

@interface DrivingCityListDMData : NSObject

@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, copy) NSString * name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end