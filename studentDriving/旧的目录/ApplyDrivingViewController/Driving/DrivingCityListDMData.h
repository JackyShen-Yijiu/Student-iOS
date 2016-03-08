#import <UIKit/UIKit.h>

@interface DrivingCityListDMData : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString * name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end