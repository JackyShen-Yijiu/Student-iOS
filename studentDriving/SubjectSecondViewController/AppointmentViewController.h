//
//  AppointmentViewController.h
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"
@interface AppointmentViewController : BLBaseViewController
@property (strong, nonatomic) NSNumber *markNum;

/*
 *  是否是强制评论
 */
@property (nonatomic,assign) BOOL isForceComment;

@end
