//
//	YBUserData.h
//
//	Create by JiangangYang on 22/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "YBUserApplyclasstypeinfo.h"
#import "YBUserApplycoachinfo.h"
#import "YBUserApplycoachinfo.h"
#import "YBUserCarmodel.h"
#import "YBUserHeadportrait.h"
#import "YBUserSubject.h"
#import "YBUserSubjectthree.h"
#import "YBUserSubjectthree.h"
#import "YBUserUsersetting.h"
#import "YBUserVipserverlist.h"

@interface YBUserData : NSObject

@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSArray * addresslist;
@property (nonatomic, strong) YBUserApplyclasstypeinfo * applyclasstypeinfo;
@property (nonatomic, strong) YBUserApplycoachinfo * applycoachinfo;
@property (nonatomic, strong) YBUserApplycoachinfo * applyschoolinfo;
@property (nonatomic, assign) NSInteger applystate;
@property (nonatomic, strong) YBUserCarmodel * carmodel;
@property (nonatomic, strong) NSString * createtime;
@property (nonatomic, strong) NSString * displaymobile;
@property (nonatomic, strong) NSString * displayuserid;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * gender;
@property (nonatomic, strong) YBUserHeadportrait * headportrait;
@property (nonatomic, strong) NSString * idcardnumber;
@property (nonatomic, strong) NSString * invitationcode;
@property (nonatomic, assign) BOOL isLock;
@property (nonatomic, strong) NSString * logintime;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * signature;
@property (nonatomic, strong) YBUserSubject * subject;
@property (nonatomic, strong) YBUserSubjectthree * subjectthree;
@property (nonatomic, strong) YBUserSubjectthree * subjecttwo;
@property (nonatomic, strong) NSString * telephone;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * userid;
@property (nonatomic, strong) YBUserUsersetting * usersetting;
@property (nonatomic, strong) NSArray * vipserverlist;

@end