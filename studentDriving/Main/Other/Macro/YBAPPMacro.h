//
//  YBAPPMacro.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#ifndef YBObject_h
#define YBObject_h

// 红色导航条颜色
#define YBNavigationBarBgColor RGBColor(209,65,53)

typedef enum state {
    kStateHome,
    kStateMenu
}state;

// 教练列表
static NSString *const kappointmentCoachUrl = @"userinfo/getusefulcoach/index/-1";

// 保存预约的教练
#define KAppointMentCoach @"appointMentCoach"

// 退出侧边栏通知
#define KhiddenSlide @"hiddenSlide"

// 数据存储路径
#define YBPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

/*************** 网络请求接口 ***************/

static NSString *const kexamquestionUrl = @"info/examquestion";

static NSString *const kappointmentUrl = @"courseinfo/getmyuncommentreservation?userid=%@&subjectid=%ld";

static NSString *const kuserCommentAppointment = @"courseinfo/usercomment";

static NSString *const KAppointgetmyreservation = @"courseinfo/getmyreservation";

static NSString *kinfomationCheck = @"userinfo/getmyapplystate";

static NSString *const kgetMyProgress = @"userinfo/getmyprogress";

static NSString *const kuserCancelAppointment = @"/courseinfo/cancelreservation";

static NSString *const kapplyexamination = @"userinfo/applyexamination";

static NSString *const kdriveschoolSchoolexamurl = @"driveschool/schoolexamurl?schoolid=%@";

//static NSString *const kAppointmentDetail = @"courseinfo/userreservationinfo/%@";
//[NSString stringWithFormat:@"%@%@?exambegintime=%@&examendtime=%@&exammobile=%@&examname=%@&exampractice=%@&subjectid=%@",BASEURL,kapplyexamination,self.startTime,self.endTime,self.phoneTextField.text,self.nameTextField.text,[NSString stringWithFormat:@"%d",self.isYESorNo],[AcountManager manager].userSubject.subjectId];

/*************** 网络请求接口 ***************/

#define ksubject      @"subject"
#define ksubjectOne   @"subjectone"
#define ksubjectTwo   @"subjecttwo"
#define ksubjectThree @"subjectThree"
#define ksubjectFour   @"subjectFour"

#endif /* YBObject_h */
