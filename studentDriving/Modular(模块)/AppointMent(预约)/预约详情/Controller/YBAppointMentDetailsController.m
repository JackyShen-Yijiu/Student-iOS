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
#import "YBAppointmentTool.h"
#import "NSString+Helper.h"

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

@property (nonatomic, strong) UILabel *promptLabel;

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
    [self.view addSubview:self.footView];
    _tableView.tableHeaderView = self.headerView;
    
    [self configViewModel];

    NSLog(@"self.courseModel.courseStatue:%ld",(long)self.courseModel.courseStatue);
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
        NSLog(@"dict: %@  string: %@", dict, string);
        // 显示二维码
        CGFloat size = 148;
        imageView.contentMode = UIViewContentModeCenter;
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
        
        if ([[_courseModel getStatueString] isEqualToString:@"教练取消"]) {
            [ws loadCancelReason];
        }
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

- (void)loadCancelReason {
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *splitView = [UIView new];
    splitView.backgroundColor = YBMainViewControlerBackgroundColor;
    
    UILabel *titleLabel = [UILabel new];
    
    titleLabel.text = @"取消原因";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
    contentLabel.text = [NSString stringWithFormat:@"%@  %@", _viewModel.dmData.cancelreason.reason, _viewModel.dmData.cancelreason.cancelcontent];
    
    splitView.frame = CGRectMake(0, 0, kSystemWide, 10);
    titleLabel.frame = CGRectMake(16, 10, kSystemWide - 16*2, 44);
    lineView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame) - 0.5, kSystemWide, 0.5);
    CGFloat contentLabelHeight = [NSString autoHeightWithString:contentLabel.text width:kSystemWide - 16*2 font:[UIFont systemFontOfSize:14]];
    contentLabel.frame = CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 15, kSystemWide - 16*2, contentLabelHeight);
    
    contentView.frame = CGRectMake(0, 0, kSystemWide, CGRectGetMaxY(contentLabel.frame) + 15);
    
    [contentView addSubview:splitView];
    [contentView addSubview:titleLabel];
    [contentView addSubview:lineView];
    [contentView addSubview:contentLabel];
    
    self.tableView.tableFooterView = contentView;
}

#pragma mark - tableView delegate datasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_viewModel.dmData) {
        return 1;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel.dmData.sigintime.length) {
        return 5;
    }
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
    }
    
    if (_viewModel.dmData.sigintime.length) {
        
        if (indexPath.row==2) {
            cell.iconImageView.image = [UIImage imageNamed:@"YBAppointMentDetailstime"];
            cell.titleLabel.text = [NSString stringWithFormat:@"签到时间 %@", [self getLocalDateFormateUTCDate:_viewModel.dmData.sigintime format:@"HH:mm"]];
        }
        if (indexPath.row==3){// 教练
            cell.iconImageView.image = [UIImage imageNamed:@"YBAppointMentDetailscoach"];
            cell.titleLabel.text = _courseModel.userModel.name;
            
            [cell.button setImage:[UIImage imageNamed:@"YBAppointMentDetailstalk"] forState:UIControlStateNormal];
            [cell.button addTarget:self action:@selector(imButtonAction) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (indexPath.row==4){// 训练场地
            cell.imageView.image = [UIImage imageNamed:@"YBAppointMentDetailslocation"];
            cell.titleLabel.text = _courseModel.courseTrainInfo.address;
        }
        
    }else {
        if (indexPath.row==2){// 教练
            cell.iconImageView.image = [UIImage imageNamed:@"YBAppointMentDetailscoach"];
            cell.titleLabel.text = _courseModel.userModel.name;
            
            [cell.button setImage:[UIImage imageNamed:@"YBAppointMentDetailstalk"] forState:UIControlStateNormal];
            [cell.button addTarget:self action:@selector(imButtonAction) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (indexPath.row==3){// 训练场地
            cell.imageView.image = [UIImage imageNamed:@"YBAppointMentDetailslocation"];
            cell.titleLabel.text = _courseModel.courseTrainInfo.address;
        }
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
        
        _promptLabel = [UILabel new];
        _promptLabel.text = @"预约开始前24小时内将不能取消预约";
        _promptLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _promptLabel.font = [UIFont systemFontOfSize:10];
        _promptLabel.frame = CGRectMake(0, CGRectGetMaxY(_tableView.frame), kSystemWide, 30);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_promptLabel];
    }
    return _tableView;
}

- (YBAppointmentDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView =[YBAppointmentDetailHeaderView new];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        // 状态
        NSString *statusStr = [_courseModel getStatueString];
        // 显示的图片
        UIImage *image = nil;
        // 根据不同的状态，显示不同的提示信息
        NSString *markStr = nil;
        // 是否显示签到提示信息
        BOOL showSigninText = NO;
        // 是否可以签到
        BOOL canSignin = NO;
        
        if ([statusStr isEqualToString:@"请求中"]) {
            
            statusStr = @"预约请求中";
            image = [UIImage imageNamed:@"hold"];
            markStr = @"教练还没有接受预约，请耐心等一下哦";
            
        }else if ([statusStr isEqualToString:@"已接受"]) {
            
            statusStr = @"预约已接受";
            showSigninText = YES;
            if ([YBAppointmentTool checkSignInWithBeginTime:_courseModel.courseBeginTime endTime:_courseModel.courseEndtime]) {
                [self loadQRCodeWithImageView:_headerView.imageView];
                markStr = @"（给教练扫一扫二维码即可签到）";
                canSignin = YES;
            }else {
                image = [UIImage imageNamed:@"wait"];
                markStr = @"还没有到签到时间哦";
            }
        }else if ([statusStr isEqualToString:@"已漏课"]) {
            
            statusStr = @"该预约漏课";
            image = [UIImage imageNamed:@"omit"];
            markStr = @"您没能及时签到该预约，请及时联系客服进行补课事宜。";
            
            // 隐藏取消预约按钮和提示文字
            [self hideBottomInfo];
            
            // 添加联系客服按钮
            [self addContactUs];
            self.tableView.frame = CGRectMake(0, 0, kSystemWide, kSystemHeight - 64 - 56 - 12);
            
        }else if ([statusStr isEqualToString:@"_markLabel"]) {
            
            statusStr = @"预约已签到";
            image = [UIImage imageNamed:@"order_indent"];
            markStr = @"该预约已签到";
            showSigninText = YES;
            
            // 隐藏取消预约按钮和提示文字
            [self hideBottomInfo];
            
        }else if ([statusStr isEqualToString:@"教练取消"]) {
            
            statusStr = @"预约被拒绝";
            image = [UIImage imageNamed:@"order_fail"];
            markStr = @"";
            
        }else if ([statusStr isEqualToString:@"学员取消"]) {
            
            statusStr = @"已取消";
            image = [UIImage imageNamed:@"order_cancel"];
            markStr = @"您取消了订单，请重新预约吧";
            
            // 隐藏取消预约按钮和提示文字
            [self hideBottomInfo];
            
        }else if ([statusStr isEqualToString:@"系统取消"]) {
            
            statusStr = @"预约被取消";
            image = [UIImage imageNamed:@"order_cancel"];
            markStr = @"抱歉，由于驾校或其他原因，该预约已被系统取消，您可以重新预约";
            
            // 隐藏取消预约按钮和提示文字
            [self hideBottomInfo];
            
        }else if ([statusStr isEqualToString:@"已签到"]) {
            
            statusStr = @"该预约已签到";
            image = [UIImage imageNamed:@"order_indent"];
            markStr = @"该预约已签到";
            
            showSigninText = YES;
            
            // 隐藏取消预约按钮和提示文字
            [self hideBottomInfo];
        }
        
        // 测试图片状态提示语的高度
        CGFloat imageMarkHeight = [NSString autoHeightWithString:markStr width:screenWidth - 48*2 font:[UIFont systemFontOfSize:14]];
        
        // 使用（masonry更新约束没成功）所以就这样写了
        _headerView.imageMarkLabel.frame = CGRectMake(48, 222, screenWidth - 48*2, imageMarkHeight);
        _headerView.markLabel.frame = CGRectMake(16, 222+imageMarkHeight+12, screenWidth - 16*2, _headerView.siginTextHeight);
        
        CGFloat height = 222 + imageMarkHeight + 12 + 16;
        _headerView.markLabel.hidden = YES;
        if (showSigninText) {
            height += _headerView.siginTextHeight;
            _headerView.markLabel.hidden = NO;
        }
        
        _headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
        _headerView.statusLabel.text = statusStr;
        // 如果不可以签到才设置状态图片
        if (!canSignin) {
            _headerView.imageView.image = image;
        }
        _headerView.imageMarkLabel.text = markStr;
        
        UIView *splitView = [UIView new];
        splitView.backgroundColor = YBMainViewControlerBackgroundColor;
        splitView.frame = CGRectMake(0, CGRectGetHeight(_headerView.frame), kSystemWide, 10);
        [_headerView addSubview:splitView];
        CGRect rect = _headerView.frame;
        rect.size.height += 10;
        _headerView.frame = rect;
    }
    return _headerView;
}

- (void)hideBottomInfo {
    
    _promptLabel.hidden = YES;
    self.footView.hidden = YES;
    self.tableView.frame = CGRectMake(0, 0, kSystemWide, kSystemHeight - 64);
}

- (void)addContactUs {
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(16, kSystemHeight - 64 - 56, kSystemWide - 16*2, 44)];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 4;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"联系客服" forState:UIControlStateNormal];
    [button setTitle:@"联系客服" forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(ContactUsButtonAction) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = YBNavigationBarBgColor;
    [self.view addSubview:button];
}

- (void)ContactUsButtonAction {
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4001016669"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:callWebview];
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
