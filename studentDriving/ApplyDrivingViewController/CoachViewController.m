//
//  CoachViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/8.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "CoachViewController.h"
#import "CoachTableViewCell.h"
#import "CoachDetailViewController.h"
#import "ToolHeader.h"
#import <Masonry.h>
#import "UIView+CalculateUIView.h"
#import <BaiduMapAPI/BMKLocationService.h>
#import "CoachModel.h"
#import "LoginViewController.h"
#import "CoachDetailAppointmentViewController.h"
#import "SignUpInfoManager.h"
#import "BLPFAlertView.h"
#import "AppointmentCoachModel.h"
#import "UIColor+Hex.h"
#import "JGCoachDetailViewController.h"

#define StartOffset  kSystemWide/4-60/2

//static NSString *const kCoachUrl = @"getschoolcoach/%@/1";
static NSString *const kappointmentCoachUrl = @"userinfo/getusefulcoach/index/1";

@interface CoachViewController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *menuIndicator;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) BMKLocationService *locationService;
@property (strong, nonatomic) CoachModel *detailModel;
@end
@implementation CoachViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
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
            }else {
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"预约教练";
    self.view.backgroundColor = [UIColor whiteColor];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
//    DYNSLog(@"right = %@",self.naviBarRightButton);
//    self.navigationItem.rightBarButtonItem = rightItem;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self locationManager];

    
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
//    }
    
}


- (void)locationManager {
//    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
//    [BMKLocationService setLocationDistanceFilter:10000.0f];
//    
//    self.locationService = [[BMKLocationService alloc] init];
//    self.locationService.delegate = self;
//    [self.locationService startUserLocationService];

    NSString *url = [NSString stringWithFormat:BASEURL,kappointmentCoachUrl];

    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (data) {
            NSDictionary *param = data;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@", param[@"msg"]];
            if (type.integerValue == 1) {
                NSArray *array = param[@"data"];
                NSLog(@"%@", array);
                if (!self.dataArray.count && !array.count) {
                    [self showTotasViewWithMes:@"没有查询到教练"];
                }
                NSError *error = nil;
                [self.dataArray addObjectsFromArray: [MTLJSONAdapter modelsOfClass:CoachModel.class fromJSONArray:array error:&error]];
//                for (CoachDetail *coachModel in self.dataArray) {
//                    if ([coachModel.coachid isEqualToString:[AcountManager manager].applycoach.infoId]) {
//                        [self.dataArray removeObject:coachModel];
//                    }
//                    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//                    NSArray *modelArr = [ud objectForKey:@"appointCoachModelArr"];
//                    for (AppointmentCoachModel *appointModel in modelArr) {
//                        if ([coachModel.coachid isEqualToString:appointModel.coachid]) {
//                            [self.dataArray removeObject:coachModel];
//                        }
//                    }
//                }
                [self.tableView reloadData];
            }else {
                kShowFail(msg);
            }
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    //latitude=40.096263&longitude=116.1270&radius=10000
////    NSString *locationContent = @"latitude=40.096263&longitude=116.1270&radius=10000";
//   NSString *locationContent =    [NSString stringWithFormat:@"latitude=%f&longitude=%f&radius=10000",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
//    NSString *urlString = [NSString stringWithFormat:kCoachUrl,locationContent];
//    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
//    
//    [self.dataArray removeAllObjects];
//    [JENetwoking initWithUrl:url WithMethod:JENetworkingRequestMethodGet WithDelegate:self];
    
    
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
    if (self.markNum == 1) {

        CoachDetailViewController *detailVC = [[CoachDetailViewController alloc]init];
        DYNSLog(@"coachid = %@",model.coachid);
        detailVC.coachUserId = model.coachid;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if (self.markNum == 2) {
        JGCoachDetailViewController *appointment = [[JGCoachDetailViewController alloc] init];
        appointment.coachUserId = model.coachid;
        appointment.rememberModel = model;
        [self.navigationController pushViewController:appointment animated:YES];
//        return;
    }
    self.naviBarRightButton.hidden = NO;
 
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)dealloc {
    [self.locationService stopUserLocationService];
}
@end
