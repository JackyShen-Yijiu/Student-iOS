//
//  JZShuttleBusDesCell.h
//  studentDriving
//
//  Created by ytzhang on 16/3/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrivingDetailDMSchoolbusroute.h"
#import "JZBusDetailStationModel.h"
@interface JZShuttleBusDesCell : UITableViewCell

@property (nonatomic, strong) UIImageView *titleImageView;

@property (nonatomic, strong) UILabel *stationLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) JZBusDetailStationModel *detailStationModel;
@end
