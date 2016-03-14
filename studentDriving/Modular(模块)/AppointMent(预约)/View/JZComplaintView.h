//
//  JZComplaintView.h
//  studentDriving
//
//  Created by ytzhang on 16/3/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAppointmentModel.h"

@interface JZComplaintView : UIView

@property (nonatomic, strong) NSString *iconImgUrl;

@property (nonatomic, strong) NSString *coachName;

@property (nonatomic, strong) UIViewController *viewVC;

@property (nonatomic, strong) MyAppointmentModel *model;
@end
