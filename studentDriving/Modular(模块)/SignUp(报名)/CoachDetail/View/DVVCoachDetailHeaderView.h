//
//  DVVCoachDetailHeaderView.h
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVCoachDetailDMData.h"
#import "THLabel.h"
#import "YBAppointMentDetailsDataData.h"
#import "RatingBar.h"

@interface DVVCoachDetailHeaderView : UIView

@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, strong) UIImageView *maskView;

@property (nonatomic, copy) NSString *coachID;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) THLabel *teacherAge; // 教龄

@property (nonatomic, strong) THLabel *teacherContentLabel; // 授课课程

@property (nonatomic, strong) RatingBar *starView;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIImageView *collectionImageView;

- (void)refreshData:(DVVCoachDetailDMData *)dmData;
- (void)refreshAppointMentData:(YBAppointMentDetailsDataData *)dmData;

+ (CGFloat)defaultHeight;

@end
