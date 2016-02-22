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
#import "YBAppotinMentHeadView.h"
#import "YBCoachListViewController.h"
#import "YBForceEvaluateViewController.h"
#import "AppDelegate.h"
#import "RatingBar.h"
#import "APWaitEvaluationViewController.h"
#import "MyAppointmentModel.h"
#import "AppointmentViewController.h"
#import "APCommentViewController.h"

static NSString *const kappointmentUrl = @"courseinfo/getmyuncommentreservation?userid=%@&subjectid=%ld";

static NSString *const kuserCommentAppointment = @"courseinfo/usercomment";

@interface YBAppointMentController ()<UITableViewDataSource,UITableViewDelegate,FDCalendarDelegate>
{
    UIImageView*navBarHairlineImageView;
    
}
@property (nonatomic,strong) YBAppointMentNoCountentView *noCountmentView;

// 底部tableview
@property(nonatomic,strong) UITableView * courseDayTableView;
// 日历
@property(nonatomic,strong) FDCalendar *calendarHeadView;

@property(nonatomic,strong) NSMutableArray * courseDayTableData;

@property(nonatomic,strong) NSDateFormatter *dateFormattor;

@property (nonatomic,strong) YBAppotinMentHeadView *appointMentHeadView;

@property (strong, nonatomic) NSDate *seletedDate;

@property (nonatomic,copy) NSString *coachID;

@property (nonatomic,strong) YBForceEvaluateViewController *feVc;

@property (nonatomic,strong) NSArray *commentListArray;

@property (nonatomic,assign) NSInteger number;// 科目几
@end

@implementation YBAppointMentController

- (YBForceEvaluateViewController *)feVc
{
    if (_feVc==nil) {
        
        WS(ws);
        _feVc = [[YBForceEvaluateViewController alloc] init];
        _feVc.view.frame = ((AppDelegate *)[UIApplication sharedApplication].delegate).window.bounds;
        _feVc.moteblock = ^{
            
            NSLog(@"更多");
            NSLog(@"_feVc.starBar.rating:%f",ws.feVc.starBar.rating);
            NSLog(@"feVc.reasonTextView.text:%@",ws.feVc.reasonTextView.text);
           
            if (self.commentListArray && self.commentListArray.count==1) {// 跳转到评论界面
                
                NSError *error = nil;

                MyAppointmentModel *model = [MTLJSONAdapter modelsOfClass:MyAppointmentModel.class fromJSONArray:ws.commentListArray error:&error].firstObject;

                APCommentViewController *comment = [[APCommentViewController alloc] init];
                comment.model = model;
                comment.hidesBottomBarWhenPushed = YES;
                comment.isForceComment = YES;
                [ws.navigationController pushViewController:comment animated:YES];

            }else if (self.commentListArray && self.commentListArray.count>1){// 跳转到预约列表
                
                AppointmentViewController *appointment = [[AppointmentViewController alloc] init];
                appointment.hidesBottomBarWhenPushed = YES;
                appointment.isForceComment = YES;
                
                if ([AcountManager manager].userSubject.name && [[AcountManager manager].userSubject.name isEqualToString:@"科目二"]){
                    appointment.title = @"科二预约列表";
                    
                }else if ([AcountManager manager].userSubject.name && [[AcountManager manager].userSubject.name isEqualToString:@"科目三"]){
                    appointment.title = @"科三预约列表";
                    
                }
                
                appointment.markNum = [NSNumber numberWithInteger:ws.number];
                [ws.navigationController pushViewController:appointment animated:YES];
                
            }
            
        };
        _feVc.commitBlock = ^{
            
            NSLog(@"提交");
            NSLog(@"_feVc.starBar.rating:%f",ws.feVc.starBar.rating);
            NSLog(@"feVc.reasonTextView.text:%@",ws.feVc.reasonTextView.text);
            
            NSError *error = nil;
            
            MyAppointmentModel *model = [MTLJSONAdapter modelsOfClass:MyAppointmentModel.class fromJSONArray:ws.commentListArray error:&error].firstObject;

            [ws commitComment:ws.feVc.reasonTextView.text star:ws.feVc.starBar.rating model:model];
            
        };
        
    }
    return _feVc;
}

- (void)commitComment:(NSString *)comment star:(CGFloat)star model:(MyAppointmentModel *)model{
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kuserCommentAppointment];
    
    NSDictionary *param = @{@"userid":[AcountManager manager].userid,
                            @"reservationid":model.infoId,
                            @"starlevel":[NSString stringWithFormat:@"%f",star],// 总体评论星级
                            @"abilitylevel":@"0",// 能力
                            @"timelevel":@"0",// 时间
                            @"attitudelevel":@"0",// 态度
                            @"hygienelevel":@"0",// 卫生
                            @"commentcontent":comment};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        DYNSLog(@"%s data = %@",__func__,data);
        
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
        
        if (type.integerValue == 1) {
            kShowSuccess(@"评论成功");
        }else {
            kShowFail(msg);
        }
    }];
    
}

- (YBAppotinMentHeadView *)appointMentHeadView
{
    if (_appointMentHeadView==nil) {
        
        _appointMentHeadView = [[YBAppotinMentHeadView alloc] init];
        
    }
    return _appointMentHeadView;
}

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
    
    [self setUpCalendar:nil didSelectedDate:self.seletedDate];

    // 获取尚未评价的订单
    [self loadCommentList];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    navBarHairlineImageView.hidden=NO;
    
    [self.feVc.view removeFromSuperview];
    
}

- (void)loadCommentList
{
    
    self.number = 0;
    if ([AcountManager manager].userSubject.name && [[AcountManager manager].userSubject.name isEqualToString:@"科目二"]) {
        self.number=2;
    }else if ([AcountManager manager].userSubject.name  && [[AcountManager manager].userSubject.name isEqualToString:@"科目三"]){
        self.number=3;
    }else{
        return;
    }
    
    NSString *appointmentUrl = [NSString stringWithFormat:kappointmentUrl,[AcountManager manager].userid,(long)self.number];
    
    NSString *downLoadUrl = [NSString stringWithFormat:BASEURL,appointmentUrl];
    DYNSLog(@"url = %@ %@",[AcountManager manager].userid,[AcountManager manager].userToken);
    
    __weak typeof (self) ws = self;
    [JENetwoking startDownLoadWithUrl:downLoadUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSArray *commentListArray = param[@"data"];

        if (type.integerValue == 1 && commentListArray && commentListArray.count>0) {
            
            self.commentListArray = commentListArray;
            
            // 强制评价
            [self.tabBarController.view insertSubview:self.feVc.view aboveSubview:((AppDelegate *)[UIApplication sharedApplication].delegate).window];
            
        }
    }];
    
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
    
    self.seletedDate = [NSDate date];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"预约";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"换教练" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarDidClick)];
    
    [self initUI];
    
}

- (void)rightBarDidClick
{
    YBCoachListViewController *vc = [[YBCoachListViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)changeCoach
{
    
    YBAppointMentChangeCoachController *vc = [[YBAppointMentChangeCoachController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.seletedDate = self.seletedDate;
    vc.navigationItem.title = self.navigationItem.title;
    vc.coachID = self.coachID;
    [self.navigationController pushViewController:vc animated:YES];
    
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
    self.calendarHeadView.parentViewController = self;
    self.calendarHeadView.frame = CGRectMake(0, 0, self.view.width, 30+67);
    [self.view addSubview:self.calendarHeadView];
    
    // 底部预约列表
    self.courseDayTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendarHeadView.frame), self.view.width, self.view.height-self.calendarHeadView.height) style:UITableViewStylePlain];
    self.courseDayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.courseDayTableView.delegate = self;
    self.courseDayTableView.dataSource = self;
    self.courseDayTableView.backgroundColor = RGBColor(238, 238, 238);
    self.courseDayTableView.tableHeaderView = self.appointMentHeadView;
    self.courseDayTableView.contentInset = UIEdgeInsetsMake(0, 0, self.calendarHeadView.height+15, 0);
    [self.view addSubview:self.courseDayTableView];
  
}

#pragma mark LoadDayData
- (void)fdCalendar:(FDCalendar *)calendar didSelectedDate:(NSDate *)date
{
    self.seletedDate = date;
    
    if (!self.dateFormattor) {
        self.dateFormattor = [[NSDateFormatter alloc] init];
        [self.dateFormattor setDateFormat:@"yyyy-M-d"];
    }
    NSString * dataStr = [self.dateFormattor stringFromDate:date];
    
    // 设置顶部标题
    self.navigationItem.title = [NSString stringWithFormat:@"%@",[self.dateFormattor stringFromDate:date]];
    
    // 加载底部预约列表数据
    [self loadFootListData:dataStr];
    
}

- (void)setUpCalendar:(FDCalendar *)calendar didSelectedDate:(NSDate *)date
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

    // 加载底部预约列表数据
    [self loadFootListData:dataStr];
    
    // 设置顶部标题
    self.navigationItem.title = [NSString stringWithFormat:@"%@",[self.dateFormattor stringFromDate:date]];
    
}


- (void)loadFootListData:(NSString *)dataStr
{
    
    // GET /courseinfo/getmyreservation
    
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
        [ws.courseDayTableView reloadData];
    }];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }else if (section==1){
        return 5;
    }else{
        return 7;
    }
    
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
//    if (indexPath.row < self.courseDayTableData.count)
//        [dayCell setModel:self.courseDayTableData[indexPath.row]];
    
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
