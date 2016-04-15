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
    NSArray *dataArray;
}

@property (nonatomic,strong) YBSubjectQuestionRightBarView *rightBarView;

@property (nonatomic,strong) NSDate *beginTime;
@property (nonatomic,strong) NSDate *endTime;

@property (nonatomic,strong) ScrollViewPage *scrollView;

@end

@implementation YBSubjectExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    time = 45 * 60;
    self.beginTime = [NSDate date];
    
    NSLog(@"YBSubjectQuestionsViewController kemu:%ld",(long)_kemu);
    
    NSArray *titleArray;
    NSArray *imgArray;
    
    titleArray = [NSArray arrayWithObjects:@"比例",@"正确",@"错误",@"正确率",@"倒计时", nil];
    imgArray = [NSArray arrayWithObjects:@"YBStudySubjectsubject",@"YBStudySubjectright",@"YBStudySubjectwrong",@"YBStudySubjectpercentage",@"YBStudySubjecttime", nil];
    
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    
    _rightBarView = [[YBSubjectQuestionRightBarView alloc] initWithFrame:CGRectMake(0, 0, titleArray.count * 45, 40) withTitleArray:titleArray withImgArray:imgArray];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBarView];
    
    // 数组中保存的是YBSubjectData对象
    dataArray = [YBSubjectTool getAllExamDataWithType:_kemu];
    
    _scrollView = [[ScrollViewPage alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-64) withArray:dataArray rightBarView:_rightBarView subjectType:_kemu chapter:@""];
    _scrollView.parentViewController = self;
    [self.view addSubview:_scrollView];
    
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
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setInteger:0 forKey:[NSString stringWithFormat:@"currentPage-%ld-%@",(long)self.kemu,@""]];
    [user synchronize];
    
    [timer invalidate];
    timer = nil;
    
}

- (void)timerRun
{
    
    time--;
    NSLog(@"time:%ld",(long)time);
    NSString *timestr = [NSString stringWithFormat:@"%ld",(long)time];
    timestr = [YBSubjectTool duration:timestr];
    
    NSLog(@"_scrollView.socre:%lu _scrollView.currentPage:%ld",(unsigned long)_scrollView.socre,(long)_scrollView.currentPage);
    
    if (time==0) {
        
        [timer invalidate];
        timer = nil;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"时间已到，是否提交本次模拟考试成绩" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    if (_scrollView.currentPage == dataArray.count-1) {
        
        [timer invalidate];
        timer = nil;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"答题完毕，是否提交成绩" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
        
    }

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

// 获取时间戳
- (NSString *)chagetime:(NSDate *)times{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    //设置格式
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString * dataStr = [df stringFromDate:times];
 
    //将符合格式的字符串转成NSDate对象
    NSDate *date = [df dateFromString:dataStr];
    
    //计算一个时间和系统当前时间的时间差
    int second = [date timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%d",second];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    self.endTime = [NSDate date];
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kuserinfosendtestscore];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"userid"] = [AcountManager manager].userid;
    params[@"begintime"] = [self chagetime:self.beginTime];
    params[@"endtime"] = [self chagetime:self.endTime];
    params[@"socre"] = [NSString stringWithFormat:@"%lu",(unsigned long)_scrollView.socre];
    params[@"subjectid"] = [NSString stringWithFormat:@"%ld",(long)_kemu];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:params WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *param = data;

        DYNSLog(@"data:%@ param = %@",data,param[@"msg"]);

        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        
        if (type.integerValue == 1) {
        
            [self obj_showTotasViewWithMes:@"提交成功"];
            
            [self.navigationController popViewControllerAnimated:YES];

        }else {
            
            [self obj_showTotasViewWithMes:msg];
            
        }
        
    }];
    
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
