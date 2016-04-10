//
//  DrivingDetailItemCell.h
//  studentDriving
//
//  Created by JiangangYang on 16/3/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrivingDetailDMData.h"

@interface DrivingDetailItemCell : UITableViewCell

@property (nonatomic,strong) UILabel *detailsLabel;

+ (CGFloat)cellHeightDmData:(DrivingDetailDMData *)dmData;

@property (nonatomic,strong) DrivingDetailDMData *dmData;

@end
