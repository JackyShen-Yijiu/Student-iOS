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

// 数据存储路径
#define YBPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

#endif /* YBObject_h */
