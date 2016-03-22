//
//  DrivingDetailLocationCell.h
//  studentDriving
//
//  Created by 大威 on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrivingDetailDMData.h"

@interface DrivingDetailLocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (nonatomic, strong) UIImageView *lineImageView;

- (void)refreshData:(DrivingDetailDMData *)dmData;

+ (CGFloat)defaultHeight;

@end
