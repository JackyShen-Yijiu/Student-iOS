//
//  ToolHeader.h
//  BlackCat
//
//  Created by bestseller on 15/9/25.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <Masonry.h>
#import "WMUITool.h"
#import "JENetwoking.h"
#import "AcountManager.h"
#import "NetMonitor.h"
#import "JsonTransformManager.h"
#import <UIImageView+WebCache.h>
#import "NSString+CurrentTimeDay.h"
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
    AppointmentStateOnCommended, // 评论成功
    AppointmentStateFinish, // 订单完成
    AppointmentStateSystemCancel, // 系统取消
    AppointmentStateSignin, // 已签到
    AppointmentStateNoSignIn // 已漏课
};


static NSString *const kQiniuUpdateUrl = @"info/qiniuuptoken";

static NSString *const kQiniuImageUrl = @"http://7xnjg0.com1.z0.glb.clouddn.com/%@";

#define kShowSuccess(msg) [self showTotasViewWithMes:msg];

#define kShowFail(msg)   [self showTotasViewWithMes:msg];


#define RGBColor(R,G,B)  [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1]
//RGBColor(255, 102, 51)
#define MAINCOLOR  [UIColor colorWithRed:255/255.0f green:102/255.0f blue:51/255.0f alpha:1]
// 主背景色
#define MAIN_BACKGROUND_COLOR [UIColor colorWithHexString:@"3E3E64"]
// 主前景色
#define MAIN_FOREGROUND_COLOR [UIColor whiteColor]


//247, 249, 251
#define TEXTGRAYCOLOR [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1]

#define BACKGROUNDCOLOR [UIColor colorWithRed:247/255.0f green:249/255.0f blue:251/255.0f alpha:1]

// 正式库
#define BASEURL @"http://api.yibuxueche.com/api/v1/%@"
// 测试库
//#define BASEURL @"http://101.200.204.240:8181/api/v1/%@"

// 切换正式库时要单独进行切换!!!!!!!!!!!!!!!!!!! 首页H5页面
#define BTH5   @"http://api.yibuxueche.com/%@"
//http://123.57.63.15:8181/ 正式库
// http://101.200.204.240:8181/ 测试库

#define kSystemWide [UIScreen mainScreen].bounds.size.width

#define kSystemHeight [UIScreen mainScreen].bounds.size.height

#ifdef DEBUG
#define DYNSLog(...) NSLog(__VA_ARGS__)
#else
#define DYNSLog(...)
#endif