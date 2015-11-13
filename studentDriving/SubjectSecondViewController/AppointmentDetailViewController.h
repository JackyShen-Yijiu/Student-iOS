//
//  AppointmentDetailViewController.h
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"

@class MyAppointmentModel;
@interface AppointmentDetailViewController : BLBaseViewController
@property (strong, nonatomic) MyAppointmentModel *model;
@property (assign, nonatomic) AppointmentState state;
@property (copy, nonatomic) NSString *infoId;
@property (assign, nonatomic) BOOL isPushInformation;

@end
