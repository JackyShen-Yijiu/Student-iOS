//
//  YBAppointMentChangeCoachController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentChangeCoachController.h"
#import "YBAppointMentChangeCoachController.h"
#import "HMCourseModel.h"
#import "FDCalendar.h"
#import "JGYuYueHeadView.h"
#import "AppointmentCoachTimeInfoModel.h"

@interface YBAppointMentChangeCoachController ()<FDCalendarDelegate>

// 日历
@property(nonatomic,strong) FDCalendar *calendarHeadView;
// 中间预约时间
@property (nonatomic,strong) JGYuYueHeadView *yuYueheadView;

@property(nonatomic,strong)NSDateFormatter *dateFormattor;

@property (nonatomic,weak) UICollectionView *collectionView;

@end

@implementation YBAppointMentChangeCoachController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 隐藏导航条底部分割线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self fdCalendar:nil didSelectedDate:self.seletedDate];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"换教练" style:UIBarButtonItemStyleDone target:self action:@selector(changeCoach)];
    
    [self initUI];
    
}

- (void)changeCoach
{
    NSLog(@"换教练");
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initUI
{
    
    // 顶部日历
    self.calendarHeadView = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    self.calendarHeadView.delegate = self;
    self.calendarHeadView.frame = CGRectMake(0, 0, self.view.width, 30+35);
    [self.view addSubview:self.calendarHeadView];
    
    // 中间方格
    self.yuYueheadView = [[JGYuYueHeadView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendarHeadView.frame), self.view.width, kSystemHeight-self.calendarHeadView.height-50)];
    [self.view addSubview:self.yuYueheadView];
    
    // 底部提交
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-50-64, self.view.width, 50)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];

    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSystemWide-10-90, 5, 90, 40)];
    commitBtn.backgroundColor = YBNavigationBarBgColor;
    commitBtn.layer.masksToBounds = YES;
    commitBtn.layer.cornerRadius = 3;
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitle:@"提交" forState:UIControlStateHighlighted];
    [commitBtn addTarget:self action:@selector(commitBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:commitBtn];
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.frame = CGRectMake(0, 0, kSystemWide-commitBtn.width-20, footView.height);
    countLabel.text = @" 科目二 第20-33课时 已完成44课时";
    countLabel.font = [UIFont systemFontOfSize:12];
    countLabel.textColor = [UIColor blackColor];
    [footView addSubview:countLabel];

}

- (void)commitBtnDidClick
{
    NSLog(@"%s",__func__);
}

#pragma mark LoadDayData
- (void)fdCalendar:(FDCalendar *)calendar didSelectedDate:(NSDate *)date
{
    NSLog(@"切换日历代理方法 %s",__func__);
    
    self.seletedDate = date;
    
    if (!self.dateFormattor) {
        self.dateFormattor = [[NSDateFormatter alloc] init];
        [self.dateFormattor setDateFormat:@"yyyy-M-d"];
    }
    NSString * dataStr = [self.dateFormattor stringFromDate:date];
    
    // 初始化日历预约、休假等信息
    if (self.coachID&&[self.coachID length]!=0) {
        [self.calendarHeadView setCurrentDate:self.seletedDate coachID:self.coachID];
    }

    // 加载中间预约时间
    [self loadMidYuyueTimeData:dataStr];
    
    // 设置顶部标题
    self.navigationItem.title = [NSString stringWithFormat:@"%@",[self.dateFormattor stringFromDate:date]];
    
}

- (void)loadMidYuyueTimeData:(NSString *)dataStr
{
    
    NSLog(@"loadMidYuyueTimeData dataStr:%@",dataStr);
    self.yuYueheadView.userCount = 20;
    [self.yuYueheadView receiveCoachTimeData];
    
    NSString *  userId = [AcountManager manager].applycoach.infoId;
     if (userId==nil) {
     return;
     }
     
     WS(ws);
     [NetWorkEntiry getAllCourseTimeWithUserId:userId DayTime:dataStr success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
         NSLog(@"loadMidYuyueTimeData responseObject:%@",responseObject);
         
         NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
         
         if (type == 1) {
         
             NSError *error=nil;
             
             NSArray *dataArray = [MTLJSONAdapter modelsOfClass:AppointmentCoachTimeInfoModel.class fromJSONArray:responseObject[@"data"] error:&error];
             
             dispatch_async(dispatch_get_main_queue(), ^{
             
               [ws.yuYueheadView receiveCoachTimeData:dataArray];
             
             });
     
         }else{
         
         }
     
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     
         
     }];
     
}

- (void)loadFootListDataWithinfoId:(NSString *)infoId
{
    
    
    NSString *  userId = [AcountManager manager].applycoach.infoId;
     if (userId==nil && infoId==nil) {
     return;
     }
     
     WS(ws);
     // 加载底部预约列表数据
     [NetWorkEntiry getcoursereservationlistWithUserId:userId courseid:infoId  success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     NSLog(@"切换日历获取最新数据:responseObject:%@",responseObject);
     
     NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
     
     if (type == 1) {
//     
//     ws.courseDayTableData = [[BaseModelMethod getCourseListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
//     
//     dispatch_async(dispatch_get_main_queue(), ^{
//     [ws.courseDayTableView reloadData];
//     });
     
     }else{
     
     }
     
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     
     }];
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
