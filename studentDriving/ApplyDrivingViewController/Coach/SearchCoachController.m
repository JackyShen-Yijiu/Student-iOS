//
//  SearchCoachController.m
//  studentDriving
//
//  Created by 大威 on 16/1/6.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SearchCoachController.h"
#import "DVVFilterView.h"
#import "DVVSearchView.h"
#import "CoachTableViewCell.h"
#import "Masonry.h"
#import "DrivingSelectMotorcycleTypeView.h"
#import "SearchCoachViewModel.h"
#import "MJRefresh.h"
#import "CoachDMData.h"
#import <BaiduMapAPI/BMKLocationService.h>
#import <BaiduMapAPI/BMKGeocodeSearch.h>
#import "WMUITool.h"
#import "ToolHeader.h"
#import "DrivingCityListView.h"
#import "CoachDetailViewController.h"
#import "AcountManager.h"
#import "BLPFAlertView.h"
#import "DVVOpenControllerFromSideMenu.h"

@interface SearchCoachController ()<UITableViewDataSource, UITableViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) UIButton *naviBarRightButton;

@property (nonatomic, strong) SearchCoachViewModel *searchCoachViewModel;
@property (nonatomic, strong) DVVFilterView *filterView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DVVSearchView *searchView;

@property (strong, nonatomic) BMKLocationService *locationService;
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;


@end

@implementation SearchCoachController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"搜索教练";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.filterView];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.tableView];
    
    [self configUI];
    [self configViewModel];
    [self configRefresh];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if ([AcountManager manager].userCity) {
        
        if ([AcountManager manager].userCity.length) {
            _searchCoachViewModel.cityName = [AcountManager manager].userCity;
            [self.naviBarRightButton setTitle:[AcountManager manager].userCity forState:UIControlStateNormal];
            [self refresh];
        }else {
            
            [self locationManager];
            // 在模拟器上定位不好用，测试时打开注释
            //    [self refresh];
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.locationService = nil;
    self.geoCodeSearch = nil;
}

#pragma mark - config viewModel
- (void)configViewModel {
    
    _searchCoachViewModel = [SearchCoachViewModel new];
    __weak typeof(self) ws = self;
    [_searchCoachViewModel setDVVRefreshSuccessBlock:^{
        [MBProgressHUD hideHUDForView:ws.view animated:YES];
        if (_searchCoachViewModel.dataArray.count == 0) {
            [BLPFAlertView showAlertWithTitle:@"提示" message:@"对不起，该地区暂无合作教练，请您在侧边栏搜驾校。如有疑问，请致电 400-626-9255"cancelButtonTitle:@"返回" otherButtonTitles:nil completion:^(NSUInteger selectedOtherButtonIndex) {
                DYNSLog(@"selected = %ld",selectedOtherButtonIndex);
                [ws.navigationController popViewControllerAnimated:YES];
            }];
        }else {
            [ws.tableView reloadData];
            [ws.tableView.mj_header endRefreshing];
        }
    }];
    [_searchCoachViewModel setDVVLoadMoreSuccessBlock:^{
        [ws.tableView reloadData];
        [ws.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - config refresh
- (void)configRefresh {
    
    __weak typeof(self) ws = self;
    // 刷新
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws refresh];
    }];
    // 加载
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [ws.searchCoachViewModel dvvNetworkRequestLoadMore];
    }];
    
    self.tableView.mj_header = refreshHeader;
    self.tableView.mj_footer = refreshFooter;
}

- (void)refresh {
    _searchCoachViewModel.index = 1;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_searchCoachViewModel dvvNetworkRequestRefresh];
}

#pragma mark - action
- (void)filterLeftButtonAction {
    DrivingSelectMotorcycleTypeView *view = [DrivingSelectMotorcycleTypeView new];
    view.frame = self.view.bounds;
    [view setSelectedItemBlock:^(NSInteger carTypeId, NSString *selectedTitle) {
        [self.filterView.leftButton setTitle:selectedTitle forState:UIControlStateNormal];
        NSLog(@"%li --- %@", carTypeId, selectedTitle);
        _searchCoachViewModel.licenseType = carTypeId;
        
        [self refresh];
        
    }];
    [self.view addSubview:view];
    [view show];
}
- (void)dvvToolBarViewItemSelectedAction:(UIButton *)sender {
    NSLog(@"dvvToolBarViewItemSelectedAction === %li", sender.tag);
    _searchCoachViewModel.orderType = sender.tag + 1;
    
    [self refresh];
}
#pragma mark 搜索框结束编辑
- (void)dvvTextFieldDidEndEditingBlock:(UITextField *)textField {
    _searchCoachViewModel.searchName = textField.text;
    [self refresh];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchCoachViewModel.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    CoachTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CoachTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    CoachDMData *model = _searchCoachViewModel.dataArray[indexPath.row];
    [cell refreshData:model];
    
    return cell;
}
#pragma mark tableView的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CoachDMData *model = _searchCoachViewModel.dataArray[indexPath.row];
    CoachDetailViewController *detailVC = [CoachDetailViewController new];
    detailVC.coachUserId = model.coachid;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark configUI
- (void)configUI {
    
    CGFloat viewWidth = self.view.bounds.size.width;
    
    CGFloat toolBarViewHeight = 30;
    _filterView.frame = CGRectMake(0, 64, viewWidth, toolBarViewHeight);
    CGFloat searchViewHeight = 30;
    _searchView.frame = CGRectMake(10, 64 + toolBarViewHeight + 3, viewWidth - 20, searchViewHeight - 6);
    __weak typeof(self) ws = self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.searchView.mas_bottom).offset(3);
        make.left.and.right.with.bottom.mas_equalTo(0);
    }];
    
//    _toolBarView.backgroundColor = [UIColor redColor];
//    _searchView.backgroundColor = [UIColor orangeColor];
//    _tableView.backgroundColor = [UIColor lightGrayColor];
}

#pragma mark - 定位功能
- (void)locationManager {
    
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [BMKLocationService setLocationDistanceFilter:10000.0f];
    
    [self.locationService startUserLocationService];
}

#pragma mark 处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    // 保存经纬度
    _searchCoachViewModel.longitude = userLocation.location.coordinate.latitude;
    _searchCoachViewModel.latitude = userLocation.location.coordinate.longitude;
    
    // 反地理编码，获取城市名
    [self reverseGeoCodeWithLatitude:_searchCoachViewModel.latitude longitude:_searchCoachViewModel.longitude];
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
        _searchCoachViewModel.cityName = addressComponent.city;
        [self.naviBarRightButton setTitle:addressComponent.city forState:UIControlStateNormal];
        
        [self refresh];
        
        // 停止位置更新服务
        [self.locationService stopUserLocationService];
    }else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - 正地理编码
- (BOOL)geoCode {
    BMKGeoCodeSearchOption *geoCodeSearchOption = [BMKGeoCodeSearchOption new];
    geoCodeSearchOption.city = _searchCoachViewModel.cityName;
    geoCodeSearchOption.address = _searchCoachViewModel.cityName;
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
        _searchCoachViewModel.latitude = location.latitude;
        _searchCoachViewModel.longitude = location.longitude;
        // 刷新数据
        [self refresh];
    }else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - lazy load
- (BMKLocationService *)locationService {
    if (!_locationService) {
        _locationService = [BMKLocationService new];
        _locationService.delegate = self;
    }
    return _locationService;
}
- (BMKGeoCodeSearch *)geoCodeSearch {
    if (!_geoCodeSearch) {
        _geoCodeSearch = [BMKGeoCodeSearch new];
        _geoCodeSearch.delegate = self;
    }
    return _geoCodeSearch;
}

- (DVVFilterView *)filterView {
    if (!_filterView) {
        _filterView = [DVVFilterView new];
        _filterView.toolBarView.selectButtonInteger = -1;
        _filterView.leftButtonTitleString = @"车型选择";
        _filterView.titleArray = @[ @"距离最近", @"评分最高" ];
        [_filterView.leftButton addTarget:self action:@selector(filterLeftButtonAction) forControlEvents:UIControlEventTouchDown];
        __weak typeof(self) ws = self;
        [_filterView.toolBarView dvvToolBarViewItemSelected:^(UIButton *button) {
            [ws dvvToolBarViewItemSelectedAction:button];
        }];
    }
    return _filterView;
}
- (DVVSearchView *)searchView {
    if (!_searchView) {
        _searchView = [DVVSearchView new];
        __weak typeof(self) ws = self;
        [_searchView setDVVTextFieldDidEndEditingBlock:^(UITextField *textField) {
            [ws dvvTextFieldDidEndEditingBlock:textField];
        }];
    }
    return _searchView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 100;
        _tableView.tableFooterView = [UIView new];
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
            _searchCoachViewModel.cityName = cityName;
            [self geoCode];
        }];
        CGRect rect = self.view.bounds;
        cityListView.frame = CGRectMake(0, 64, rect.size.width, rect.size.height - 64);
        [self.view addSubview:cityListView];
        [cityListView show];
    }
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