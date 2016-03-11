//
//  JGYuYueHeadView.h
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

#define rightFooter 80

@class AppointmentCoachTimeInfoModel,YBAppointMentCoachModel,JGYuYueHeadView;

@protocol JGYuYueHeadViewDelegate <NSObject>

- (void)JGYuYueHeadViewWithModifyCoach:(JGYuYueHeadView *)headView dateString:(NSString *)dateString isModifyCoach:(BOOL)isModifyCoach timeid:(NSNumber *)timeid;

@end

@interface JGYuYueHeadView : UIView

// 刷新数据源
- (void)receiveCoachTimeData:(NSArray *)coachTimeData selectData:(NSDate *)selectDate coachModel:(YBAppointMentCoachModel *)coachModel;

// 点击选中的数据
@property (strong, nonatomic) NSMutableArray *upDateArray;

@property (nonatomic,weak) UIViewController *parentViewController;

@property (strong, nonatomic) NSDate *selectDate;

@property (nonatomic,weak) id<JGYuYueHeadViewDelegate>delegate;

@end
