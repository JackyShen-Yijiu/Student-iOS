//
//  YBAppointMentController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentController.h"
#import "YBAppointMentNoCountentView.h"
#import "YBAppointMentChangeCoachController.h"
#import "HMCourseModel.h"
#import "FDCalendar.h"
#import "CourseSummaryDayCell.h"
#import "AppointmentCoachTimeInfoModel.h"
#import "BaseModelMethod.h"

@interface YBAppointMentController ()<UITableViewDataSource,UITableViewDelegate,FDCalendarDelegate>
{
    UIImageView*navBarHairlineImageView;
}
@property (nonatomic,strong) YBAppointMentNoCountentView *noCountmentView;

// 底部tableview
@property(nonatomic,strong) UITableView * courseDayTableView;
// 日历
@property(nonatomic,strong) FDCalendar *calendarHeadView;


@property(nonatomic,strong)NSMutableArray * courseDayTableData;

@property(nonatomic,strong)NSDateFormatter *dateFormattor;

@end

@implementation YBAppointMentController

- (YBAppointMentNoCountentView *)noCountmentView
{
    if (_noCountmentView==nil) {
        _noCountmentView = [[YBAppointMentNoCountentView alloc] init];
        _noCountmentView.frame = self.view.bounds;
    }
    return _noCountmentView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    
    // 没有内容，占位图
    //    [self.view addSubview:self.noCountmentView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self fdCalendar:nil didSelectedDate:[NSDate date]];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    navBarHairlineImageView.hidden=NO;
}

- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView*subview in view.subviews) {
        UIImageView*imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyVacation) name:@"modifyVacation" object:nil];
    
    self.title = @"预约";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"换教练" style:UIBarButtonItemStyleDone target:self action:@selector(changeCoach)];
    
    [self initUI];
    
}

- (void)changeCoach
{
    YBAppointMentChangeCoachController *vc = [[YBAppointMentChangeCoachController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - LoingNotification
- (void)didLoginSucess:(NSNotification *)notification
{
    [self fdCalendar:nil didSelectedDate:[NSDate date]];
}

- (void)didLoginoutSucess:(NSNotification *)notifcation
{
    [self.courseDayTableData removeAllObjects];
    [[self courseDayTableData] removeAllObjects];
    [self.courseDayTableView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)modifyVacation
{
    NSLog(@"%s",__func__);
    
    // 设置当前日期
    [self.calendarHeadView setCurrentDate:[NSDate date]];
    
    [self fdCalendar:self.calendarHeadView didSelectedDate:[NSDate date]];
    
    
}

-(void)initUI
{
    
    // 顶部日历
    self.calendarHeadView = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    self.calendarHeadView.delegate = self;
    self.calendarHeadView.frame = CGRectMake(0, 0, self.view.width, 30+65);
    [self.view addSubview:self.calendarHeadView];
    
    // 底部预约列表
    self.courseDayTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendarHeadView.frame), self.view.width, self.view.height-self.calendarHeadView.height) style:UITableViewStylePlain];
    self.courseDayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.courseDayTableView.delegate = self;
    self.courseDayTableView.dataSource = self;
    [self.view addSubview:self.courseDayTableView];
  
}

#pragma mark LoadDayData
- (void)fdCalendar:(FDCalendar *)calendar didSelectedDate:(NSDate *)date
{
    NSLog(@"切换日历代理方法 %s",__func__);
    
    if (!self.dateFormattor) {
        self.dateFormattor = [[NSDateFormatter alloc] init];
        [self.dateFormattor setDateFormat:@"yyyy-M-d"];
    }
    NSString * dataStr = [self.dateFormattor stringFromDate:date];
    
    // 加载底部预约列表数据
    [self loadFootListData:dataStr];
    
    // 设置顶部标题
    self.navigationItem.title = [NSString stringWithFormat:@"%@",[self.dateFormattor stringFromDate:date]];
    
}

#pragma mark --- 中间日程点击事件
- (void)JGYuYueHeadViewWithCollectionViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath timeInfo:(AppointmentCoachTimeInfoModel *)model
{
    NSLog(@"加载日程模块底部预约列表数据");
    [self loadFootListDataWithinfoId:model.infoId];
    
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
            
            ws.courseDayTableData = [[BaseModelMethod getCourseListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [ws.courseDayTableView reloadData];
            });
            
        }else{
            
            [ws obj_showTotasViewWithMes:responseObject];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)loadFootListData:(NSString *)dataStr
{
    
    
    NSString *  userId = [AcountManager manager].applycoach.infoId;
    if (userId==nil) {
        return;
    }
    
    WS(ws);
    // 加载底部预约列表数据
    [NetWorkEntiry getAllCourseInfoWithUserId:userId DayTime:dataStr  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"切换日历获取最新数据:responseObject:%@",responseObject);
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        
        if (type == 1) {
            
            ws.courseDayTableData = [[BaseModelMethod getCourseListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [ws.courseDayTableView reloadData];
            });
            
        }else{
            
            [ws obj_showTotasViewWithMes:responseObject];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    count =  self.courseDayTableData.count;
        [self.noCountmentView setHidden:count];
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CourseSummaryDayCell cellHeight];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CourseSummaryDayCell * dayCell = [tableView dequeueReusableCellWithIdentifier:@"dayCell"];
    if (!dayCell) {
        dayCell = [[CourseSummaryDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dayCell"];
    }
    if (indexPath.row < self.courseDayTableData.count)
        [dayCell setModel:self.courseDayTableData[indexPath.row]];
    
    return dayCell;
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HMCourseModel  * courseModel = nil;
    courseModel = [[self courseDayTableData] objectAtIndex:indexPath.row];
//    if (courseModel) {
//        CourseDetailViewController * decv = [[CourseDetailViewController alloc] init];
//        decv.couresID = courseModel.courseId;
//        [self.navigationController pushViewController:decv animated:YES];
//    }
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
