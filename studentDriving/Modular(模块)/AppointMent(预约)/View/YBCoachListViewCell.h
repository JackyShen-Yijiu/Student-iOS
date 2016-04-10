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
@class JZCoachListMoel;

@interface YBCoachListViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

@property (nonatomic, assign) BOOL isFormSignUp; // 判断是否从报名界面进入的教练列表;

- (void)receivedCellModelWith:(CoachModel *)coachModel;

- (void)receivedCellModelFormSignUpWith:(JZCoachListMoel *)coachModel;

@end
