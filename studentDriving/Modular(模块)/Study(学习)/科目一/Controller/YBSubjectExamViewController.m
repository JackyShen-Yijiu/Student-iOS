//
//  YBSubjectExamViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectExamViewController.h"
#import "ScrollViewPage.h"
#import "YBSubjectTool.h"
#import "YBSubjectQuestionRightBarView.h"

@interface YBSubjectExamViewController ()<UIAlertViewDelegate>
{
    NSTimer *timer;
    NSInteger time;
}

@property (nonatomic,strong) YBSubjectQuestionRightBarView *rightBarView;
@end

@implementation YBSubjectExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    time = 1 * 60;

    NSLog(@"YBSubjectQuestionsViewController kemu:%ld",(long)_kemu);
    
    NSArray *titleArray;
    NSArray *imgArray;
    
    titleArray = [NSArray arrayWithObjects:@"比例",@"正确",@"错误",@"正确率",@"倒计时", nil];
    imgArray = [NSArray arrayWithObjects:@"YBStudySubjectsubject",@"YBStudySubjectright",@"YBStudySubjectwrong",@"YBStudySubjectpercentage",@"YBStudySubjecttime", nil];
    
    
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    
    _rightBarView = [[YBSubjectQuestionRightBarView alloc] initWithFrame:CGRectMake(0, 0, titleArray.count * 45, 40) withTitleArray:titleArray withImgArray:imgArray];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBarView];
    
    // 数组中保存的是YBSubjectData对象
    NSArray *dataArray = [YBSubjectTool getAllExamDataWithType:_kemu];
    
    ScrollViewPage *scrollView = [[ScrollViewPage alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-64) withArray:dataArray rightBarView:_rightBarView subjectType:_kemu chapter:nil];
    scrollView.parentViewController = self;
    [self.view addSubview:scrollView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 创建定时器
    timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [timer invalidate];
    timer = nil;
    
}

- (void)timerRun
{
    
    time--;
    NSLog(@"time:%ld",(long)time);
    NSString *timestr = [NSString stringWithFormat:@"%ld",(long)time];
    timestr = [YBSubjectTool duration:timestr];
    
    if (time==0) {
        
        [timer invalidate];
        timer = nil;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"时间已到" delegate:self cancelButtonTitle:@"知道啦" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    NSLog(@"self.rightBarView.subviews:%@",self.rightBarView.subviews);
    for (UIButton *btn in self.rightBarView.subviews) {
        
        switch (btn.tag) {
                
            case 4:// 倒计时
                
                [btn setTitle:timestr forState:UIControlStateNormal];
                
                break;
                
            default:
                break;
        }
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
