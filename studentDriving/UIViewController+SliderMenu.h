//
//  UIViewController+SliderMenu.h
//  studentDriving
//
//  Created by kequ on 15/12/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(Present)
- (void)setPresentBackBotton;
@end

@interface UIViewController (SliderMenu)
- (RESideMenu *)slideMenu;
- (UINavigationController *)slideMainNavController;
@end

@interface HMControllerManager : NSObject
+ (UINavigationController *)slideMainNavController;
@end

@interface NSObject(LoginView)
- (void)showLoginView;
@end
