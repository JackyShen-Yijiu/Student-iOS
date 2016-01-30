//
//  DrivingDetailShuttleBusCell.h
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrivingDetailDMData.h"

@interface DrivingDetailShuttleBusCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@property (weak, nonatomic) IBOutlet UILabel *shuttleBusLabel;

- (void)refreshData:(DrivingDetailDMData *)dmData;

+ (CGFloat)dynamicHeight:(DrivingDetailDMData *)dmData;

@end
