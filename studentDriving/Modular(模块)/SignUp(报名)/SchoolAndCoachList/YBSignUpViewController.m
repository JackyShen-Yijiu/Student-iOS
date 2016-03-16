//
//  YBSignUpViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSignUpViewController.h"
#import "DVVLocation.h"
#import "CityListViewController.h"
#import "DVVSignUpToolBarView.h"
#import "DVVSignUpSchoolCell.h"
#import "DVVSignUpCoachCell.h"
#import "DVVSignUpSchoolViewModel.h"
#import "DVVSignUpCoachViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import "DVVToast.h"
#import "DVVSearchView.h"
#import "DrivingDetailController.h"
#import "WMCommon.h"
#import "DVVCoachDetailController.h"
#import "DVVNoDataPromptView.h"

#import "DVVPaySuccessController.h"
#import "YBLoginController.h"

static NSString *schoolCellID = @"schoolCellID";
static NSString *coachCellID = @"coachCellID";

@interface YBSignUpViewController ()<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate, CityListViewDelegate>
{
    UIImageView*navBarHairlineImageView;
}

@property (nonatomic, assign) BOOL alreadyBeginLoaction;

@property (nonatomic, strong) DVVSignUpSchoolViewModel *schoolViewModel;
@property (nonatomic, strong) DVVSignUpCoachViewModel *coachViewModel;

// 当前显示的是驾校还是教练（0：驾校  1：教练）
@property (nonatomic, assign) BOOL showType;

//@property (nonatomic, strong) UIView *titleView;
//@property (nonatomic, strong) UIButton *titleLeftButton;
//@property (nonatomic, strong) UIButton *titleRightButton;
//@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISegmentedControl *segment;

// 定位
@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) DVVSignUpToolBarView *toolBarView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DVVSearchView *searchView;
@property (nonatomic, strong) UIView *searchContentView;

@property (nonatomic, assign) CGFloat lastOffsetY;

@property (nonatomic, strong) DVVNoDataPromptView *noDataPromptView;

@property (nonatomic, assign) BOOL loadedCache;

@end

@implementation YBSignUpViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    
//    [self.view addSubview:self.titleView];
//    [_titleView addSubview:self.titleLeftButton];
//    [_titleView addSubview:self.titleRightButton];
//    [_titleView addSubview:self.titleLabel];
//    self.navigationItem.titleView = _titleView;
    self.navigationItem.titleView = self.segment;
    
    UIBarButtonItem *rightBBI = [[UIBarButtonItem alloc] initWithCustomView:self.locationLabel];
    self.navigationItem.rightBarButtonItem = rightBBI;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.toolBarView];
    
    [self configSchoolViewModel];
    [self configCoachViewModel];
    [self configRefresh];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = YBNavigationBarBgColor;
    topView.frame = CGRectMake(0, -64, kSystemWide, 64);
    [self.view addSubview:topView];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, kSystemHeight - 64 - 49, kSystemWide, 49);
    [self.view addSubview:bottomView];
    
    // 测试控制器
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        DVVPaySuccessController *vc = [DVVPaySuccessController new];
////        vc.hidesBottomBarWhenPushed = YES;
////        [self.navigationController pushViewController:vc animated:YES];
//        YBLoginController *vc = [YBLoginController new];
//        [self presentViewController:vc animated:YES completion:nil];
//    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGSize size = self.view.bounds.size;
    _toolBarView.frame = CGRectMake(0, 0, size.width, 44);
    _tableView.frame = CGRectMake(0, 44, size.width, size.height - 44);
    
//    _titleView.backgroundColor = [UIColor redColor];
//    _titleLeftButton.backgroundColor = [UIColor orangeColor];
//    _titleRightButton.backgroundColor = [UIColor orangeColor];
    
    _toolBarView.backgroundColor = [UIColor whiteColor];
    
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    
    if (!_alreadyBeginLoaction) {
        // 加载数据
        NSString *city = [AcountManager manager].userSelectedCity;
        if (city && city.length) {
            _locationLabel.text = city;
        }else {
            [self beginLocation];
        }
        _alreadyBeginLoaction = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    // 显示导航条分割线
//    navBarHairlineImageView.hidden=NO;
    
    // 退出侧边栏
    if ([WMCommon getInstance].homeState==kStateMenu) {
        [self clicked];
    }
}

- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView*subview in view.subviews) {
        UIImageView*imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

#pragma mark - action
#pragma mark 选驾校或者选教练
//- (void)selectSchoolOrCoachAction {
//    
//    // 根据当前的状态来判断是显示驾校还是教练
//    if (0 == _showType) {
//        _showType = 1;
//        _titleLabel.text = @"教练";
//        
//    }else {
//        _showType = 0;
//        _titleLabel.text = @"驾校";
//    }
//
//    [self cancelSearch];
//    [self beginRefresh];
//}
- (void)didClicksegmentedControlAction:(UISegmentedControl *)Seg {
    
    NSInteger index = Seg.selectedSegmentIndex;
    NSLog(@"%lu", (long)index);
    
    if (0 == index) {
        if (_showType != 0) {
            _showType = 0;
            [self cancelSearch];
            [self beginRefresh];
        }
    }else if (1 == index) {
        if (_showType != 1) {
            _showType = 1;
            [self cancelSearch];
            [self beginRefresh];
        }
    }
}

#pragma mark 筛选条件
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    NSInteger orderType;
    if (0 == index) {
        orderType = 2;
    }else if (1 == index) {
        orderType = 3;
    }else if (2 == index) {
        orderType = 0;
    }
    _schoolViewModel.orderType = orderType;
    _coachViewModel.orderType = orderType;
    [self cancelSearch];
    [self beginRefresh];
}

#pragma mark 搜索
- (void)dvvTextFieldDidBeginEditingAction:(UITextField *)textField {
    _schoolViewModel.isSearch = YES;
    _coachViewModel.isSearch = YES;
}

- (void)dvvTextFieldDidEndEditingAction:(UITextField *)textField {
    _schoolViewModel.searchName = textField.text;
    _coachViewModel.searchName = textField.text;
    if (!textField.text.length) {
        _schoolViewModel.isSearch = NO;
        _coachViewModel.isSearch = NO;
    }
    [self beginRefresh];
}

#pragma mark 右上角定位按钮
- (void)locationLabelAction {
    
    CityListViewController *vc = [CityListViewController new];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark 选择城市的代理事件
- (void)didClickedWithCityName:(NSString *)cityName {
    
    NSLog(@"selected cityName: %@", cityName);
    _locationLabel.text = cityName;
    
    _schoolViewModel.cityName = cityName;
    _coachViewModel.cityName = cityName;
    [self beginRefresh];
}

#pragma mark - public

- (void)beginRefresh {
    
    // 当刷新时，刷新下数据，避免驾校和教练切换时，点击cell崩溃
    if (0 == _showType) {
        [_schoolViewModel.dataArray removeAllObjects];
    }else {
        [_coachViewModel.dataArray removeAllObjects];
    }
    [self.tableView reloadData];
    
    if (!_loadedCache) {
        [self loadDataFromCache];
        _loadedCache = YES;
    }
    
    
    // 开始请求数据
    [self.noDataPromptView remove];
    [DVVToast showFromView:self.view OffSetY:-10];
    if (0 == _showType) {
        [_schoolViewModel dvv_networkRequestRefresh];
    }else {
        [_coachViewModel dvv_networkRequestRefresh];
    }
    
}

- (void)loadDataFromCache {
    if (0 == _showType) {
        // 加载驾校缓存数据
        NSMutableArray *schoolDataArray = [self dvv_unarchiveFromCacheWithFileName:ArchiverName_SchoolDataArray];
        if (schoolDataArray && schoolDataArray.count) {
            _schoolViewModel.dataArray = schoolDataArray;
            [_tableView reloadData];
        }
    }else {
        // 加载教练缓存数据
        NSMutableArray *coachDataArray = [self dvv_unarchiveFromCacheWithFileName:ArchiverName_CoachDataArray];
        if (coachDataArray && coachDataArray.count) {
            _coachViewModel.dataArray = coachDataArray;
            [_tableView reloadData];
        }
    }
}

- (void)cancelSearch {
    _schoolViewModel.searchName = @"";
    _coachViewModel.searchName = @"";
    _searchView.textField.text = @"";
    [self.view endEditing:YES];
}

- (void)hideSearchView {
    
    if (!_schoolViewModel.isSearch) {
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
        }];
    }else if (!_coachViewModel.isSearch) {
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
        }];
    }
}

#pragma mark - table delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == _showType) {
        return _schoolViewModel.dataArray.count;
    }else {
        return _coachViewModel.dataArray.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == _showType) {
        return 88;
    }else {
        return 88;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == _showType) {
        DVVSignUpSchoolCell *schoolCell = [tableView dequeueReusableCellWithIdentifier:schoolCellID];
        return schoolCell;
    }else {
        DVVSignUpCoachCell *coachCell = [tableView dequeueReusableCellWithIdentifier:coachCellID];
        return coachCell;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == _showType) {
        DVVSignUpSchoolCell *schoolCell = (DVVSignUpSchoolCell *)cell;
        [schoolCell refreshData:_schoolViewModel.dataArray[indexPath.row]];
    }else {
        DVVSignUpCoachCell *coachCell = (DVVSignUpCoachCell *)cell;
        [coachCell refreshData:_coachViewModel.dataArray[indexPath.row]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 退出侧边栏
    if ([WMCommon getInstance].homeState==kStateMenu) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KhiddenSlide object:self];
        return;
    }
    
    if (0 == _showType) {
        
        // 跳转到驾校详情
        DVVSignUpSchoolDMData *dmData = _schoolViewModel.dataArray[indexPath.row];
        DrivingDetailController *vc = [DrivingDetailController new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.schoolID = dmData.schoolid;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        DVVSignUpCoachDMData *dmData = _coachViewModel.dataArray[indexPath.row];
        NSLog(@"%@", dmData.coachid);
        // 跳转到教练详情
        DVVCoachDetailController *vc = [DVVCoachDetailController new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.coachID = dmData.coachid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= 0 && offsetY <= 40) {
        self.tableView.contentInset = UIEdgeInsetsMake(-offsetY, 0, 0, 0);
    }
    
    
//    __weak typeof(self) ws = self;
//    if (offsetY > 0 && offsetY <= 20 && offsetY < _lastOffsetY) {
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            ws.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        }];
//        NSLog(@"开始显示：%f", scrollView.contentOffset.y);
//        
//    }else if (offsetY < 40 && offsetY > 20 && offsetY > _lastOffsetY) {
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            ws.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
//        }];
//        NSLog(@"开始隐藏：%f", scrollView.contentOffset.y);
//        
//    }
    
//    // 记录下本次的Y偏移位置
//    _lastOffsetY = scrollView.contentOffset.y;
    
    // 在没有数据的时候不让用户滚动
    if (0 == _showType) {
        if (!_schoolViewModel.dataArray.count) {
            _tableView.contentOffset = CGPointMake(0, 40);
        }
    }else {
        if (!_coachViewModel.dataArray.count) {
            _tableView.contentOffset = CGPointMake(0, 40);
        }
    }
    
}

#pragma mark - config view model
- (void)configSchoolViewModel {
    
    __weak typeof(self) ws = self;
    _schoolViewModel = [DVVSignUpSchoolViewModel new];
    
    [_schoolViewModel dvv_setRefreshSuccessBlock:^{
        [ws.noDataPromptView remove];
        [ws.tableView reloadData];
    }];
    [_schoolViewModel dvv_setLoadMoreSuccessBlock:^{
        [ws.noDataPromptView remove];
        [ws.tableView reloadData];
    }];
    [_schoolViewModel dvv_setNilResponseObjectBlock:^{
        if (ws.schoolViewModel.dataArray.count) {
            [ws obj_showTotasViewWithMes:@"已经全部加载完毕"];
            ws.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        }else {
//            if (!((NSMutableArray *)[ws dvv_unarchiveFromCacheWithFileName:ArchiverName_SchoolDataArray]).count) {
//                ws.noDataPromptView.titleLabel.text = @"暂无合作驾校信息";
//                ws.noDataPromptView.subTitleLabel.text = @"请切换合作城市";
//                [ws.tableView addSubview:ws.noDataPromptView];
//            }
            [ws.tableView addSubview:self.noDataPromptView];
        }
    }];
    [_schoolViewModel dvv_setNetworkCallBackBlock:^{
        [DVVToast hideFromView:ws.view];
        [ws.tableView.mj_header endRefreshing];
        [ws.tableView.mj_footer endRefreshing];
        [self hideSearchView];
    }];
    [_schoolViewModel dvv_setNetworkErrorBlock:^{
        if (!((NSMutableArray *)[ws dvv_unarchiveFromCacheWithFileName:ArchiverName_SchoolDataArray]).count) {
            ws.noDataPromptView.titleLabel.text = @"网络错误";
            ws.noDataPromptView.subTitleLabel.text = @"";
            [ws.tableView addSubview:ws.noDataPromptView];
        }
        [ws obj_showTotasViewWithMes:@"网络错误"];
    }];
}

- (void)configCoachViewModel {
    
    __weak typeof(self) ws = self;
    _coachViewModel = [DVVSignUpCoachViewModel new];
    
    [_coachViewModel dvv_setRefreshSuccessBlock:^{
        [ws.noDataPromptView remove];
        [ws.tableView reloadData];
    }];
    [_coachViewModel dvv_setLoadMoreSuccessBlock:^{
        [ws.noDataPromptView remove];
        [ws.tableView reloadData];
    }];
    [_coachViewModel dvv_setNilResponseObjectBlock:^{
        if (ws.coachViewModel.dataArray.count) {
            [ws obj_showTotasViewWithMes:@"已经全部加载完毕"];
            ws.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        }else {
//            if (!(NSMutableArray *)([ws dvv_unarchiveFromCacheWithFileName:ArchiverName_SchoolDataArray])) {
//                ws.noDataPromptView.titleLabel.text = @"暂无合作教练信息";
//                ws.noDataPromptView.subTitleLabel.text = @"请切换合作城市";
//                [ws.tableView addSubview:ws.noDataPromptView];
//            }
            [ws.tableView addSubview:self.noDataPromptView];
        }
    }];
    [_coachViewModel dvv_setNetworkCallBackBlock:^{
        [DVVToast hideFromView:ws.view];
        [ws.tableView.mj_header endRefreshing];
        [ws.tableView.mj_footer endRefreshing];
        [ws hideSearchView];
    }];
    [_coachViewModel dvv_setNetworkErrorBlock:^{
        if (!(NSMutableArray *)([ws dvv_unarchiveFromCacheWithFileName:ArchiverName_SchoolDataArray])) {
            ws.noDataPromptView.titleLabel.text = @"网络错误";
            ws.noDataPromptView.subTitleLabel.text = @"";
            [ws.tableView addSubview:ws.noDataPromptView];
        }
        [ws obj_showTotasViewWithMes:@"网络错误"];
    }];
}

#pragma mark - config refresh
- (void)configRefresh {
    
    __weak typeof(self) ws = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self cancelSearch];
        if (0 == ws.showType) {
            [ws.schoolViewModel dvv_networkRequestRefresh];
        }else {
            [ws.coachViewModel dvv_networkRequestRefresh];
        }
    }];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (0 == ws.showType) {
            [ws.schoolViewModel dvv_networkRequestLoadMore];
        }else {
            [ws.coachViewModel dvv_networkRequestLoadMore];
        }
    }];
    _tableView.mj_header = header;
    _tableView.mj_footer = footer;
}

#pragma mark - 右上角的定位
- (void)beginLocation {
    
    // 先加载缓存数据
    [self loadDataFromCache];
    
    _locationLabel.text = @"定位中";
    [DVVToast show];
    [DVVLocation reverseGeoCode:^(BMKReverseGeoCodeResult *result,
                                  CLLocationCoordinate2D coordinate,
                                  NSString *city,
                                  NSString *address) {
        [DVVToast hide];
        _locationLabel.text = city;
        [self saveUserLocationInfoWithCity:city address:address coordinate:coordinate];
        
        _schoolViewModel.cityName = city;
        _schoolViewModel.latitude = coordinate.latitude;
        _schoolViewModel.longitude = coordinate.longitude;
        
        _coachViewModel.cityName = city;
        _coachViewModel.latitude = coordinate.latitude;
        _coachViewModel.longitude = coordinate.longitude;
        
        [self beginRefresh];
        
    } error:^{
        [DVVToast hide];
        _locationLabel.text = @"北京市";
        [self beginRefresh];
    }];
}

#pragma mark 保存用户当前定位到的城市信息
- (void)saveUserLocationInfoWithCity:(NSString *)city
                             address:(NSString *)address
                          coordinate:(CLLocationCoordinate2D)coordinate {
    
    [AcountManager manager].userCity = city;
    [AcountManager manager].locationAddress = address;
    [AcountManager manager].latitude = [NSString stringWithFormat:@"%lf", coordinate.latitude];
    [AcountManager manager].longitude = [NSString stringWithFormat:@"%lf", coordinate.longitude];
}

#pragma mark - lazy load
//- (UIView *)titleView {
//    if (!_titleView) {
//        _titleView = [UIView new];
//        _titleView.frame = CGRectMake(0, 0, 30*2 + 40, 44);
//    }
//    return _titleView;
//}
//- (UILabel *)titleLabel {
//    if (!_titleLabel) {
//        _titleLabel = [UILabel new];
//        _titleLabel.font = [UIFont systemFontOfSize:17];
//        _titleLabel.textColor = [UIColor whiteColor];
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.text = @"驾校";
//        _titleLabel.frame = CGRectMake(0, 0, 30*2 + 40, 44);
//    }
//    return _titleLabel;
//}
//- (UIButton *)titleLeftButton {
//    if (!_titleLeftButton) {
//        _titleLeftButton = [UIButton new];
//        [_titleLeftButton setImage:[UIImage imageNamed:@"signup_titleLeftButton_icon"] forState:UIControlStateNormal];
//        _titleLeftButton.frame = CGRectMake(0, 0, 30, 44);
//        [_titleLeftButton addTarget:self action:@selector(selectSchoolOrCoachAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _titleLeftButton;
//}
//- (UIButton *)titleRightButton {
//    if (!_titleRightButton) {
//        _titleRightButton = [UIButton new];
//        [_titleRightButton setImage:[UIImage imageNamed:@"signup_titleRightButton_icon"] forState:UIControlStateNormal];
//        _titleRightButton.frame = CGRectMake(30 + 40, 0, 30, 44);
//        [_titleRightButton addTarget:self action:@selector(selectSchoolOrCoachAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _titleRightButton;
//}

- (UISegmentedControl *)segment {
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[ @"驾校", @"教练" ]];
        _segment.frame = CGRectMake(100, 100, 100, 30);
        _segment.tintColor = [UIColor whiteColor];
        [_segment addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
        _segment.selectedSegmentIndex = 0;
    }
    return _segment;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [UILabel new];
        _locationLabel.textAlignment = NSTextAlignmentRight;
        _locationLabel.textColor = [UIColor whiteColor];
        _locationLabel.text = @"定位中";
        _locationLabel.font = [UIFont systemFontOfSize:14];
        _locationLabel.frame = CGRectMake(0, 0, 70, 44);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationLabelAction)];
        [_locationLabel addGestureRecognizer:tap];
        _locationLabel.userInteractionEnabled = YES;
    }
    return _locationLabel;
}

- (DVVSignUpToolBarView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [DVVSignUpToolBarView new];
        
        _toolBarView.titleNormalColor = [UIColor colorWithHexString:@"6e6e6e"];
        _toolBarView.titleSelectColor = YBNavigationBarBgColor;
        _toolBarView.followBarColor = YBNavigationBarBgColor;
        
        _toolBarView.layer.shadowColor = [UIColor blackColor].CGColor;
        _toolBarView.layer.shadowOffset = CGSizeMake(0, 2);
        _toolBarView.layer.shadowOpacity = 0.3;
        _toolBarView.layer.shadowRadius = 2;
        
        _toolBarView.titleArray = @[ @"评分最高", @"价格最低", @"综合排序" ];
        __weak typeof(self) ws = self;
        [_toolBarView dvvToolBarViewItemSelected:^(UIButton *button) {
            [ws dvvToolBarViewItemSelectedAction:button.tag];
        }];
        
        if (ScreenWidthIs_6Plus_OrWider) {
            _toolBarView.titleFont = [UIFont systemFontOfSize:14*YBRatio];
        }
    }
    return _toolBarView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView= [UITableView new];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        _tableView.clipsToBounds = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DVVSignUpSchoolCell class] forCellReuseIdentifier:schoolCellID];
        [_tableView registerClass:[DVVSignUpCoachCell class] forCellReuseIdentifier:coachCellID];
        
        _searchContentView = [UIView new];
        _searchContentView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        _searchContentView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
        [_searchContentView addSubview:self.searchView];
        _tableView.tableHeaderView = _searchContentView;
    }
    return _tableView;
}
- (DVVSearchView *)searchView {
    if (!_searchView) {
        _searchView = [DVVSearchView new];
        _searchView.backgroundImageView.backgroundColor = [UIColor whiteColor];
        _searchView.frame = CGRectMake(16, 7, self.view.bounds.size.width - 16 * 2, _searchView.defaultHeight);
        __weak typeof(self) ws = self;
        [_searchView dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField) {
            [ws dvvTextFieldDidEndEditingAction:textField];
        }];
        [_searchView dvv_setTextFieldDidBeginEditingBlock:^(UITextField *textField) {
            [ws dvvTextFieldDidBeginEditingAction:textField];
        }];
    }
    return _searchView;
}

- (DVVNoDataPromptView *)noDataPromptView {
    if (!_noDataPromptView) {
        _noDataPromptView = [[DVVNoDataPromptView alloc] initWithTitle:@"暂无数据" image:[UIImage imageNamed:@"app_error_robot"]];
    }
    return _noDataPromptView;
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
