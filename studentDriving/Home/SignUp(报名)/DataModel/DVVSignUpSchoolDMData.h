#import <UIKit/UIKit.h>
#import "DVVSignUpSchoolDMLogoimg.h"
#import "YYModel.h"

@interface DVVSignUpSchoolDMData : NSObject<YYModel>

@property (nonatomic, strong) NSString * address;
@property (nonatomic, assign) NSInteger coachcount;
@property (nonatomic, assign) NSInteger commentcount;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, strong) DVVSignUpSchoolDMLogoimg * logoimg;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, assign) NSInteger maxprice;
@property (nonatomic, assign) NSInteger minprice;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger passingrate;
@property (nonatomic, strong) NSString * schoolid;
@property (nonatomic, strong) NSString * schoollevel;
@end