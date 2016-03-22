//
//  CoachTableViewCell.h
//  BlackCat
//
//  Created by 董博 on 15/9/9.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBBaseTableCell.h"
#import "DVVStarView.h"
#import "RatingBar.h"
@class CoachDMData;
@class CoachModel;

@interface CoachTableViewCell : UITableViewCell

@property (nonatomic, strong) RatingBar *starView;

- (void)refreshData:(CoachDMData *)coachModel;
- (void)receivedCellModelWith:(CoachModel *)coachModel;


@property (nonatomic,assign) BOOL isSelectCoachVc;

@end
