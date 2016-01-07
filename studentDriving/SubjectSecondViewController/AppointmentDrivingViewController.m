//
//  AppointmentDrivingViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "AppointmentDrivingViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "AppointmentDrivingCell.h"
#import "AppointmentCoachModel.h"
#import "CoachHeadCell.h"
#import "NSString+CurrentTimeDay.h"
#import "AppointmentCoachTimeInfoModel.h"
#import "BLInformationManager.h"
#import "CoachViewController.h"
#import "AppointmentCollectionCell.h"
#import "StudentModel.h"
#import "StudentDetailViewController.h"
#import "AppointmentViewController.h"
#import "ChatSendHelper.h"

#define kSameTimeStudent @"courseinfo/sametimestudentsv2"

static NSString *const kStudentTimeStudy = @"courseinfo/sametimestudents/reservationid/%@/index/%@";
static NSString *const kappointmentCoachUrl = @"userinfo/getusefulcoach/index/1";
static NSString *const kuserUpdateParam = @"courseinfo/userreservationcourse";
//http://101.200.204.240:3000/api/v1/courseinfo/getcoursebycoach?coachid=5616352721ec29041a9af889&date=2015-10-10
//http://101.200.204.240:3000/api/v1/courseinfo/userreservationcourse

static NSString *const kappointmentCoachTimeUrl = @"courseinfo/getcoursebycoach?coachid=%@&date=%@";
@interface AppointmentDrivingViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AppointmentDrivingCellDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UICollectionView *coachHeadCollectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSArray *coachTimeArray;
@property (strong, nonatomic) UIView *bottomTooBar;
@property (strong, nonatomic) UIButton *submitBtn;
@property (strong, nonatomic) AppointmentCoachModel *coachModel;
@property (strong, nonatomic) UIScrollView *menuScrollview;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) NSString *updateTimeString;
@property (strong, nonatomic) UICollectionView *sameTimeStudentCollectionView;
@property (strong, nonatomic) UILabel *studentTitle;
@property (strong, nonatomic) NSArray *stuDataArray;

@property (strong, nonatomic) UIButton *naviBarRightButton;

@property (strong, nonatomic) UILabel *contentLabel ;
@property (strong, nonatomic) UILabel *appointDetailLabel;

@property (assign, nonatomic) BOOL is_AddCoachModel;
@property (strong, nonatomic) UIButton *goBackButton;
@property (nonatomic ,strong) NSString *coachIdStr;
@property (nonatomic ,strong) NSString *startTimeStr;
@property (nonatomic ,strong) NSString *endTimeStr;

@end

@implementation AppointmentDrivingViewController
#pragma mark - 控件

- (UILabel *)appointDetailLabel {
    if (!_appointDetailLabel) {
        _appointDetailLabel = [[UILabel alloc] init];
        _appointDetailLabel.numberOfLines = 2;
        _appointDetailLabel.textColor = TEXTGRAYCOLOR;
        _appointDetailLabel.font = [UIFont systemFontOfSize:14];
        if ([AcountManager manager].userSubject.subjectId.integerValue == 2) {
            NSInteger doneCourse = [AcountManager manager].subjecttwo.finishcourse.integerValue;
            NSInteger appointCourse = [AcountManager manager].subjecttwo.reservation.integerValue;
            NSInteger totalCourse = [AcountManager manager].subjecttwo.totalcourse.integerValue;
            NSInteger restCourse = totalCourse - doneCourse - appointCourse;
            _appointDetailLabel.text = [NSString stringWithFormat:@"您已完成%zd课时，总共预约了%zd课时,科目二的可预约课时剩余%zd课时。",doneCourse,appointCourse,restCourse];
        }else if ([AcountManager manager].userSubject.subjectId.integerValue == 3) {
            NSInteger doneCourse = [AcountManager manager].subjectthree.finishcourse.integerValue;
            NSInteger appointCourse = [AcountManager manager].subjectthree.reservation.integerValue;
            NSInteger totalCourse = [AcountManager manager].subjectthree.totalcourse.integerValue;
            NSInteger restCourse = totalCourse - doneCourse - appointCourse;
            _appointDetailLabel.text = [NSString stringWithFormat:@"您已完成%zd课时，总共预约了%zd课时,科目二的可预约课时剩余%zd课时。",doneCourse,appointCourse,restCourse];
        }
        
    }
    return _appointDetailLabel;
}

- (UIButton *)goBackButton{
    if (_goBackButton == nil) {
        _goBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        //        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回_click"] forState:UIControlStateNormal];
        [_goBackButton addTarget:self action:@selector(dealGoBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBackButton;
}

- (UICollectionView *)sameTimeStudentCollectionView {
    if (_sameTimeStudentCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 10.0f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _sameTimeStudentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 100, kSystemWide-30, 45) collectionViewLayout:flowLayout];
        _sameTimeStudentCollectionView.backgroundColor = [UIColor whiteColor];
        _sameTimeStudentCollectionView.dataSource = self;
        _sameTimeStudentCollectionView.delegate = self;
        _sameTimeStudentCollectionView.showsHorizontalScrollIndicator = NO;
        [_sameTimeStudentCollectionView registerClass:[AppointmentCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _sameTimeStudentCollectionView;
}
- (UILabel *)studentTitle {
    if (_studentTitle == nil) {
        _studentTitle = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _studentTitle.text  = @"同时段学员";
    }
    return _studentTitle;
}
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"更多教练" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 100, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}

- (UIScrollView *)menuScrollview {
    if (_menuScrollview == nil) {
        _menuScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 44)];
    }
    return _menuScrollview;
}
- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}

- (UIView *)bottomTooBar {
    if (_bottomTooBar == nil) {
        _bottomTooBar = [[UIView alloc] init];
        _bottomTooBar.backgroundColor  = [UIColor whiteColor];
        _bottomTooBar.layer.borderColor = TEXTGRAYCOLOR.CGColor;
        _bottomTooBar.layer.borderWidth = 0.5;
    }
    return _bottomTooBar;
}
- (UIButton *)submitBtn {
    if (_submitBtn == nil) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.backgroundColor = MAINCOLOR;
        [_submitBtn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _submitBtn;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)dealGoBack {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 头视图教练
- (UICollectionView *)coachHeadCollectionView {
    if (_coachHeadCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 15;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _coachHeadCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 90) collectionViewLayout:flowLayout];
        _coachHeadCollectionView.backgroundColor = [UIColor whiteColor];
        _coachHeadCollectionView.delegate = self;
        _coachHeadCollectionView.dataSource = self;
        [_coachHeadCollectionView registerClass:[CoachHeadCell class] forCellWithReuseIdentifier:@"collectionCell"];
    }
    return _coachHeadCollectionView;
}
#pragma mark - tableview
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kSystemWide, kSystemHeight-49-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)clickRight:(UIButton *)sender {
    DYNSLog(@"更多教练");
    CoachViewController *coach = [[CoachViewController alloc] init];
    coach.markNum = 2;
    [self.navigationController pushViewController:coach animated:YES];
   
}
#pragma mark - viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _is_AddCoachModel = NO;
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.goBackButton];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kCellChange) name:@"kCellChange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kAddCoachModel) name:@"kAddCoachModel" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我要预约";
    self.automaticallyAdjustsScrollViewInsets = NO;
        if ([UIDevice jeSystemVersion] >= 7.0f) {
            //当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    [self.view addSubview:self.tableView];
    
    [self conformNavItem];
    
   

    
    self.tableView.tableHeaderView = [self tableViewHeadView];
    
    self.tableView.tableFooterView = [self tableViewFootView];
    
//    [self.view addSubview:self.bottomTooBar];
//    
//    [self.bottomTooBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view.mas_left).offset(0);
//        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
//        make.right.mas_equalTo(self.view.mas_right).offset(0);
//        make.height.mas_equalTo(@49);
//        
//    }];
    
    [self.view addSubview:self.submitBtn];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.height.mas_equalTo(@44);
    }];
   
    [self startDownLoadCoach];
}
#pragma mark - NotifacationCenter
- (void)kCellChange {
    NSArray *array = [BLInformationManager sharedInstance].appointmentData;
    
    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(AppointmentCoachTimeInfoModel *  _Nonnull obj1, AppointmentCoachTimeInfoModel *  _Nonnull obj2) {
        //obj1.coursetime.numMark < obj2.coursetime.numMark
        return obj1.coursetime.numMark > obj2.coursetime.numMark ;
    }];
    AppointmentCoachTimeInfoModel *firstModel = resultArray.firstObject;
    AppointmentCoachTimeInfoModel *lastModel = resultArray.lastObject;
    
    NSArray *beginArray = [firstModel.coursetime.begintime componentsSeparatedByString:@":"];
    NSString *beginString = beginArray.firstObject;
    _startTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:beginString data:_updateTimeString]];
    NSArray *endArray = [lastModel.coursetime.endtime componentsSeparatedByString:@":"];
    NSString *endString = endArray.firstObject;
    _endTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:endString data:_updateTimeString]];
    if (beginString && endString) {
        self.contentLabel.text = [NSString stringWithFormat:@"当前预约为科目二的第%@-%@时段",beginString,endString];
    }else {
        self.contentLabel.text = @"";
    }
    
    DYNSLog(@"%@",self.contentLabel.text);
    NSLog(@"%@",self.coachModel.coachid);
    NSLog(@"%@",_endTimeStr);
    NSLog(@"%@",_startTimeStr);
    
    if (_endTimeStr&&_startTimeStr&&self.coachModel.coachid&&_updateTimeString) {
        NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kSameTimeStudent];
        
        NSLog(@"%@",applyUrlString);
        NSDictionary *upData = @{@"coachid"   :self.coachModel.coachid,
                                 @"begintime" :_startTimeStr,
                                 @"endtime"   :_endTimeStr,
                                 @"index"     :@"1"
                                 };
        [JENetwoking startDownLoadWithUrl:applyUrlString postParam:upData WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            DYNSLog(@"param = %@",data[@"msg"]);
            NSDictionary *param = data;
            NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
            if ([type isEqualToString:@"1"]) {
                NSError *error = nil;
                self.stuDataArray = [MTLJSONAdapter modelsOfClass:StudentModel.class fromJSONArray:param[@"data"] error:&error];
                [self.sameTimeStudentCollectionView reloadData];
            }else {
                kShowFail(param[@"msg"]);
            }
        } withFailure:^(id data) {
            kShowFail(@"网络连接失败，请检查网络连接");
        }];
    }
}

- (int)chagetime:(NSString *)timeStr data:(NSString *)dataStr {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //设置格式
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    //将符合格式的字符串转成NSDate对象
    NSDate *date = [df dateFromString:[NSString stringWithFormat:@"%@ %@:00:00",dataStr,timeStr]];
    //计算一个时间和系统当前时间的时间差
    int second = [date timeIntervalSince1970];
    return second;
}
- (void)kAddCoachModel {
    
    if (_is_AddCoachModel == NO) {
        [self.dataArray insertObject:[BLInformationManager sharedInstance].appointmentCoachModel atIndex:0];
        self.is_AddCoachModel = YES;
    }else if (_is_AddCoachModel == YES) {
        [self.dataArray replaceObjectAtIndex:0 withObject:[BLInformationManager sharedInstance].appointmentCoachModel];
    }
    [self.coachHeadCollectionView reloadData];
    
}
#pragma mark -- 导航button
- (void)conformNavItem {
    UIBarButtonItem *navMessegeItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    self.navigationItem.rightBarButtonItems = @[spaceItem,navMessegeItem];
}
#pragma mark -- 开始下载
- (void)startDownLoadCoach {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSString *urlString = [NSString stringWithFormat:BASEURL,kappointmentCoachUrl];
    DYNSLog(@"url = %@",urlString);
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (data) {
            NSDictionary *param = data;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
            if (type.integerValue == 1) {
                NSArray *array = param[@"data"];
                NSError *error = nil;
                [self.dataArray addObjectsFromArray: [MTLJSONAdapter modelsOfClass:AppointmentCoachModel.class fromJSONArray:array error:&error]];
                [self.coachHeadCollectionView reloadData];
            }else {
                kShowFail(msg);
            }
        }
    }];
    
}

- (void)startDownLoad {
    
    NSString *urlString = [NSString stringWithFormat:@"1"];
    
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        if (data) {
            NSDictionary *param = data;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
            if (type.integerValue == 1) {
                NSError *error = nil;
                self.stuDataArray = [MTLJSONAdapter modelsOfClass:StudentModel.class fromJSONArray:param[@"data"] error:&error];
                DYNSLog(@"error = %@",error);
                [self.sameTimeStudentCollectionView reloadData];
            }else {
                kShowFail(msg);
            }
        }
    }];
    
}

#pragma mark -- footview

- (UIView *)tableViewFootView {
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 150)];
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,9, kSystemWide-100, 20)];
    _contentLabel.textColor = TEXTGRAYCOLOR;
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.text = @"";
    [backGroundView addSubview:_contentLabel];
    
    self.appointDetailLabel.frame = CGRectMake(15, 20, kSystemWide-30, 50);
    [backGroundView addSubview:self.appointDetailLabel];
    
    [backGroundView addSubview:self.studentTitle];
    [self.studentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.appointDetailLabel.mas_bottom).offset(0);
    }];
    
    [backGroundView addSubview:self.sameTimeStudentCollectionView];
    
    return backGroundView;
}
#pragma mark -- headview

- (UIView *)tableViewHeadView {
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 90)];
    backGroundView.userInteractionEnabled = YES;
    backGroundView.backgroundColor = [UIColor whiteColor];
    [backGroundView addSubview:self.coachHeadCollectionView];
    return backGroundView;
}

#pragma mark - collectionviewdelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == self.coachHeadCollectionView) {
        return self.dataArray.count;
    }else {
        return self.stuDataArray.count;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.coachHeadCollectionView) {
        static NSString *cellId = @"collectionCell";
        CoachHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        AppointmentCoachModel *coachModel = self.dataArray[indexPath.row];
        
        [cell recevieCoachData:coachModel];
        if (indexPath.row == 0) {
            //        cell.selected = YES;
            self.coachModel = coachModel;
            NSString *dateString = [NSString getDayWithAddCountWithData:0];
            NSString *urlString = [NSString stringWithFormat:kappointmentCoachTimeUrl,coachModel.coachid,dateString];
            NSString *url = [NSString stringWithFormat:BASEURL,urlString];
            [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
                DYNSLog(@"appointment = %@",data);
                
                NSDictionary *param = data;
                DYNSLog(@"msg = %@",param[@"msg"]);
                NSString *type = [NSString stringWithFormat:@"%@",param[@"msg"]];
                if ([type isEqualToString:@"0"]) {
                    [self showTotasViewWithMes:param[@"msg"]];
                }else {
                    NSArray *array = param[@"data"];
                    NSError *error = nil;
                    self.coachTimeArray = [MTLJSONAdapter modelsOfClass:AppointmentCoachTimeInfoModel.class fromJSONArray:array error:&error];
                    DYNSLog(@"error = %@",error);
                    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    
                }
                
            }];
        }
         return cell;
    }else {
        static NSString *cellId = @"cell";
        AppointmentCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        if (!cell) {
            DYNSLog(@"创建错误");
        }
        StudentModel *model = self.stuDataArray[indexPath.row];
        DYNSLog(@"headImage = %@",model.userid.headportrait.originalpic);
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.userid.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
        return cell;

    }
   
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.coachHeadCollectionView) {
        CGSize cellSize = CGSizeMake(kSystemWide*0.8125, 78);
        return cellSize;
    }else {
        CGSize cellSize = CGSizeMake(45, 45);
        return cellSize;
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView == self.coachHeadCollectionView) {
        return UIEdgeInsetsMake(0, 10, 0, 0);
    }else {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DYNSLog(@"click");

    if (collectionView == self.coachHeadCollectionView) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.coachModel = self.dataArray[indexPath.row];
        NSString *dateString = [NSString getDayWithAddCountWithData:0];
        NSString *urlString = [NSString stringWithFormat:kappointmentCoachTimeUrl, self.coachModel.coachid,dateString];
        NSString *url = [NSString stringWithFormat:BASEURL,urlString];
        [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            DYNSLog(@"appointment = %@",data);

            NSDictionary *param = data;
            DYNSLog(@"msg = %@",param[@"msg"]);
            NSString *type = [NSString stringWithFormat:@"%@",param[@"msg"]];
            if ([type isEqualToString:@"0"]) {
                [MBProgressHUD hideHUDForView:self.view animated:NO];
                [self showTotasViewWithMes:param[@"msg"]];
            }else {
                NSArray *array = param[@"data"];
                NSError *error = nil;
                self.coachTimeArray = [MTLJSONAdapter modelsOfClass:AppointmentCoachTimeInfoModel.class fromJSONArray:array error:&error];
                DYNSLog(@"error = %@",error);
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
            
        }];
        
        if (_coachIdStr&&_startTimeStr&&_endTimeStr) {
            [self startDownLoad];
        }
    }else {
        StudentModel *model = self.stuDataArray[indexPath.row];
        StudentDetailViewController *studentDetail = [[StudentDetailViewController alloc] init];
        UserIdModel *userIdModel = model.userid;
        studentDetail.studetnId = userIdModel.userId;
        [self.navigationController pushViewController:studentDetail animated:YES];
    }
}


#pragma mark - tableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 269.0f-44.0f;
    }
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 44)];
        backGroundView.backgroundColor  = [UIColor whiteColor];
        [backGroundView addSubview:self.menuScrollview];
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 1)];
        upLine.backgroundColor = RGBColor(221, 221, 221);
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43, kSystemWide, 1)];
        downLine.backgroundColor = RGBColor(221, 221, 221);
        [backGroundView addSubview:upLine];
        [backGroundView addSubview:downLine];
        [self createButtonWith:backGroundView];
        return backGroundView;
    }
    
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0  ) {
        static NSString *cellId = @"cell";
        AppointmentDrivingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AppointmentDrivingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.delegate = self;
        }
        DYNSLog(@"self.coachTimeArray = %ld",self.coachTimeArray.count);
        [cell receiveCoachTimeData:self.coachTimeArray];
        return cell;
    }else {
        static NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = @"接送地址";
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        
        cell.detailTextLabel.text = [AcountManager manager].userAddress;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
        rightView.image = [UIImage imageNamed:@"地点.png"];
        cell.accessoryView = rightView;
        return cell;
    }
    return nil;
}
#pragma mark -- 日历button
- (void)createButtonWith:(UIView *)backGroundView{
    
    for (NSUInteger i = 0; i<30; i++) {
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = CGRectMake(15+(65+15)*i, 44/2-28/2, 65, 28);
        [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [b setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [b setTitle:[NSString getDayWithAddCountWithDisplay:i] forState:UIControlStateNormal];
        b.titleLabel.font = [UIFont systemFontOfSize:12];
        b.tag = 100 +i;
        b.layer.cornerRadius = 2;
        [b addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            b.selected = YES;
            b.backgroundColor = MAINCOLOR;
            self.updateTimeString = [NSString getDayWithAddCountWithData:0];
        }
        [self.buttonArray addObject:b];
        [self.menuScrollview addSubview:b];
    }
    self.menuScrollview.contentSize = CGSizeMake((65+15)*30, 44);
}

#pragma mark -- 日历按钮点击
- (void)clickButton:(UIButton *)sender {
    NSUInteger index = sender.tag - 100;
    for (UIButton  *b in self.buttonArray) {
        b.selected = NO;
        b.backgroundColor = [UIColor whiteColor];
    }
    sender.backgroundColor = MAINCOLOR;
    sender.selected = YES;
    
    [self calendarClick:[NSString getDayWithAddCountWithData:index]];
    self.updateTimeString = [NSString getDayWithAddCountWithData:index];
    
}


#pragma mark - AppointmentDrivingCellDelegate
- (void)calendarClick:(NSString *)dateString {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlString = [NSString stringWithFormat:kappointmentCoachTimeUrl,self.coachModel.coachid,dateString];
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {

        NSDictionary *param = data;
        NSArray *array = param[@"data"];
        NSError *error = nil;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];

        if (type.integerValue == 1) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.coachTimeArray = [MTLJSONAdapter modelsOfClass:AppointmentCoachTimeInfoModel.class fromJSONArray:array error:&error];

            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.coachTimeArray = nil;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            kShowFail(msg);
        }
        
    }];
}

- (void)submitClick:(UIButton *)sender {
    NSArray *array = [BLInformationManager sharedInstance].appointmentData;
    
    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(AppointmentCoachTimeInfoModel *  _Nonnull obj1, AppointmentCoachTimeInfoModel *  _Nonnull obj2) {
       //obj1.coursetime.numMark < obj2.coursetime.numMark
        return obj1.coursetime.numMark > obj2.coursetime.numMark ;
    }];
   
    DYNSLog(@"submit = %@",resultArray);
    AppointmentCoachTimeInfoModel *firstModel = resultArray.firstObject;
    DYNSLog(@"startTime = %@",firstModel.coursetime.begintime);

    NSString *updateBeginTime = [NSString stringWithFormat:@"%@ %@",self.updateTimeString,firstModel.coursetime.begintime];
    DYNSLog(@"startTime = %@",updateBeginTime);
    
    AppointmentCoachTimeInfoModel *lastModel = resultArray.lastObject;
    NSString *updateEndTime = [NSString stringWithFormat:@"%@ %@",self.updateTimeString,lastModel.coursetime.endtime];
    DYNSLog(@"updateEndTime = %@",updateEndTime);

    NSString *userid = [AcountManager manager].userid;
    
    NSString *coachid = self.coachModel.coachid;
    
    NSString *is_shuttle = [NSString stringWithFormat:@"%d",self.coachModel.is_shuttle];
    
    NSString *address = @"";
    if ([AcountManager manager].userAddress) {
        address = [AcountManager manager].userAddress;
    }
    
    NSMutableString *courselistString = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i<resultArray.count; i++) {
        AppointmentCoachTimeInfoModel *model = resultArray[i];
        if (i==0) {
        [courselistString appendString:[NSString stringWithFormat:@"%@",model.infoId]];
        }else {
        [courselistString appendString:[NSString stringWithFormat:@",%@",model.infoId]];
        }
    }
    
    /*
     {
     "userid": "560539bea694336c25c3acb9",
     "coachid": "5616352721ec29041a9af889",
     "courselist": "5616352721ec29041a9af889,5616352721ec29041a9af889",
     "is_shuttle": 1,
     "address": "北京市",
     "begintime": "2015-09-15 10:00:00",
     "endtime": "2015-09-15 12:00:00"
     }
     */
    if (userid&&coachid&&courselistString&&is_shuttle&&address&&updateBeginTime&&updateEndTime) {
        NSDictionary *param = @{@"userid":userid,@"coachid":coachid,@"courselist":courselistString,@"is_shuttle":is_shuttle,@"address":address,@"begintime":updateBeginTime,@"endtime":updateEndTime};
        DYNSLog(@"param = %@",param);
        NSString *urlString = [NSString stringWithFormat:BASEURL,kuserUpdateParam];
        
        [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            NSDictionary *param = data;
            DYNSLog(@"param = %@",param[@"msg"]);
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
            if (type.integerValue == 1) {
                [self showTotasViewWithMes:@"预约成功"];
                
                NSString *userName = [AcountManager manager].userName;
                NSString *yearFormatString = @"yyyy";
                NSString *monthFormatString = @"MM";
                NSString *dayFormatString = @"dd";
                NSString *year = [self dateFromLocalWithFormatString:yearFormatString];
                NSString *month = [self dateFromLocalWithFormatString:monthFormatString];
                NSString *day = [self dateFromLocalWithFormatString:dayFormatString];
                
                NSString *content = [NSString stringWithFormat:@"%@学员,于%@年%@月%@日预约了您的课程,请查看!", userName, year, month, day];
                
                // 预约成功后，通过环信给教练发送一条提示消息
                EMMessage *message = [ChatSendHelper sendTextMessageWithString:content toUsername:self.coachModel.coachid isChatGroup:NO requireEncryption:NO ext:nil];
                
                [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil prepare:^(EMMessage *message, EMError *error) {
                    
                    
                } onQueue:nil completion:^(EMMessage *message, EMError *error) {
                    
                    if(!error){
                        
                    }
                    
                } onQueue:nil];
                
                
                AppointmentViewController *vc = [[AppointmentViewController alloc] init];
                vc.markNum = @2;
                vc.title = @"预约列表";
                [self.navigationController pushViewController:vc animated:YES];
                
            }else {
                kShowFail(msg)
            }
            
        }];
    }else {
        [self showTotasViewWithMes:@"教练信息或日期不全！"];
    }
    
    
    
    
}

- (NSString *)dateFromLocalWithFormatString:(NSString *)formatString {
    
    NSDate *localDate = [NSDate new];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter stringFromDate:localDate];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
