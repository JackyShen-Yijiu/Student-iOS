//
//  YBAppointController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointController.h"
#import "YBAppointController.h"
#import "HMCourseModel.h"
#import "JGYuYueHeadView.h"
#import "AppointmentCoachTimeInfoModel.h"
#import "YBCoachListViewController.h"
#import "BLInformationManager.h"
#import "EMMessage.h"
#import "ChatSendHelper.h"
#import "YBAppointMentNoCountentView.h"
#import "StudentModel.h"
#import "CoachModel.h"
#import "YBAppointMentCoachModel.h"
#import "DIDatepicker.h"

#define kSameTimeStudent @"courseinfo/sametimestudentsv2"

@interface YBAppointController ()<YBCoachListViewControllerDelegate,JGYuYueHeadViewDelegate>

@property (nonatomic,strong) DIDatepicker *datepicker;

// 中间预约时间
@property (nonatomic,strong) JGYuYueHeadView *midYuYueheadView;

@property(nonatomic,strong)NSDateFormatter *dateFormattor;

@property (nonatomic,weak) UICollectionView *collectionView;

@property (strong, nonatomic) NSDate *seletedDate;
@property (nonatomic,copy) NSString *selectDateStr;

@property (nonatomic,strong) YBAppointMentCoachModel *appointCoach;

@property (nonatomic ,strong) NSString *startTimeStr;
@property (nonatomic ,strong) NSString *endTimeStr;

@property (nonatomic,strong) YBAppointMentNoCountentView *noCountmentView;

@property ( nonatomic,weak) UILabel *countLabel;

@property (strong, nonatomic) NSMutableArray *stuDataArray;
@property (strong, nonatomic) NSMutableArray *appointDataArray;

@property (nonatomic,strong) NSMutableArray *coachArray;

@end

@implementation YBAppointController

- (DIDatepicker *)datepicker
{
    if (_datepicker == nil) {
        
        _datepicker = [[DIDatepicker alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
        _datepicker.backgroundColor = [UIColor whiteColor];
    }
    return _datepicker;
}


- (YBAppointMentNoCountentView *)noCountmentView
{
    if (_noCountmentView==nil) {
        _noCountmentView = [[YBAppointMentNoCountentView alloc] init];
        _noCountmentView.frame = self.view.bounds;
        _noCountmentView.hidden = YES;
    }
    return _noCountmentView;
}

- (NSMutableArray *)coachArray
{
    if (_coachArray==nil) {
        _coachArray = [NSMutableArray array];
    }
    return _coachArray;
}

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
    
//    [self fdCalendar:nil didSelectedDate:self.seletedDate];
    [self updateSelectedDate];
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.seletedDate = [NSDate date];
    
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    
    [self initUI];
    
    // 没有内容，占位图
    [self.view addSubview:self.noCountmentView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kCellChange) name:@"kCellChange" object:nil];
    
    YBAppointMentCoachModel *appointCoach = [self getPersonArrayData];
    NSLog(@"appointCoach.coachid：%@",appointCoach.coachid);
    if (appointCoach&&appointCoach.coachid) {
        self.appointCoach = appointCoach;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"换教练" style:UIBarButtonItemStyleDone target:self action:@selector(changeCoach)];
    }else{
        self.noCountmentView.hidden = NO;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加教练" style:UIBarButtonItemStyleDone target:self action:@selector(changeCoach)];
    }
    
}

- (void)changeCoach
{
    YBCoachListViewController *vc = [[YBCoachListViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)YBCoachListViewControllerWithCoach:(CoachModel *)coachModel
{
    
    YBAppointMentCoachModel *model = [[YBAppointMentCoachModel alloc] init];
    model.coachid = coachModel.coachid;
    model.headportrait = coachModel.headportrait.originalpic;
    model.name = coachModel.name;
    
    // 保存教练信息
    [self savePersonArrayData:model];
    
    self.noCountmentView.hidden = YES;
    self.appointCoach = model;
    
    
}

- (YBAppointMentCoachModel *)getPersonArrayData{
    
    YBAppointMentCoachModel *coach = [NSKeyedUnarchiver unarchiveObjectWithFile:[YBPath stringByAppendingPathComponent:@"saveAppointMentData"]];
    
    return coach;
}

- (void)savePersonArrayData:(YBAppointMentCoachModel *)coachModel {
    
    [NSKeyedArchiver archiveRootObject:coachModel toFile:[YBPath stringByAppendingPathComponent:@"saveAppointMentData"]];
}

- (void)JGYuYueHeadViewWithModifyCoach:(JGYuYueHeadView *)headView dateString:(NSString *)dateString isModifyCoach:(BOOL)isModifyCoach timeid:(NSNumber *)timeid
{
    
    YBCoachListViewController *coachList = [[YBCoachListViewController alloc] init];
    coachList.delegate = self;
    coachList.isModifyCoach = isModifyCoach;
    coachList.timeid = timeid;
    coachList.coursedate = dateString;
    [self.navigationController pushViewController:coachList animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initUI
{
    
    [self.view addSubview:self.datepicker];
    [self.datepicker addTarget:self action:@selector(updateSelectedDate) forControlEvents:UIControlEventValueChanged];
    
    // 从今天开始-14天后
    [self.datepicker fillDatesFromCurrentDate:14];
    //    [self.datepicker fillCurrentWeek];
    //    [self.datepicker fillCurrentMonth];
    //    [self.datepicker fillCurrentYear];
    // 选中第0个
    [self.datepicker selectDateAtIndex:0];
    
    // 顶部日历
//    self.TopCalendarHeadView = [[FDCalendar alloc] initWithData:[NSDate date]];
//    self.TopCalendarHeadView.delegate = self;
//    self.TopCalendarHeadView.frame = CGRectMake(0, 0, self.view.width, 30+35);
//    [self.view addSubview:self.TopCalendarHeadView];
    
    // 中间方格
    self.midYuYueheadView = [[JGYuYueHeadView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.datepicker.frame), self.view.width, kSystemHeight-self.datepicker.height-50)];
    self.midYuYueheadView.parentViewController = self;
    self.midYuYueheadView.delegate = self;
    [self.view addSubview:self.midYuYueheadView];
    
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
    self.countLabel = countLabel;
    
    [self setupcountLabelData];
    
}

- (void)setupcountLabelData
{
    
    NSMutableString *detailStr = [NSMutableString string];
    
    if ([AcountManager manager].subjecttwo.progress) {
        [detailStr appendString:[NSString stringWithFormat:@" %@",[AcountManager manager].subjecttwo.progress]];
    }else if ([AcountManager manager].subjectthree.progress) {
        [detailStr appendString:[NSString stringWithFormat:@" %@",[AcountManager manager].subjectthree.progress]];
    }
    
    if ([AcountManager manager].userSubject.subjectId.integerValue == 2) {
        
        NSInteger doneCourse = [AcountManager manager].subjecttwo.finishcourse.integerValue;
        
        [detailStr appendString:[NSString stringWithFormat:@" 完成:%ld课时",(long)doneCourse]];
        
    }else if ([AcountManager manager].userSubject.subjectId.integerValue == 3) {
        
        NSInteger doneCourse = [AcountManager manager].subjectthree.finishcourse.integerValue;
        [detailStr appendString:[NSString stringWithFormat:@" 完成:%ld课时",(long)doneCourse]];
        
    }
    
    if (detailStr&&[detailStr length]!=0) {
        self.countLabel.text = detailStr;
    }
    
}


- (void)updateSelectedDate
{
    NSLog(@"self.datepicker.selectedDate:%@",self.datepicker.selectedDate);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy年dd月MM日,EEEE" options:0 locale:nil];
    
    NSLog(@"self.datepicker.selectedDate:%@",self.datepicker.selectedDate);
    
//    self.selectedDateLabel.text = [formatter stringFromDate:self.datepicker.selectedDate];
    
    self.seletedDate = self.datepicker.selectedDate;
    
    if (!self.dateFormattor) {
        self.dateFormattor = [[NSDateFormatter alloc] init];
        [self.dateFormattor setDateFormat:@"yyyy-M-d"];
    }
    NSString * dataStr = [self.dateFormattor stringFromDate:self.datepicker.selectedDate];
    NSLog(@"切换日历代理方法 dataStr:%@",dataStr);
    self.selectDateStr = dataStr;
    
    // 初始化日历
//    [self.TopCalendarHeadView setCurrentDate:self.seletedDate coachID:self.appointCoach.coachid];
    
    // 加载中间预约时间
    [self loadMidYuyueTimeData:dataStr];
    
    // 设置顶部标题
    self.navigationItem.title = [NSString stringWithFormat:@"%@",[self.dateFormattor stringFromDate:self.datepicker.selectedDate]];
    
}

#pragma mark LoadDayData
//- (void)fdCalendar:(FDCalendar *)calendar didSelectedDate:(NSDate *)date
//{
//    
//}

- (void)loadMidYuyueTimeData:(NSString *)dataStr
{
    
    NSLog(@"loadMidYuyueTimeData dataStr:%@",dataStr);
    
    if (self.appointCoach.coachid==nil) {
        return;
    }
    
    WS(ws);
    NSString *urlString = [NSString stringWithFormat:kappointmentCoachTimeUrl,self.appointCoach.coachid,dataStr];
    
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"loadMidYuyueTimeData data:%@",data);
        
        NSDictionary *param = data;
        DYNSLog(@"msg = %@",param[@"msg"]);
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        
        if ([type isEqualToString:@"1"]) {
            
            NSArray *array = param[@"data"];
            NSError *error = nil;
            
            if (array&&array.count!=0) {
                
                self.appointDataArray = [[MTLJSONAdapter modelsOfClass:AppointmentCoachTimeInfoModel.class fromJSONArray:array error:&error] mutableCopy];
                
                DYNSLog(@"error = %@",error);
                
                [ws.midYuYueheadView receiveCoachTimeData:self.appointDataArray selectData:self.seletedDate coachModel:self.appointCoach];
                
            }
            
        }else{
            
            [self obj_showTotasViewWithMes:param[@"msg"]];
            
            [ws.midYuYueheadView receiveCoachTimeData:nil selectData:self.seletedDate coachModel:self.appointCoach];
            
        }
        
    }];
    
}

- (void)kCellChange
{
    
    NSArray *array = [BLInformationManager sharedInstance].appointmentData;
    if (array&&array.count==0) {
        [self showTotasViewWithMes:@"请选择预约时间"];
        return;
    }
    
    // 数组排序
    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(AppointmentCoachTimeInfoModel *  _Nonnull obj1, AppointmentCoachTimeInfoModel *  _Nonnull obj2) {
        //obj1.coursetime.numMark < obj2.coursetime.numMark
        return obj1.coursetime.numMark > obj2.coursetime.numMark ;
        
    }];
    NSLog(@"appointmentData resultArray:%@",resultArray);
    
    AppointmentCoachTimeInfoModel *firstModel = resultArray.firstObject;
    AppointmentCoachTimeInfoModel *lastModel = resultArray.lastObject;
    
    NSArray *beginArray = [firstModel.coursetime.begintime componentsSeparatedByString:@":"];
    NSString *beginString = beginArray.firstObject;
    _startTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:beginString data:self.selectDateStr]];
    
    NSArray *endArray = [lastModel.coursetime.endtime componentsSeparatedByString:@":"];
    NSString *endString = endArray.firstObject;
    _endTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:endString data:self.selectDateStr]];
    
    NSLog(@"self.selectDateStr:%@",self.selectDateStr);
    NSLog(@"firstModel.coursetime.begintime:%@",firstModel.coursetime.begintime);
    NSLog(@"lastModel.coursetime.endtime:%@",lastModel.coursetime.endtime);
    
    NSMutableString *courselistStr = [NSMutableString string];
    for (int i = 0; i<resultArray.count; i++) {
        
        AppointmentCoachTimeInfoModel *model = resultArray[i];
        
        NSString *courseID = model.infoId;
        NSLog(@"courseID:%@",courseID);
        
        if (i==resultArray.count-1) {
            NSString *lastID = ((AppointmentCoachTimeInfoModel *)[resultArray lastObject]).infoId;
            [courselistStr appendString:[NSString stringWithFormat:@"%@",lastID]];
        }else{
            [courselistStr appendString:[NSString stringWithFormat:@"%@,",courseID]];
        }
        
    }
    
    WS(ws);
    
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kSameTimeStudent];
    
    NSLog(@"%@",applyUrlString);
    NSDictionary *upData = @{@"coachid"   :self.appointCoach.coachid,
                             @"begintime" :[NSString stringWithFormat:@"%d",[self chagetime:firstModel.coursetime.begintime data:self.selectDateStr]],//[NSString stringWithFormat:@"%@ %@",self.selectDateStr,firstModel.coursetime.begintime],
                             @"endtime"   :[NSString stringWithFormat:@"%d",[self chagetime:lastModel.coursetime.endtime data:self.selectDateStr]],//[NSString stringWithFormat:@"%@ %@",self.selectDateStr,lastModel.coursetime.endtime],
                             @"index"     :@"1"
                             };
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:upData WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        DYNSLog(@"同时段学员 applyUrlString:%@ upData:%@ %@",applyUrlString,upData,data);
        
        NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];
        
        if ([type isEqualToString:@"1"]) {
            
            NSError *error = nil;
            ws.stuDataArray = [[MTLJSONAdapter modelsOfClass:StudentModel.class fromJSONArray:data[@"data"] error:&error] mutableCopy];
            for (StudentModel *studentModel in self.stuDataArray) {
                if ([studentModel.userid.userId isEqualToString:[AcountManager manager].userid]) {
                    [ws.stuDataArray removeObject:studentModel];
                }
            }
            [ws.midYuYueheadView receiveCoachTimeDataWithStudentData:self.stuDataArray coachModel:self.appointCoach];
            
        }else {
            [self obj_showTotasViewWithMes:[NSString stringWithFormat:@"%@",data[@"msg"]]];
        }
    } withFailure:^(id data) {
        kShowFail(@"网络连接失败，请检查网络连接");
    }];
    
    
}

- (void)commitBtnDidClick
{
    
    NSArray *array = [BLInformationManager sharedInstance].appointmentData;
    if (array&&array.count==0) {
        [self showTotasViewWithMes:@"请选择预约时间"];
        return;
    }
    
    //    NSArray *userArray = [BLInformationManager sharedInstance].appointmentUserData;
    //    if (userArray&&userArray.count==0) {
    //        [self showTotasViewWithMes:@"请选择预约学员"];
    //        return;
    //    }
    
    
    // 数组排序
    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(AppointmentCoachTimeInfoModel *  _Nonnull obj1, AppointmentCoachTimeInfoModel *  _Nonnull obj2) {
        //obj1.coursetime.numMark < obj2.coursetime.numMark
        return obj1.coursetime.numMark > obj2.coursetime.numMark ;
        
    }];
    NSLog(@"appointmentData resultArray:%@",resultArray);
    
    AppointmentCoachTimeInfoModel *firstModel = resultArray.firstObject;
    AppointmentCoachTimeInfoModel *lastModel = resultArray.lastObject;
    
    NSArray *beginArray = [firstModel.coursetime.begintime componentsSeparatedByString:@":"];
    NSString *beginString = beginArray.firstObject;
    _startTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:beginString data:self.selectDateStr]];
    
    NSArray *endArray = [lastModel.coursetime.endtime componentsSeparatedByString:@":"];
    NSString *endString = endArray.firstObject;
    _endTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:endString data:self.selectDateStr]];
    
    NSLog(@"self.selectDateStr:%@",self.selectDateStr);
    NSLog(@"firstModel.coursetime.begintime:%@",firstModel.coursetime.begintime);
    NSLog(@"lastModel.coursetime.endtime:%@",lastModel.coursetime.endtime);
    
    NSMutableString *courselistStr = [NSMutableString string];
    for (int i = 0; i<resultArray.count; i++) {
        
        AppointmentCoachTimeInfoModel *model = resultArray[i];
        
        NSString *courseID = model.infoId;
        NSLog(@"courseID:%@",courseID);
        
        if (i==resultArray.count-1) {
            NSString *lastID = ((AppointmentCoachTimeInfoModel *)[resultArray lastObject]).infoId;
            [courselistStr appendString:[NSString stringWithFormat:@"%@",lastID]];
        }else{
            [courselistStr appendString:[NSString stringWithFormat:@"%@,",courseID]];
        }
        
    }
    
    /*
     
     "userid": "560539bea694336c25c3acb9",（用户id）
     
     "coachid": "5616352721ec29041a9af889",（教练id）
     
     "courselist": "5616352721ec29041a9af889, 5616352721ec29041a9af889",（课程id列表）
     
     "is_shuttle": 1,（是否接送1接送0不接送）
     
     "address": "sdfsdfsdfdsfdssf",（接送地址）
     
     "begintime": "2015-09-10 10:00:00",（课程的开始时间
     
     "endtime": "2015-09-10 14:00:00"（课程结束时间）
     
     */
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = [AcountManager manager].userid;
    params[@"coachid"] = self.appointCoach.coachid;
    params[@"courselist"] = courselistStr;
    params[@"is_shuttle"] = @"1";
    params[@"address"] = @"";
    params[@"begintime"] = [NSString stringWithFormat:@"%@ %@",self.selectDateStr,firstModel.coursetime.begintime];
    params[@"endtime"] = [NSString stringWithFormat:@"%@ %@",self.selectDateStr,lastModel.coursetime.endtime];
    
    NSLog(@"预约params:%@",params);
    /*
     
     预约params:{
     address = "";
     begintime = "2016-2-24 11:00:00";
     coachid = 568d01c3ee34ba2e74f1e233;
     courselist = "56cbcfc88305b8fd727688fa,56cbcfc88305b8fd727688fb,56cbcfc88305b8fd727688fc,56cbcfc88305b8fd727688fd";
     endtime = "2016-2-24 15:00:00";
     "is_shuttle" = 1;
     userid = 568b21993b4fb24b6b5614a6;
     }
     
     */
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kuserUpdateParam];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:params WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *param = data;
        DYNSLog(@"param = %@",param[@"msg"]);
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        
        if (type.integerValue == 1) {
            
            [BLInformationManager sharedInstance].appointmentData = nil;
            //            [[BLInformationManager sharedInstance].appointmentData removeAllObjects];
            
            [self obj_showTotasViewWithMes:@"预约成功"];
            
            NSString *userName = [AcountManager manager].userName;
            
            NSString *content = [NSString stringWithFormat:@"%@学员,预约了您%@日的课程,请查看!", userName,self.selectDateStr];
            
            // 预约成功后，通过环信给教练发送一条提示消息
            EMMessage *message = [ChatSendHelper sendTextMessageWithString:content toUsername:self.appointCoach.coachid isChatGroup:NO requireEncryption:NO ext:nil];
            
            [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil prepare:^(EMMessage *message, EMError *error) {
                
                
            } onQueue:nil completion:^(EMMessage *message, EMError *error) {
                
                if(!error){
                    
                }
                
            } onQueue:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            [self obj_showTotasViewWithMes:msg];
        }
        
    }];
    
}

- (int)chagetime:(NSString *)timeStr data:(NSString *)dataStr {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    //设置格式
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    
    //将符合格式的字符串转成NSDate对象
    NSDate *date = [df dateFromString:[NSString stringWithFormat:@"%@ %@",dataStr,timeStr]];
    NSLog(@"chagetime date:%@",date);
    
    //计算一个时间和系统当前时间的时间差
    int second = [date timeIntervalSince1970];
    
    return second;
    
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
