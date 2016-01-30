//
//  CoachListCell.h
//  studentDriving
//
//  Created by 大威 on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachListDMData.h"
#import "RatingBar.h"

@interface CoachListCell : UITableViewCell

@property (nonatomic, strong) RatingBar *starBar;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *classTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *seniorityLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

- (void)refreshData:(CoachListDMData *)dmData;

@end
