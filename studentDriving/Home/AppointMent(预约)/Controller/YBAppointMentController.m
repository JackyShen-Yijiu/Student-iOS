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
#import "CourseSummaryDayCell.h"
#import "AppointmentCoachTimeInfoModel.h"
#import "BaseModelMethod.h"
#import "YBAppotinMentHeadView.h"
#import "YBForceEvaluateViewController.h"
#import "AppDelegate.h"
#import "RatingBar.h"
#import "APWaitEvaluationViewController.h"
#import "MyAppointmentModel.h"
#import "AppointmentViewController.h"
#import "APCommentViewController.h"
#import "MJRefresh.h"
#import "NSUserStoreTool.h"
#import "YBObjectTool.h"
#import "YBAppointMentDetailsController.h"
#import "WMCommon.h"
#import "YBActivity.h"

#import "YBUserCenterController.h"

@interface YBAppointMentController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView*navBarHairlineImageView;
    
}
@property (nonatomic,strong) YBAppointMentNoCountentView *noCountmentView;

// 底部tableview
@property(nonatomic,strong) UITableView * courseDayTableView;

@property(nonatomic,strong) NSMutableArray * courseCurDayTableData;
@property(nonatomic,strong) NSMutableArray * courseTomDayTableData;
@property(nonatomic,strong) NSMutableArray * courseYesDayTableData;

@property(nonatomic,strong) NSDateFormatter *dateFormattor;

@property (nonatomic,strong) YBAppotinMentHeadView *appointMentHeadView;

@property (nonatomic,strong) YBForceEvaluateViewController *feVc;

@property (nonatomic,strong) NSArray *commentListArray;

@property (nonatomic,assign) NSInteger number;// 科目几
@end

@implementation YBAppointMentController

- (NSMutableArray *)courseCurDayTableData
{
    if (_courseCurDayTableData==nil) {
        _courseCurDayTableData = [NSMutableArray array];
    }
    return _courseCurDayTableData;
}
- (NSMutableArray *)courseTomDayTableData
{
    if (_courseTomDayTableData==nil) {
        _courseTomDayTableData = [NSMutableArray array];
    }
    return _courseTomDayTableData;
}
- (NSMutableArray *)courseYesDayTableData
{
    if (_courseYesDayTableData==nil) {
        _courseYesDayTableData = [NSMutableArray array];
    }
    return _courseYesDayTableData;
}

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
            if (model && model.userid && [model.userid length]!=0 && ![model.userid isEqualToString:@"(null)"]) {
                [ws commitComment:ws.feVc.reasonTextView.text star:ws.feVc.starBar.rating model:model];
            }
            
        };
        
    }
    return _feVc;
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
        _noCountmentView.hidden = YES;
    }
    return _noCountmentView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [YBActivity  checkActivity];
    
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
   
    // 检测是否打开登录页
    if (![AcountManager isLogin]) {
//        [DVVUserManager loginController].hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:[DVVUserManager loginController] animated:NO];
//        [self.navigationController presentViewController:[DVVUserManager loginController] animated:YES completion:nil];
        [DVVUserManager userNeedLogin];
        return;
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 获取尚未评价的订单
    [self loadCommentList];
    
    [self addLoadSubjectProress];
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
//    navBarHairlineImageView.hidden=NO;
    
    [self.feVc.view removeFromSuperview];
    
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
    
    NSLog(@"%s,[AcountManager manager].userSubject.name:%@",__func__,[AcountManager manager].userSubject.name);
    
    // 设置顶部标题
    self.navigationItem.title = @"预约列表";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"YBSlideBarAppointMentBtnImg"] style:UIBarButtonItemStyleDone target:self action:@selector(addAppointMent)];
    
    [self initUI];
    
    // 加载底部预约列表数据
    [self setUpRefresh];
    
    // 没有内容，占位图
     [self.view addSubview:self.noCountmentView];

    // 接收到预约消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLoadSubjectProress) name:@"kuserapplysuccess" object:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        YBUserCenterController *vc = [YBUserCenterController new];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    });
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initUI
{
    
    // 底部预约列表
    self.courseDayTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-64) style:UITableViewStylePlain];
    self.courseDayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.courseDayTableView.delegate = self;
    self.courseDayTableView.dataSource = self;
    self.courseDayTableView.backgroundColor = RGBColor(238, 238, 238);
    self.courseDayTableView.tableHeaderView = self.appointMentHeadView;
    [self.view addSubview:self.courseDayTableView];
  
}

- (void)addAppointMent
{
    YBAppointMentChangeCoachController *vc = [[YBAppointMentChangeCoachController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setUpRefresh
{
    __weak typeof(self) ws = self;
    // 刷新
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
       [ws loadFootListData];
        
    }];
    
    self.courseDayTableView.mj_header = refreshHeader;
    
}

- (void)loadCommentList
{
    
    NSString *appointmentUrl = [NSString stringWithFormat:kappointmentUrl,[AcountManager manager].userid,(long)self.number];
    
    NSString *downLoadUrl = [NSString stringWithFormat:BASEURL,appointmentUrl];
    DYNSLog(@"url = %@ %@",[AcountManager manager].userid,[AcountManager manager].userToken);
    
    __weak typeof (self) ws = self;
    [JENetwoking startDownLoadWithUrl:downLoadUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSArray *commentListArray = param[@"data"];
        
        if (type.integerValue == 1 && commentListArray && commentListArray.count>0) {
            
            ws.commentListArray = commentListArray;
            
            // 强制评价
            [ws.tabBarController.view insertSubview:ws.feVc.view aboveSubview:((AppDelegate *)[UIApplication sharedApplication].delegate).window];
            
            NSError *error;
            MyAppointmentModel *model = [MTLJSONAdapter modelsOfClass:MyAppointmentModel.class fromJSONArray:ws.commentListArray error:&error].firstObject;

            ws.feVc.iconURL = model.coachid.headportrait.originalpic;
            
        }
    }];
    
}

- (void)commitComment:(NSString *)comment star:(CGFloat)star model:(MyAppointmentModel *)model{
    
    NSLog(@"[AcountManager manager].userid:%@",[AcountManager manager].userid);
    NSLog(@"model.infoId:%@",model.infoId);
    
    if ([AcountManager manager].userid==nil && model.infoId == nil) {
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kuserCommentAppointment];
    
    NSDictionary *param = @{@"userid":[AcountManager manager].userid,
                            @"reservationid":model.infoId,
                            @"starlevel":[NSString stringWithFormat:@"%f",star],// 总体评论星级
                            @"abilitylevel":@"0",// 能力
                            @"timelevel":@"0",// 时间
                            @"attitudelevel":@"0",// 态度
                            @"hygienelevel":@"0",// 卫生
                            @"commentcontent":comment};
    NSLog(@"param:%@",param);
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        DYNSLog(@"%s data = %@",__func__,data);
        
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
        
        if (type.integerValue == 1) {
            [self obj_showTotasViewWithMes:@"评论成功"];
            [self.feVc.view removeFromSuperview];
        }else{
            [self obj_showTotasViewWithMes:msg];
        }
    }];
    
}

- (void)loadFootListData
{
    
    NSString *  userId = [AcountManager manager].userid;
    if (userId==nil) {
        _noCountmentView.hidden = NO;
        return;
    }
    
    WS(ws);
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,KAppointgetmyreservation];

    NSString *  userid = [AcountManager manager].userid;
    
    NSDictionary * dic = @{
                           @"subjectid":[NSString stringWithFormat:@"%ld",(long)self.number],
                           @"userid":userid,
                           @"reservationstate":@"0"
                           };
   
    [JENetwoking startDownLoadWithUrl:urlString postParam:dic WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        [ws.courseDayTableView.mj_header endRefreshing];
        
        [ws.courseCurDayTableData removeAllObjects];
        [ws.courseTomDayTableData removeAllObjects];
        [ws.courseYesDayTableData removeAllObjects];
        
        NSLog(@"loadFootListData dic:%@ data:%@",dic,data);
        /*
         
         
         {
         "_id": "56934a48e6b6a92c09a54d38",
         "coachid": {
             "coachid": "5666365ef14c20d07ffa6ae8",
             "_id": "5666365ef14c20d07ffa6ae8",
             "name": "Jacky ",
             "headportrait": {
             "originalpic": "http://7xnjg0.com1.z0.glb.clouddn.com/5666365ef14c20d07ffa6ae81455620521999",
             "thumbnailpic": "",
             "width": "",
             "height": ""
         },
         "driveschoolinfo": {
             "name": "一步互联网驾校",
             "id": "562dcc3ccb90f25c3bde40da"
         },
         "Gender": "男"
         },
         "reservationstate": 10,
         "reservationcreatetime": "2016-01-11T06:23:04.848Z",
         "subject": {
         "subjectid": 3,
         "name": "科目三"
         },
         "shuttleaddress": "上海",
         "courseprocessdesc": "科目三第15,16课时",
         "classdatetimedesc": "2016年01月11日 18:00--20:00",
         "trainfieldlinfo": {
             "id": "561636cc21ec29041a9af88e",
             "name": "一步驾校第一训练场"
         },
         "begintime": "2016-01-11T10:00:00.000Z",
         "endtime": "2016-01-11T12:00:00.000Z"
         
         // 取消原因
         coureCancleresone
         
         },
         
         
         */
        NSInteger type = [[data objectForKey:@"type"] integerValue];
        
        NSArray *array = [data objectArrayForKey:@"data"];
        
        NSString *message = [data objectForKey:@"msg"];
        
        if (type == 1) {
            
            NSArray *tempArray = [[BaseModelMethod getCourseListArrayFormDicInfo:array] mutableCopy];
            
            [self.noCountmentView setHidden:tempArray.count];
            
            for (HMCourseModel *model in tempArray) {
                NSLog(@"model.courseBeginTime:%@",model.courseBeginTime);
                NSLog(@"getYearLocalDateFormateUTCDate model.courseBeginTime:%@",[NSString getYearLocalDateFormateUTCDate:model.courseBeginTime]);
                
                int compareDataNum = [YBObjectTool compareDateWithSelectDateStr:[NSString getYearLocalDateFormateUTCDate:model.courseBeginTime]];
                NSLog(@"[NSString getYearLocalDateFormateUTCDate:model.courseBeginTime]:%@ compareDataNum:%d",[NSString getYearLocalDateFormateUTCDate:model.courseBeginTime],compareDataNum);
                
                if (compareDataNum==0) {// 当前
                    [self.courseCurDayTableData addObject:model];
                }else if (compareDataNum==1){// 大于当前日期
                    [self.courseTomDayTableData addObject:model];
                }else if (compareDataNum==-1){// 小于当前日期
                    [self.courseYesDayTableData addObject:model];
                }
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [ws.courseDayTableView reloadData];
            });
            
        }else{
            
            [ws obj_showTotasViewWithMes:message];
            
        }
        
    }withFailure:^(id data) {
        
        [ws.courseDayTableView.mj_header endRefreshing];

    }];
    
}

- (void)addLoadSubjectProress
{
    if (![AcountManager isLogin]) {
        return;
    }
    
    self.number = [[AcountManager manager].userSubject.subjectId integerValue];
    [self.courseDayTableView.mj_header beginRefreshing];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        return 0;
        
    }else if (section==1){
        
        if (self.courseTomDayTableData&&self.courseTomDayTableData.count>0) {
            return 30;
        }else{
            return 0;
        }
        
    }else if (section==2){
        
        if (self.courseYesDayTableData&&self.courseYesDayTableData.count>0) {
            return 30;
        }else{
            return 0;
        }
        
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 3;
}

#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.courseCurDayTableData.count;
    }else if (section==1){
        return self.courseTomDayTableData.count;
    }else{
        return self.courseYesDayTableData.count;
    }
    
    NSInteger count = 0;
    count =  self.courseCurDayTableData.count+self.courseTomDayTableData.count+self.courseYesDayTableData.count;
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
    
    if (indexPath.section==0) {
        
        if (indexPath.row < self.courseCurDayTableData.count)
            [dayCell setModel:self.courseCurDayTableData[indexPath.row]];
    
    }else if (indexPath.section==1){
        
        if (indexPath.row < self.courseTomDayTableData.count)
            [dayCell setModel:self.courseTomDayTableData[indexPath.row]];
        
    }else{
        
        if (indexPath.row < self.courseYesDayTableData.count)
            [dayCell setModel:self.courseYesDayTableData[indexPath.row]];
    
    }

    return dayCell;
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    // 退出侧边栏
    if ([WMCommon getInstance].homeState==kStateMenu) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KhiddenSlide object:self];
        return;
    }
    
    HMCourseModel  * courseModel = nil;
    
    if (indexPath.section==0) {
        
        if (indexPath.row < self.courseCurDayTableData.count)
            courseModel = self.courseCurDayTableData[indexPath.row];
        
    }else if (indexPath.section==1){
        
        if (indexPath.row < self.courseTomDayTableData.count)
            courseModel = self.courseTomDayTableData[indexPath.row];
        
    }else{
        
        if (indexPath.row < self.courseYesDayTableData.count)
            courseModel = self.courseYesDayTableData[indexPath.row];
        
    }
    
    if (courseModel) {
       
        NSLog(@"courseModel.courseId:%@",courseModel.userModel.coachid);
        
        YBAppointMentDetailsController *vc = [[YBAppointMentDetailsController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.appointMentID = courseModel.courseId;
        vc.courseModel = courseModel;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
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
