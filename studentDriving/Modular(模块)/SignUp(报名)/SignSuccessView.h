//
//  SignSuccessView.h
//  chooseView
//
//  Created by 胡东苑 on 15/12/13.
//  Copyright © 2015年 胡东苑. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YBSignUpSuccessRootClass;

@interface SignSuccessView : UIView

- (instancetype)initWithFrame:(CGRect)frame signUpSuccessClass:(YBSignUpSuccessRootClass *)signUpSuccessClass;

- (CGFloat)successViewH;

@property (nonatomic,weak) UIViewController *parentViewController;

@end
