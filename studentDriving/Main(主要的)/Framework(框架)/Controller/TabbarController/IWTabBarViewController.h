//
//  IWTabBarViewController.h
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWTabBar.h"
#import "YBSignUpViewController.h"
#import "YBStudyViewController.h"
#import "YBAppointMentController.h"
#import "YBMallViewController.h"
#import "YBCommunityViewController.h"
#import "WMNavigationController.h"

@protocol IWTabBarViewControllerDelegate <NSObject>

- (void)IWTabBarViewControllerWithLeftBarDidClick;

@end

@interface IWTabBarViewController : UITabBarController

@property (assign, nonatomic) kControllerType   vcType;// 控制器类型

@property (strong, nonatomic) YBSignUpViewController   *baomingVC;
@property (strong, nonatomic) YBStudyViewController   *xuexiVC;
@property (strong, nonatomic) YBAppointMentController   *yuyueVC;
@property (strong, nonatomic) YBMallViewController   *shangchengVC;
@property (strong, nonatomic) YBCommunityViewController   *shequVC;

@property (strong, nonatomic) WMNavigationController *mainNav;

@property (nonatomic,weak)id<IWTabBarViewControllerDelegate>delegate;

@end
