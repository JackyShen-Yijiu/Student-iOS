//
//  YBAppointmentDetailHeaderView.h
//  studentDriving
//
//  Created by 大威 on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCourseModel.h"

@interface YBAppointmentDetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UILabel *imageMarkLabel;
@property (strong, nonatomic) UILabel *markLabel;

@property (nonatomic, strong) HMCourseModel *model;

@property (nonatomic, readonly, assign) CGFloat siginTextHeight;

@end
