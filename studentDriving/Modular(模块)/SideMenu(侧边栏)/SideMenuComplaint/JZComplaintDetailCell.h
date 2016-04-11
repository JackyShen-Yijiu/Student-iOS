//
//  JZComplaintDetailCell.h
//  studentDriving
//
//  Created by 雷凯 on 16/4/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZComplaintDetailCell : UITableViewCell

/// 教练（不是名字）
@property (nonatomic, weak) UILabel *coachLabel;
/// 教练名字
@property (nonatomic, weak) UILabel *coachNameLabel;
/// 箭头
@property (nonatomic, weak) UIImageView *detailImg;

@end
