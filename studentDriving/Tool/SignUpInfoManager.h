//
//  SignUpInfoManager.h
//  BlackCat
//
//  Created by bestseller on 15/10/20.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kRealName = @"name";
static NSString *const kRealIdentityCar = @"idcardnumber";
static NSString *const kRealTelephone = @"telephone";
static NSString *const kRealAddress = @"address";
static NSString *const kRealSchoolid = @"schoolid";
static NSString *const kRealCoachid = @"coachid";
static NSString *const kRealClasstypeid = @"classtypeid";
static NSString *const kRealCarmodel = @"carmodel";
static NSString *const kRealLearnStage = @"learnStage";

static NSString *const kRealCode = @"code";
static NSString *const kRealSubjectID = @"subjectid";

static NSString *const kSchoolParam = @"applyschoolinfo";
static NSString *const kClasstypeParam = @"applyclasstypeinfo";
static NSString *const kCoachParam = @"applycoachinfo";

static NSString *const kStudentNumber = @"studentid";
static NSString *const kPassNumber = @"ticketnumber";
@interface SignUpInfoManager : NSObject
@property (copy, readonly, nonatomic) NSString *realName;
@property (copy, readonly, nonatomic) NSString *realIdentityCar;
@property (copy, readonly, nonatomic) NSString *realTelephone;
@property (copy, readonly, nonatomic) NSString *realAddress;
@property (copy, readonly, nonatomic) NSString *realSchoolid;
@property (copy, readonly, nonatomic) NSString *realCoachid;
@property (copy, readonly, nonatomic) NSString *realClasstypeid;
@property (copy, readonly, nonatomic) NSString *LearnStage; //学习阶段
@property (strong, readonly, nonatomic) NSDictionary *realCarmodel;

+ (void)signUpInfoSaveRealName:(NSString *)realName;
+ (void)signUpInfoSaveLearnStage:(NSString *)LearnStage;
+ (void)signUpInfoSaveRealIdentityCar:(NSString *)realIdentityCar;
+ (void)signUpInfoSaveRealTelephone:(NSString *)realTelephone;
+ (void)signUpInfoSaveRealAddress:(NSString *)realAddress;

+ (void)signUpInfoSaveRealcode:(NSString *)code;
+ (void)signUpInfoSaveRealSubjectID:(NSDictionary *)SubjectID;

//缓存准考证信息
+ (void)signUpInfoSaveStudentNumber:(NSString *)studentNumber;
+ (void)signUpInfoSavePassNumber:(NSString *)passNumber;


//缓存报考驾校
//+ (void)signUpInfoSaveRealSchoolid:(NSString *)realSchoolid;
+ (void)signUpInfoSaveRealSchool:(NSDictionary *)schoolParam;
//缓存报考教练
+ (void)signUpInfoSaveRealCoachid:(NSString *)realCoachid;
+ (void)signUpInfoSaveRealCoach:(NSDictionary *)CoachParam;
//缓存报考班型
//+ (void)signUpInfoSaveRealClasstypeid:(NSString *)realClasstypeid;
+ (void)signUpInfoSaveRealClasstype:(NSDictionary *)ClasstypeParam;
//缓存报考车型
+ (void)signUpInfoSaveRealCarmodel:(NSDictionary *)realCarmodel;

+ (NSDictionary *)getSignUpInforamtion;
+ (NSDictionary *)getSignUpPassInformation;


+ (NSString *)getSignUpSchoolid;
+ (NSString *)getSignUpCoachid;
+ (NSString *)getSignUpRealName;
+ (NSString *)getSignUpRealIdentityCar;
+ (NSString *)getSignUpRealTelephone;
+ (NSString *)getSignUpRealAddress;
+ (NSString *)getSignUprealClasstypeid;
+ (NSString *)getSignUprealLearnStage;
+ (NSDictionary *)getSignUpCarmodel;
+ (NSString *)getSignUpSubjectId;

+ (NSString *)getSignUpCoachName;
+ (NSString *)getSignUpClasstypeName;
+ (NSString *)getSignUpSchoolName;
+ (NSString *)getSignUpCarmodelName;

+ (NSString *)getStudentNumber;
+ (NSString *)getPassNumber ;

+ (void)removeSignData;

@end
