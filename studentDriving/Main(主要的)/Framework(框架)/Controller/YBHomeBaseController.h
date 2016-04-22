//
//  YBHomeBaseController.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//  首页基类

#import "YBBaseViewController.h"


static NSString *const kupdateSignUpListHeaderData = @"kupdateSignUpListHeaderData";



@protocol YBHomeBaseControllerDelegate <NSObject>
@optional
- (void)leftBtnClicked;
@end

@interface YBHomeBaseController : YBBaseViewController

@property (weak, nonatomic) id<YBHomeBaseControllerDelegate> delegate;

@property (weak, nonatomic) UIButton *leftBtn;

- (void)clicked;

@end
