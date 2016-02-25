//
//  YBAppointMentDetailsController.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//  预约详情

#import "YBBaseViewController.h"
@class HMCourseModel;

@interface YBAppointMentDetailsController : YBBaseViewController

@property (nonatomic,strong) HMCourseModel  * courseModel;

@property (nonatomic, copy) NSString *coachID;

@end
