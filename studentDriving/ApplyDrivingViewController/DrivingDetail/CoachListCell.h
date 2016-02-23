//
//  CoachListCell.h
//  studentDriving
//
//  Created by 大威 on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachListDMData.h"
#import "DVVStarView.h"

@interface CoachListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *passRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *seniorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@property (nonatomic, strong) DVVStarView *starView;

@property (nonatomic, strong) UIImageView *lineImageView;

- (void)refreshData:(CoachListDMData *)dmData;

@end
