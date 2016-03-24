//
//  YBNotificationMacro.h
//  studentDriving
//
//  Created by 大威 on 16/2/26.
//  Copyright © 2016年 jatd. All rights reserved.
//  通知宏

#ifndef YBNotificationMacro_h
#define YBNotificationMacro_h

// 退出侧边栏通知
#define KhiddenSlide @"hiddenSlide"

// 保存预约的教练
#define KAppointMentCoach @"appointMentCoach"

#define ksubject      @"subject"
#define ksubjectOne   @"subjectone"
#define ksubjectTwo   @"subjecttwo"
#define ksubjectThree @"subjectThree"
#define ksubjectFour   @"subjectFour"

#define KNOTIFICATION_USERLOADED @"userLoaded"

// 刷新预约详情的通知
#define kAppointmentDetailRefresh @"appointmentDetailRefresh"

/** 接收到推送消息，跳转到对应的窗体的通知 */
#define YBNotif_HandleNotification @"kYBNotif_HandleNotification"

/** 用户修改过头像，改变侧边栏头像的通知 */
#define YBNotif_ChangeUserPortrait @"kYBNotif_ChangeUserPortrait"

#define YBNotif_ChangeUserInfo @"kYBNotif_ChangeUserInfo"

#endif /* YBNotificationMacro_h */
