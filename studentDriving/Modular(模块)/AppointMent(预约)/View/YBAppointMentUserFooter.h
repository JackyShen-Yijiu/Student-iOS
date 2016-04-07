//
//  YBAppointMentUserFooter.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YBAppointMentCoachModel;

@interface YBAppointMentUserFooter : UICollectionReusableView

@property (strong, nonatomic) UICollectionView *userCollectionView;

@property (nonatomic,assign) NSArray *studentArray;

@property (nonatomic,weak) UIViewController *parentViewController;

@property (nonatomic,strong) YBAppointMentCoachModel *appointCoach;

@end
