#import <UIKit/UIKit.h>
#import "DrivingCityListDMData.h"

@interface DrivingCityListDMRootClass : NSObject

@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end