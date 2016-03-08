//
//  YBCoachListViewController.h
//  BlackCat
//
//  Created by 董博 on 15/9/8.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"

@class CoachModel;

@protocol YBCoachListViewControllerDelegate <NSObject>

- (void)YBCoachListViewControllerWithCoach:(CoachModel *)coachModel;

@end

@interface YBCoachListViewController : BLBaseViewController

@property(nonatomic,weak)id<YBCoachListViewControllerDelegate>delegate;

/*
 *  点击更换更多预约教练
 */
@property (nonatomic,assign) BOOL isModifyCoach;
/*
 *  时间ID
 */
@property (assign, nonatomic) NSNumber *timeid;
/*
 *  创建时间
 */
@property (copy, nonatomic) NSString *coursedate;

@end
