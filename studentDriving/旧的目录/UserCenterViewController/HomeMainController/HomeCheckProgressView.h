//
//  HomeCheckProgressView.h
//  studentDriving
//
//  Created by ytzhang on 16/1/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCheckProgressView : UIView

typedef void (^didClickBlock) (NSInteger  tag);

@property (nonatomic,copy) didClickBlock didClickBlock;

@property (strong, nonatomic) UIView *groundView;
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel  *topLabel;
@property (strong, nonatomic) UILabel *bottomLabel;
@property (strong, nonatomic) UIButton *rightButtton;
@property (strong, nonatomic) UIButton *wrongButton;
@end
