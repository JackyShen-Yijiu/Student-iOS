//
//  JGYuYueHeadView.h
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

#define rightFooter 80

@class AppointmentCoachTimeInfoModel;

@interface JGYuYueHeadView : UIView

// 刷新数据源
- (void)receiveCoachTimeData:(NSArray *)coachTimeData;

- (void)receiveCoachTimeData;

// 点击选中的数据
@property (strong, nonatomic) NSMutableArray *upDateArray;

@property (nonatomic,weak) UIViewController *parentViewController;

@property (nonatomic,assign) NSInteger userCount;

@end
