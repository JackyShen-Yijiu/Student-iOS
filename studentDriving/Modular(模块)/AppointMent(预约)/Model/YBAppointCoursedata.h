//
//	YBAppointCoursedata.h
//
//	Create by JiangangYang on 12/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "YBAppointCoursetime.h"

@interface YBAppointCoursedata : NSObject

@property (nonatomic, assign) NSInteger v;
@property (nonatomic, strong) NSString * _id;
@property (nonatomic, assign) NSInteger carmodelid;
@property (nonatomic, copy) NSString * coachid;
@property (nonatomic, copy) NSString * coachname;
@property (nonatomic, copy) NSString * coursebegintime;
@property (nonatomic, copy) NSString * coursedate;
@property (nonatomic, copy) NSString * courseendtime;
@property (nonatomic, strong) NSArray * coursereservation;
@property (nonatomic, assign) NSInteger coursestudentcount;
@property (nonatomic, strong) YBAppointCoursetime * coursetime;
@property (nonatomic, strong) NSArray * courseuser;
@property (nonatomic, copy) NSString * createtime;
@property (nonatomic, copy) NSString * driveschool;
@property (nonatomic, strong) NSObject * platenumber;
@property (nonatomic, assign) NSInteger selectedstudentcount;
@property (nonatomic, assign) NSInteger signinstudentcount;
@property (nonatomic, assign) NSInteger subjectid;
@end