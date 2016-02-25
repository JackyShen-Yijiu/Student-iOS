//
//  YBCoachListViewCell.h
//  BlackCat
//
//  Created by 董博 on 15/9/9.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoachModel;
@class RatingBar;

@interface YBCoachListViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

- (void)receivedCellModelWith:(CoachModel *)coachModel;

@end
