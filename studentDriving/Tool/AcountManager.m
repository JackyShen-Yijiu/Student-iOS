//
//  UserInformationCenter.m
//  BlackCat
//
//  Created by bestseller on 15/10/4.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "AcountManager.h"
#import "NSUserStoreTool.h"
#import "ToolHeader.h"
#import <SSKeychain.h>

static  NSString    *kMobile = @"mobile";
static  NSString    *kuserMobile = @"telephone";
static  NSString    *kuserName = @"name";
static  NSString    *kuserNickName = @"nickname";
static  NSString    *kuserCreateTime = @"userCreateTime";
static  NSString    *kuserEmail = @"email";
static  NSString    *kuserToken  = @"token";
static  NSString    *kuserCarmodels = @"carmodel";
static  NSString    *kuserLogintime = @"logintime";
static  NSString    *kuserInvitationcode = @"invitationcode";
static  NSString    *kuserApplystate = @"applystate";
static  NSString    *kuserDisplayuserid = @"displayuserid";
static  NSString    *kuserIs_lock = @"is_lock";
static  NSString    *kuserid = @"userid";
static  NSString    *kuserDisplaymobile = @"displaymobile";
static  NSString    *kAcount = @"acount";
static  NSString    *kPassword = @"passoword";
static  NSString    *kUserHeadImage = @"userHeadImage";
static  NSString    *kGender = @"gender";
static  NSString    *kSignature = @"signature";
static  NSString    *kApplyclasstypeinfo = @"applyclasstypeinfo";
static  NSString    *kApplycoachinfo = @"applycoachinfo";
static  NSString    *kApplyschoolinfo = @"applyschoolinfo";
static  NSString    *kheadportrait = @"headportrait";
static  NSString    *kaddress = @"address";
static  NSString    *kidcardnumber = @"idcardnumber";
static  NSString    *ksubject = @"subject";
static  NSString    *ksubjectTwo = @"subjecttwo";
static  NSString    *ksubjectThree = @"subjectthree";
static  NSString    *kBannerUrl = @"bannerUrl";
// 设置
static  NSString    *kUserSetting = @"usersetting";
static  NSString    *kReservationReminder = @"reservationreminder";
static  NSString    *kNewmessageReminder = @"newmessagereminder";

// 定位到的城市
static  NSString    *kUserCity = @"kUserCity";
// 根据城市名获取用户所在的城市是以驾校为主还是以教练为主
static  NSString    *kUserLocationShowType = @"kUserLocationShowType";

// 兑换券
static  NSString    *kUserCoinCertificate = @"kUserCoinCertificate";

@interface AcountManager ()
@property (readwrite,copy, nonatomic) NSString *userMobile;
@property (readwrite,copy, nonatomic) NSString *userName;
@property (readwrite,copy, nonatomic) NSString *userNickName;
@property (readwrite,copy, nonatomic) NSString *userCreateTime;
@property (readwrite,copy, nonatomic) NSString *userEmail;
@property (readwrite,copy, nonatomic) NSString *userToken;
@property (readwrite,strong, nonatomic) ExamCarModel *userCarmodels;
@property (readwrite,copy, nonatomic) NSString *userLogintime;
@property (readwrite,copy, nonatomic) NSString *userInvitationcode;
@property (readwrite,copy, nonatomic) NSString *userApplystate;
@property (readwrite,copy, nonatomic) NSString *userDisplayuserid;
@property (readwrite,copy, nonatomic) NSString *userIs_lock;
@property (readwrite,copy, nonatomic) NSString *userid;
@property (readwrite,copy, nonatomic) NSString *userDisplaymobile;
@property (readwrite,copy, nonatomic) NSString *userGender;
@property (readwrite,copy, nonatomic) NSString *userSignature;
@property (readwrite,strong, nonatomic) Logoimg *headportrait;
@property (readwrite,copy, nonatomic) NSString *headImageUrl;

@end
@implementation AcountManager
+ (AcountManager *)manager {
    AcountManager *manager = [[self alloc] init];
    return manager;
}
+ (AcountManager *)configUserInformationWith:(NSDictionary *)userInformaiton {

    AcountManager *userInformationManager = [[self alloc] init];
    //存储手机号
    if ([userInformaiton objectForKey:kuserMobile]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserMobile] WithKey:kuserMobile];
        
    }
    //用户名字
    if ([userInformaiton objectForKey:kuserName]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserName] WithKey:kuserName];
    }
    //用户昵称
    if ([userInformaiton objectForKey:kuserNickName]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserNickName] WithKey:kuserNickName];
    }
    if ([userInformaiton objectForKey:kuserCreateTime]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserCreateTime] WithKey:kuserCreateTime];
    }
    if ([userInformaiton objectForKey:kuserEmail]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserEmail] WithKey:kuserEmail];
    }
    if ([userInformaiton objectForKey:kuserToken]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserToken] WithKey:kuserToken];
    }
    if ([userInformaiton objectForKey:kuserCarmodels]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserCarmodels] WithKey:kuserCarmodels];
       
    }
    if ([userInformaiton objectForKey:kuserLogintime]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserLogintime] WithKey:kuserLogintime];
    }
    if ([userInformaiton objectForKey:kuserInvitationcode]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserInvitationcode] WithKey:kuserInvitationcode];
    }
    if ([userInformaiton objectForKey:kuserApplystate]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserApplystate] WithKey:kuserApplystate];
    }
    if ([userInformaiton objectForKey:kuserDisplayuserid]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserDisplayuserid] WithKey:kuserDisplayuserid];
    }
    if ([userInformaiton objectForKey:kuserIs_lock]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserIs_lock] WithKey:kuserIs_lock];
    }
    if ([userInformaiton objectForKey:kuserid]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserid] WithKey:kuserid];
    }
    if ([userInformaiton objectForKey:kuserDisplaymobile]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kuserDisplaymobile] WithKey:kuserDisplaymobile];
    }
    
    if ([userInformaiton objectForKey:kApplyclasstypeinfo]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kApplyclasstypeinfo] WithKey:kApplyclasstypeinfo];
    }
    
    if ([userInformaiton objectForKey:kheadportrait]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kheadportrait] WithKey:kheadportrait];
    }
    
    if ([userInformaiton objectForKey:kaddress]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kaddress] WithKey:kaddress];
    }
    
    if ([userInformaiton objectForKey:kidcardnumber]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kidcardnumber] WithKey:kidcardnumber];
    }
    //签名
    if ([userInformaiton objectForKey:kSignature]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kSignature] WithKey:kSignature];
    }
    
    if ([userInformaiton objectForKey:kGender]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kGender] WithKey:kGender];
    }
    
    if ([userInformaiton objectForKey:kApplyschoolinfo]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kApplyschoolinfo] WithKey:kApplyschoolinfo];
    }
    
    if ([userInformaiton objectForKey:kApplycoachinfo]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kApplycoachinfo] WithKey:kApplycoachinfo];
    }
    
    if ([userInformaiton objectForKey:ksubject]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:ksubject] WithKey:ksubject];
    }
    
    if ([userInformaiton objectForKey:ksubjectTwo]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:ksubjectTwo] WithKey:ksubjectTwo];
    }
    
    if ([userInformaiton objectForKey:ksubjectThree]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:ksubjectThree] WithKey:ksubjectThree];
    }
    
    if ([userInformaiton objectForKey:kMobile]) {
        [NSUserStoreTool storeWithId:[userInformaiton objectForKey:kMobile] WithKey:kMobile];
    }
    
    // 用户设置
    if ([userInformaiton objectForKey:kUserSetting]) {
        NSDictionary *dict = [userInformaiton objectForKey:kUserSetting];
        if (dict) {
            NSLog(@"---%@",[dict objectForKey:kReservationReminder]);
            NSLog(@"---%@",[dict objectForKey:kNewmessageReminder]);
            [NSUserStoreTool storeWithId:[dict objectForKey:kReservationReminder] WithKey:kReservationReminder];
            [NSUserStoreTool storeWithId:[dict objectForKey:kNewmessageReminder] WithKey:kNewmessageReminder];
//            [NSUserStoreTool storeWithId:@(1) WithKey:kReservationReminder];
//            [NSUserStoreTool storeWithId:@(1) WithKey:kNewmessageReminder];
        }
    }
    return userInformationManager;
}

+ (void)saveUserApplyState:(NSString *)state {
    if (state) {
        [NSUserStoreTool storeWithId:state WithKey:kuserApplystate];
    }
}


+ (void)saveUserNickName:(NSString *)nickName {
    [NSUserStoreTool storeWithId:nickName WithKey:kuserNickName];
}

+ (void)saveUserName:(NSString *)userName {
    [NSUserStoreTool storeWithId:userName WithKey:kuserName];
}
+ (void)saveUserAddress:(NSString *)address {
    [NSUserStoreTool storeWithId:address WithKey:kaddress];
}

+ (void)saveUserSignature:(NSString *)sigature {
    [NSUserStoreTool storeWithId:sigature WithKey:kSignature];
}

+ (void)saveUserGender:(NSString *)gender {
    [NSUserStoreTool storeWithId:gender WithKey:kGender];
}

//存储账号
+ (void)saveUserName:(NSString *)userName andPassword:(NSString *)password {
    [NSUserStoreTool storeWithId:userName WithKey:kAcount];
    [SSKeychain setPassword:password forService:kAcount account:userName];
}

+ (void)saveUserPhoneNum:(NSString *)phoneNum {
    [NSUserStoreTool storeWithId:phoneNum WithKey:kuserMobile];
}


//默认返回NO
+ (BOOL)isLogin {
    
    NSString *userName = [NSUserStoreTool getObjectWithKey:kAcount];
    if (userName != nil && userName.length > 0) {
        return YES;
    }
    return NO;
}
+ (void)saveUserHeadImageUrl:(NSString *)headImageUrl {
    [NSUserStoreTool storeWithId:headImageUrl WithKey:kUserHeadImage];
}
- (NSString *)userAddress {
    NSString *kuserAddress = [NSUserStoreTool getObjectWithKey:kaddress];
    if (kuserAddress == nil || [kuserAddress isEqual:[NSNull null]]) {
        return kuserAddress = @"";
    }
    return kuserAddress;
    
}
- (ApplyclasstypeinfoModel *)applyclasstype {
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kApplyclasstypeinfo];
    NSError *error = nil;
    
    ApplyclasstypeinfoModel *model = [MTLJSONAdapter modelOfClass:ApplyclasstypeinfoModel.class fromJSONDictionary:param error:&error];
    DYNSLog(@"error = %@",error);
    
    return model;
}

- (ApplycoachinfoModel *)applycoach {
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kApplycoachinfo];
    NSError *error = nil;
    ApplycoachinfoModel *model = [MTLJSONAdapter modelOfClass:ApplycoachinfoModel.class fromJSONDictionary:param error:&error];
    DYNSLog(@"error = %@",model);
    return model;
}

- (ApplyschoolinfoModel *)applyschool {
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kApplyschoolinfo];
    NSError *error = nil;
    ApplyschoolinfoModel *model = [MTLJSONAdapter modelOfClass:ApplyschoolinfoModel.class fromJSONDictionary:param error:&error];
    DYNSLog(@"model = %@",param);
    return model;
}

- (SubjectTwoModel *)subjecttwo {
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:ksubjectTwo];
    NSError *error = nil;
    SubjectTwoModel *model = [MTLJSONAdapter modelOfClass:SubjectTwoModel.class fromJSONDictionary:param error:&error];
    DYNSLog(@"model = %@",param);
    return model;
}
- (SubjectThreeModel *)subjectthree {
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:ksubjectTwo];
    NSError *error = nil;
    SubjectThreeModel *model = [MTLJSONAdapter modelOfClass:SubjectThreeModel.class fromJSONDictionary:param error:&error];
    DYNSLog(@"model = %@",param);
    return model;
}
// 设置
- (BOOL)reservationreminder {
    id object = [NSUserStoreTool getObjectWithKey:kReservationReminder];
    if (object) {
        return [object boolValue];
    }
    return NO;
}
- (void)setReservationreminder:(BOOL)reservationreminder {
    [NSUserStoreTool storeWithId:@(reservationreminder) WithKey:kReservationReminder];
}
- (BOOL)newmessagereminder {
    id object = [NSUserStoreTool getObjectWithKey:kNewmessageReminder];
    if (object) {
        return [object boolValue];
    }
    return NO;
}
- (void)setNewmessagereminder:(BOOL)newmessagereminder {
    [NSUserStoreTool storeWithId:@(newmessagereminder) WithKey:kNewmessageReminder];
}

- (NSString *)userHeadImageUrl {
    
    NSString *kUserHeadImageString = [NSUserStoreTool getObjectWithKey:kUserHeadImage];
    DYNSLog(@"Storeurl = %@",kUserHeadImageString);
    if (kUserHeadImageString){
        return kUserHeadImageString;
    }
    NSDictionary *param = [NSUserStoreTool getObjectWithKey:kheadportrait];
    NSError *error = nil;
    Logoimg *headportrait = [MTLJSONAdapter modelOfClass:Logoimg.class fromJSONDictionary:param error:&error];
    DYNSLog(@"error = %@",headportrait.originalpic);
    
    if (headportrait.originalpic) {
        kUserHeadImageString = headportrait.originalpic;
        return kUserHeadImageString;
    }
    kUserHeadImageString = @"";
    return kUserHeadImageString;
}
+ (NSDictionary *)getUserNameAndPassword {
    NSString *userName = [NSUserStoreTool getObjectWithKey:kAcount];
    NSString *password = [SSKeychain passwordForService:kAcount account:userName];
    
    NSDictionary *dic = @{kAcount:userName,kPassword:password};
    return dic;
}
- (NSString *)userMobile {
    NSString *userMobileString = [NSUserStoreTool getObjectWithKey:kMobile];
    if (userMobileString == nil) return @"";
    return userMobileString;
}

- (NSString *)userName {
    NSString *userNameString = [NSUserStoreTool getObjectWithKey:kuserName];
    if (userNameString == nil) return @"";

    return userNameString;
}
- (NSString *)userNickName {
    NSString *userNickNameString = [NSUserStoreTool getObjectWithKey:kuserNickName];
    if (userNickNameString == nil) return @"";

    return userNickNameString;
}
- (NSString *)userCreateTime {
    NSString *userCreateTimeString = [NSUserStoreTool getObjectWithKey:kuserCreateTime];
    if (userCreateTimeString == nil) return @"";

    return userCreateTimeString;
}
- (NSString *)userEmail {
    NSString *userEmailString = [NSUserStoreTool getObjectWithKey:kuserEmail];
    if (userEmailString == nil) return @"";

    return userEmailString;
}
- (NSString *)userToken {
    NSString *userTokenString = [NSUserStoreTool getObjectWithKey:kuserToken];
    if (userTokenString == nil) return @"";

    return userTokenString;
}
- (ExamCarModel *)userCarmodels {
    NSDictionary *userCarmodels = [NSUserStoreTool getObjectWithKey:kuserCarmodels];
    NSError *error = nil;
    ExamCarModel *model = [MTLJSONAdapter modelOfClass:ExamCarModel.class fromJSONDictionary:userCarmodels error:&error];
    DYNSLog(@"error Carmodels = %@ ",error);
    return model;
}

- (SubjectModel *)userSubject {
    NSDictionary *userSubject = [NSUserStoreTool getObjectWithKey:ksubject];
    NSLog(@"*****%@",userSubject);
    NSError *error = nil;
    SubjectModel *model = [MTLJSONAdapter modelOfClass:SubjectModel.class fromJSONDictionary:userSubject error:&error];
    DYNSLog(@"error = %@",error);
    return model;
}

- (NSString *)userLogintime {
    NSString *userLogintimeString = [NSUserStoreTool getObjectWithKey:kuserLogintime];
    if (userLogintimeString == nil) return @"";

    return userLogintimeString;
}
- (NSString *)userInvitationcode {
    NSString *userInvitationcodeString = [NSUserStoreTool getObjectWithKey:kuserInvitationcode];
    if (userInvitationcodeString == nil) return @"";

    return userInvitationcodeString;
}
- (NSString *)userApplystate {
    NSString *userApplystateString = [NSString stringWithFormat:@"%@",[NSUserStoreTool getObjectWithKey:kuserApplystate]];
    if (userApplystateString == nil) return @"";

    return userApplystateString;
}
- (NSString *)userDisplayuserid {
    NSString *userDisplayuseridString = [NSUserStoreTool getObjectWithKey:kuserDisplayuserid];
    if (userDisplayuseridString == nil) return @"";

    return userDisplayuseridString;
}
- (NSString *)userIs_lock {
    NSString *userIs_lockString = [NSUserStoreTool getObjectWithKey:kuserIs_lock];
    if (userIs_lockString == nil) return @"";

    return userIs_lockString;
}
- (NSString *)userid {
    NSString *useridString = [NSUserStoreTool getObjectWithKey:kuserid];
    if (useridString == nil)  return @"";
    return useridString;
}
- (NSString *)userDisplaymobile {
    NSString *userDisplaymobileString = [NSUserStoreTool getObjectWithKey:kuserDisplaymobile];
    if (userDisplaymobileString == nil) return @"";
   
    return userDisplaymobileString;
}
- (NSString *)userGender {
    NSString *userGenderString = [NSUserStoreTool getObjectWithKey:kGender];
    if (userGenderString == nil) return @"";
    return userGenderString;
}
- (NSString *)userSignature {
    NSString *userSignatureString = [NSUserStoreTool getObjectWithKey:kSignature];
    if (userSignatureString == nil) return @"";
    return userSignatureString;
}
- (NSString *)userIdcardnumber {
    NSString *idCardNumberString = [NSUserStoreTool getObjectWithKey:kidcardnumber];
    if (idCardNumberString == nil || [idCardNumberString isEqual:[NSNull null]]) {
        return idCardNumberString = @"";
    }
    return idCardNumberString;
}
+ (void)removeAllData {
    
    [NSUserStoreTool removeObjectWithKey:kuserMobile];
    [NSUserStoreTool removeObjectWithKey:kuserName];
    [NSUserStoreTool removeObjectWithKey:kuserNickName];
    [NSUserStoreTool removeObjectWithKey:kuserCreateTime];
    [NSUserStoreTool removeObjectWithKey:kuserEmail];
    [NSUserStoreTool removeObjectWithKey:kuserToken];
    [NSUserStoreTool removeObjectWithKey:kuserCarmodels];
    [NSUserStoreTool removeObjectWithKey:kuserLogintime];
    [NSUserStoreTool removeObjectWithKey:kuserInvitationcode];
    [NSUserStoreTool removeObjectWithKey:kuserApplystate];
    [NSUserStoreTool removeObjectWithKey:kuserDisplayuserid];
    [NSUserStoreTool removeObjectWithKey:kuserIs_lock];
    [NSUserStoreTool removeObjectWithKey:kuserid];
    [NSUserStoreTool removeObjectWithKey:kuserDisplaymobile];
    [NSUserStoreTool removeObjectWithKey:kAcount];
    [NSUserStoreTool removeObjectWithKey:kPassword];
    [NSUserStoreTool removeObjectWithKey:kUserHeadImage];
    [NSUserStoreTool removeObjectWithKey:kGender];
    [NSUserStoreTool removeObjectWithKey:kSignature];
    [NSUserStoreTool removeObjectWithKey:kApplyclasstypeinfo];
    [NSUserStoreTool removeObjectWithKey:kApplycoachinfo];
    [NSUserStoreTool removeObjectWithKey:kApplyschoolinfo];
    [NSUserStoreTool removeObjectWithKey:kheadportrait];
    [NSUserStoreTool removeObjectWithKey:kaddress];
    [NSUserStoreTool removeObjectWithKey:kidcardnumber];
    [NSUserStoreTool removeObjectWithKey:@"schoolid"];
    [NSUserStoreTool removeObjectWithKey:@"coachid"];
    [NSUserStoreTool removeObjectWithKey:ksubject];
    [NSUserStoreTool removeObjectWithKey:ksubjectThree];
    [NSUserStoreTool removeObjectWithKey:ksubjectTwo];
    
    
    [NSUserStoreTool removeObjectWithKey:kUserCity];
    [NSUserStoreTool removeObjectWithKey:kUserLocationShowType];
    
    [NSUserStoreTool removeObjectWithKey:kReservationReminder];
    [NSUserStoreTool removeObjectWithKey:kNewmessageReminder];
    
    [NSUserStoreTool removeObjectWithKey:kUserCoinCertificate];
}

+ (void)saveUserBanner:(NSArray *)dataArray {
    [NSUserStoreTool storeWithId:dataArray WithKey:kBannerUrl];
}

+ (NSArray *)getBannerUrlArray {
    NSArray *array = [NSUserStoreTool getObjectWithKey:kBannerUrl];
    NSArray *dataArray = [[NSArray alloc] init];
    if (array != nil ) {
        NSError *error = nil;
        dataArray = [MTLJSONAdapter modelsOfClass:BannerModel.class fromJSONArray:array error:&error];
    }
    return dataArray;
}

// 存储定位到的城市
- (void)setUserCity:(NSString *)userCity {
    [NSUserStoreTool storeWithId:userCity WithKey:kUserCity];
}
- (NSString *)userCity {
    
    if ([NSUserStoreTool getObjectWithKey:kUserCity]) {
        return [NSUserStoreTool getObjectWithKey:kUserCity];
    }else {
        return @"";
    }
}
// 根据城市名获取用户所在的城市是以驾校为主还是以教练为主
- (void)setUserLocationShowType:(BOOL)userLocationShowType {
    [NSUserStoreTool storeWithId:@(userLocationShowType) WithKey:kUserLocationShowType];
}
- (BOOL)userLocationShowType {
    if ([NSUserStoreTool getObjectWithKey:kUserLocationShowType]) {
        return [[NSUserStoreTool getObjectWithKey:kUserLocationShowType] boolValue];
    }else {
        return NO;
    }
}
// 兑换券
- (void)setUserCoinCertificate:(NSUInteger)userCoinCertificate {
    [NSUserStoreTool storeWithId:@(userCoinCertificate) WithKey:kUserCoinCertificate];
}
- (NSUInteger)userCoinCertificate {
    if ([NSUserStoreTool getObjectWithKey:kUserCoinCertificate]) {
        return [[NSUserStoreTool getObjectWithKey:kUserCoinCertificate] integerValue];
    }else {
        return 0;
    }
}

- (void)dealloc {
//    DYNSLog(@"对象销毁");
}

+(BOOL)isValidateMobile:(NSString *)mobile
{
    NSString *regex = @"^((17[0-9])|(13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobile];
    return isMatch;
}

@end
