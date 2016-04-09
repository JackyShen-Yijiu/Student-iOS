//
//  YBAppointmentListCell.h
//  studentDriving
//
//  Created by 大威 on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCourseModel.h"

@interface YBAppointmentListCell : UITableViewCell

@property (nonatomic, strong) HMCourseModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *qrCodeMarkLabel;
@property (weak, nonatomic) IBOutlet UIButton *qrCodeButton;

@property (nonatomic, strong) UIImageView *lineImageView;


/**
 *  刷新数据的方法
 *
 *  @param model           HMCourseModel模型
 *  @param appointmentTime 0:今天的预约  1:未来的预约  -1:已完成的预约
 */
- (void)refreshData:(HMCourseModel *)model
    appointmentTime:(NSUInteger)appointmentTime;

@end
