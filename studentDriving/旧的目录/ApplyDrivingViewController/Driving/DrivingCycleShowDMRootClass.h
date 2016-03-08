#import <UIKit/UIKit.h>
#import "DrivingCycleShowDMData.h"

@interface DrivingCycleShowDMRootClass : NSObject

@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end