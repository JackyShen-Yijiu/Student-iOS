//
//  YBSubjectQuestionsViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/8.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectQuestionsViewController.h"
#import "ScrollViewPage.h"
#import "YBSubjectTool.h"
#import "YBSubjectQuestionRightBarView.h"

@interface YBSubjectQuestionsViewController()

@property (nonatomic,strong) YBSubjectQuestionRightBarView *rightBarView;

@end

@implementation YBSubjectQuestionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    NSLog(@"YBSubjectQuestionsViewController kemu:%ld",(long)_kemu);
    
    NSArray *titleArray;
    NSArray *imgArray;
    
    titleArray = [NSArray arrayWithObjects:@"比例",@"正确",@"错误",@"正确率", nil];
    imgArray = [NSArray arrayWithObjects:@"YBStudySubjectsubject",@"YBStudySubjectright",@"YBStudySubjectwrong",@"YBStudySubjectpercentage", nil];
    
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    
    _rightBarView = [[YBSubjectQuestionRightBarView alloc] initWithFrame:CGRectMake(0, 0, titleArray.count * 45, 40) withTitleArray:titleArray withImgArray:imgArray];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBarView];
    
    // 数组中保存的是YBSubjectData对象
    NSArray *dataArray = [YBSubjectTool getAllSubjectDataWithType:_kemu chapter:_chapter];
    
    ScrollViewPage *scrollView = [[ScrollViewPage alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-64) withArray:dataArray rightBarView:_rightBarView subjectType:_kemu chapter:_chapter];
    scrollView.parentViewController = self;
    scrollView.isWrongAndQuestion = YES;
    [self.view addSubview:scrollView];
    
}



@end
