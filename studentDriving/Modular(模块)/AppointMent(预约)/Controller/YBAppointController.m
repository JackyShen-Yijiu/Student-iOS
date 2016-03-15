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
#import "YBCoachListViewController.h"
#import "BLInformationManager.h"
#import "EMMessage.h"
#import "ChatSendHelper.h"
#import "YBAppointMentNoCountentView.h"
#import "StudentModel.h"
#import "CoachModel.h"
#import "YBAppointMentCoachModel.h"
#import "DIDatepicker.h"
#import "YBAppointMentFootView.h"
#import "YBAppointRootClass.h"
#import "YBAppointData.h"
#import "YBAppointCoursedata.h"
#import "YBAppointCoursetime.h"
#import "YYModel.h"

#define kSameTimeStudent @"courseinfo/sametimestudentsv2"

#define datePickerH 55
#define footViewH 150

@interface YBAppointController ()<YBCoachListViewControllerDelegate,JGYuYueHeadViewDelegate>

// 顶部日历
@property (nonatomic,strong) DIDatepicker *datepicker;

// 中间预约时间
@property (nonatomic,strong) JGYuYueHeadView *midYuYueheadView;

// 底部工具条
@property (nonatomic,strong) YBAppointMentFootView *footView;

@property(nonatomic,strong)NSDateFormatter *dateFormattor;

@property (nonatomic,copy) NSString *selectDateStr;

@property (nonatomic,strong) YBAppointMentCoachModel *appointCoach;

@property (nonatomic ,strong) NSString *startTimeStr;
@property (nonatomic ,strong) NSString *endTimeStr;

@property (strong, nonatomic) NSMutableArray *stuDataArray;
@property (strong, nonatomic) NSMutableArray *appointDataArray;

@property (nonatomic,strong) NSMutableArray *coachArray;

@end

@implementation YBAppointController

- (NSMutableArray *)coachArray
{
    if (_coachArray==nil) {
        _coachArray = [NSMutableArray array];
    }
    return _coachArray;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 初始化日期、预约教练、预约时间
    [self updateSelectedDate];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    
    // 获取教练
    [self getPersonArrayData];
    
    [self initUI];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"预约列表" target:self action:@selector(back)];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kCellChange) name:@"kCellChange" object:nil];

}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (DIDatepicker *)datepicker
{
    if (_datepicker == nil) {
        
        _datepicker = [[DIDatepicker alloc] initWithFrame:CGRectMake(0, 0, self.view.width, datePickerH)];
        _datepicker.backgroundColor = [UIColor whiteColor];
        [_datepicker addTarget:self action:@selector(updateSelectedDate) forControlEvents:UIControlEventValueChanged];

    }
    return _datepicker;
}

- (YBAppointMentFootView *)footView
{
    if (_footView==nil) {
        _footView = [[YBAppointMentFootView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-footViewH-64, self.view.width, footViewH)];
        _footView.parentViewController = self;
        [_footView.commitBtn addTarget:self action:@selector(commitBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [_footView.changeCoachBtn addTarget:self action:@selector(changeCoachBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footView;
}

-(void)initUI
{
    
    [self.view addSubview:self.datepicker];
    
    // 从今天开始-14天后
    [self.datepicker fillDatesFromCurrentDate:14];
    //    [self.datepicker fillCurrentWeek];
    //    [self.datepicker fillCurrentMonth];
    //    [self.datepicker fillCurrentYear];
    // 选中第0个
    [self.datepicker selectDateAtIndex:0];
    
    // 中间方格
    self.midYuYueheadView = [[JGYuYueHeadView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.datepicker.frame), self.view.width, kSystemHeight-64-self.datepicker.height-footViewH)];
    self.midYuYueheadView.parentViewController = self;
    self.midYuYueheadView.delegate = self;
    [self.view addSubview:self.midYuYueheadView];
    
    // 底部提交
    [self.view addSubview:self.footView];
    
    // 初始化数据
    [self setupcountLabelData];
    
}

- (void)changeCoachBtnDidClick
{
    YBCoachListViewController *vc = [[YBCoachListViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)JGYuYueHeadViewWithModifyCoach:(JGYuYueHeadView *)headView isModifyCoach:(BOOL)isModifyCoach timeid:(NSNumber *)timeid
{
    
    YBCoachListViewController *coachList = [[YBCoachListViewController alloc] init];
    coachList.delegate = self;
    coachList.isModifyCoach = isModifyCoach;
    coachList.timeid = timeid;
    coachList.coursedate = [self.dateFormattor stringFromDate:self.datepicker.selectedDate];
    [self.navigationController pushViewController:coachList animated:YES];
}

- (void)YBCoachListViewControllerWithCoach:(CoachModel *)coachModel
{
    
    YBAppointMentCoachModel *model = [[YBAppointMentCoachModel alloc] init];
    model.coachid = coachModel.coachid;
    model.headportrait = coachModel.headportrait.originalpic;
    model.name = coachModel.name;
    
    // 保存教练信息
    [self savePersonArrayData:model];
    
    self.appointCoach = model;
    
}

- (void)savePersonArrayData:(YBAppointMentCoachModel *)coachModel {
    
    [NSKeyedArchiver archiveRootObject:coachModel toFile:[YBPath stringByAppendingPathComponent:@"saveAppointMentData"]];
}

- (void)getPersonArrayData{
    
    YBAppointMentCoachModel *coach = [NSKeyedUnarchiver unarchiveObjectWithFile:[YBPath stringByAppendingPathComponent:@"saveAppointMentData"]];
    
    if (coach.coachid && [coach.coachid length]!=0) {
        self.appointCoach = coach;
        return;
    }
    
    WS(ws);

    NSString *url = [NSString stringWithFormat:kgetmyfirstcoach,[AcountManager manager].userid,[AcountManager manager].userSubject.subjectId];
    
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,url];
    
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"获取明星教练%@",data);
        
        NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];
        
        NSDictionary *dictData = data[@"data"];
        
        if ([type isEqualToString:@"1"]) {
            
            YBAppointMentCoachModel *coach = [[YBAppointMentCoachModel alloc] init];
            coach.coachid = [NSString stringWithFormat:@"%@",dictData[@"coachid"]];
            coach.name = [NSString stringWithFormat:@"%@",dictData[@"name"]];
            coach.headportrait = [NSString stringWithFormat:@"%@",dictData[@"headportrait"][@"originalpic"]];
            [ws savePersonArrayData:coach];
            ws.appointCoach = coach;
            
            [ws updateSelectedDate];
            
        }else {
            
            [self obj_showTotasViewWithMes:[NSString stringWithFormat:@"%@",data[@"msg"]]];
            
        }
        
    } withFailure:^(id data) {
        [self obj_showTotasViewWithMes:@"网络连接失败，请检查网络连接"];
    }];

}

- (void)updateSelectedDate
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy年dd月MM日,EEEE" options:0 locale:nil];
    
    if (!self.dateFormattor) {
        self.dateFormattor = [[NSDateFormatter alloc] init];
        [self.dateFormattor setDateFormat:@"yyyy-M-d"];
    }
    NSString * dataStr = [self.dateFormattor stringFromDate:self.datepicker.selectedDate];
    if (dataStr && [dataStr length]!=0) {
        self.selectDateStr = dataStr;
    }else{
        self.selectDateStr = [self.dateFormattor stringFromDate:[NSDate date]];
    }

    if (self.appointCoach.coachid) {
        
        self.footView.appointCoach = self.appointCoach;

        [self loadMidYuyueTimeData:self.selectDateStr];

    }
    
    // 设置顶部标题
    self.navigationItem.title = [NSString stringWithFormat:@"%@",[self.dateFormattor stringFromDate:self.datepicker.selectedDate]];
    
}

- (void)loadMidYuyueTimeData:(NSString *)dataStr
{
    
    NSLog(@"loadMidYuyueTimeData dataStr:%@",dataStr);
    
    if (self.appointCoach.coachid==nil) {
        return;
    }
    
    WS(ws);
    NSString *urlString = [NSString stringWithFormat:kgetcoursebycoachv2,self.appointCoach.coachid,dataStr,[AcountManager manager].userid];
    
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"loadMidYuyueTimeData data:%@",data);
        
        DYNSLog(@"msg = %@",data[@"msg"]);
        NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];
        
        if ([type isEqualToString:@"1"]) {
            
            NSArray *dataDict = data[@"data"];
            
            if (dataDict&&dataDict.count!=0) {
                
                YBAppointRootClass *class = [YBAppointRootClass yy_modelWithJSON:data];
               
                self.appointDataArray = [class.data mutableCopy];
                
                [ws.midYuYueheadView receiveCoachTimeData:self.appointDataArray selectData:self.datepicker.selectedDate coachModel:self.appointCoach];
                
            }
            
        }else{
            
            [ws.midYuYueheadView receiveCoachTimeData:nil selectData:self.datepicker.selectedDate coachModel:self.appointCoach];

            if (data[@"msg"] && [data[@"msg"] length]!=0) {
                [self obj_showTotasViewWithMes:data[@"msg"]];
            }
            
        }
        
    }];
    
}

- (void)setupcountLabelData
{
    
    NSMutableString *detailStr = [NSMutableString string];
    
    if ([AcountManager manager].subjecttwo.progress) {
        [detailStr appendString:[NSString stringWithFormat:@"  %@",[AcountManager manager].subjecttwo.progress]];
    }else if ([AcountManager manager].subjectthree.progress) {
        [detailStr appendString:[NSString stringWithFormat:@"  %@",[AcountManager manager].subjectthree.progress]];
    }
    
    if (detailStr&&[detailStr length]!=0) {
        self.footView.countLabel.text = detailStr;
    }
    
}

- (void)kCellChange
{
    
    NSArray *array = [BLInformationManager sharedInstance].appointmentData;
    if (array&&array.count==0) {
        [self showTotasViewWithMes:@"请选择预约时间"];
        return;
    }
    
//    // 数组排序
//    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(YBAppointData *  _Nonnull obj1, YBAppointData *  _Nonnull obj2) {
//        return obj1.timeid > obj2.timeid;
//    }];
//    
//    YBAppointData *firstModel = resultArray.firstObject;
//    YBAppointData *lastModel = resultArray.lastObject;
//    
//    NSArray *beginArray = [firstModel.begintime componentsSeparatedByString:@":"];
//    NSString *beginString = beginArray.firstObject;
//    _startTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:beginString data:self.selectDateStr]];
//    
//    NSArray *endArray = [lastModel.endtime componentsSeparatedByString:@":"];
//    NSString *endString = endArray.firstObject;
//    _endTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:endString data:self.selectDateStr]];
//    
//    NSMutableString *courselistStr = [NSMutableString string];
//    for (int i = 0; i<resultArray.count; i++) {
//        
//        YBAppointData *model = resultArray[i];
//        
//        NSString *courseID = [NSString stringWithFormat:@"%@",model.coursedata._id];
//        NSLog(@"courseID:%@",courseID);
//        
//        if (i==resultArray.count-1) {
//            NSString *lastID = [NSString stringWithFormat:@"%@",lastModel.coursedata._id];
//            [courselistStr appendString:[NSString stringWithFormat:@"%@",lastID]];
//        }else{
//            [courselistStr appendString:[NSString stringWithFormat:@"%@,",courseID]];
//        }
//        
//    }
    
//    NSArray *array = [BLInformationManager sharedInstance].appointmentData;
    
    // 数组排序
    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(YBAppointData *  _Nonnull obj1, YBAppointData *  _Nonnull obj2) {
        return obj1.timeid > obj2.timeid;
    }];
    
    NSLog(@"resultArray:%@",resultArray);
    
    NSMutableString *courselistStr = [NSMutableString string];
    NSString *begingtime = nil;
    NSString *endtime = nil;
    
    for (int i = 0; i<resultArray.count; i++) {
        
        YBAppointData *model = resultArray[i];
        YBAppointData *firstmodel = resultArray.firstObject;
        YBAppointData *lastmodel = resultArray.lastObject;
        
        NSLog(@"firstmodel.begintime:%@ lastmodel.endtime:%@",firstmodel.begintime,lastmodel.endtime);
        begingtime = firstmodel.begintime;
        endtime = lastmodel.endtime;
        
        NSString *courseID = [NSString stringWithFormat:@"%@",model.coursedata._id];
        
        if (resultArray.count==1) {
            
            [courselistStr appendString:[NSString stringWithFormat:@"%@",courseID]];
            
        }else{
            
            if (i==0) {
                
                [courselistStr appendString:[NSString stringWithFormat:@"%@,",courseID]];
                
            }else if (i==resultArray.count-1){
                
                [courselistStr appendString:[NSString stringWithFormat:@"%@",courseID]];
                
            }else{
                
                [courselistStr appendString:[NSString stringWithFormat:@"%@",courseID]];
                
            }
            
        }
        
        
    }
    
    NSLog(@"begintime:%@ endtime:%@",begingtime,endtime);
    
    _startTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:begingtime data:self.selectDateStr]];
    NSLog(@"_startTimeStr:%@",_startTimeStr);
    
    _endTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:endtime data:self.selectDateStr]];
    NSLog(@"_endTimeStr:%@",_endTimeStr);
    
    if (begingtime && endtime) {
        if ([AcountManager manager].userSubject.subjectId.integerValue == 2) {
            self.footView.countLabel.text = [NSString stringWithFormat:@" 科目二 %@-%@",[NSString getHourLocalDateFormateDate:begingtime],[NSString getHourLocalDateFormateDate:endtime]];
        }else if ([AcountManager manager].userSubject.subjectId.integerValue == 3) {
            self.footView.countLabel.text = [NSString stringWithFormat:@" 科目三 %@-%@",[NSString getHourLocalDateFormateDate:begingtime],[NSString getHourLocalDateFormateDate:endtime]];
        }
    }else {
        self.footView.countLabel.text = @"";
    }
    
    WS(ws);
    
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kSameTimeStudent];
    
    NSLog(@"%@",applyUrlString);
    NSDictionary *upData = @{@"coachid"   :self.appointCoach.coachid,
                             @"begintime" :[NSString stringWithFormat:@"%d",[self chagetime:begingtime data:self.selectDateStr]],
                             @"endtime"   :[NSString stringWithFormat:@"%d",[self chagetime:endtime data:self.selectDateStr]],
                             @"index"     :@"1"
                             };
    
    
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:upData WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        DYNSLog(@"同时段学员 applyUrlString:%@ upData:%@ %@",applyUrlString,upData,data);
        
        NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];
        
        if ([type isEqualToString:@"1"]) {
            
            ws.footView.studentArray = nil;

            NSError *error = nil;
            ws.stuDataArray = [[MTLJSONAdapter modelsOfClass:StudentModel.class fromJSONArray:data[@"data"] error:&error] mutableCopy];
            
            if (ws.stuDataArray&&ws.stuDataArray.count!=0) {
                NSLog(@"ws.stuDataArray:%@",ws.stuDataArray);
                for (StudentModel *studentModel in ws.stuDataArray) {
                    NSLog(@"studentModel.userid.name:%@",studentModel.userid.name);
                    if (studentModel.userid.userId && [studentModel.userid.userId length]!=0 && [studentModel.userid.userId isEqualToString:[AcountManager manager].userid]) {
                        [ws.stuDataArray removeObject:studentModel];
                    }
                }
                ws.footView.studentArray = ws.stuDataArray;
            }
           
        }else {
            [self obj_showTotasViewWithMes:[NSString stringWithFormat:@"%@",data[@"msg"]]];
        }
        
    } withFailure:^(id data) {
        kShowFail(@"网络连接失败，请检查网络连接");
    }];
    
    
}

- (NSDictionary *)getParams
{
    
    NSArray *array = [BLInformationManager sharedInstance].appointmentData;
    
    // 数组排序
    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(YBAppointData *  _Nonnull obj1, YBAppointData *  _Nonnull obj2) {
        return obj1.timeid > obj2.timeid;
    }];
    
    NSLog(@"resultArray:%@",resultArray);
 
    NSMutableString *courselistStr = [NSMutableString string];
    NSString *begingtime = nil;
    NSString *endtime = nil;
    
    for (int i = 0; i<resultArray.count; i++) {
        
        YBAppointData *model = resultArray[i];
        YBAppointData *firstmodel = resultArray.firstObject;
        YBAppointData *lastmodel = resultArray.lastObject;
        
        NSLog(@"firstmodel.begintime:%@ lastmodel.endtime:%@",firstmodel.begintime,lastmodel.endtime);
        begingtime = firstmodel.begintime;
        endtime = lastmodel.endtime;
        
        NSString *courseID = [NSString stringWithFormat:@"%@",model.coursedata._id];

        if (resultArray.count==1) {
            
            [courselistStr appendString:[NSString stringWithFormat:@"%@",courseID]];

        }else{
            
            if (i==0) {
                
                [courselistStr appendString:[NSString stringWithFormat:@"%@,",courseID]];
                
            }else if (i==resultArray.count-1){
                
                [courselistStr appendString:[NSString stringWithFormat:@"%@",courseID]];
                
            }else{
                
                [courselistStr appendString:[NSString stringWithFormat:@"%@",courseID]];
                
            }
            
        }
        
        
    }

    NSLog(@"begintime:%@ endtime:%@",begingtime,endtime);

    _startTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:begingtime data:self.selectDateStr]];
    NSLog(@"_startTimeStr:%@",_startTimeStr);
    
    _endTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:endtime data:self.selectDateStr]];
    NSLog(@"_endTimeStr:%@",_endTimeStr);

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = [AcountManager manager].userid;
    params[@"coachid"] = self.appointCoach.coachid;
    params[@"courselist"] = courselistStr;
    params[@"is_shuttle"] = @"1";
    params[@"address"] = @"";
    params[@"begintime"] = [NSString stringWithFormat:@"%@ %@",self.selectDateStr,begingtime];
    params[@"endtime"] = [NSString stringWithFormat:@"%@ %@",self.selectDateStr,endtime];
    
    return params;
    
}

- (void)commitBtnDidClick
{
    NSArray *array = [BLInformationManager sharedInstance].appointmentData;
    if (array&&array.count==0) {
        [self showTotasViewWithMes:@"请选择预约时间"];
        return;
    }
    
    // 获取参数
    NSDictionary *params = [self getParams];
    
    NSLog(@"预约params:%@",params);
   
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
