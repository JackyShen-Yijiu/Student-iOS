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

#import <Masonry.h>
#import "UIView+CalculateUIView.h"
#import <BaiduMapAPI/BMKLocationService.h>
#import "CoachModel.h"
#import "SignUpInfoManager.h"
#import "CoachDetailAppointmentViewController.h"
#import "BLPFAlertView.h"
#import "LoginViewController.h"

#import "DVVLocationStatus.h"

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

@property (nonatomic, strong) DVVLocationStatus *dvvLocationStatus;

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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.hidden = YES;
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (void)clickRight:(UIButton *)sender {
    
    if (![AcountManager isLogin]) {
        [DVVUserManager userNeedLogin];
        return;
    }
    if (![[AcountManager manager].userApplystate isEqualToString:@"0"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    DYNSLog(@"countId = %@",[AcountManager manager].applycoach.infoId);
    
    if (![AcountManager manager].applyschool.infoId) {
        if (self.detailModel || self.detailModel.name) {
            if (self.isVerify) {
                NSDictionary *coachParam = @{kVerifyCoachid:self.detailModel.coachid,@"name":self.detailModel.name};
                [SignUpInfoManager signUpInfoSaveVerifyRealCoach:coachParam];
            }else {
                NSDictionary *coachParam = @{kRealCoachid:self.detailModel.coachid,@"name":self.detailModel.name};
                [SignUpInfoManager signUpInfoSaveRealCoach:coachParam];
            }
            
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
            if (self.isVerify) {
                NSDictionary *coachParam = @{kVerifyCoachid:self.detailModel.coachid,@"name":self.detailModel.name};
                [SignUpInfoManager signUpInfoSaveVerifyRealCoach:coachParam];
            }else {
                NSDictionary *coachParam = @{kRealCoachid:self.detailModel.coachid,@"name":self.detailModel.name};
                [SignUpInfoManager signUpInfoSaveRealCoach:coachParam];
            }
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
            }else  {
                if (self.detailModel || self.detailModel.name) {
                    if (self.isVerify) {
                        NSDictionary *coachParam = @{kVerifyCoachid:self.detailModel.coachid,@"name":self.detailModel.name};
                        [SignUpInfoManager signUpInfoSaveVerifyRealCoach:coachParam];
                    }else {
                        NSDictionary *coachParam = @{kRealCoachid:self.detailModel.coachid,@"name":self.detailModel.name};
                        [SignUpInfoManager signUpInfoSaveRealCoach:coachParam];
                    }
                    
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"报考教练";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    DYNSLog(@"right = %@",self.naviBarRightButton);
    self.navigationItem.rightBarButtonItem = rightItem;

    
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


- (void)locationManager {
    
    // 检查定位功能是否可用
    _dvvLocationStatus = [DVVLocationStatus new];
    __weak typeof(self) ws = self;
    [_dvvLocationStatus setSelectCancelButtonBlock:^{
        [ws.navigationController popViewControllerAnimated:YES];
    }];
    [_dvvLocationStatus setSelectOkButtonBlock:^{
        [ws.navigationController popViewControllerAnimated:YES];
    }];
    if (![_dvvLocationStatus checkLocationStatus]) {
        [_dvvLocationStatus remindUser];
        return ;
    }
    
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyHundredMeters];
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
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
//    if (self.markNum == 1) {
//        SignUpCoachDetailViewController *detailVC = [[SignUpCoachDetailViewController alloc]init];
//        detailVC.isVerify = self.isVerify;
//        detailVC.coachUserId = model.coachid;
//        [self.navigationController pushViewController:detailVC animated:YES];
//    }else
    if (self.markNum == 2) {
        CoachDetailAppointmentViewController *appointment = [[CoachDetailAppointmentViewController alloc] init];
        appointment.coachUserId = model.coachid;
        
        [self.navigationController pushViewController:appointment animated:YES];
    }
    
}

@end
