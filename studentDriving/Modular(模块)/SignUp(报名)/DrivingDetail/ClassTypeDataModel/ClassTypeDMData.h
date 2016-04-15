#import <UIKit/UIKit.h>
#import "ClassTypeDMCarmodel.h"
#import "ClassTypeDMSchoolinfo.h"
#import "ClassTypeDMVipserverlist.h"
#import "YYModel.h"

@interface ClassTypeDMData : NSObject<YYModel>

/*
 applycount = 3;
 begindate = "2016-01-29T10:34:56.601Z";
 calssid = 56ab4050bab8de31021e27cc;
 carmodel =             {
 code = C1;
 modelsid = 1;
 name = "\U624b\U52a8\U6321\U6c7d\U8f66";
 };
 cartype = "\U76ae\U5361";
 classchedule = "\U5468\U4e00\U5230\U5468\U65e5";
 classdesc = "\U6b64\U8d39\U4e3a\U5168\U8d39\Uff0c\U5305\U62ec\U8003\U8bd5\U8d39\Uff0c\U5de5\U672c\U8d39\Uff0c\U6cd5\U57f9\U8d39\Uff0c\U6742\U8d39";
 classname = "\U5468\U672b\U73ed";
 enddate = "2016-01-29T10:34:56.601Z";
 "is_vip" = 1;
 onsaleprice = 3880;
 price = 4880;
 schoolinfo =             {
 address = "\U5317\U4eac\U5e02\U5317\U4eac\U5e02\U987a\U4e49\U533aS305(\U987a\U5e73\U8def)";
 latitude = "40.124455";
 longitude = "116.54538";
 name = "\U65f6\U661f\U5b87\U9a7e\U6821";
 schoolid = 56947dcd5180e10078ed6b3b;
 };
 vipserverlist =             (
 {
 "_id" = 563b452eeaf3c240264350b6;
 color = "#FF0000";
 id = 4;
 name = "1:1";
 }
 );
 },

 
 */

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
@property (nonatomic, assign) NSInteger onsaleprice;
@property (nonatomic, strong) ClassTypeDMSchoolinfo * schoolinfo;
@property (nonatomic, strong) NSArray * vipserverlist;

// 报名时需要的参数（从教练详情进入会用到）
@property (nonatomic, copy) NSString *coachID;
@property (nonatomic, copy) NSString *coachName;

@end