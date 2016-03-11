//
//  YBAppointMentFootView.h
//  studentDriving
//
//  Created by JiangangYang on 16/3/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YBAppointMentCoachModel;

@interface YBAppointMentFootView : UIView

@property (strong, nonatomic) UIImageView *iconImageView;
@property (nonatomic,strong) UIButton *changeCoachBtn;
@property (nonatomic,strong) UIButton *commitBtn;

// 预约时常
@property ( nonatomic,strong) UILabel *countLabel;
// 同时段学员
@property (strong, nonatomic) UICollectionView *userCollectionView;
// 同时段学员
@property (nonatomic,assign) NSArray *studentArray;
// 预约教练
@property (nonatomic,strong) YBAppointMentCoachModel *appointCoach;

@property (nonatomic,weak) UIViewController *parentViewController;

@end
