//
//  YBAppointMentDetailsController.m
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentDetailsController.h"
#import "YBAppointMentDetailsDataModel.h"
#import "DrivingDetailTableHeaderView.h"
#import "DVVToast.h"
#import "DVVCoachDetailHeaderView.h"
#import "ShuttleBusController.h"
#import "HMCourseModel.h"
#import "DrivingDetailViewModel.h"
#import "YBAppointMentDetailsFootView.h"
#import "YBAppointMentDetailsCancleView.h"
#import "YBCancleAppointMentController.h"
#import "ChatViewController.h"

#import "DVVLocation.h"
#import "NSString+Helper.h"
#import "DVVCreateQRCode.h"
#import "DVVToast.h"
#import "YBAppointmentDetailHeaderView.h"
#import "YBAppointmentDetailCell.h"
#import "YBAppointmentCheckSignInTool.h"

//static NSString *infoCellID = @"kInfoCellID";
//static NSString *introductionCellID = @"kIntroductionCellID";
//static NSString *tagCellID = @"kTagCellID";
//static NSString *courseCellID = @"kCourseCellID";

static NSString *kCellIdentifier = @"kCellIdentifier";

@interface YBAppointMentDetailsController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) YBAppointmentDetailHeaderView *headerView;

@property (nonatomic, strong) YBAppointMentDetailsDataModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *shuttleBusButton;

@property (nonatomic, assign) BOOL isShowIntroduction;

@property (nonatomic,strong) YBAppointMentDetailsFootView *footView;
@property (nonatomic,strong) YBAppointMentDetailsCancleView *cancleFootView;

@property (nonatomic, assign) BOOL networkSuccess;

@property (nonatomic,strong) UIView *commentFooter;

@end

@implementation YBAppointMentDetailsController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = NO;
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    self.title = @"预约详情";
    
    [self.view addSubview:self.tableView];
    _tableView.tableHeaderView = self.headerView;
    
    [self configViewModel];

    NSLog(@"self.courseModel.courseStatue:%ld",(long)self.courseModel.courseStatue);
    
    [self.view addSubview:self.footView];
//    if (self.courseModel.courseStatue == KCourseStatueapplyconfirm || self.courseModel.courseStatue == KCourseStatueapplying) {// 预约中,取消预约
//        [self.view addSubview:self.footView];
//    }
//    else if (self.courseModel.courseStatue == KCourseStatueapplyrefuse){// 教练拒绝或者取消->教练取消
//        [self.view addSubview:self.cancleFootView];
//    }
    
}


#pragma mark - action

#pragma mark 聊天
- (void)imButtonAction {
    
    ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:_courseModel.userModel.coachid
                                                                    conversationType:eConversationTypeChat];
    chatController.title = _courseModel.userModel.name;
    [self.navigationController pushViewController:chatController animated:YES];
}


#pragma mark - public

- (void)loadQRCodeWithImageView:(UIImageView *)imageView {
    
    [DVVToast showFromView:self.view OffSetY:-64];
    [DVVLocation reverseGeoCode:^(BMKReverseGeoCodeResult *result, CLLocationCoordinate2D coordinate, NSString *city, NSString *address) {
        
        [DVVToast hideFromView:self.view];
        
        // 用户id
        NSString *userId = [AcountManager manager].userid;
        // 用户名
        NSString *userName = [AcountManager manager].userName;
        // 详细地址
        NSString *locationAddress = result.address;
        // 经纬度
        NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
        // 当前的时间(时间戳)
        NSDate *nowDate = [NSDate date];
        NSString *nowTimeStamp = [NSString stringWithFormat:@"%zi", (long)[nowDate timeIntervalSince1970]];
        
        NSString *reservationId = @"";
        if (![_courseModel.courseId isEmptyString]) {
            reservationId = _courseModel.courseId;
        }
        NSString *coachName = @"";
        if (![_courseModel.userModel.name isEmptyString]) {
            coachName = _courseModel.userModel.name;
        }
        NSString *courseProcessDesc = @"";
        if (![_courseModel.courseprocessdesc isEmptyString]) {
            courseProcessDesc = _courseModel.courseprocessdesc;
        }
        
        NSDictionary *dict = @{ @"studentId": userId,
                                @"studentName": userName,
                                @"reservationId": reservationId,
                                @"createTime": nowTimeStamp,
                                @"locationAddress": locationAddress,
                                @"latitude": latitude,
                                @"longitude": longitude,
                                @"coachName": coachName,
                                @"courseProcessDesc": courseProcessDesc };
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        // 显示二维码
        CGFloat size = 128;
        imageView.image = [DVVCreateQRCode createQRCodeWithContent:string size:size];
        
    } error:^{
        [DVVToast hideFromView:self.view];
        [DVVToast showMessage:@"定位错误"];
    }];
    
}


#pragma mark - config view model
- (void)configViewModel {
    
    __weak typeof(self) ws = self;
    _viewModel = [YBAppointMentDetailsDataModel new];
    _viewModel.appointMentID = _appointMentID;
    
    [_viewModel dvv_setRefreshSuccessBlock:^{
        _networkSuccess = YES;
        [ws.tableView reloadData];
    }];
    [_viewModel dvv_setNilResponseObjectBlock:^{
        [ws obj_showTotasViewWithMes:@"暂无数据"];
    }];
    [_viewModel dvv_setNetworkCallBackBlock:^{
        [DVVToast hide];
    }];
    [_viewModel dvv_setNetworkErrorBlock:^{
        [ws obj_showTotasViewWithMes:@"网络错误"];
    }];
    [_viewModel dvv_networkRequestRefresh];
}

#pragma mark - tableView delegate datasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_viewModel.dmData) {
        return 1;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YBAppointmentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (indexPath.row==0) {// 科目二 第多少课时
        cell.iconImageView.image = [UIImage imageNamed:@"YBAppointMentDetailsinformation"];
        cell.titleLabel.text = _courseModel.courseprocessdesc;
        
    }else if (indexPath.row==1){//
        cell.iconImageView.image = [UIImage imageNamed:@"YBAppointMentDetailstime"];
        
        NSString *MMString = [self getLocalDateFormateUTCDate:_courseModel.courseBeginTime format:@"MM"];
        NSString *ddString = [self getLocalDateFormateUTCDate:_courseModel.courseBeginTime format:@"dd"];
        // 将后台传回的时间转化为HH:mm格式的
        NSString *format = @"HH:mm";
        NSString *beginString = [self getLocalDateFormateUTCDate:_courseModel.courseBeginTime format:format];
        
        NSString *endString = [self getLocalDateFormateUTCDate:_courseModel.courseEndtime format:format];
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%@/%@ %@-%@", MMString, ddString, beginString, endString];
    }else if (indexPath.row==2){// 教练
        cell.iconImageView.image = [UIImage imageNamed:@"YBAppointMentDetailscoach"];
        cell.titleLabel.text = _courseModel.userModel.name;
        
        [cell.button setImage:[UIImage imageNamed:@"YBAppointMentDetailstalk"] forState:UIControlStateNormal];
        [cell.button addTarget:self action:@selector(imButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (indexPath.row==3){// 训练场地
        cell.imageView.image = [UIImage imageNamed:@"YBAppointMentDetailslocation"];
        cell.titleLabel.text = _courseModel.courseTrainInfo.address;
    }
    
    if (indexPath.row == 3) {
        cell.lineImageView.hidden = YES;
    }else {
        cell.lineImageView.hidden = NO;
    }
    
    return cell;
    
}

- (UIView *)commentFooter
{
    if (_commentFooter==nil) {
        
        _commentFooter = [[UIView alloc] init];
        
    }
    return _commentFooter;
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = YBMainViewControlerBackgroundColor;
        _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 56 - 30);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UITableView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YBAppointmentDetailCell class] forCellReuseIdentifier:kCellIdentifier];
        
        UILabel *label = [UILabel new];
        label.text = @"预约开始前24小时内将不能取消预约";
        label.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        label.font = [UIFont systemFontOfSize:10];
        label.frame = CGRectMake(0, CGRectGetMaxY(_tableView.frame), kSystemWide, 30);
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
    return _tableView;
}

- (YBAppointmentDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView =[YBAppointmentDetailHeaderView new];
        
        NSString *statusStr = [_courseModel getStatueString];
        UIImage *image = nil;
        NSString *markStr = nil;
        CGFloat height = _headerView.defaultHeight;
        
        if ([statusStr isEqualToString:@"请求中"]) {
            
            statusStr = @"预约请求中";
            image = [UIImage imageNamed:@"alipy_way"];
            markStr = @"（教练还没有接受预约，请耐心等一下哦）";
            height = 228;
            
        }else if ([statusStr isEqualToString:@"已接收"]) {
            
            statusStr = @"预约已接受";
            if ([YBAppointmentCheckSignInTool checkSignInWithBeginTime:_courseModel.courseBeginTime endTime:_courseModel.courseEndtime]) {
                [self loadQRCodeWithImageView:_headerView.imageView];
                markStr = @"（给教练扫一扫二维码即可签到）";
            }else {
                image = [UIImage imageNamed:@"默认"];
                markStr = @"（还没有到签到时间哦）";
            }
        }
        _headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
        _headerView.statusLabel.text = statusStr;
        _headerView.imageView.image = image;
        _headerView.imageMarkLabel.text = markStr;
    }
    return _headerView;
}

- (YBAppointMentDetailsFootView *)footView
{
    
    WS(ws);
    if (_footView == nil) {
        
        _footView = [[YBAppointMentDetailsFootView alloc] initWithFrame:CGRectMake(0, self.view.height-56-64, self.view.width, 56)];
        _footView.courseModel = _courseModel;
        _footView.didClick = ^{
            NSLog(@"取消预约");
            YBCancleAppointMentController *vc = [[YBCancleAppointMentController alloc] init];
            vc.courseModel = ws.courseModel;
            [ws.navigationController pushViewController:vc animated:YES];
        };
    }
    return _footView;
}

- (YBAppointMentDetailsCancleView *)cancleFootView
{
    if (_cancleFootView == nil) {
        
        _cancleFootView = [[YBAppointMentDetailsCancleView alloc] initWithFrame:CGRectMake(0, self.view.height-80-64, self.view.width, 80)];
        _cancleFootView.courseModel = _courseModel;
    }
    return _cancleFootView;
}


- (NSString *)dateFromLocalWithFormatString:(NSString *)formatString {
    
    NSDate *localDate = [NSDate new];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter stringFromDate:localDate];
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
- (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate format:(NSString *)formatString {
    //    NSLog(@"utc = %@",utcDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:formatString];
    //    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
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
