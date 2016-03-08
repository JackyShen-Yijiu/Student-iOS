//
//  DVVCoachDetailTagCell.h
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVCoachDetailDMData.h"

@interface DVVCoachDetailTagCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

- (void)refreshData:(DVVCoachDetailDMData *)dmData;

+ (CGFloat)dynamicHeight:(DVVCoachDetailDMData *)dmData;

@end
