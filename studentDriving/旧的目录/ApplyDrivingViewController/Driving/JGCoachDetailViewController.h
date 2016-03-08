//
//  JGCoachDetailViewController.h
//  studentDriving
//
//  Created by JiangangYang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"
#import "CoachModel.h"

@interface JGCoachDetailViewController : BLBaseViewController
@property (copy, nonatomic) NSString *coachUserId;
@property (strong, nonatomic) CoachModel *rememberModel;
@end
