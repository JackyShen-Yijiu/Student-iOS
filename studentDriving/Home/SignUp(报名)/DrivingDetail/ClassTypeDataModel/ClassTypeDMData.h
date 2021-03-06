#import <UIKit/UIKit.h>
#import "ClassTypeDMCarmodel.h"
#import "ClassTypeDMSchoolinfo.h"
#import "ClassTypeDMVipserverlist.h"
#import "YYModel.h"

@interface ClassTypeDMData : NSObject<YYModel>

@property (nonatomic, assign) NSInteger applycount;
@property (nonatomic, strong) NSString * begindate;
@property (nonatomic, strong) NSString * calssid;
@property (nonatomic, strong) ClassTypeDMCarmodel * carmodel;
@property (nonatomic, strong) NSString * cartype;
@property (nonatomic, strong) NSString * classchedule;
@property (nonatomic, strong) NSString * classdesc;
@property (nonatomic, strong) NSString * classname;
@property (nonatomic, strong) NSString * enddate;
@property (nonatomic, assign) BOOL is_Vip;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, strong) ClassTypeDMSchoolinfo * schoolinfo;
@property (nonatomic, strong) NSArray * vipserverlist;

// 报名时需要的参数（从教练详情进入会用到）
@property (nonatomic, copy) NSString *coachID;
@property (nonatomic, copy) NSString *coachName;

@end