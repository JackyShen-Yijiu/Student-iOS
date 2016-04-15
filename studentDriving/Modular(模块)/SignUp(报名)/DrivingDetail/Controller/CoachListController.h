//
//  CoachListController.h
//  studentDriving
//
//  Created by 大威 on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachListDMData.h"


@protocol BackCoachCompalaintModelDelegate <NSObject>

- (void)initWithCoacheModel:(CoachListDMData *)model;

@end


@interface CoachListController : UIViewController

@property (nonatomic, copy) NSString *schoolID;

@property (nonatomic, assign) NSUInteger type;
// 从投诉进入需要的属性
@property (nonatomic, strong) UILabel *complaintCoachNameLabel;
@property (nonatomic, strong) UILabel *complaintCoachNameLabelBottom;

@property (nonatomic, strong) id<BackCoachCompalaintModelDelegate> delagate;

@end
