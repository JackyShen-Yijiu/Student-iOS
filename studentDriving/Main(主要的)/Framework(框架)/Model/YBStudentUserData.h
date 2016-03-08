#import <UIKit/UIKit.h>
#import "YBStudentUserApplyclasstypeinfo.h"
#import "YBStudentUserApplycoachinfo.h"
#import "YBStudentUserApplycoachinfo.h"
#import "YBStudentUserCarmodel.h"
#import "YBStudentUserHeadportrait.h"
#import "YBStudentUserSubject.h"
#import "YBStudentUserSubjectthree.h"
#import "YBStudentUserSubjectthree.h"

@interface YBStudentUserData : NSObject

@property (nonatomic, strong) NSArray * addresslist;
@property (nonatomic, strong) YBStudentUserApplyclasstypeinfo * applyclasstypeinfo;
@property (nonatomic, strong) YBStudentUserApplycoachinfo * applycoachinfo;
@property (nonatomic, strong) YBStudentUserApplycoachinfo * applyschoolinfo;
@property (nonatomic, assign) NSInteger applystate;
@property (nonatomic, strong) YBStudentUserCarmodel * carmodel;
@property (nonatomic, strong) NSString * createtime;
@property (nonatomic, strong) NSString * displaymobile;
@property (nonatomic, strong) NSString * displayuserid;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * gender;
@property (nonatomic, strong) YBStudentUserHeadportrait * headportrait;
@property (nonatomic, strong) NSString * invitationcode;
@property (nonatomic, assign) BOOL isLock;
@property (nonatomic, strong) NSString * logintime;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * signature;
@property (nonatomic, strong) YBStudentUserSubject * subject;
@property (nonatomic, strong) YBStudentUserSubjectthree * subjectthree;
@property (nonatomic, strong) YBStudentUserSubjectthree * subjecttwo;
@property (nonatomic, strong) NSString * telephone;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * userid;
@end