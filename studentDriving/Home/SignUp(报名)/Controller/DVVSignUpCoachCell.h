//
//  DVVSignUpCoachCell.h
//  studentDriving
//
//  Created by 大威 on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVSignUpCoachDMData.h"
#import "DVVStarView.h"

@interface DVVSignUpCoachCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (nonatomic, strong) DVVStarView *starView;

@property (nonatomic, strong) UIImageView *lineImageView;

- (void)refreshData:(DVVSignUpCoachDMData *)dmData;

@end
