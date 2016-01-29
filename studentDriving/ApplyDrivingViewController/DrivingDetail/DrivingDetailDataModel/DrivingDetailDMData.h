#import <UIKit/UIKit.h>
#import "DrivingDetailDMLogoimg.h"
#import "DrivingDetailDMSchoolbusroute.h"

@interface DrivingDetailDMData : NSObject

@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * hours;
@property (nonatomic, strong) NSString * introduction;
@property (nonatomic, assign) NSInteger isFavoritschool;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, strong) DrivingDetailDMLogoimg * logoimg;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, assign) NSInteger maxprice;
@property (nonatomic, assign) NSInteger minprice;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger passingrate;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSArray * pictures;
@property (nonatomic, strong) NSString * registertime;
@property (nonatomic, strong) NSString * responsible;
@property (nonatomic, strong) NSArray * schoolbusroute;
@property (nonatomic, strong) NSString * schoolid;
@property (nonatomic, strong) NSArray * trainingfiledpiclist;
@end