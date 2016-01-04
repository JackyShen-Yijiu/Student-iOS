#import <UIKit/UIKit.h>

@interface DrivingCityListDMData : NSObject

@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end