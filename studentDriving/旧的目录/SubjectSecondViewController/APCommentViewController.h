//
//  APCommentViewController.h
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "BLBaseViewController.h"
@class MyAppointmentModel;

@interface APCommentViewController : BLBaseViewController
@property (strong, nonatomic) MyAppointmentModel *model;

/*
 *  是否是强制评论
 */
@property (nonatomic,assign) BOOL isForceComment;

@end
