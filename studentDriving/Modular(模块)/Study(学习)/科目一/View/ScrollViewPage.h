//
//  ScrollViewPage.h
//  ScollViewPage
//
//  Created by allen on 15/9/18.
//  Copyright (c) 2015年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YBSubjectQuestionRightBarView;

@interface ScrollViewPage : UIView<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,assign) NSInteger currentPage;

// 考试分数
@property (nonatomic,assign) NSUInteger socre;

-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *) array rightBarView:(YBSubjectQuestionRightBarView *)rightBarView subjectType:(subjectType)kemu chapter:(NSString *)chapter;

@property (nonatomic,strong) UIViewController *parentViewController;

@end
