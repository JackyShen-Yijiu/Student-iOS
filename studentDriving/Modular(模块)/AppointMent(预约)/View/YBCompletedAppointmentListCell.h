//
//  YBCompletedAppointmentListCell.h
//  studentDriving
//
//  Created by 大威 on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCourseModel.h"

@interface YBCompletedAppointmentListCell : UITableViewCell

@property (nonatomic, strong) HMCourseModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (nonatomic, strong) UIImageView *lineImageView;
@property (weak, nonatomic) IBOutlet UILabel *subjectIntroductionLabel;
@property (weak, nonatomic) IBOutlet UILabel *signInTimeLabel;

- (void)refreshData:(HMCourseModel *)model;

@end
