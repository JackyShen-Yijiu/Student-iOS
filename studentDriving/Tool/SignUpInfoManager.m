//
//  SignUpInfoManager.m
//  BlackCat
//
//  Created by bestseller on 15/10/20.
//  Copyright © 2015年 lord. All rights reserved.
//
#import "SignUpInfoManager.h"
#import "NSUserStoreTool.h"
#import "AcountManager.h"
#import "BLInformationManager.h"
#import "JsonTransformManager.h"
static NSString *const kRealUserid = @"userid";

@interface SignUpInfoManager ()
@property (copy, readwrite, nonatomic) NSString *realName;
@property (copy, readwrite, nonatomic) NSString *realIdentityCar;
@property (copy, readwrite, nonatomic) NSString *realTelephone;
@property (copy, readwrite, nonatomic) NSString *realAddress;
@property (copy, readwrite, nonatomic) NSString *realSchoolid;
@property (copy, readwrite, nonatomic) NSString *realCoachid;
@property (copy, readwrite, nonatomic) NSString *realClasstypeid;
@property (strong, readwrite, nonatomic) NSDictionary *realCarmodel;
@property (copy, readwrite, nonatomic) NSString *realUserId;
@end
@implementation SignUpInfoManager

+ (void)signUpInfoSaveStudentNumber:(NSString *)studentNumber {
    [NSUserStoreTool storeWithId:studentNumber WithKey:kStudentNumber];

}
+ (void)signUpInfoSavePassNumber:(NSString *)passNumber {
    [NSUserStoreTool storeWithId:passNumber WithKey:kPassNumber];
}

+ (NSString *)getStudentNumber {
    NSString *studentNumberString = [NSUserStoreTool getObjectWithKey: kStudentNumber];
    if (studentNumberString != nil) {
        return studentNumberString;
    }
    NSLog(@"student = %@",studentNumberString);
    return @"";
}
+ (NSString *)getPassNumber {
    NSString *passNumberString = [NSUserStoreTool getObjectWithKey:kPassNumber];
    if (passNumberString != nil) {
        return passNumberString;
    }
    return @"";
}
+ (void)signUpInfoSaveRealName:(NSString *)realName {
    
    [NSUserStoreTool storeWithId:realName WithKey:kRealName];
}

+ (void)signUpInfoSaveRealcode:(NSString *)code {
    [NSUserStoreTool storeWithId:code WithKey:kRealCode];
}

+ (void)signUpInfoSaveRealFcode:(NSString *)Fcode {
    [NSUserStoreTool storeWithId:Fcode WithKey:kFcode];
}

+ (void)signUpInfoSaveRealSubjectID:(NSDictionary *)SubjectID {
    [NSUserStoreTool storeWithId:SubjectID WithKey:kRealSubjectID];
}

+ (void)signUpInfoSaveLearnStage:(NSString *)LearnStage {
    
    [NSUserStoreTool storeWithId:LearnStage WithKey:kRealLearnStage];
}

+ (void)signUpInfoSaveRealIdentityCar:(NSString *)realIdentityCar {
    [NSUserStoreTool storeWithId:realIdentityCar WithKey:kRealIdentityCar];
}
+ (void)signUpInfoSaveRealTelephone:(NSString *)realTelephone {
    [NSUserStoreTool storeWithId:realTelephone WithKey:kRealTelephone];
}

+ (void)signUpInfoSaveRealAddress:(NSString *)realAddress {
    [NSUserStoreTool storeWithId:realAddress WithKey:kRealAddress];
}

//缓存报考学校
+ (void)signUpInfoSaveRealSchool:(NSDictionary *)schoolParam {
    if (schoolParam == nil || [schoolParam isEqual:[NSNull null]]) {
        return;
    }
    
     NSDictionary *param = @{@"id":schoolParam[@"schoolid"],@"name":schoolParam[@"name"]};
    NSLog(@"param = %@",param);
    [NSUserStoreTool storeWithId:param WithKey:kSchoolParam];
    [self signUpInfoSaveRealSchoolid:schoolParam[kRealSchoolid]];
}
+ (void)signUpInfoSaveRealSchoolid:(NSString *)realSchoolid {
    [NSUserStoreTool storeWithId:realSchoolid WithKey:kRealSchoolid];
}

//获得报考驾校名字
+ (NSString *)getSignUpSchoolName {
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kSchoolParam];
    NSString *name = param[@"name"];
    if (name == nil || name.length == 0) {
        return @"";
    }
    return name;
}
//缓存报考班型
+ (void)signUpInfoSaveRealClasstype:(NSDictionary *)ClasstypeParam {
    if (ClasstypeParam == nil || [ClasstypeParam isEqual:[NSNull null]]) {
        return;
    }
    [NSUserStoreTool storeWithId:ClasstypeParam WithKey:kClasstypeParam];
    [self signUpInfoSaveRealClasstypeid:ClasstypeParam[kRealClasstypeid]];
}
+ (void)signUpInfoSaveRealClasstypeid:(NSString *)realClasstypeid {
    [NSUserStoreTool storeWithId:realClasstypeid WithKey:kRealClasstypeid];
}

//获得报考班型名字
+ (NSString *)getSignUpClasstypeName {
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kClasstypeParam];
    NSString *name = param[@"name"];
    if (name == nil || name.length == 0) {
        return @"";
    }
    if (param[@"id"]) {
        [self signUpInfoSaveRealClasstypeid:param[@"id"]];
    }
    
    return name;
}

//缓存报考教练
+ (void)signUpInfoSaveRealCoach:(NSDictionary *)CoachParam {
    if (CoachParam == nil || [CoachParam isEqual:[NSNull null]]) {
        return;
    }
    NSLog(@"param = %@",CoachParam);
    
    NSDictionary *param = @{@"id":CoachParam[@"coachid"],@"name":CoachParam[@"name"]};
    
    [NSUserStoreTool storeWithId:param WithKey:kCoachParam];
    [self signUpInfoSaveRealCoachid:CoachParam[kRealCoachid]];
}

+ (void)signUpInfoSaveRealCoachid:(NSString *)realCoachid {
    [NSUserStoreTool storeWithId:realCoachid WithKey:kRealCoachid];
}
//获取报考教练名字
+ (NSString *)getSignUpCoachName {
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kCoachParam];
    NSString *name = param[@"name"];
    if (name == nil || name.length == 0) {
        return @"智能匹配";
    }
    return name;
}

#warning  由于验证和报名的key相同，修改一个
//缓存验证教练
+ (void)signUpInfoSaveVerifyRealCoach:(NSDictionary *)CoachParam {
    if (CoachParam == nil || [CoachParam isEqual:[NSNull null]]) {
        return;
    }
    NSLog(@"param = %@",CoachParam);
    
    NSDictionary *param = @{@"id":CoachParam[@"verifycoachid"],@"name":CoachParam[@"name"]};
    
    [NSUserStoreTool storeWithId:param WithKey:kVerifyCoachParam];
    [self signUpInfoSaveVerifyRealCoachid:CoachParam[kVerifyCoachid]];
}

+ (void)signUpInfoSaveVerifyRealCoachid:(NSString *)realCoachid {
    [NSUserStoreTool storeWithId:realCoachid WithKey:kVerifyCoachid];
}
//获取验证教练名字
+ (NSString *)getSignUpVerifyCoachName {
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kVerifyCoachParam];
    NSString *name = param[@"name"];
    if (name == nil || name.length == 0) {
        return @"";
    }
    return name;
}
//缓存车型
+ (void)signUpInfoSaveRealCarmodel:(NSDictionary *)realCarmodel {
    if (realCarmodel == nil || [realCarmodel isEqual:[NSNull null]]) {
        return;
    }
    [NSUserStoreTool storeWithId:realCarmodel WithKey:kRealCarmodel];
}
+ (NSString *)getSignUpCarmodelName {
    
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kRealCarmodel];
    NSString *name = param[@"name"];
    if (name == nil || name.length == 0) {
        return @"";
    }
    NSLog(@"name = %@",param);
    return name;
}
//填写信息
+ (NSString *)getSignUpRealName {
    NSString *realName = @"";
    if ([NSUserStoreTool getObjectWithKey:kRealName]) {
        realName = [NSUserStoreTool getObjectWithKey:kRealName];
    }
    return realName;
}

+ (NSString *)getSignUpSubjectId {
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kRealSubjectID];
    NSString *name = param[@"name"];
    if (name == nil || name.length == 0) {
        return @"";
    }
    return name;
}


+ (NSString *)getSignUpRealIdentityCar {
    NSString *realIdentityCar = @"";
    if ([NSUserStoreTool getObjectWithKey:kRealIdentityCar]) {
        realIdentityCar = [NSUserStoreTool getObjectWithKey:kRealIdentityCar];
    }
    return realIdentityCar;
}
+ (NSString *)getSignUpRealTelephone {
    NSString *realTelephone = @"";
    if ([NSUserStoreTool getObjectWithKey:kRealTelephone]) {
        realTelephone = [NSUserStoreTool getObjectWithKey:kRealTelephone];
    }
    NSLog(@"telephone = %@",realTelephone);
    return realTelephone;
}
+ (NSString *)getSignUpRealAddress {
    NSString *realAddress = @"";
    if ([NSUserStoreTool getObjectWithKey:kRealAddress]) {
        realAddress = [NSUserStoreTool getObjectWithKey:kRealAddress];
    }
    return realAddress;
}

+ (NSString *)getSignUpSchoolid {
    return [NSUserStoreTool getObjectWithKey:kRealSchoolid];
}

+ (NSString *)getSignUpCoachid {
    return [NSUserStoreTool getObjectWithKey:kRealCoachid];
}
+ (NSDictionary *)getSignUpCarmodel {
    return [NSUserStoreTool getObjectWithKey:kRealCarmodel];
}

+ (NSString *)getSignUprealClasstypeid {
    return [NSUserStoreTool getObjectWithKey:kRealClasstypeid];
}
+ (NSString *)getSignUprealLearnStage {
    NSString *LearnStage = @"";
    if ([NSUserStoreTool getObjectWithKey:kRealLearnStage]) {
        LearnStage = [NSUserStoreTool getObjectWithKey:kRealLearnStage];
    }
    return LearnStage;
}
+ (NSDictionary *)getSignUpInforamtion {
    
    NSString *krealNameString = [NSUserStoreTool getObjectWithKey:kRealName];
    if (krealNameString == nil || krealNameString.length == 0) {
        [self obj_showTotasViewWithMes:@"名字为空"];
        return nil;
    }
    NSString *krealTelephoneString = [NSUserStoreTool getObjectWithKey:kRealTelephone];
    if (krealTelephoneString == nil || krealTelephoneString.length == 0) {
        [self  obj_showTotasViewWithMes:@"请输入正确的手机号"];
        return nil;
    }

    NSString *krealSchoolidString = [NSUserStoreTool getObjectWithKey:kRealSchoolid];
    if (krealSchoolidString == nil || krealSchoolidString.length == 0) {
        [self obj_showTotasViewWithMes:@"学校为空"];
        return nil;

    }
    NSString *krealCoachidString = [NSUserStoreTool getObjectWithKey:kRealCoachid];
    if (krealCoachidString == nil || krealCoachidString.length == 0) {
        krealCoachidString = @"-1";
    }

    NSString *krealClasstypeidString = [NSUserStoreTool getObjectWithKey:kRealClasstypeid];
    if (krealClasstypeidString == nil || krealClasstypeidString.length == 0) {
        [self obj_showTotasViewWithMes:@"班型为空"];
        return nil;

    }
    NSDictionary *krealCarmodelDictionary = [NSUserStoreTool getObjectWithKey:kRealCarmodel];
    if (krealCarmodelDictionary == nil) {
        [self obj_showTotasViewWithMes:@"车型为空"];
        return nil;
    }
    
    NSString *applyAgain = [NSUserStoreTool getObjectWithKey:@"applyAgain"];
    if (applyAgain == nil) {
        applyAgain = @"0";
    }
    
    NSString *kFcode = [NSUserStoreTool getObjectWithKey:@"fcode"];
    if (kFcode == nil || kFcode.length == 0) {
        kFcode = @"";
    }
    
    return @{kRealUserid:[AcountManager manager].userid,kRealName:krealNameString,kRealIdentityCar:@"",kRealTelephone:krealTelephoneString,kRealAddress:@"",kRealSchoolid:krealSchoolidString,kRealCoachid:krealCoachidString,kRealClasstypeid:krealClasstypeidString,kRealCarmodel:[JsonTransformManager dictionaryTransformJsonWith:krealCarmodelDictionary],@"fcode":kFcode,@"applyagain":applyAgain };
}

+ (NSDictionary *)getSignUpPassInformation {
    NSString *krealNameString = [NSUserStoreTool getObjectWithKey:kRealName];
    if (krealNameString == nil || krealNameString.length == 0) {
        [self obj_showTotasViewWithMes:@"名字为空"];
        return nil;
    }
    NSString *krealCode = [NSUserStoreTool getObjectWithKey:kRealCode];
    if (krealCode == nil || krealCode.length == 0) {
        [self obj_showTotasViewWithMes:@"短信验证码为空"];
        return nil;
    }
    
    NSString *krealTelephoneString = [NSUserStoreTool getObjectWithKey:kRealTelephone];
    if (krealTelephoneString == nil || krealTelephoneString.length == 0) {
        [self obj_showTotasViewWithMes:@"手机号为空"];
        return nil;
    }
    
    NSString *krealSchoolidString = [NSUserStoreTool getObjectWithKey:kRealSchoolid];
    if (krealSchoolidString == nil || krealSchoolidString.length == 0) {
        [self obj_showTotasViewWithMes:@"学校为空"];
        return nil;
        
    }
    NSString *krealCoachidString = [NSUserStoreTool getObjectWithKey:kVerifyCoachid];
    if (krealCoachidString == nil || krealCoachidString.length == 0) {
        [self obj_showTotasViewWithMes:@"教练为空"];
        return nil;
        
    }
//    NSString *krealClasstypeidString = [NSUserStoreTool getObjectWithKey:kRealClasstypeid];
//    if (krealClasstypeidString == nil || krealClasstypeidString.length == 0) {
//        [self obj_showTotasViewWithMes:@"班型为空"];
//        return nil;
//        
//    }
    NSDictionary *krealSubjectDic = [NSUserStoreTool getObjectWithKey:kRealSubjectID];
    NSString *krealSubjectId = @"";
    if ([[krealSubjectDic objectForKey:@"subject"] isEqualToString:krealSubjectId]&&[krealSubjectDic objectForKey:@"subject"] == nil) {
        [self obj_showTotasViewWithMes:@"科目进度为空"];
        return nil;
    }
    krealSubjectId = [krealSubjectDic objectForKey:@"subject"];
    
    NSDictionary *krealCarmodelDictionary = [NSUserStoreTool getObjectWithKey:kRealCarmodel];
    if (krealCarmodelDictionary == nil) {
        [self obj_showTotasViewWithMes:@"车型为空"];
        return nil;
    }
    
    
    return @{@"userid":[AcountManager manager].userid,
             @"name":krealNameString,
             @"telephone":krealTelephoneString,
             @"schoolid":krealSchoolidString,
             @"coachid":krealCoachidString,
//             @"classtypeid":krealClasstypeidString,
             @"subjectid":krealSubjectId,
             @"code":krealCode,
             @"carmodel":[JsonTransformManager dictionaryTransformJsonWith:krealCarmodelDictionary]
             };
}


+ (void)removeSignData {
    [NSUserStoreTool removeObjectWithKey:kRealCarmodel];
    [NSUserStoreTool removeObjectWithKey:kRealClasstypeid];
    [NSUserStoreTool removeObjectWithKey:kRealCoachid];
    [NSUserStoreTool removeObjectWithKey:kRealSchoolid];
    [NSUserStoreTool removeObjectWithKey:kSchoolParam];
    [NSUserStoreTool removeObjectWithKey:kCoachParam];
    [NSUserStoreTool removeObjectWithKey:kClasstypeParam];
    [NSUserStoreTool removeObjectWithKey:kPassNumber];
    [NSUserStoreTool removeObjectWithKey:kStudentNumber];
    [NSUserStoreTool removeObjectWithKey:kRealSubjectID];
    [NSUserStoreTool removeObjectWithKey:kRealCode];
    [NSUserStoreTool removeObjectWithKey:kRealLearnStage];
    [NSUserStoreTool removeObjectWithKey:kFcode];
    [NSUserStoreTool removeObjectWithKey:kRealName];
    [NSUserStoreTool removeObjectWithKey:kRealTelephone];
    [NSUserStoreTool removeObjectWithKey:kVerifyCoachid];
    [NSUserStoreTool removeObjectWithKey:kVerifyCoachParam];
}

@end
