//
//  UIViewController+SliderMenu.m
//  studentDriving
//
//  Created by kequ on 15/12/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "UIViewController+SliderMenu.h"
#import "LoginViewController.h"

@implementation UIViewController(Present)
- (void)setPresentBackBotton
{
    CGRect backframe= CGRectMake(0, 0, 16, 16);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)pushBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

@implementation UIViewController (SliderMenu)

- (RESideMenu *)slideMenu
{
    return (RESideMenu *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
}

- (UINavigationController *)slideMainNavController
{
    return (UINavigationController *)[self.slideMenu contentViewController];
}

@end

@implementation HMControllerManager
+ (UINavigationController *)slideMainNavController
{
    return (UINavigationController *)[(RESideMenu *)[[[[UIApplication sharedApplication] delegate] window] rootViewController] contentViewController];
}
@end

@implementation NSObject(LoginView)

- (void)showLoginView
{
    LoginViewController *login = [[LoginViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
    [login setPresentBackBotton];
}

@end
