//
//  BLBaseViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "BLBaseViewController.h"
#import <SVProgressHUD.h>
#import <IQKeyboardManager.h>

@interface BLBaseViewController ()

@end

@implementation BLBaseViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DYNSLog(@"touch");
    [[IQKeyboardManager sharedManager] resignFirstResponder];
}

@end
