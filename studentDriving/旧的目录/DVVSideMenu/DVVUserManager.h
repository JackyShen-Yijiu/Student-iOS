//
//  DVVUserManager.h
//  studentDriving
//
//  Created by 大威 on 15/12/24.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVUserManager : NSObject

// 打开登录窗体
+ (void)userNeedLogin;

// 获得登录窗体
+ (UIViewController *)loginController;

// 用户登录成功后调用此方法打开主页
+ (void)userLoginSucces;

// 用户退出登录后调用此方法
+ (void)userLogout;

// 用户需要随便看看时调用此方法
+ (void)userNeedBrowsing;

// Push一个视图
+ (void)pushController:(UIViewController *)controller;

+ (void)loginSuccsssAndSetupMainVc;

@end
