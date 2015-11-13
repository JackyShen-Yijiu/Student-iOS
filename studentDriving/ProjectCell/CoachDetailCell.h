//
//  CoachDetailCell.h
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBar.h"

@interface CoachDetailCell : UITableViewCell
@property (strong, nonatomic) UILabel *coachNameLabel;
@property (strong, nonatomic) RatingBar *starBar;
@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UIButton *coachStateSend;
@property (strong, nonatomic) UIButton *coachStateAll;
@end
