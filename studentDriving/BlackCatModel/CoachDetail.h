//
//  CoachDetail.h
//  BlackCat
//
//  Created by bestseller on 15/10/19.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MTLModel.h"
#import "CarModel.h"
#import "SubjectModel.h"

#import "DriveSchoolinfo.h"
#import "Logoimg.h"
#import "TrainFieldInfoModel.h"
#import <MTLJSONAdapter.h>
#import "trainfieldModel.h"

@interface CoachDetail : MTLModel<MTLJSONSerializing>
//资质
@property (copy, nonatomic) NSString *seniority;
@property (copy, nonatomic) NSString *address;
@property (strong, nonatomic) CarModel *carmodel;
@property (copy, nonatomic) NSString *coachid;
@property (strong, nonatomic) NSNumber *commentcount;
@property (copy, nonatomic) NSString *createtime;
@property (copy, nonatomic) NSString *displaycoachid;
@property (strong, nonatomic) DriveSchoolinfo *driveschoolinfo;
@property (copy, nonatomic) NSString *email;
@property (strong, nonatomic) Logoimg *headportrait;
@property (copy, nonatomic) NSString *introduction;
@property (strong, nonatomic) NSString *invitationcode;
@property (assign, nonatomic) BOOL is_lock;
//是否接送
@property (assign, nonatomic) BOOL is_shuttle;
@property (assign, nonatomic) BOOL is_validation;
@property (copy, nonatomic) NSString *logintime;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *name;
//通过率
@property (strong, nonatomic) NSNumber *passrate;
//车牌号
@property (copy, nonatomic) NSString *platenumber;
//接送信息
@property (copy, nonatomic) NSString *shuttlemsg;
@property (strong, nonatomic) NSNumber *starlevel;
@property (strong, nonatomic) NSNumber *studentcoount;
@property (strong, nonatomic) NSArray *subject;
@property (strong, nonatomic) TrainFieldInfoModel *trainFieldInfo;
@property (strong, nonatomic) NSNumber *validationstate;
@property (copy, nonatomic) NSString *worktimedesc;

@property (nonatomic,strong) trainfieldModel *trainfield;

@property (nonatomic,strong) NSArray *tagslist;

@end
