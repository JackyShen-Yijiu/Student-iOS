//
//  CardViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/10.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "DrivingCandidatesViewController.h"
#import "DrivingDetailViewController.h"
#import "ToolHeader.h"
#import "DrivingCell.h"
#import <BaiduMapAPI/BMKLocationService.h>
#import "DrivingModel.h"


static NSString *const kDrivingUrl = @"driveschool/nearbydriveschool?%@";

@interface DrivingCandidatesViewController ()<UITableViewDelegate, UITableViewDataSource,BMKLocationServiceDelegate,JENetwokingDelegate>
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic) BMKLocationService *locationService;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation DrivingCandidatesViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择驾校";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
    [self locationManager];
}
- (void)locationManager {
    
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyHundredMeters];
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
//    NSString *locationContent = @"latitude=40.096263&longitude=116.1270&radius=10000";
     NSString *locationContent =   [NSString stringWithFormat:@"latitude=%f&longitude=%f&radius=10000",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    DrivingModel *model = self.dataArray[indexPath.row];
    [cell updateAllContentWith:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DrivingDetailViewController *SelectVC = [[DrivingDetailViewController alloc]init];
    DrivingModel *model = self.dataArray[indexPath.row];
    SelectVC.schoolId = model.schoolid;
    [self.navigationController pushViewController:SelectVC animated:YES];
}


@end
