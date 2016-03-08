//
//  JGAppointMentCell.h
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppointmentCoachTimeInfoModel;
@interface JGAppointMentCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *startTimeLabel;
@property (strong, nonatomic) UILabel *finalTimeLabel;
@property (strong, nonatomic) UILabel *remainingPersonLabel;

// 预约模块
@property (nonatomic,strong) AppointmentCoachTimeInfoModel *appointInfoModel;

@property (nonatomic,assign) BOOL isModifyCoach;

@property (strong, nonatomic) NSDate *selectDate;

@end
