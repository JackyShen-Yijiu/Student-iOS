//
//  CardViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/10.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "SignUpDrivingViewController.h"
#import "SignUpDrivingDetailViewController.h"
#import "ToolHeader.h"
#import "DrivingCell.h"
#import <BaiduMapAPI/BMKLocationService.h>
#import "DrivingModel.h"
#import <SVProgressHUD.h>
#import "LoginViewController.h"
#import "SignUpInfoManager.h"
#import "PFAlertView.h"
static NSString *const kDrivingUrl = @"driveschool/nearbydriveschool?%@";

@interface SignUpDrivingViewController ()<UITableViewDelegate, UITableViewDataSource,BMKLocationServiceDelegate,JENetwokingDelegate>
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic) BMKLocationService *locationService;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) DrivingModel *detailModel;
@end

@implementation SignUpDrivingViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight-64)  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
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
        if (self.detailModel.schoolid || self.detailModel.name) {
            NSDictionary *schoolParam = @{kRealSchoolid:self.detailModel.schoolid,@"name":self.detailModel.name};
            [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
            
        }
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if ([[AcountManager manager].applyschool.infoId isEqualToString:self.detailModel.schoolid] ) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    
    if (![[AcountManager manager].applyschool.infoId isEqualToString:self.detailModel.schoolid]) {
        [PFAlertView showAlertWithTitle:@"提示" message:@"您已经选择了教练和班型更换驾校后您可能重新做出选择" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
            DYNSLog(@"index = %ld",selectedOtherButtonIndex);
            NSUInteger index = selectedOtherButtonIndex + 1;
            if (index == 0) {
                return ;
            }else if (index == 1) {
                
                [SignUpInfoManager removeSignData];
                
                if (self.detailModel.schoolid || self.detailModel.name) {
                    NSDictionary *schoolParam = @{kRealSchoolid:self.detailModel.schoolid,@"name":self.detailModel.name};
                    [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
                    
                }
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [SVProgressHUD show];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    DYNSLog(@"right = %@",self.naviBarRightButton);
    self.navigationItem.rightBarButtonItem = rightItem;

    
    self.title = @"选择驾校";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
    
    
    [self locationManager];
}
- (void)locationManager {
    
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [BMKLocationService setLocationDistanceFilter:10000.0f];
    
    self.locationService = [[BMKLocationService alloc] init];
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];

}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //latitude=40.096263&longitude=116.1270&radius=10000
    NSString *locationContent = @"latitude=40.096263&longitude=116.1270&radius=10000";
    //    [NSString stringWithFormat:@"latitude=%f&longitude=%f&radius=10000",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
    NSString *urlString = [NSString stringWithFormat:kDrivingUrl,locationContent];
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    
    [self.dataArray removeAllObjects];
    
    [JENetwoking initWithUrl:url WithMethod:JENetworkingRequestMethodGet WithDelegate:self];
    
    
}
- (void)jeNetworkingCallBackData:(id)data {
    DYNSLog(@"result = %@",data);
    NSArray *array = data[@"data"];
    for (NSDictionary *dic in array) {
        NSError *error = nil;
        DrivingModel *dModel = [MTLJSONAdapter modelOfClass:DrivingModel.class fromJSONDictionary:dic error:&error];
        [self.dataArray addObject:dModel];
    }
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        tableView.hidden = YES;
    }else {
        tableView.hidden = NO;
    }
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    DrivingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[DrivingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    DrivingModel *model = self.dataArray[indexPath.row];
    [cell updateAllContentWith:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SignUpDrivingDetailViewController *SelectVC = [[SignUpDrivingDetailViewController alloc]init];
    DrivingModel *model = self.dataArray[indexPath.row];
    self.detailModel = model;
    self.naviBarRightButton.hidden = NO;
    SelectVC.schoolId = model.schoolid;
    [self.navigationController pushViewController:SelectVC animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [self.locationService stopUserLocationService];
    
    kShowDismiss
}

@end
