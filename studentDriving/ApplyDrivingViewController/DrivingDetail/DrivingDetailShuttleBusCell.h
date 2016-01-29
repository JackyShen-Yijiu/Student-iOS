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

@property (nonatomic, assign)BOOL isShowMoreContent;

@property (weak, nonatomic) IBOutlet UILabel *shuttleBusLabel;

- (void)refreshData:(DrivingDetailDMData *)dmData;

+ (CGFloat)dynamicHeight:(NSString *)string;

@end
