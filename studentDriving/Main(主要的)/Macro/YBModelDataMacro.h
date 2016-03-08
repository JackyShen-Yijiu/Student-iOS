//
//  YBModelDataMacro.h
//  studentDriving
//
//  Created by JiangangYang on 16/3/8.
//  Copyright © 2016年 jatd. All rights reserved.
//

#ifndef YBModelDataMacro_h
#define YBModelDataMacro_h

typedef enum state {
    kStateHome,
    kStateMenu
}state;

typedef NS_ENUM(NSUInteger,SubjectState){
    SubjectStateTime,
    SubjectStateWaitConfirm,
    SubjectStateWaitEvaluation,
    SubjectStateCompletion
};

typedef NS_ENUM(NSUInteger,AppointmentState){
    AppointmentStateWait = 1, //  预约中
    AppointmentStateSelfCancel, //  学生取消
    AppointmentStateCoachConfirm, //  新订单
    AppointmentStateCoachCancel, //  已取消
    AppointmentStateConfirmEnd, // 待确认完成
    AppointmentStateWaitComment, // 待评价
    //    AppointmentStateOnCommended, // 评论成功
    AppointmentStateFinish, // 订单完成
    AppointmentStateSystemCancel, // 系统取消
    AppointmentStateSignin, // 已签到
    AppointmentStateNoSignIn // 已漏课
};

/**
 *  根据城市名获取用户所在的城市是以驾校为主还是以教练为主
 */
typedef NS_ENUM(NSInteger, kLocationShowType){
    // 驾校
    kLocationShowTypeDriving = 0,
    // 教练
    kLocationShowTypeCoach,
};

// 驾校详情  教练详情 进入报名界面
typedef NS_ENUM(NSUInteger,SignUpFormDetail){
    SignUpFormSchoolDetail, // 驾校详情
    SignUpFormCoachDetail // 教练详情
};

// 数据存储路径
#define YBPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

#endif /* YBModelDataMacro_h */
