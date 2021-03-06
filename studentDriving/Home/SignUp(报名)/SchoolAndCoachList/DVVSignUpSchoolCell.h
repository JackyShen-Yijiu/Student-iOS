//
//  DVVSignUpSchoolCell.h
//  studentDriving
//
//  Created by 大威 on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVSignUpSchoolDMData.h"
#import "DVVStarView.h"

@interface DVVSignUpSchoolCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *coachCountLabel;
@property (nonatomic, strong) DVVStarView *starView;

@property (nonatomic, strong) UIImageView *lineImageView;

- (void)refreshData:(DVVSignUpSchoolDMData *)dmData;

@end
