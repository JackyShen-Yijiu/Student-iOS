//
//  ComplainViewController.h
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "BLBaseViewController.h"
@class MyAppointmentModel;

@interface ComplainViewController : BLBaseViewController
@property (strong, nonatomic) MyAppointmentModel *model;
@property  (strong,nonatomic) NSArray *buttonArray;
@property (strong,nonatomic) NSArray *labelArray;



@end
