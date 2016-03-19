//
//  DrivingDetailController.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailController.h"
#import "DrivingDetailAddressCell.h"
#import "DrivingDetailInfoCell.h"
#import "DrivingDetailBriefIntroductionCell.h"
#import "DrivingDetailTrainingGroundCell.h"
#import "DrivingDetailSignUpCell.h"
#import "DrivingDetailViewModel.h"

#import "ShuttleBusController.h"
#import "CoachListController.h"
#import "DVVToast.h"

#import "SchoolClassDetailController.h"
#import "SignUpController.h"
#import "serverclasslistModel.h"

#import "DrivingDetailTableHeaderView.h"
#import "DrivingDetailLocationCell.h"

#import "DVVSignUpToolBarView.h"
#import "AppDelegate.h"

#import "DVVSignUpDetailController.h"

#import "DVVNoDataPromptView.h"

#import "JZMainSignUpController.h"

#import "DrivingDetailItemCell.h"
#import "DrivingDetailTopItemCell.h"
#import "DrivingDetailCoachInfoController.h"

@interface DrivingDetailController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    UIImageView*navBarHairlineImageView;
}

@property (nonatomic, strong) DrivingDetailTableHeaderView *tableHeaderView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) __block BOOL isShowMore;

@property (nonatomic, strong) DrivingDetailViewModel *viewModel;

// 这个要动态调高度，放里面不好动态调  而且也没有复用性   所以放这里
@property (nonatomic, strong) DrivingDetailAddressCell *addressCell;
@property (nonatomic, strong) DrivingDetailSignUpCell *signUpCell;
@property (nonatomic, strong) DrivingDetailBriefIntroductionCell *introductionCell;
@property (nonatomic, strong) UIButton *shuttleBusButton;
@property (nonatomic, strong) UIButton *phoneButton;

@property (nonatomic, strong) DVVSignUpToolBarView *toolBarView;

@property (nonatomic, strong) DVVNoDataPromptView *noDataPromptView;

@property (nonatomic, assign) BOOL isLoaded;

@property (nonatomic,strong) DrivingDetailItemCell *drivingDetailsCell;

@end

@implementation DrivingDetailController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ((AppDelegate *)([UIApplication sharedApplication].delegate)).window.backgroundColor = YBNavigationBarBgColor;
    
    self.edgesForExtendedLayout = NO;
    self.title = @"驾校详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    
    NSLog(@"%@", _schoolID);

    // 测试时打开
//    _schoolID = @"562dcc3ccb90f25c3bde40da";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.tableHeaderView];
    
    // 添加有上角的班车和拨打电话
    _shuttleBusButton = [UIButton new];
    [_shuttleBusButton setImage:[UIImage imageNamed:@"bus_white_icon"] forState:UIControlStateNormal];
    _shuttleBusButton.bounds = CGRectMake(0, 0, 24, 44);
    [_shuttleBusButton addTarget:self action:@selector(shuttleBusMoreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _phoneButton = [UIButton new];
    [_phoneButton setImage:[UIImage imageNamed:@"phone_white_icon"] forState:UIControlStateNormal];
    _phoneButton.bounds = CGRectMake(0, 0, 24, 44);
    [_phoneButton addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbiBus = [[UIBarButtonItem alloc] initWithCustomView:_shuttleBusButton];
    UIBarButtonItem *bbiPhone = [[UIBarButtonItem alloc] initWithCustomView:_phoneButton];
    self.navigationItem.rightBarButtonItems = @[ bbiPhone, bbiBus ];
    
    [self configViewModel];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    
    UINavigationBar *bar = self.navigationController.navigationBar;
    // 背景色
    [bar setBackgroundColor:[UIColor clearColor]];
    // 背景图片
    [bar setBackgroundImage:[UIImage imageNamed:@"透明"] forBarMetrics:UIBarMetricsDefault];
    // 打开透明效果
    [bar setTranslucent:YES];
    _isLoaded = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    navBarHairlineImageView.hidden=NO;
    
    UINavigationBar *bar = self.navigationController.navigationBar;
    // 背景色
    [bar setBackgroundColor:YBNavigationBarBgColor];
    // 背景图片
    [bar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    // 去掉透明效果
    [bar setTranslucent:NO];
    
    [DVVToast hide];
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

#pragma mark - config view model
- (void)configViewModel {
    
    _viewModel = [DrivingDetailViewModel new];
    _viewModel.schoolID = _schoolID;
    __weak typeof(self) ws = self;
    [_viewModel dvvSetRefreshSuccessBlock:^{
        [ws.tableView reloadData];
        [ws.tableHeaderView refreshData:_viewModel.dmData];
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
//        [ws obj_showTotasViewWithMes:@"加载失败"];
        [ws.view addSubview:ws.noDataPromptView];
    }];
    
    [_viewModel dvvSetNilResponseObjectBlock:^{
//        [ws obj_showTotasViewWithMes:@"没有数据"];
        [ws.view addSubview:ws.noDataPromptView];
    }];
    [_viewModel dvvSetNetworkErrorBlock:^{
//        [ws obj_showTotasViewWithMes:@"网络错误"];
        [ws.view addSubview:ws.noDataPromptView];
    }];
    [_viewModel dvvSetNetworkCallBackBlock:^{
        [DVVToast hide];
    }];
    
    [DVVToast show];
    [_viewModel dvvNetworkRequestRefresh];
}

#pragma mark - action

#pragma mark - 拨打电话
- (void)callPhone {
    if (_viewModel.dmData.phone && _viewModel.dmData.phone.length) {
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@", _viewModel.dmData.phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:callWebview];
    }else {
        [self obj_showTotasViewWithMes:@"暂无电话信息"];
    }
}

#pragma mark 班车路线
- (void)shuttleBusMoreButtonAction {
    
    if (!_viewModel.dmData.schoolbusroute || !_viewModel.dmData.schoolbusroute.count) {
        [self obj_showTotasViewWithMes:@"暂无班车信息"];
        return ;
    }
    ShuttleBusController *busVC = [ShuttleBusController new];
    busVC.dataArray = _viewModel.dmData.schoolbusroute;
    [self.navigationController pushViewController:busVC animated:YES];
}

#pragma mark 班型选择、教练信息切换
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    
    NSLog(@"班型选择、教练信息切换index:%ld",(long)index);
    
    if (0 == index) {
        [_signUpCell courseButtonAction];
    }else {
        [_signUpCell coachButtonAction];
    }
}

#pragma mark 更多教练
- (void)allCoachInSchoolAction:(UIButton *)sender {
    
    if (sender.tag) {
        return ;
    }
    CoachListController *coachListVC = [CoachListController new];
    coachListVC.schoolID = _schoolID;
    [self.navigationController pushViewController:coachListVC animated:YES];
}
#pragma mark 班型cell单击事件
- (void)classTypeCellDidSelectAction:(ClassTypeDMData *)dmData {
    SchoolClassDetailController *schoolClassDetailVC = [[SchoolClassDetailController alloc] init];
    schoolClassDetailVC.classTypeDMData = dmData;
    [self.navigationController pushViewController:schoolClassDetailVC animated:YES];
}
#pragma mark 班型cell中的报名按钮单击事件
- (void)signUpButtonAction:(ClassTypeDMData *)dmData {
    
    JZMainSignUpController *vc = [JZMainSignUpController new];
    vc.dmData = dmData;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark 教练cell的点击事件
- (void)coachListViewCellDidSelectAction:(CoachListDMData *)dmData {
    
}

#pragma mark - table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_viewModel.dmData) {
        return 4;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 4;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (0 == indexPath.section) {
        
        return 44;

    }else if (indexPath.section==1){// 驾校详情
        
        return [DrivingDetailItemCell cellHeightDmData:_viewModel.dmData];
        
    }else if (indexPath.section==2){// 教练信息
        
        return 44;
        
    }else{
        
        // 报名（班型和教练信息）
        return [self.signUpCell dynamicHeight];
        
    }
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (3 == section) {
        return 44;
    }else {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section!=3) {
        return 10;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (3 == section) {
        return self.toolBarView;
    }else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        DrivingDetailTopItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (cell==nil) {
            cell = [[DrivingDetailTopItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delive.hidden = NO;
        
        if (0 == indexPath.row) {
          
            cell.leftLabel.text = @"价格:";
            cell.detailsLabel.text = [NSString stringWithFormat:@"%ld-%ld",(long)_viewModel.dmData.minprice,(long)_viewModel.dmData.maxprice];
            cell.detailsLabel.textColor = YBNavigationBarBgColor;
            cell.imgView.image = [UIImage imageNamed:@"YBDringDetailsmoney"];

        }else if (indexPath.row == 1){
            
            cell.leftLabel.text = @"地址:";
            cell.detailsLabel.text = _viewModel.dmData.address;
            cell.detailsLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
            cell.imgView.image = [UIImage imageNamed:@"YBDringDetailslocation"];

        }else if (indexPath.row == 2){
            
            cell.leftLabel.text = @"通过率:";
            cell.detailsLabel.text = [NSString stringWithFormat:@"%ld%",(long)_viewModel.dmData.passingrate];
            cell.detailsLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
            cell.imgView.image = [UIImage imageNamed:@"YBDringDetailspass"];

        }else if (indexPath.row == 3){
            
            cell.leftLabel.text = @"营业时间:";
            cell.detailsLabel.text = [NSString stringWithFormat:@"%@",_viewModel.dmData.hours];
            cell.detailsLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
            cell.imgView.image = [UIImage imageNamed:@"YBDringDetailstime"];
            cell.delive.hidden = YES;
            
        }
        
        return cell;
        
    }else if (indexPath.section == 1){// 驾校详情
        
        DrivingDetailItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrivingDetailItemCell"];
        if (cell==nil) {
            cell = [[DrivingDetailItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DrivingDetailItemCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.drivingDetailsCell = cell;
        
        cell.dmData = _viewModel.dmData;
        
        cell.detailsLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreBtnDidClick)];
        [cell.detailsLabel addGestureRecognizer:tap];
        
        return cell;
        
    }else if (indexPath.section == 2){// 教练信息
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
        if (YBIphone6Plus) {
            cell.textLabel.font = [UIFont boldSystemFontOfSize:13*1.5];
        }
        cell.textLabel.text = @"教练信息";
        
        return cell;

    }else{
        
        // 报名（班型和教练信息）
        return self.signUpCell;
        
    }
    
    return nil;
}

-(void)moreBtnDidClick
{
    _viewModel.dmData.isMore = !_viewModel.dmData.isMore;
        
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        NSLog(@"教练信息");
        DrivingDetailCoachInfoController *vc = [[DrivingDetailCoachInfoController alloc] init];
        vc.schoolID = _schoolID;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat centerY = [UIScreen mainScreen].bounds.size.width*0.7;
    CGFloat centerX = [UIScreen mainScreen].bounds.size.width - 16 - 63/2.f;
    CGFloat height = centerY;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    NSLog(@"%f",  _tableView.frame.origin.y);
    if (offsetY > 0) {
        NSLog(@"offsetY大于0");

        if (_tableView.frame.origin.y > 0) {
            
            CGFloat originY = _tableView.frame.origin.y - offsetY;
            if (originY < 0) {
                _tableHeaderView.frame = CGRectMake(0, - height, _tableHeaderView.frame.size.width, _tableHeaderView.frame.size.height);
                _tableView.frame = CGRectMake(0, 0, _tableView.frame.size.width, _tableView.frame.size.height);
            }else {
                _tableHeaderView.frame = CGRectMake(0, _tableHeaderView.frame.origin.y - offsetY, _tableHeaderView.frame.size.width, _tableHeaderView.frame.size.height);
                _tableView.frame = CGRectMake(0, _tableView.frame.origin.y - offsetY, _tableView.frame.size.width, _tableView.frame.size.height);
                _tableView.contentOffset = CGPointMake(0, 0);
            }
        }
    }
    if (offsetY < 0 ) {
        NSLog(@"offsetY小于0");
        if (_tableView.frame.origin.y < height - 64) {
            
            CGFloat originY = _tableView.frame.origin.y - offsetY;
            if (originY > height - 64) {
                _tableHeaderView.frame = CGRectMake(0, -64, _tableHeaderView.frame.size.width, _tableHeaderView.frame.size.height);
                _tableView.frame = CGRectMake(0, height - 64, _tableView.frame.size.width, _tableView.frame.size.height);
            }else {
                _tableHeaderView.frame = CGRectMake(0, _tableHeaderView.frame.origin.y - offsetY, _tableHeaderView.frame.size.width, _tableHeaderView.frame.size.height);
                _tableView.frame = CGRectMake(0, _tableView.frame.origin.y - offsetY, _tableView.frame.size.width, _tableView.frame.size.height);
                _tableView.contentOffset = CGPointMake(0, 0);
            }
        }
    }
    
    if (_tableView.frame.origin.y < 64) {
        
        [UIView animateWithDuration:0.3 animations:^{
            _tableHeaderView.collectionImageView.size = CGSizeMake(0, 0);
            _tableHeaderView.collectionImageView.center = CGPointMake(centerX, centerY);
            _tableHeaderView.collectionImageView.alpha = 0;
            
            _tableHeaderView.alphaView.backgroundColor = YBNavigationBarBgColor;
        }];
    }else {
        
        [UIView animateWithDuration:0.3 animations:^{
            _tableHeaderView.collectionImageView.size = CGSizeMake(63, 63);
            _tableHeaderView.collectionImageView.center = CGPointMake(centerX, centerY);
            _tableHeaderView.collectionImageView.alpha = 1;
            
            _tableHeaderView.alphaView.backgroundColor = [UIColor clearColor];
        }];
    }
    
    // 取消tableView底部的弹簧效果的方法
    CGFloat maxOffsetY = _tableView.contentSize.height - _tableView.bounds.size.height;
    if (offsetY > maxOffsetY) {
        _tableView.contentOffset = CGPointMake(0, maxOffsetY);
    }
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, [DrivingDetailTableHeaderView defaultHeight] - 64, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UITableView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (DrivingDetailTableHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [DrivingDetailTableHeaderView new];
        _tableHeaderView.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, [DrivingDetailTableHeaderView defaultHeight]);
        _tableHeaderView.schoolID = _schoolID;
    }
    return _tableHeaderView;
}

- (DrivingDetailBriefIntroductionCell *)introductionCell {
    if (!_introductionCell) {
        _introductionCell = [[DrivingDetailBriefIntroductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kIntroCell"];
        __weak typeof(self) ws = self;
        [_introductionCell setShowMoreButtonTouchDownBlock:^(BOOL isShowMore) {
            
            ws.isShowMore = isShowMore;
            [ws.tableView reloadData];
            
        }];
    }
    return _introductionCell;
}

- (DrivingDetailSignUpCell *)signUpCell {
    if (!_signUpCell) {
        _signUpCell = [[DrivingDetailSignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kSignUpCell"];
        __weak typeof(self) ws = self;
        [_signUpCell.classTypeView setClassTypeSignUpButtonActionBlock:^(ClassTypeDMData *dmData) {
            [ws signUpButtonAction:dmData];
        }];
        [_signUpCell.classTypeView setClassTypeViewCellDidSelectBlock:^(ClassTypeDMData *dmData) {
            [ws classTypeCellDidSelectAction:dmData];
        }];
        [_signUpCell.coachListView setCoachListViewCellDidSelectBlock:^(CoachListDMData *dmData) {
            [ws coachListViewCellDidSelectAction:dmData];
        }];
        [_signUpCell.coachListView.bottomButton addTarget:self action:@selector(allCoachInSchoolAction:) forControlEvents:UIControlEventTouchUpInside];
        _signUpCell.tableView = self.tableView;
        _signUpCell.schoolID = _schoolID;
    }
    return _signUpCell;
}

- (DVVSignUpToolBarView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [DVVSignUpToolBarView new];
        _toolBarView.backgroundColor = [UIColor whiteColor];;
//        _toolBarView.layer.shadowColor = [UIColor blackColor].CGColor;
//        _toolBarView.layer.shadowOffset = CGSizeMake(0, 2);
//        _toolBarView.layer.shadowOpacity = 0.3;
//        _toolBarView.layer.shadowRadius = 2;
        _toolBarView.titleNormalColor = [UIColor colorWithHexString:@"6e6e6e"];
        _toolBarView.titleSelectColor = [UIColor colorWithHexString:@"6e6e6e"];
        _toolBarView.textAlignment = NSTextAlignmentLeft;
        _toolBarView.titleFont = [UIFont boldSystemFontOfSize:13];
        if (YBIphone6Plus) {
            _toolBarView.titleFont = [UIFont boldSystemFontOfSize:13*1.5];
        }
        _toolBarView.followBarColor = [UIColor lightGrayColor];
        _toolBarView.followBarHeight = 0.5;
        _toolBarView.followBarAlpha = 0.3;
        _toolBarView.titleArray = @[@"课程班型"];

        __weak typeof(self) ws = self;
        [_toolBarView dvvToolBarViewItemSelected:^(UIButton *button) {
            [ws dvvToolBarViewItemSelectedAction:button.tag];
        }];
    }
    return _toolBarView;
}

- (DVVNoDataPromptView *)noDataPromptView {
    if (!_noDataPromptView) {
        _noDataPromptView = [[DVVNoDataPromptView alloc] initWithTitle:@"加载失败" image:[UIImage imageNamed:@"app_error_robot"]];
        _noDataPromptView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
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
