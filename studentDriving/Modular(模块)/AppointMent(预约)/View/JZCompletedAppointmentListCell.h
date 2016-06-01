//
//  JZCompletedAppointmentListCell.h
//  studentDriving
//
//  Created by ytzhang on 16/4/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCourseModel.h"

@interface JZCompletedAppointmentListCell : UITableViewCell

@property (nonatomic, strong) HMCourseModel *model;

@property (strong, nonatomic)  UIImageView *iconImageView;
@property (strong, nonatomic)  UILabel *statusLabel;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *schoolLabel;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (strong, nonatomic)  UILabel *subjectLabel;
@property (nonatomic, strong) UIView *lineView;
@property (strong, nonatomic)  UILabel *subjectIntroductionLabel;
@property (strong, nonatomic)  UILabel *signInTimeLabel;

- (void)refreshData:(HMCourseModel *)model;

@end
