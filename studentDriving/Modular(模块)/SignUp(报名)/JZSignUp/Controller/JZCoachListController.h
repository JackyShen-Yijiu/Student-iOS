//
//  JZCoachListController.h
//  studentDriving
//
//  Created by ytzhang on 16/3/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTypeDMData.h"

@class JZCoachListMoel;

@protocol JZCoachListViewControllerDelegate <NSObject>

- (void)JZCoachListViewControllerWithCoach:(JZCoachListMoel *)coachModel;

@end

@interface JZCoachListController : UIViewController

@property(nonatomic,weak)id<JZCoachListViewControllerDelegate>delegate;

@property (nonatomic, strong) ClassTypeDMData *dmData;

@property (nonatomic, strong) NSString *schoolid;
@end
