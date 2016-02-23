//
//  DVVCoachDetailHeaderView.h
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVCoachDetailDMData.h"
#import "DVVStarView.h"
#import "THLabel.h"

@interface DVVCoachDetailHeaderView : UIView

@property (nonatomic, strong) UIView *alphaView;

@property (nonatomic, copy) NSString *coachID;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) THLabel *nameLabel;
@property (nonatomic, strong) DVVStarView *starView;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIImageView *collectionImageView;

- (void)refreshData:(DVVCoachDetailDMData *)dmData;

+ (CGFloat)defaultHeight;

@end
