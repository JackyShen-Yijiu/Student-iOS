//
//	YBAppointData.h
//
//	Create by JiangangYang on 12/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "YBAppointCoursedata.h"

@interface YBAppointData : NSObject

@property (nonatomic, copy) NSString * begintime;
@property (nonatomic, assign) NSInteger coachcount;
@property (nonatomic, strong) YBAppointCoursedata * coursedata;
@property (nonatomic, copy) NSString * endtime;
@property (nonatomic, assign) NSInteger is_outofdate;
@property (nonatomic, assign) NSInteger is_reservation;
@property (nonatomic, assign) NSInteger is_rest;
@property (nonatomic, copy) NSString * reservationcoachname;
@property (nonatomic, assign) NSInteger timeid;
@property (nonatomic, copy) NSString * timespace;

@property (assign, nonatomic) NSInteger indexPath;
@property (assign, nonatomic) BOOL is_selected;

@end