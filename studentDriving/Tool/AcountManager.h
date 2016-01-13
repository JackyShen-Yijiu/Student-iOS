//
//  UserInformationCenter.h
//  BlackCat
//
//  Created by bestseller on 15/10/4.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApplyclasstypeinfoModel.h"
#import "ApplycoachinfoModel.h"
#import "ApplyschoolinfoModel.h"
#import "ExamCarModel.h"
#import "Logoimg.h"
#import "SubjectModel.h"
#import "SubjectTwoModel.h"
#import "SubjectThreeModel.h"
#import "BannerModel.h"

@interface AcountManager : NSObject
@property (readonly,copy, nonatomic) NSString *userAddress;
@property (readonly,strong, nonatomic) ApplyclasstypeinfoModel *applyclasstype;
@property (readonly,strong, nonatomic) ApplycoachinfoModel *applycoach;
@property (readonly,strong, nonatomic) ApplyschoolinfoModel *applyschool;
@property (readonly,strong, nonatomic) ExamCarModel *userCarmodels;
@property (readonly,copy, nonatomic) NSString *userIdcardnumber;
@property (readonly,copy, nonatomic) NSString *userMobile;
@property (readonly,copy, nonatomic) NSString *userName;
@property (readonly,copy, nonatomic) NSString *userNickName;
@property (readonly,copy, nonatomic) NSString *userCreateTime;
@property (readonly,copy, nonatomic) NSString *userEmail;
@property (readonly,copy, nonatomic) NSString *userToken;
@property (readonly,copy, nonatomic) NSString *userLogintime;
@property (readonly,copy, nonatomic) NSString *userInvitationcode;
@property (readonly,copy, nonatomic) NSString *userApplystate;
@property (readonly,copy, nonatomic) NSString *userApplycount;
@property (readonly,copy, nonatomic) NSString *userDisplayuserid;
@property (readonly,copy, nonatomic) NSString *userIs_lock;
@property (readonly,copy, nonatomic) NSString *userid;
@property (readonly,copy, nonatomic) NSString *userDisplaymobile;
@property (readonly,copy, nonatomic) NSString *userGender;
@property (readonly,copy, nonatomic) NSString *userSignature;
@property (readonly,copy, nonatomic) NSString *userHeadImageUrl;
@property (readonly,strong, nonatomic) SubjectModel *userSubject;
@property (readonly, strong, nonatomic) SubjectTwoModel *subjecttwo;
@property (readonly,strong, nonatomic) SubjectThreeModel *subjectthree;

// 定位到的经纬度
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;

// 定位到的城市
@property (nonatomic, copy) NSString *userCity;
// 定位到的详细地址
@property (nonatomic, copy) NSString *locationAddress;
// 根据城市名获取用户所在的城市是以驾校为主还是以教练为主
@property (nonatomic, assign) BOOL userLocationShowType;

// 设置
@property (nonatomic, assign) BOOL reservationreminder;
@property (nonatomic, assign) BOOL newmessagereminder;

// 兑换券
@property (atomic, assign) NSUInteger userCoinCertificate;

+ (AcountManager *)manager;

+ (AcountManager *)configUserInformationWith:(NSDictionary *)userInformaiton;
+ (void)saveUserName:(NSString *)userName andPassword:(NSString *)password;
+ (NSDictionary *)getUserNameAndPassword;
+ (BOOL)isLogin;
+ (void)saveUserHeadImageUrl:(NSString *)headImageUrl;
+ (void)saveUserGender:(NSString *)gender;
+ (void)saveUserPhoneNum:(NSString *)phoneNum;
+ (void)saveUserSignature:(NSString *)sigature;
+ (void)saveUserName:(NSString *)userName;
+ (void)saveUserNickName:(NSString *)nickName;
+ (void)saveUserAddress:(NSString *)address;

+ (void)removeAllData;

+ (void)saveUserApplyState:(NSString *)state;
+ (void)saveUserApplyCount:(NSString *)count;
+ (void)saveUserBanner:(NSArray *)dataArray;
+ (NSArray *)getBannerUrlArray;

// 判断手机号格式是否正确
+(BOOL)isValidateMobile:(NSString *)mobile;

@end
