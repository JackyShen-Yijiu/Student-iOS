//
//  HMOrderModel.h
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMStudentModel.h"
#import "HMClassInfoModel.h"
#import "HMTrainaddressModel.h"
#import "JGSubjectthreeModel.h"
#import "HMCourseUserModel.h"
#import "HMSubjectModel.h"

@interface HMCourseModel : NSObject

@property(nonatomic,strong)NSString * courseId;

@property(nonatomic,assign)KCourseStatue courseStatue;

@property(nonatomic,strong)NSString * reservationcreatetime;

@property(nonatomic,strong)NSString * coursePikerAddres; //接送地址

@property(nonatomic,strong)NSString * courseprocessdesc;

@property(nonatomic,strong)NSString * courseTime;

@property(nonatomic,strong)HMCourseUserModel* userModel;

@property(nonatomic,strong)HMSubjectModel* subject;

@property(nonatomic,strong)HMTrainaddressModel* courseTrainInfo;

@property(nonatomic,strong)NSString * courseBeginTime;

@property(nonatomic,strong)NSString * courseEndtime;

// 取消原因 cancelreason:{reason:String,cancelcontent:String},
@property(nonatomic,strong)NSDictionary * cancelreason;


//@property(nonatomic,strong)NSString * courseProgress;
////@property(nonatomic,strong)NSString * courseAddress;     //训练场地
//@property(nonatomic,assign)BOOL isPickerUp;
//@property(nonatomic,strong)HMClassInfoModel * classType;
//@property(nonatomic,strong)HMStudentModel * studentInfo;
//
//// 倒车入科(学习内容)
//@property(nonatomic,strong)NSString * learningcontent;
//
//@property(nonatomic,strong)NSString * comment;
//@property(nonatomic,strong)NSString * coachcomment;
//@property(nonatomic,strong)NSString * cancelreason;
//
//// 官方学时
//@property(nonatomic,strong)NSString * officialDesc;
//
///*
// * v1.1.0添加剩余多少课时，漏课统计
// */
//@property(nonatomic,assign)NSInteger leavecoursecount;
//@property(nonatomic,assign)NSInteger missingcoursecount;
//
//@property (nonatomic,strong) JGSubjectthreeModel *subjectthree;

+ (HMCourseModel *)converJsonDicToModel:(NSDictionary *)dic;

- (NSString *)getStatueString;
@end


