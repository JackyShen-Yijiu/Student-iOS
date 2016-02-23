#import <UIKit/UIKit.h>
#import "DVVSignUpCoachDMDriveschoolinfo.h"
#import "DVVSignUpCoachDMHeadportrait.h"
#import "DVVSignUpCoachDMSubject.h"
#import "YYModel.h"

@interface DVVSignUpCoachDMData : NSObject<YYModel>

@property (nonatomic, strong) NSString * seniority;
@property (nonatomic, strong) NSString * coachid;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, strong) DVVSignUpCoachDMDriveschoolinfo * driveschoolinfo;
@property (nonatomic, strong) DVVSignUpCoachDMHeadportrait * headportrait;
@property (nonatomic, assign) BOOL isShuttle;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, assign) NSInteger maxprice;
@property (nonatomic, assign) NSInteger minprice;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger passrate;
@property (nonatomic, assign) NSInteger starlevel;
@property (nonatomic, strong) NSArray * subject;
@property (nonatomic, assign) NSInteger commentcount;
@property (nonatomic, strong) NSString *gender;

@end