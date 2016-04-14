//
//  ScrollViewPage.h
//  ScollViewPage
//
//  Created by allen on 15/9/18.
//  Copyright (c) 2015年 Allen. All rights reserved.
//

// 顶部视频播放有问题
//

#import <UIKit/UIKit.h>

@class YBSubjectQuestionRightBarView;

@interface ScrollViewPage : UIView<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *) array rightBarView:(YBSubjectQuestionRightBarView *)rightBarView subjectType:(subjectType)kemu chapter:(NSString *)chapter;

@property (nonatomic,strong) UIViewController *parentViewController;

@end
