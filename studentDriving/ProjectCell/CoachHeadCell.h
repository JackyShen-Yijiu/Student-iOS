//
//  CoachHeadCell.h
//  BlackCat
//
//  Created by bestseller on 15/10/22.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppointmentCoachModel;
@interface CoachHeadCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *coachHeadImageView;
@property (strong, nonatomic) UILabel *coachNameLabel;
@property (strong, nonatomic) UILabel *coachAddress;
@property (strong, nonatomic) UIButton *coachStateSend;
@property (strong, nonatomic) UIButton *coachStateAll;

- (void)recevieCoachData:(AppointmentCoachModel *)coachModel;

@end
