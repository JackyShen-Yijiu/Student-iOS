//
//  JZPayWayHeaderCell.h
//  studentDriving
//
//  Created by ytzhang on 16/3/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTypeDMData.h"

@interface JZPayWayHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *driveIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *driveName;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *coachName;
@property (nonatomic, strong) ClassTypeDMData *dmdata;
@property (nonatomic, strong) NSDictionary *extraDict;
@end
