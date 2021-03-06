//
//  ShuttleBusCell.h
//  studentDriving
//
//  Created by 大威 on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrivingDetailDMSchoolbusroute.h"

@interface ShuttleBusCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)refreshData:(DrivingDetailDMSchoolbusroute *)dmBus;

+ (CGFloat)dynamicHeight:(NSString *)string;

@end
