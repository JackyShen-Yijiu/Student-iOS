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
#import <BaiduMapAPI/BMKGeocodeSearch.h>
#import "DrivingModel.h"
#import "DrivingModel.h"
#import "LoginViewController.h"
#import "SignUpInfoManager.h"
#import "BLPFAlertView.h"
#import "DrivingTableHeaderView.h"
#import "DrivingSelectMotorcycleTypeView.h"
#import "DrivingCityListView.h"
#import "MJRefresh.h"
#import "DVVSideMenu.h"
#import "DVVLocationStatus.h"
#import "JGSelectDrivingVcHeadSearch.h"
#import "JGSelectDrivingVcHead.h"

static NSString *const kDrivingUrl = @"searchschool";

#define selectHeadViewH 35
#define searchHeadViewH selectHeadViewH

@interface DrivingViewController ()<UITableViewDelegate, UITableViewDataSource,BMKLocationServiceDelegate,JENetwokingDelegate, UITextFieldDelegate, BMKGeoCodeSearchDelegate, UIAlertViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic)UITableView *tableView;

@property (strong, nonatomic) BMKLocationService *locationService;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) UIButton *naviBarRightselectjiaxiao;

@property (strong, nonatomic) UIButton *naviBarRightselectjiaolian;

@property (strong, nonatomic) DrivingModel *detailModel;

@property (nonatomic, strong) JGSelectDrivingVcHead *tableHeaderView;

@property (nonatomic, strong) JGSelectDrivingVcHeadSearch *searchView;

@property (nonatomic, strong) DrivingSelectMotorcycleTypeView *selectMotorcycleTypeView;

@property (nonatomic, strong) DVVLocationStatus *dvvLocationStatus;

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

@property (nonatomic,weak) DrivingSelectMotorcycleTypeView *typeView;

// 0:找驾校 1:找教练
@property (nonatomic,assign) NSInteger selectType;

@end

@implementation DrivingViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _radius = 10000;
    _cityName = @"";
    _address = @"";
    
    _carTypeId = 0;
    _filterType = 0;
    _searchName = @"";
    
    _index = 1;
    _count = 10;
    
    _selectType = 1;
    
    self.title = @"一步学车";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    [self.view addSubview:self.tableHeaderView];
    
    [self.view addSubview:self.tableView];
    
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
    // 初始化网络请求
    [self configRefresh];
    
    // 初始化筛选模式（找驾校、找教练）
    [self clickRight];
    
        // 定位
//    [self locationManager];
//         在模拟器上定位不好用，测试是打开注释
        self.latitude = 39.929985778080237;
        self.longitude = 116.39564503787867;
        self.index = 1;
        self.isRefresh = YES;
   
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
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
    
    // 判断字符串是否null
    if (![self.cityName isKindOfClass:[NSNull class]]) {
        self.cityName = @"";
    }
    if (!self.searchName || !self.searchName.length) {
        self.searchName = @"";
    }
    NSLog(@"searchName === %@",self.searchName);
    
    NSString *latitude = [NSString stringWithFormat:@"%f", self.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", self.longitude];
    NSString *radius = [NSString stringWithFormat:@"%li", self.radius];
    NSString *cityName = [NSString stringWithFormat:@"%@", self.cityName];
    NSString *carTypeId = [NSString stringWithFormat:@"%li", self.carTypeId];
    NSString *searchName = [NSString stringWithFormat:@"%@", self.searchName];
    NSString *filterType = [NSString stringWithFormat:@"%li", self.filterType];
    NSString *index = [NSString stringWithFormat:@"%li", self.index];
    NSString *count = [NSString stringWithFormat:@"%li", self.count];
    
//    params = [NSString stringWithFormat:@"latitude=%f&longitude=%f&radius=%li&cityname=%@&licensetype=%li&schoolname=%@&ordertype=%li&index=%li&count=%li", self.latitude, self.longitude, self.radius, self.cityName, self.carTypeId, self.searchName, self.filterType, self.index, self.count ];
    
    //    NSLog(@"%@",params);
    
    NSDictionary *params = @{ @"latitude": latitude,
                          @"longitude": longitude,
                          @"radius": radius,
                          @"cityname": cityName,
                          @"licensetype": carTypeId,
                          @"schoolname": searchName,
                          @"ordertype": filterType,
                          @"index": index,
                          @"count": count };
    NSLog(@"%@",params);
    NSString *url = [NSString stringWithFormat:BASEURL,kDrivingUrl];
    
    [JENetwoking startDownLoadWithUrl:url postParam:params WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        [self jeNetworkingCallBackData:data];
        
    } withFailure:^(id data) {
        [self showTotasViewWithMes:@"网络错误"];
    }];
}

- (void)jeNetworkingCallBackData:(id)data {
    
    [MBProgressHUD hideHUDForView:self.tableView animated:self.dataArray.count];

    DYNSLog(@"result = %@",data);
    if (![[data objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
        [self showTotasViewWithMes:@"没有找到数据"];
        return ;
    }
    NSArray *array = data[@"data"];
    if (!array.count) {
        [self showTotasViewWithMes:@"没有更多数据啦"];
    }
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
    
    // 设置contentInset隐藏搜索框
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(-searchHeadViewH, 0, 0, 0);
    }];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    if (!self.dataArray.count) {
        [self showTotasViewWithMes:@"没有找到数据"];
    }
}

#pragma mark - 定位功能
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
       // [self.naviBarRightButton setTitle:addressComponent.city forState:UIControlStateNormal];
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
    NSLog(@"%@", model.schoolid);
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

- (JGSelectDrivingVcHead *)tableHeaderView {
    
    if (!_tableHeaderView) {
        
        _tableHeaderView = [JGSelectDrivingVcHead new];
        _tableHeaderView.frame = CGRectMake(0, 64, kSystemWide, _tableHeaderView.defaultHeight);
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
       
    }
    return _tableHeaderView;
}

- (JGSelectDrivingVcHeadSearch *)searchView {
    
    if (!_searchView) {
        
        _searchView = [JGSelectDrivingVcHeadSearch new];
        
        _searchView.frame = CGRectMake(0, 0, kSystemWide, _searchView.defaultHeight);
        
        _searchView.backgroundColor = RGBColor(255, 255, 255);
        
        // 搜索按钮点击事件
        __weak typeof(self) ws = self;
        [_searchView.searchView setDVVTextFieldDidEndEditingBlock:^(UITextField *textField) {
            [ws searchButtonAction:textField];
        }];
        
    }
    return _searchView;
}

- (void)motorcycleTypeButtonAction {
    
    if (self.typeView.isShow) {
        [self.typeView closeSelf];
        return;
    }
    
     DrivingSelectMotorcycleTypeView *typeView = [DrivingSelectMotorcycleTypeView new];
    
    CGFloat viewX = 0;
    CGFloat viewY = CGRectGetMaxY(self.tableHeaderView.frame)+1;
    CGFloat viewW = self.view.frame.size.width;
    CGFloat viewH = self.view.frame.size.height;
    typeView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    [typeView setSelectedItemBlock:^(NSInteger carTypeId, NSString *selectedTitle) {
        
        self.carTypeId = carTypeId;
        [self.tableHeaderView.motorcycleTypeButton setTitle:selectedTitle forState:UIControlStateNormal];
        //        NSLog(@"%li --- %@", carTypeId, selectedTitle);
        self.index = 1;
        self.isRefresh = YES;
        [self network];
        
    }];
    
    [self.view addSubview:typeView];
    
    [typeView show];
    
    self.typeView = typeView;
    
}

- (void)searchButtonAction:(UITextField *)textField {
    
    [self.view endEditing:YES];
    self.searchName = textField.text;
    
    NSLog(@"longitude===%f,latitude===%f,searchName===%@,carTypeId===%li,filterType===%li",self.longitude,self.latitude,self.searchName,self.carTypeId,self.filterType);
    self.index = 1;
    self.isRefresh = YES;
    [self network];
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableHeaderView.frame), kSystemWide, kSystemHeight-64-self.tableHeaderView.frame.size.height)  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.searchView;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
- (UIButton *)naviBarRightselectjiaolian {
    if (_naviBarRightselectjiaolian == nil) {
        
        _naviBarRightselectjiaolian = [WMUITool initWithTitle:@"找教练" withTitleColor:MAIN_FOREGROUND_COLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightselectjiaolian.frame = CGRectMake(0, 0, 70, 44);
        [_naviBarRightselectjiaolian addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];

    }
    return _naviBarRightselectjiaolian;
}
- (UIButton *)naviBarRightselectjiaxiao {
    if (_naviBarRightselectjiaxiao == nil) {
        
        _naviBarRightselectjiaxiao = [WMUITool initWithTitle:@"找驾校" withTitleColor:MAIN_FOREGROUND_COLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightselectjiaxiao.frame = CGRectMake(0, 0, 70, 44);
        [_naviBarRightselectjiaxiao addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _naviBarRightselectjiaxiao;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    CGPoint offY = scrollView.contentOffset;
    NSLog(@"offY.y:%f",offY.y);
    if (offY.y<=searchHeadViewH) {// 不需要刷新
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }];
    }else{// 刷新
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(-searchHeadViewH, 0, 0, 0);
        }];
    }
    
}

- (void)clickRight
{
    
    UIBarButtonItem *rightItem;
    if (self.selectType==0) {
        self.selectType=1;
        rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightselectjiaolian];
    }else{
        self.selectType=0;
        rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightselectjiaxiao];
    }
    self.navigationItem.rightBarButtonItem = rightItem;

    // 刷新列表
    [self.tableView reloadData];

    // 刷新数据
    [self.tableView.mj_header beginRefreshing];
    
}

@end
