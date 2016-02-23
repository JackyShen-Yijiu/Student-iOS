#import <UIKit/UIKit.h>
#import "DVVCoachDetailDMCarmodel.h"
#import "DVVCoachDetailDMDriveschoolinfo.h"
#import "DVVCoachDetailDMHeadportrait.h"
#import "DVVCoachDetailDMSubject.h"
#import "DVVCoachDetailDMTrainfield.h"
#import "DVVCoachDetailDMTrainfieldlinfo.h"
#import "DVVCoachDetailDMWorktimespace.h"
#import "YYModel.h"
#import "CoachListDMServerClassList.h"

@interface DVVCoachDetailDMData : NSObject<YYModel>

@property (nonatomic, strong) NSString * seniority;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) DVVCoachDetailDMCarmodel * carmodel;
@property (nonatomic, strong) NSString * cartype;
@property (nonatomic, strong) NSString * coachid;
@property (nonatomic, strong) NSString * coachnumber;
@property (nonatomic, assign) NSInteger coachtype;
@property (nonatomic, assign) NSInteger commentcount;
@property (nonatomic, strong) NSString * createtime;
@property (nonatomic, strong) NSString * displaycoachid;
@property (nonatomic, strong) DVVCoachDetailDMDriveschoolinfo * driveschoolinfo;
@property (nonatomic, strong) NSString * drivinglicensenumber;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) DVVCoachDetailDMHeadportrait * headportrait;
@property (nonatomic, strong) NSString * introduction;
@property (nonatomic, strong) NSString * invitationcode;
@property (nonatomic, assign) NSInteger isFavoritcoach;
@property (nonatomic, assign) BOOL isLock;
@property (nonatomic, assign) BOOL isShuttle;
@property (nonatomic, assign) BOOL isValidation;
@property (nonatomic, strong) NSString * logintime;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * gender;
@property (nonatomic, assign) NSInteger passrate;
@property (nonatomic, strong) NSString * platenumber;
@property (nonatomic, assign) NSInteger serverclass;
@property (nonatomic, strong) NSArray * serverclasslist;
@property (nonatomic, strong) NSObject * shuttlemsg;
@property (nonatomic, assign) NSInteger starlevel;
@property (nonatomic, assign) NSInteger studentcoount;
@property (nonatomic, strong) NSArray * subject;
@property (nonatomic, strong) NSArray * tagslist;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) DVVCoachDetailDMTrainfield * trainfield;
@property (nonatomic, strong) DVVCoachDetailDMTrainfieldlinfo * trainfieldlinfo;
@property (nonatomic, assign) NSInteger validationstate;
@property (nonatomic, strong) NSString * worktimedesc;
@property (nonatomic, strong) DVVCoachDetailDMWorktimespace * worktimespace;
@property (nonatomic, strong) NSArray * workweek;
@end