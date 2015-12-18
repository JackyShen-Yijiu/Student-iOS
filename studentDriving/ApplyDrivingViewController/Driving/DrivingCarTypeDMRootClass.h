#import <UIKit/UIKit.h>
#import "DrivingCarTypeDMData.h"

@interface DrivingCarTypeDMRootClass : NSObject

@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end