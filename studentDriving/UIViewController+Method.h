//
//  UIViewController+DivideAssett.h
//  SohuPhotoAlbum
//
//  Created by sohu on 13-4-27.
//  Copyright (c) 2013年 Qu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "ToastAlertView.h"

#define WRITEIMAGE @"WriteImage"

@interface UIViewController (Tips)
- (MBProgressHUD *)waitForMomentsWithTitle:(NSString*)str withView:(UIView *)view;
- (void)stopWaitProgressView:(MBProgressHUD *)view;
- (void)showPopAlerViewWithMes:(NSString *)message withDelegate:(id<UIAlertViewDelegate>)delegate cancelButton:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
- (void)showTotasViewWithMes:(NSString *)message;
- (void)showPopAlerViewWithMes:(NSString *)message;
@end


@interface NSObject(Tips)
- (void)obj_showTotasViewWithMes:(NSString *)message;

@end