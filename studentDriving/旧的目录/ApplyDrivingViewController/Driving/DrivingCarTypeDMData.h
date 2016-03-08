#import <UIKit/UIKit.h>

@interface DrivingCarTypeDMData : NSObject

@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, assign) NSInteger modelsid;
@property (nonatomic, strong) NSString * name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end