//
//  ScrollViewPage.h
//  ScollViewPage
//
//  Created by allen on 15/9/18.
//  Copyright (c) 2015年 Allen. All rights reserved.
//
// 做题时候的下一步有问题
// 最后一题有问题

#import <UIKit/UIKit.h>

@class YBSubjectQuestionRightBarView;

@interface ScrollViewPage : UIView<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) BOOL isWrongVc;

@property (nonatomic,assign) BOOL isWrongAndQuestion;

@property (nonatomic ,assign) NSInteger currentPage;

// 是否是最后一题
@property (nonatomic,assign) BOOL isLastQuestion;

// 考试分数
@property (nonatomic,assign) NSUInteger socre;

-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *) array rightBarView:(YBSubjectQuestionRightBarView *)rightBarView subjectType:(subjectType)kemu chapter:(NSString *)chapter;

@property (nonatomic,strong) UIViewController *parentViewController;

@end
