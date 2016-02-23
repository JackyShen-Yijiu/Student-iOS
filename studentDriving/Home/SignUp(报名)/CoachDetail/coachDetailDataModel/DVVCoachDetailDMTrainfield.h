#import <UIKit/UIKit.h>
#import "YYModel.h"

@interface DVVCoachDetailDMTrainfield : NSObject<YYModel>

@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * fieldname;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSArray * pictures;
@end