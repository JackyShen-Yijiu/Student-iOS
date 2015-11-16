//
//  CoachViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/8.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "SignUpCoachViewController.h"
#import "CoachTableViewCell.h"
#import "SignUpCoachDetailViewController.h"
#import "ToolHeader.h"
#import <Masonry.h>
#import "UIView+CalculateUIView.h"
#import <BaiduMapAPI/BMKLocationService.h>
#import <SVProgressHUD.h>
#import "CoachModel.h"
#import "SignUpInfoManager.h"
#import "CoachDetailAppointmentViewController.h"
#import "BLPFAlertView.h"
#import "LoginViewController.h"
#define StartOffset  kSystemWide/4-60/2

static NSString *const kCoachUrl = @"userinfo/nearbycoach?%@";

static NSString *const kGetSchoolUrl = @"getschoolcoach/%@/1";

@interface SignUpCoachViewController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate,JENetwokingDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *menuIndicator;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) BMKLocationService *locationService;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) CoachModel *detailModel;

@end
@implementation SignUpCoachViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UIView *)menuIndicator {
    if (_menuIndicator == nil) {
        _menuIndicator = [[UIView alloc] initWithFrame:CGRectMake(kSystemWide/4-60/2,40-2, 60, 2)];
        _menuIndicator.backgroundColor = MAINCOLOR;
    }
    return _menuIndicator;
}
- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil ) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40, kSystemWide, kSystemHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.hidden = YES;
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (void)clickRight:(UIButton *)sender {
    
    if (![AcountManager isLogin]) {
        DYNSLog(@"islogin = %d",[AcountManager isLogin]);
        LoginViewController *login = [[LoginViewController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
        return;
    }
    if (![[AcountManager manager].userApplystate isEqualToString:@"0"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    DYNSLog(@"countId = %@",[AcountManager manager].applycoach.infoId);
    
    if (![AcountManager manager].applyschool.infoId) {
        if (self.detailModel || self.detailModel.name) {
            NSDictionary *coachParam = @{kRealCoachid:self.detailModel.coachid,@"name":self.detailModel.name};
            [SignUpInfoManager signUpInfoSaveRealCoach:coachParam];
            
        }
        if (self.detailModel.driveschoolinfo.driveSchoolId && self.detailModel.driveschoolinfo.name) {
            DYNSLog(@"schoolinfo");
            NSDictionary *schoolParam = @{kRealSchoolid:self.detailModel.driveschoolinfo.driveSchoolId,@"name":self.detailModel.driveschoolinfo.name};
            [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
        }
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if ([AcountManager manager].applyschool.infoId) {
        if (self.detailModel || self.detailModel.name) {
            NSDictionary *coachParam = @{kRealCoachid:self.detailModel.coachid,@"name":self.detailModel.name};
            [SignUpInfoManager signUpInfoSaveRealCoach:coachParam];
        }
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if ([[AcountManager manager].applyschool.infoId isEqualToString:self.detailModel.driveschoolinfo.driveSchoolId]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if (![[AcountManager manager].applyschool.infoId isEqualToString:self.detailModel.driveschoolinfo.driveSchoolId]) {
        [BLPFAlertView showAlertWithTitle:@"提示" message:@"您已经选择了教练和班型更换驾校后您可能重新做出选择" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
            DYNSLog(@"index = %ld",selectedOtherButtonIndex);
            NSUInteger index = selectedOtherButtonIndex + 1;
            if (index == 0) {
                return ;
            }else if (index == 1) {
                if (self.detailModel || self.detailModel.name) {
                    NSDictionary *coachParam = @{kRealCoachid:self.detailModel.coachid,@"name":self.detailModel.name};
                    [SignUpInfoManager signUpInfoSaveRealCoach:coachParam];
                    
                }
                if (self.detailModel.driveschoolinfo.driveSchoolId && self.detailModel.driveschoolinfo.name) {
                    DYNSLog(@"schoolinfo");
                    NSDictionary *schoolParam = @{kRealSchoolid:self.detailModel.driveschoolinfo.driveSchoolId,@"name":self.detailModel.driveschoolinfo.name};
                    [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
                }
                [self.navigationController popViewControllerAnimated:YES];
                return;
                
            }
        }];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"教练";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    DYNSLog(@"right = %@",self.naviBarRightButton);
    self.navigationItem.rightBarButtonItem = rightItem;

    
    
    [self.view addSubview:[self tableViewHeadView]];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    if ([AcountManager manager].applyschool.infoId) {
        NSString *urlString = [NSString stringWithFormat:kGetSchoolUrl,[AcountManager manager].applyschool.infoId];
        NSString *url = [NSString stringWithFormat:BASEURL,urlString];
        [JENetwoking initWithUrl:url WithMethod:JENetworkingRequestMethodGet WithDelegate:self];
        
    }else {
        [self locationManager];

    }
    
    
    //    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
    //        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    //    }
    //    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
    //        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    //    }
    
}

- (UIView *)tableViewHeadView {
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kSystemWide, 40)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    backGroundView.layer.shadowColor = RGBColor(204, 204, 204).CGColor;
    backGroundView.layer.shadowOffset = CGSizeMake(0, 1);
    backGroundView.layer.shadowOpacity = 0.5;
    backGroundView.userInteractionEnabled = YES;
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(kSystemWide/2-1/2, 40/2-18/2, 1, 18)];
    centerView.backgroundColor = RGBColor(230, 230, 230);
    [backGroundView addSubview:centerView];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"距离" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.selected = YES;
    [leftButton addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [leftButton setTitleColor:MAINCOLOR forState:UIControlStateSelected];
    [backGroundView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backGroundView.mas_left).offset(0);
        make.top.mas_equalTo(backGroundView.mas_top).offset(0);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide/2];
        make.width.mas_equalTo(height);
        make.height.mas_equalTo(@40);
    }];
    [self.buttonArray addObject:leftButton];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"评分" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    [rightButton setTitleColor:MAINCOLOR forState:UIControlStateSelected];
    [backGroundView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(backGroundView.mas_right).offset(0);
        make.top.mas_equalTo(backGroundView.mas_top).offset(0);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide/2];
        make.width.mas_equalTo(height);
        make.height.mas_equalTo(@40);
    }];
    [self.buttonArray addObject:rightButton];
    
    [backGroundView addSubview:self.menuIndicator];
    
    return backGroundView;
}

- (void)locationManager {
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [BMKLocationService setLocationDistanceFilter:10000.0f];
    
    self.locationService = [[BMKLocationService alloc] init];
    self.locationService.delegate = self;
    
    [self.locationService startUserLocationService];
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //latitude=40.096263&longitude=116.1270&radius=10000
//    NSString *locationContent = @"latitude=40.096263&longitude=116.1270&radius=10000";
      NSString *locationContent =  [NSString stringWithFormat:@"latitude=%f&longitude=%f&radius=10000",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
    [self.dataArray removeAllObjects];


        NSString *urlString = [NSString stringWithFormat:kCoachUrl,locationContent];
        NSString *url = [NSString stringWithFormat:BASEURL,urlString];
        [JENetwoking initWithUrl:url WithMethod:JENetworkingRequestMethodGet WithDelegate:self];

  
   
    
    
    
}
- (void)jeNetworkingCallBackData:(id)data {
    DYNSLog(@"result = %@",data);
    NSArray *array = data[@"data"];
    for (NSDictionary *dic in array) {
        NSError *error = nil;
        CoachModel *model = [MTLJSONAdapter modelOfClass:CoachModel.class fromJSONDictionary:dic error:&error];
        DYNSLog(@"error = %@",error);
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
}
#pragma mark - bntAciton
- (void)clickLeftBtn:(UIButton *)sender {
    for (UIButton *b in self.buttonArray) {
        b.selected = NO;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.menuIndicator.frame = CGRectMake(StartOffset, self.menuIndicator.calculateFrameWithY, self.menuIndicator.calculateFrameWithWide, self.menuIndicator.calculateFrameWithHeight);
    }];
    sender.selected = YES;
}
- (void)clickRightBtn:(UIButton *)sender {
    for (UIButton *b in self.buttonArray) {
        b.selected = NO;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.menuIndicator.frame = CGRectMake(StartOffset+kSystemWide/2, self.menuIndicator.calculateFrameWithY, self.menuIndicator.calculateFrameWithWide, self.menuIndicator.calculateFrameWithHeight);
    }];
    sender.selected = YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        tableView.hidden = YES;
    }else {
        tableView.hidden = NO;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"cell";
    
    CoachTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (cell == nil) {
        cell = [[CoachTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CoachModel *model = self.dataArray[indexPath.row];
    
    [cell receivedCellModelWith:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoachModel *model = self.dataArray[indexPath.row];
    self.detailModel = model;
    self.naviBarRightButton.hidden = NO;
    if (self.markNum == 1) {
        SignUpCoachDetailViewController *detailVC = [[SignUpCoachDetailViewController alloc]init];
        detailVC.coachUserId = model.coachid;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if (self.markNum == 2) {
        CoachDetailAppointmentViewController *appointment = [[CoachDetailAppointmentViewController alloc] init];
        appointment.coachUserId = model.coachid;
        
        [self.navigationController pushViewController:appointment animated:YES];
    }
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    kShowDismiss
}

@end
