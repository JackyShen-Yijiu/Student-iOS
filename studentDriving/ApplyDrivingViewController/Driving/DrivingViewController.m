//
//  CardViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/10.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "DrivingViewController.h"
#import "DrivingDetailViewController.h"
#import "DrivingCell.h"
#import <BaiduMapAPI/BMKLocationService.h>
#import "DrivingModel.h"
#import "DrivingModel.h"
#import "LoginViewController.h"
#import "SignUpInfoManager.h"
#import "BLPFAlertView.h"
#import "DrivingTableHeaderView.h"
#import "DrivingCycleShowViewModel.h"
#import "DrivingSelectMotorcycleTypeView.h"
#import "DrivingCityListView.h"
#import <BaiduMapAPI/BMKGeocodeSearch.h>
#import "MJRefresh.h"
#import "DVVSideMenu.h"

static NSString *const kDrivingUrl = @"searchschool?%@";

@interface DrivingViewController ()<UITableViewDelegate, UITableViewDataSource,BMKLocationServiceDelegate,JENetwokingDelegate, UITextFieldDelegate, BMKGeoCodeSearchDelegate>
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic) BMKLocationService *locationService;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) DrivingModel *detailModel;
@property (nonatomic, strong) DrivingTableHeaderView *tableHeaderView;
@property (nonatomic, strong) DrivingCycleShowViewModel *cycleShowViewModel;
@property (nonatomic, strong) DrivingSelectMotorcycleTypeView *selectMotorcycleTypeView;

@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;

@property (nonatomic, assign) BOOL isRefresh;

// 搜索参数
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) NSInteger radius;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger carTypeId;
@property (nonatomic, assign) NSInteger filterType;
@property (nonatomic, copy) NSString *searchName;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger count;
@end

@implementation DrivingViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addSideMenuButton];
    
    _radius = 10000;
    _cityName = @"";
    _address = @"";
    
    _carTypeId = 0;
    _filterType = 0;
    _searchName = @"";
    
    _index = 1;
    _count = 10;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    self.title = @"选择驾校";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    DYNSLog(@"right = %@",self.naviBarRightButton);
    self.navigationItem.rightBarButtonItem = rightItem;

    [self.view addSubview:self.tableView];
    
    [self networkCallBack];
    
    [self configRefresh];
    // 定位
//    [self locationManager];
    
//     在模拟器上定位不好用，测试是打开注释
    self.latitude = 39.929985778080237;
    self.longitude = 116.39564503787867;
    self.index = 1;
    self.isRefresh = YES;
    // 获取网络数据
    [self network];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.geoCodeSearch = nil;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - networkCallBack
- (void)networkCallBack {
    // 轮播图
    _cycleShowViewModel = [DrivingCycleShowViewModel new];
    __weak typeof(self) ws = self;
    [_cycleShowViewModel setSuccessRefreshBlock:^{
        [ws.tableHeaderView.cycleShowImagesView reloadDataWithArray:ws.cycleShowViewModel.imagesUrlArray];
    }];
    [_cycleShowViewModel networkRequestRefresh];
}
#pragma mark - 刷新和加载
- (void)configRefresh {
    
    __weak typeof(self) ws = self;
    // 刷新
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.isRefresh = YES;
        self.index = 1;
        [ws network];
    }];
    // 加载
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        // 判断加载时当前的请求的页面
        NSInteger dataCount = 0;
        if (ws.dataArray.count) {
            if (ws.dataArray.count <= 10) {
                dataCount = 10;
            }else {
                NSInteger temp = ws.dataArray.count % 10;
                if (temp) {
                    temp += 10 - temp;
                }
                dataCount = ws.dataArray.count + temp;
            }
        }
        NSInteger index = dataCount / 10 + 1;
        // 设置当前请求的页面
        self.index = index;
        
        self.isRefresh = NO;
        [ws network];
    }];
    
    self.tableView.mj_header = refreshHeader;
    self.tableView.mj_footer = refreshFooter;
}

- (void)network {
    
//    NSDictionary *params = @{ @"latitude": [NSString stringWithFormat:@"%f",self.latitude],
//                              @"longitud": [NSString stringWithFormat:@"%f",self.longitude],
//                              @"radius": [NSString stringWithFormat:@"%li",self.radius],
//                              @"cityname": [NSString stringWithFormat:@"%@",self.cityName],
//                              @"licensetype": [NSString stringWithFormat:@"%li",self.carTypeId],
//                              @"schoolname": [NSString stringWithFormat:@"%@",self.searchName],
//                              @"ordertype": [NSString stringWithFormat:@"%li",self.filterType],
//                              @"index": [NSString stringWithFormat:@"%li",self.index],
//                              @"count": [NSString stringWithFormat:@"%li",self.count] };
    
    NSString *params = @"";
    // 判断字符串是否null
    if (![self.cityName isKindOfClass:[NSNull class]]) {
        self.cityName = @"";
    }
    if (![self.searchName isKindOfClass:[NSNull class]]) {
        self.searchName = @"";
    }
//    params = [NSString stringWithFormat:@"latitude=%f&longitude=%f&radius=%li&cityname=%@&licensetype=%li&schoolname=%@&ordertype=%li&index=%li&count=%li", 39.915, 116.404, self.radius, self.cityName, self.carTypeId, self.searchName, self.filterType, self.index, self.count ];
    
    params = [NSString stringWithFormat:@"latitude=%f&longitude=%f&radius=%li&cityname=%@&licensetype=%li&schoolname=%@&ordertype=%li&index=%li&count=%li", self.latitude, self.longitude, self.radius, self.cityName, self.carTypeId, self.searchName, self.filterType, self.index, self.count ];

    
//    NSLog(@"%@",params);
    
    NSString *urlString = [NSString stringWithFormat:kDrivingUrl,params];
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    
    [JENetwoking initWithUrl:url WithMethod:JENetworkingRequestMethodGet WithDelegate:self];
}

- (void)jeNetworkingCallBackData:(id)data {
    
    DYNSLog(@"result = %@",data);
    NSArray *array = data[@"data"];
    // 如果是刷新则清空数组
    if (self.isRefresh) {
        [self.dataArray removeAllObjects];
    }
    for (NSDictionary *dic in array) {
        NSError *error = nil;
        DrivingModel *dModel = [MTLJSONAdapter modelOfClass:DrivingModel.class fromJSONDictionary:dic error:&error];
        [self.dataArray addObject:dModel];
    }
    
    [self.tableView reloadData];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    if (!self.dataArray.count) {
        [self showTotasViewWithMes:@"没有找到数据！"];
    }
    [MBProgressHUD hideHUDForView:self.view animated:self.dataArray.count];

}

#pragma mark - 定位功能
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
//    NSString *locationContent = @"latitude=40.096263&longitude=116.1270&radius=10000";
//    NSString *locationContent =[NSString stringWithFormat:@"latitude=%f&longitude=%f&radius=10000",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
//    NSString *locationContent =[NSString stringWithFormat:@"latitude=%f&longitude=%f&radius=10000",39.915, 116.404];

//    NSString *urlString = [NSString stringWithFormat:kDrivingUrl,locationContent];
//    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    
//    [self.dataArray removeAllObjects];
    
//    [JENetwoking initWithUrl:url WithMethod:JENetworkingRequestMethodGet WithDelegate:self];
    
    // 保存经纬度
    self.longitude = userLocation.location.coordinate.longitude;
    self.latitude = userLocation.location.coordinate.latitude;
    
    // 反地理编码，获取城市名
    [self reverseGeoCodeWithLatitude:self.latitude longitude:self.longitude];
}

#pragma mark - 反地理编码
- (BOOL)reverseGeoCodeWithLatitude:(double)latitude
                               longitude:(double)longitude {
    
    CLLocationCoordinate2D point = (CLLocationCoordinate2D){ latitude, longitude };
//    CLLocationCoordinate2D point = (CLLocationCoordinate2D){39.929986, 116.395645};
    BMKReverseGeoCodeOption *reverseGeocodeOption = [BMKReverseGeoCodeOption new];
    reverseGeocodeOption.reverseGeoPoint = point;
    // 发起反向地理编码
    BOOL flage = [self.geoCodeSearch reverseGeoCode:reverseGeocodeOption];
    if (flage) {
//        NSLog(@"反geo检索发送成功");
        return YES;
    }else {
//        NSLog(@"反geo检索发送失败");
        return NO;
    }
}
#pragma mark 反地理编码回调
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR) {
//        NSLog(@"%@",result);
        BMKAddressComponent *addressComponent = result.addressDetail;
//        NSLog(@"addressComponent.city===%@",addressComponent.city);
        // 保存城市名
        self.cityName = addressComponent.city;
        [self.naviBarRightButton setTitle:addressComponent.city forState:UIControlStateNormal];
        self.index = 1;
        self.isRefresh = YES;
        // 获取网络数据
        [self network];
        
        // 停止位置更新服务
        [self.locationService stopUserLocationService];
    }else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - 正地理编码
- (BOOL)geoCode {
    BMKGeoCodeSearchOption *geoCodeSearchOption = [BMKGeoCodeSearchOption new];
    geoCodeSearchOption.city = self.cityName;
    geoCodeSearchOption.address = self.cityName;
//    geoCodeSearchOption.city= @"北京市";
//    geoCodeSearchOption.address = @"海淀区上地10街10号";
    BOOL flag = [self.geoCodeSearch geoCode:geoCodeSearchOption];
    if(flag) {
//        NSLog(@"geo检索发送成功");
        return YES;
    }else {
//        NSLog(@"geo检索发送失败");
        return NO;
    }
}

#pragma mark 正地理编码回调
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR) {
//        NSLog(@"%@",result);
        CLLocationCoordinate2D location = result.location;
//        NSLog(@"result.location.latitude===%f, result.location.longitude===%f",result.location.latitude,result.location.longitude);
        self.latitude = location.latitude;
        self.longitude = location.longitude;
        // 刷新数据
        self.index = 1;
        self.isRefresh = YES;
        [self network];
    }else {
        NSLog(@"抱歉，未找到结果");
    }
}
    
#pragma mark - tableViwe
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        tableView.hidden = NO;
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
    DrivingDetailViewController *SelectVC = [[DrivingDetailViewController alloc]init];
    DrivingModel *model = self.dataArray[indexPath.row];
    self.detailModel = model;
    SelectVC.schoolId = model.schoolid;
    [self.navigationController pushViewController:SelectVC animated:YES];
}

#pragma mark - lazy load
- (BMKGeoCodeSearch *)geoCodeSearch {
    if (!_geoCodeSearch) {
        _geoCodeSearch = [BMKGeoCodeSearch new];
        _geoCodeSearch.delegate = self;
    }
    return _geoCodeSearch;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (DrivingTableHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [DrivingTableHeaderView new];
        _tableHeaderView.frame = CGRectMake(0, 0, kSystemWide, _tableHeaderView.defaultHeight);
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        
        // 选择车型点击事件
        [_tableHeaderView.motorcycleTypeButton addTarget:self action:@selector(motorcycleTypeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        // 筛选条件点击事件
        [_tableHeaderView.filterView dvvToolBarViewItemSelected:^(UIButton *button) {
            self.filterType = button.tag + 1;
            NSLog(@"%li",button.tag);
            self.index = 1;
            self.isRefresh = YES;
            [self network];
        }];
        // 搜索按钮点击事件
        [_tableHeaderView.searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tableHeaderView;
}

- (void)motorcycleTypeButtonAction {
    DrivingSelectMotorcycleTypeView *view = [DrivingSelectMotorcycleTypeView new];
    view.frame = self.view.bounds;
    [view setSelectedItemBlock:^(NSInteger carTypeId, NSString *selectedTitle) {
        self.carTypeId = carTypeId;
        [self.tableHeaderView.motorcycleTypeButton setTitle:selectedTitle forState:UIControlStateNormal];
//        NSLog(@"%li --- %@", carTypeId, selectedTitle);
        self.index = 1;
        self.isRefresh = YES;
        [self network];
    }];
    [self.view addSubview:view];
    [view show];
}

- (void)searchButtonAction {
    
    [self.view endEditing:YES];
    self.searchName = self.tableHeaderView.searchTextField.text;
    
    NSLog(@"longitude===%f,latitude===%f,searchName===%@,carTypeId===%li,filterType===%li",self.longitude,self.latitude,self.searchName,self.carTypeId,self.filterType);
    self.index = 1;
    self.isRefresh = YES;
    [self network];
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight-64)  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"定位中" withTitleColor:MAIN_FOREGROUND_COLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 70, 44);
        [_naviBarRightButton setImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateNormal];
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
//        _naviBarRightButton.backgroundColor = [UIColor redColor];
    }
    return _naviBarRightButton;
}
- (void)clickRight:(UIButton *)sender {
    
    BOOL flage = 0;
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[DrivingCityListView class]]) {
            flage = 1;
            return;
        }
    }
    if (!flage) {
        DrivingCityListView *cityListView = [DrivingCityListView new];
        [cityListView setSelectedItemBlock:^(NSString *cityName) {
            
            [self.naviBarRightButton setTitle:cityName forState:UIControlStateNormal];
            self.cityName = cityName;
            [self geoCode];
        }];
        CGRect rect = self.view.bounds;
        cityListView.frame = CGRectMake(0, 64, rect.size.width, rect.size.height - 64);
        [self.view addSubview:cityListView];
        [cityListView show];
    }
//    if (![AcountManager isLogin]) {
//        DYNSLog(@"islogin = %d",[AcountManager isLogin]);
//        LoginViewController *login = [[LoginViewController alloc] init];
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
//        return;
//    }
//    if (![[AcountManager manager].userApplystate isEqualToString:@"0"]) {
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
//    
//    DYNSLog(@"countId = %@",[AcountManager manager].applycoach.infoId);
//    
//    if (![AcountManager manager].applyschool.infoId) {
//        if (self.detailModel.schoolid || self.detailModel.name) {
//            NSDictionary *schoolParam = @{kRealSchoolid:self.detailModel.schoolid,@"name":self.detailModel.name};
//            [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
//            
//        }
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
//    
//    if ([[AcountManager manager].applyschool.infoId isEqualToString:self.detailModel.schoolid] ) {
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
//    
//    
//    if (![[AcountManager manager].applyschool.infoId isEqualToString:self.detailModel.schoolid]) {
//        [BLPFAlertView showAlertWithTitle:@"提示" message:@"您已经选择了教练和班型更换驾校后您可能重新做出选择" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
//            DYNSLog(@"index = %ld",selectedOtherButtonIndex);
//            NSUInteger index = selectedOtherButtonIndex + 1;
//            if (index == 0) {
//                return ;
//            }else if (index == 1) {
//                
//                [SignUpInfoManager removeSignData];
//                
//                if (self.detailModel.schoolid || self.detailModel.name) {
//                    NSDictionary *schoolParam = @{kRealSchoolid:self.detailModel.schoolid,@"name":self.detailModel.name};
//                    [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
//                    
//                }
//                [self.navigationController popViewControllerAnimated:YES];
//                
//            }
//        }];
//    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
