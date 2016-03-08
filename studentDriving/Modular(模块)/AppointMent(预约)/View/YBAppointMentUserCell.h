//
//  YBAppointMentUserCell.h
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppointmentCoachTimeInfoModel;
@interface YBAppointMentUserCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *iconImageView;

// 预约模块
@property (nonatomic,strong) AppointmentCoachTimeInfoModel *appointInfoModel;

@end
