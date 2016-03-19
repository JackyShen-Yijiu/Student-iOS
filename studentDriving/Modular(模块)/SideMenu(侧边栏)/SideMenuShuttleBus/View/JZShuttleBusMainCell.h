//
//  JZShuttleBusMainCell.h
//  studentDriving
//
//  Created by ytzhang on 16/3/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrivingDetailDMSchoolbusroute.h"

@interface JZShuttleBusMainCell : UITableViewCell

@property (nonatomic, strong) UILabel *lineNameLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) DrivingDetailDMSchoolbusroute *titleModel;

@property (nonatomic, assign) BOOL  isSelectionHeaderCell;
@end
