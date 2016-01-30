#import <UIKit/UIKit.h>
#import "CoachListDMCarmodel.h"
#import "CoachListDMDriveschoolinfo.h"
#import "CoachListDMHeadportrait.h"
#import "CoachListDMSubject.h"
#import "CoachListDMServerClassList.h"
#import "YYModel.h"

@interface CoachListDMData : NSObject<YYModel>

@property (nonatomic, strong) NSString * seniority;
@property (nonatomic, strong) CoachListDMCarmodel * carmodel;
@property (nonatomic, strong) NSString * coachid;
@property (nonatomic, strong) CoachListDMDriveschoolinfo * driveschoolinfo;
@property (nonatomic, strong) CoachListDMHeadportrait * headportrait;
@property (nonatomic, assign) BOOL isShuttle;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, assign) NSInteger maxprice;
@property (nonatomic, assign) NSInteger minprice;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger passrate;
@property (nonatomic, assign) NSInteger starlevel;
@property (nonatomic, strong) NSArray * subject;
@property (nonatomic, strong) NSArray * serverclasslist;
@end