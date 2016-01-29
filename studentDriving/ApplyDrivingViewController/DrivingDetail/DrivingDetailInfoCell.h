//
//  DrivingInfoCell.h
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrivingDetailDMData.h"

@interface DrivingDetailInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *passRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *learnTimeLabel;

- (void)refreshData:(DrivingDetailDMData *)dmData;

+ (CGFloat)defaultHeight;

@end
