//
//  CardViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/10.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "DrivingViewController.h"
#import "JGDrivingDetailViewController.h"
#import "DrivingCell.h"
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
#import "DrivingDetailViewController.h"
#import "CoachTableViewCell.h"
#import "SearchCoachViewModel.h"
#import "CoachDMData.h"
#import "DrivingDetailController.h"
#import "DVVLocation.h"
#import "HomeCheckProgressView.h"
#import "JGPayTool.h"
#import "SignUpFirmOrderController.h"

static NSString *const kDrivingUrl = @"searchschool";

#define selectHeadViewH 35
#define searchHeadViewH selectHeadViewH

@interface DrivingViewController ()<UITableViewDelegate, UITableViewDataSource,JENetwokingDelegate, UITextFieldDelegate, UIAlertViewDelegate,UIScrollViewDelegate>

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

@property (nonatomic,weak) DrivingSelectMotorcycleTypeView *typeView;

@property (nonatomic, strong) SearchCoachViewModel *searchCoachViewModel;

@property (nonatomic, assign) BOOL isRefresh;

// 搜索参数
// 车型选择(服务器返回类型)
@property (nonatomic, assign) NSInteger licensetype;
// 0 默认 1距离 2评分 3价格
@property (nonatomic, assign) NSInteger ordertype;

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
// 可选
@property (nonatomic, assign) NSInteger radius;
// 城市名称
@property (nonatomic, copy) NSString *cityname;
// 搜索名字（coachname schoolname）
@property (nonatomic, copy) NSString *searchName;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger count;

// 0:找驾校 1:找教练
@property (nonatomic,assign) NSInteger selectType;

@property (nonatomic,strong) HomeCheckProgressView *vc;

@end

@implementation DrivingViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _licensetype = 0;
    _ordertype = 0;
    _radius = 10000;
    _searchName = @"";
    _index = 1;
    _count = 10;

    _selectType = 0;
    
    self.title = @"一步学车";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    [self.view addSubview:self.tableHeaderView];
    
    [self.view addSubview:self.tableView];
    
    [self configViewModel];
    
    // 初始化网络请求刷新控件
    [self configRefresh];
    [self.tableView.mj_header beginRefreshing];
    
    // 初始化筛选模式（找驾校、找教练）
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightselectjiaolian];
    self.navigationItem.rightBarButtonItem = rightItem;
    if (1 == _isHideItem) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
        // 定位
    __weak typeof(self) ws = self;
    [DVVLocation getLocation:^(BMKUserLocation *userLocation, double latitude, double longitude) {
        
        ws.latitude = latitude;
        ws.longitude = longitude;
        
    } error:^{
        
        ws.latitude = 39.929985778080237;
        ws.longitude = 116.39564503787867;
        
    }];
    
    // 判断上次是否有尚未支付的订单
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isAlipayError = [user boolForKey:isPayErrorKey];
    NSDictionary *payDict = [user objectForKey:payErrorWithDictKey];
    NSString *phone = [user objectForKey:payErrorWithPhone];
    
    __weak DrivingViewController *weakSelf = self;
    
    if (isAlipayError) {
        NSLog(@"上次还有尚未支付的订单");
        
        _vc = [[HomeCheckProgressView alloc] init];
        _vc.topLabel.text = @"您有未完成的订单,是否需要立即支付";
        [_vc.rightButtton setTitle:@"重新报名" forState:UIControlStateNormal];
        [_vc.wrongButton setTitle:@"立即支付" forState:UIControlStateNormal];
        _vc.didClickBlock = ^(NSInteger tag){
            
            if (tag==200) {// 立即支付
                
                SignUpFirmOrderController *vc = [[SignUpFirmOrderController alloc] init];
                vc.extraDict = payDict;
                vc.mobile = phone;
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            }else if (tag==201){// 重新报名
                [weakSelf.vc removeFromSuperview];
            }
            
        };
        _vc.frame = [UIApplication sharedApplication].keyWindow.rootViewController.view.bounds;
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_vc];
        
    }
    
    
}

#pragma mark - 刷新和加载
- (void)configRefresh {
    
    __weak typeof(self) ws = self;
    // 刷新
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        ws.isRefresh = YES;
        
        if (ws.selectType==1) {// 找教练
            
            _searchCoachViewModel.index = 1;
            _searchCoachViewModel.orderType = ws.ordertype;
            _searchCoachViewModel.licenseType = self.licensetype;
            _searchCoachViewModel.searchName = self.searchName;
            
            [ws refresh];
            
        }else{// 0:找驾校
            
            ws.index = 1;

            [ws network];
        }
        
    }];
    // 加载
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        ws.isRefresh = NO;

        if (ws.selectType==1) {//
            
            [ws.searchCoachViewModel dvvNetworkRequestLoadMore];
            
        }else{// 0:找驾校
            
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
            ws.index = index;
            
            [ws network];
        }
        
    }];
    
    self.tableView.mj_header = refreshHeader;
    self.tableView.mj_footer = refreshFooter;
   
}

- (void)network
{
    
    // 判断字符串是否null
    if (![self.cityname isKindOfClass:[NSNull class]]) {
        self.cityname = @"";
    }
    if (!self.searchName || !self.searchName.length) {
        self.searchName = @"";
    }
    
    NSString *latitude = [NSString stringWithFormat:@"%f", self.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", self.longitude];
    NSString *radius = [NSString stringWithFormat:@"%li", self.radius];
    NSString *cityName = [NSString stringWithFormat:@"%@", self.cityname];
    NSString *carTypeId = [NSString stringWithFormat:@"%li", self.licensetype];
    NSString *searchName = [NSString stringWithFormat:@"%@", self.searchName];
    NSString *filterType = [NSString stringWithFormat:@"%li", self.ordertype];
    NSString *index = [NSString stringWithFormat:@"%li", self.index];
    NSString *count = [NSString stringWithFormat:@"%li", self.count];
    
    NSDictionary *params = @{ @"latitude": latitude,
                          @"longitude": longitude,
                          @"radius": radius,
                          @"cityname": cityName,
                          @"licensetype": carTypeId,
                          @"schoolname": searchName,
                          @"ordertype": filterType,
                          @"index": index,
                          @"count": count };

    NSString *url = [NSString stringWithFormat:BASEURL,kDrivingUrl];
    
    [JENetwoking startDownLoadWithUrl:url postParam:params WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        [self jeNetworkingCallBackData:data];
        
    } withFailure:^(id data) {
        [self showTotasViewWithMes:@"网络错误"];
    }];
}

- (void)jeNetworkingCallBackData:(id)data {
    
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
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
   
    // 设置contentInset隐藏搜索框
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(-searchHeadViewH, 0, 0, 0);
    }];
    
    if (!self.dataArray.count) {
        [self showTotasViewWithMes:@"没有找到数据"];
    }
}
#pragma mark - 找教练
- (void)refresh
{
    [_searchCoachViewModel dvvNetworkRequestRefresh];
    
}
#pragma mark - config viewModel
- (void)configViewModel {
    
    _searchCoachViewModel = [SearchCoachViewModel new];
    __weak typeof(self) ws = self;
    
    [_searchCoachViewModel dvvSetRefreshSuccessBlock:^{
        
        if (0 == _searchCoachViewModel.dataArray.count && 0 == _searchCoachViewModel.licenseType && 0 == _searchCoachViewModel.orderType) {
            
            [BLPFAlertView showAlertWithTitle:@"提示" message:@"对不起，该地区暂无合作教练。如有疑问，请致电 400-626-9255"cancelButtonTitle:@"返回" otherButtonTitles:nil completion:^(NSUInteger selectedOtherButtonIndex) {
                DYNSLog(@"selected = %ld",selectedOtherButtonIndex);
                [ws.navigationController popViewControllerAnimated:YES];
            }];
            
        }
        
        [ws.tableView reloadData];
        
        [ws.tableView.mj_header endRefreshing];
        [ws.tableView.mj_footer endRefreshing];
        
        NSLog(@"ws.tableView.contentInset.top:%f",ws.tableView.contentInset.top);
        
        // 设置contentInset隐藏搜索框
        [UIView animateWithDuration:0.5 animations:^{
            ws.tableView.contentInset = UIEdgeInsetsMake(-searchHeadViewH, 0, 0, 0);
        }];
        
        NSLog(@"设置contentInset隐藏搜索框 ws.tableView.contentInset.top:%f",ws.tableView.contentInset.top);
        
    }];
    
    [_searchCoachViewModel dvvSetLoadMoreSuccessBlock:^{
        
        [ws.tableView reloadData];
        
        [ws.tableView.mj_footer endRefreshing];
        
    }];
    
    
}

#pragma mark - tableViwe
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    if (self.selectType==1) {
        return _searchCoachViewModel.dataArray.count;
    }
    
    if (self.dataArray.count == 0) {
        tableView.hidden = NO;
    }else {
        tableView.hidden = NO;
    }
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectType==1) {// 找教练
        
        static NSString *cellIdentifier = @"cellIdentifier";
        CoachTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[CoachTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.isSelectCoachVc = YES;
        
        CoachDMData *model = _searchCoachViewModel.dataArray[indexPath.row];
       
        [cell refreshData:model];
        
        return cell;
    }
    
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
    // 验证学车进度点击驾校列表直接返回,
    if (1 == _isHideItem) {
        DrivingModel *model = self.dataArray[indexPath.row];
        if (model.name && model.schoolid) {
            DYNSLog(@"schoolinfo");
            NSDictionary *schoolParam = @{kRealSchoolid:model.schoolid,@"name":model.name};
            [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
        }

        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if (self.selectType==1) {// 教练详情
            CoachDMData *model = _searchCoachViewModel.dataArray[indexPath.row];
            JGDrivingDetailViewController *detailVC = [JGDrivingDetailViewController new];
            detailVC.coachUserId = model.coachid;
            [self.navigationController pushViewController:detailVC animated:YES];
            return;
        }
        // 驾校详情
        DrivingDetailController *SelectVC = [[DrivingDetailController alloc]init];
        DrivingModel *model = self.dataArray[indexPath.row];
        self.detailModel = model;
        SelectVC.schoolID = model.schoolid;
        [self.navigationController pushViewController:SelectVC animated:YES];

    }
    }

#pragma mark - lazy load
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
            
            self.ordertype = button.tag + 1;
            
            [self.tableView.mj_header beginRefreshing];
            
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

#pragma mark --- 车型选择
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
        
        [self.tableHeaderView.motorcycleTypeButton setTitle:selectedTitle forState:UIControlStateNormal];

        self.licensetype = carTypeId;
       
        [self.tableView.mj_header beginRefreshing];

    }];
    
    [self.view addSubview:typeView];
    
    [typeView show];
    
    self.typeView = typeView;
    
}

- (void)searchButtonAction:(UITextField *)textField {
    
    [self.view endEditing:YES];

    self.searchName = textField.text;
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    CGPoint offY = scrollView.contentOffset;
    NSLog(@"offY.y:%f",offY.y);
    NSLog(@"self.isRefresh:%d",self.isRefresh);
    NSLog(@"self.tableView.contentInset.top:%f",self.tableView.contentInset.top);
    
    if (self.selectType==1) {
        
        if (offY.y<=0) {// 不需要刷新
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            }];
        }else{// 刷新
//            [UIView animateWithDuration:0.5 animations:^{
//                self.tableView.contentInset = UIEdgeInsetsMake(-searchHeadViewH, 0, 0, 0);
//            }];
        }
        
    }else{
     
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
    
    
}

- (void)clickRight
{
    UIBarButtonItem *rightItem;
    if (self.selectType==0) {
        self.selectType=1;
        rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightselectjiaxiao];
    }else{
        self.selectType=0;
        rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightselectjiaolian];
    }
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // 刷新列表
    [self.tableView reloadData];
    
    // 刷新数据
    [self.tableView.mj_header beginRefreshing];
    
}

@end
