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
#import <SVProgressHUD.h>
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
+ (NSDictionary *)getSignUpInforamtion {
    
    NSString *krealNameString = [NSUserStoreTool getObjectWithKey:kRealName];
    if (krealNameString == nil || krealNameString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"名字为空"];
        return nil;
    }
    NSString *krealIdentityCarString = [NSUserStoreTool getObjectWithKey:kRealIdentityCar];
    if (krealIdentityCarString == nil || krealIdentityCarString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"身份证为空"];
        return nil;
    }
    NSString *krealTelephoneString = [NSUserStoreTool getObjectWithKey:kRealTelephone];
    if (krealTelephoneString == nil || krealTelephoneString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号为空"];
        return nil;
    }
    NSString *krealAddressString = [NSUserStoreTool getObjectWithKey:kRealAddress];
    if (krealAddressString == nil || krealAddressString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"地址为空"];
        return nil;

    }
    NSString *krealSchoolidString = [NSUserStoreTool getObjectWithKey:kRealSchoolid];
    if (krealSchoolidString == nil || krealSchoolidString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"学校为空"];
        return nil;

    }
    NSString *krealCoachidString = [NSUserStoreTool getObjectWithKey:kRealCoachid];
    if (krealCoachidString == nil || krealCoachidString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"教练为空"];
        return nil;

    }
    NSString *krealClasstypeidString = [NSUserStoreTool getObjectWithKey:kRealClasstypeid];
    if (krealClasstypeidString == nil || krealClasstypeidString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"班型为空"];
        return nil;

    }
    NSDictionary *krealCarmodelDictionary = [NSUserStoreTool getObjectWithKey:kRealCarmodel];
    if (krealCarmodelDictionary == nil) {
        [SVProgressHUD showErrorWithStatus:@"车型为空"];
        return nil;
    }
    
    return @{kRealUserid:[AcountManager manager].userid,kRealName:krealNameString,kRealIdentityCar:krealIdentityCarString,kRealTelephone:krealTelephoneString,kRealAddress:krealAddressString,kRealSchoolid:krealSchoolidString,kRealCoachid:krealCoachidString,kRealClasstypeid:krealClasstypeidString,kRealCarmodel:[JsonTransformManager dictionaryTransformJsonWith:krealCarmodelDictionary] };
}

+ (NSDictionary *)getSignUpPassInformation {
    NSString *krealNameString = [NSUserStoreTool getObjectWithKey:kRealName];
    if (krealNameString == nil || krealNameString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"名字为空"];
        return nil;
    }
    NSString *krealIdentityCarString = [NSUserStoreTool getObjectWithKey:kRealIdentityCar];
    if (krealIdentityCarString == nil || krealIdentityCarString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"身份证为空"];
        return nil;
    }
    NSString *krealTelephoneString = [NSUserStoreTool getObjectWithKey:kRealTelephone];
    if (krealTelephoneString == nil || krealTelephoneString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号为空"];
        return nil;
    }
    NSString *krealAddressString = [NSUserStoreTool getObjectWithKey:kRealAddress];
    if (krealAddressString == nil || krealAddressString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"地址为空"];
        return nil;
        
    }
    NSString *krealSchoolidString = [NSUserStoreTool getObjectWithKey:kRealSchoolid];
    if (krealSchoolidString == nil || krealSchoolidString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"学校为空"];
        return nil;
        
    }
    NSString *krealCoachidString = [NSUserStoreTool getObjectWithKey:kRealCoachid];
    if (krealCoachidString == nil || krealCoachidString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"教练为空"];
        return nil;
        
    }
    NSString *krealClasstypeidString = [NSUserStoreTool getObjectWithKey:kRealClasstypeid];
    if (krealClasstypeidString == nil || krealClasstypeidString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"班型为空"];
        return nil;
        
    }
    NSDictionary *krealCarmodelDictionary = [NSUserStoreTool getObjectWithKey:kRealCarmodel];
    if (krealCarmodelDictionary == nil) {
        [SVProgressHUD showErrorWithStatus:@"车型为空"];
        return nil;
    }
    
    if ([self getStudentNumber] == nil || [self getStudentNumber].length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"学员号为空"];
        return nil;
    }
    if ([self getPassNumber] == nil || [self getPassNumber].length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"准考证号为空"];
        return nil;
    }
    
    return @{kStudentNumber:[self getStudentNumber],kPassNumber:[self getPassNumber],kRealUserid:[AcountManager manager].userid,kRealName:krealNameString,kRealIdentityCar:krealIdentityCarString,kRealTelephone:krealTelephoneString,kRealAddress:krealAddressString,kRealSchoolid:krealSchoolidString,kRealCoachid:krealCoachidString,kRealClasstypeid:krealClasstypeidString,kRealCarmodel:[JsonTransformManager dictionaryTransformJsonWith:krealCarmodelDictionary] };
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
}

@end
