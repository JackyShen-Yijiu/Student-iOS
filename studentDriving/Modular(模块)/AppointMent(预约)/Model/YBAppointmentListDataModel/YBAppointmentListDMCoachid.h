#import <UIKit/UIKit.h>
#import "YBAppointmentListDMDriveschoolinfo.h"
#import "YBAppointmentListDMHeadportrait.h"
#import "YYModel.h"

@interface YBAppointmentListDMCoachid : NSObject<YYModel>

@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) YBAppointmentListDMDriveschoolinfo * driveschoolinfo;
@property (nonatomic, strong) YBAppointmentListDMHeadportrait * headportrait;
@property (nonatomic, strong) NSString * name;
@end