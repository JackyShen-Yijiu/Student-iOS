#import <UIKit/UIKit.h>
#import "YBAppointmentListDMCoachid.h"
#import "YBAppointmentListDMSubject.h"
#import "YBAppointmentListDMDriveschoolinfo.h"
#import "YYModel.h"

@interface YBAppointmentListDMData : NSObject<YYModel>

@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * classdatetimedesc;
@property (nonatomic, strong) YBAppointmentListDMCoachid * coachid;
@property (nonatomic, strong) NSString * courseprocessdesc;
@property (nonatomic, strong) NSString * reservationcreatetime;
@property (nonatomic, assign) NSInteger reservationstate;
@property (nonatomic, strong) NSString * shuttleaddress;
@property (nonatomic, strong) YBAppointmentListDMSubject * subject;
@property (nonatomic, strong) YBAppointmentListDMDriveschoolinfo * trainfieldlinfo;
@end