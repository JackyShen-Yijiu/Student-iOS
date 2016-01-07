#import <UIKit/UIKit.h>
#import "CoachDMDriveschoolinfo.h"
#import "CoachDMHeadportrait.h"
#import "CoachDMSubject.h"

@interface CoachDMData : NSObject

@property (nonatomic, strong) NSString * seniority;
@property (nonatomic, strong) NSString * coachid;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, strong) CoachDMDriveschoolinfo * driveschoolinfo;
@property (nonatomic, strong) CoachDMHeadportrait * headportrait;
@property (nonatomic, assign) BOOL isShuttle;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger passrate;
@property (nonatomic, assign) NSInteger starlevel;
@property (nonatomic, strong) NSArray * subject;
@end