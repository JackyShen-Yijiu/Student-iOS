//
//  AppDelegate+DealTool.m
//  studentDriving
//
//  Created by bestseller on 15/11/13.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "AppDelegate+DealTool.h"
#import "BLBaseViewController.h"
#import <IQKeyboardManager.h>
#import <IQKeyboardReturnKeyHandler.h>
#import <SVProgressHUD.h>

@implementation AppDelegate (DealTool)
- (void)dealTool {
    [[IQKeyboardManager sharedManager] disableToolbarInViewControllerClass:[BLBaseViewController class]];
    [self configAppearance];

}
- (void)configAppearance {
//    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:RGBColor(255, 102, 51)};
//    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
//    [[UINavigationBar appearance] setTintColor:RGBColor(255, 102, 51)];
    [SVProgressHUD setForegroundColor:[UIColor grayColor]];
//    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    //    UIBarButtonItem *leftItem = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    //    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"backImage.png"]];
    //    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"backImage.png"]];
    //
    //    [leftItem setBackButtonBackgroundImage:[UIImage imageNamed:@"backImage.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    [leftItem setBackButtonBackgroundVerticalPositionAdjustment:50 forBarMetrics:UIBarMetricsDefault];
    //    [leftItem setBackgroundVerticalPositionAdjustment:50 forBarMetrics:UIBarMetricsDefault];
    //    [leftItem setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}
@end
