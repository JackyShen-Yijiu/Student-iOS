//
//  DVVCoachCommentCell.h
//  studentDriving
//
//  Created by 大威 on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVCoachCommentDMData.h"
#import "DVVStarView.h"

@interface DVVCoachCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *classTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, strong) DVVStarView *starView;

@property (nonatomic, strong) UIImageView *lineImageView;

- (void)refreshData:(DVVCoachCommentDMData *)dmData;

+ (CGFloat)dynamicHeight:(DVVCoachCommentDMData *)dmData;

@end
