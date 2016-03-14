//
//  YBNetworkMacro.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//  网络宏

#ifndef YBNetworkMacro_h
#define YBNetworkMacro_h

// 切换正式库时要单独进行切换!!!!!!!!!!!!!!!!!!! 首页H5页面
#define BTH5   @"http://api.yibuxueche.com/%@"
//http://123.57.63.15:8181/ 正式库
// http://101.200.204.240:8181/ 测试库

// 正式库
#define BASEURL @"http://jzapi.yibuxueche.com/api/v1/%@"
// 测试库
//#define BASEURL @"http://101.200.204.240:8181/api/v1/%@"

// 教练列表
static NSString *const kappointmentCoachUrl = @"userinfo/getusefulcoach/index/-1";

static NSString *const kQiniuUpdateUrl = @"info/qiniuuptoken";

static NSString *const kQiniuImageUrl = @"http://7xnjg0.com1.z0.glb.clouddn.com/%@";

static NSString *const kexamquestionUrl = @"info/examquestion";

static NSString *const kappointmentUrl = @"courseinfo/getmyuncommentreservation?userid=%@&subjectid=%ld";

static NSString *const kuserCommentAppointment = @"courseinfo/usercomment";

static NSString *const ksaveuserconsult = @"saveuserconsult";

static NSString *const KAppointgetmyreservation = @"courseinfo/getmyreservation";

static NSString *kinfomationCheck = @"userinfo/getmyapplystate";

static NSString *const kgetMyProgress = @"userinfo/getmyprogress";

static NSString *const kuserCancelAppointment = @"/courseinfo/cancelreservation";

static NSString *const kapplyexamination = @"userinfo/applyexamination";

static NSString *const kdriveschoolSchoolexamurl = @"driveschool/schoolexamurl?schoolid=%@";

static NSString *kgetuserinfo = @"userinfo/getimuserinfo?userid=%@";

static NSString *const kappointmentCoachTimeUrl = @"courseinfo/getcoursebycoach?coachid=%@&date=%@";

// 2.0版本获取我和教练的课程安排
static NSString *const kgetcoursebycoachv2 = @"courseinfo/getcoursebycoachv2?coachid=%@&date=%@&userid=%@";

static NSString *const kuserUpdateParam = @"courseinfo/userreservationcourse";

// 第一次获取预约教练
static NSString *const kgetmyfirstcoach = @"userinfo/getmyfirstcoach?userid=%@&subjectid=%@";

// 获取预支付订单
static NSString *const kgetprepayinfo = @"payinfo/getprepayinfo?userid=%@&payoderid=%@";

#endif /* YBNetworkMacro_h */
