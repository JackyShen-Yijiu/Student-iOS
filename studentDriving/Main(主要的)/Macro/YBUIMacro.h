//
//  YBUIMacro.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//  UI宏

#ifndef YBUIMacro_h
#define YBUIMacro_h

typedef NS_ENUM(NSInteger, kControllerType) {
    
    kYBSignUpViewController,
    kYBStudyViewController,
    kYBAppointMentController,
    kYBMallViewController,
    kYBCommunityViewController,

};

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

// 红色导航条颜色
#define YBNavigationBarBgColor RGBColor(209,65,53)

static const CGFloat viewSlideHorizonRatio = 0.64;
static const CGFloat viewHeightNarrowRatio = 0.80;
static const CGFloat menuStartNarrowRatio  = 0.70;

#define YBRatio 1.2

#define kSystemWide [UIScreen mainScreen].bounds.size.width

#define kSystemHeight [UIScreen mainScreen].bounds.size.height

#endif /* YBUIMacro_h */
