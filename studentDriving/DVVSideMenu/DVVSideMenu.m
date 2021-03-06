//
//  DVVSideMenu.m
//  DVVSideMenu
//
//  Created by 大威 on 15/12/22.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "DVVSideMenu.h"
#import "DVVOpenControllerFromSideMenu.h"
#import "DVVSideMenuHeaderView.h"
#import "DVVSideMenuFooterView.h"
#import "DVVSideMenuBlockView.h"

#import "MyWalletViewController.h"
#import "DiscountWalletController.h"

#import "UIButton+WebCache.h"
#import "AcountManager.h"
#import "DVVUserManager.h"

#import "EditorUserViewController.h"

#import "JENetwoking.h"

#import "CoinCertificateController.h"

#define AnimateDuration 0.4

@interface DVVSideMenu : UIViewController

@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UIImageView *contentBackgroundImageView;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * titleArray;
@property (nonatomic, strong) NSArray * normalImages;
@property (nonatomic, strong) NSArray * selectedImages;
@property (nonatomic, strong) NSArray * markTitleArray;

@property (nonatomic, strong) NSArray *blockTitleArray;
@property (nonatomic, strong) NSArray *blockImagesArray;

@property (nonatomic, strong) DVVSideMenuCell * lastSelectedCell;
@property (nonatomic, assign) NSInteger selectedIdx;

@property (nonatomic, strong) DVVSideMenuHeaderView *headerView;
@property (nonatomic, strong) DVVSideMenuFooterView *footerView;
@property (nonatomic, strong) DVVSideMenuBlockView *blockView;

// 用户豆币、兑换券和现金额
@property (nonatomic, strong) NSArray *moneyArray;

+ (instancetype)sharedMenu;

@end

@implementation UIViewController (DVVSideMenu)

#pragma mark - 显示到一个window上的方法
- (void)showSideMenu {
    
    DVVSideMenu *sideMenu = [DVVSideMenu sharedMenu];
    [self.view.window addSubview:sideMenu.view];
    
    // 动画显示出来
    CGRect rect = sideMenu.contentView.frame;
    rect.origin.x = 0;
    [UIView animateWithDuration:AnimateDuration animations:^{
        
        sideMenu.backgroundView.alpha = 0.1;
        sideMenu.contentView.frame = rect;
        
        [UIApplication sharedApplication].keyWindow.rootViewController.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.65, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
}

// 添加打开侧栏的按钮
- (void)addSideMenuButton {
    
    CGRect backframe= CGRectMake(0, 0, 24, 24);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:[UIImage imageNamed:@"side_menu_button"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(sideMenuButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)sideMenuButtonAction {
    
    [self showSideMenu];
}

@end

@interface DVVSideMenu ()<UITableViewDataSource, UITableViewDelegate>

- (void)removeSideMenu;

@end

@implementation DVVSideMenu

// 初始化（单例方法）
+ (instancetype)sharedMenu {
    
    static DVVSideMenu *sideMenu = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sideMenu = [self new];
    });
    return sideMenu;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    _selectedIdx = -1;
    
    _titleArray = @[ @"积分收益", @"商城兑换券", @"可取现金额" ];
    _moneyArray = @[ @"0", @"0", @"0" ];
    _markTitleArray = @[ @"Y币", @"张", @"元" ];
    
    _blockTitleArray = @[ @"报名", @"签到", @"投诉", @"消息", @"活动", @"商城", @"班车", @"优势", @"设置" ];
    _blockImagesArray = @[ @"side_menu_baoming",
                           @"iconfont-xiaoyuanqiandao",
                           @"side_menu_tousu",
                           @"iconfont-xiaoxi",
                           @"iconfont-huodong",
                           @"iconfont-shangcheng1",
                           @"side_menu_banche",
                           @"side_menu_youshi",
                           @"iconfont-shezhi" ];
    
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.contentView];
    [_contentView addSubview:self.contentBackgroundImageView];
    [_contentView addSubview:self.tableView];
    [_contentView addSubview:self.blockView];
    [_contentView addSubview:self.footerView];
    
    _contentBackgroundImageView.image = [UIImage imageNamed:@"side_menu_bg"];
    [self configLayout];
    self.tableView.tableHeaderView = self.headerView;
}

// 因为此侧边栏用static修饰了，所以在这里加载用户信息
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.headerView.iconButton setBackgroundImage:[UIImage imageNamed:@"side_user_header"] forState:UIControlStateNormal];
    self.headerView.nameLabel.text = @"用户名";
    self.headerView.drivingNameLabel.text = @"驾校：未报考";
    self.headerView.markLabel.text = @"我的Y码：暂无";
    _moneyArray = @[@"0",@"0",@"0"];
    [self.tableView reloadData];

    if (![AcountManager isLogin]) {
        return;
    }
    // 显示搜索的类型是驾校还是教练
//    [self.blockView setLocationShowType];
    // 设置头像
    [self.headerView.iconButton sd_setBackgroundImageWithURL:(NSURL *)[AcountManager manager].userHeadImageUrl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"side_user_header"]];
    // 用户名、报考驾校
    if ([AcountManager manager].userName && [AcountManager manager].userName.length) {
        self.headerView.nameLabel.text = [AcountManager manager].userName;
    }else {
        if ([AcountManager manager].userMobile) {
            self.headerView.nameLabel.text = [AcountManager manager].userMobile;
        }
    }
    if ([AcountManager manager].applyschool.name && [AcountManager manager].applyschool.name.length) {
        self.headerView.drivingNameLabel.text = [NSString stringWithFormat:@"驾校：%@", [AcountManager manager].applyschool.name];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"/userinfo/getmymoney?userid=%@&usertype=1", [AcountManager manager].userid];
    // 请求数据显示豆币相关信息
    [JENetwoking startDownLoadWithUrl:[NSString stringWithFormat:BASEURL,urlString] postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSLog(@"=== %@",data);
        NSDictionary *dict = data;
        if ([dict objectForKey:@"type"]) {
            NSDictionary *paramsDict = [dict objectForKey:@"data"];
            if (paramsDict) {
                NSString *fcode = [paramsDict objectForKey:@"fcode"];
                NSInteger wallet = [[paramsDict objectForKey:@"wallet"] integerValue];
                NSInteger money = [[paramsDict objectForKey:@"money"] integerValue];
                NSInteger couponcount = [[paramsDict objectForKey:@"couponcount"] integerValue];
                if (fcode && fcode.length) {
                    self.headerView.markLabel.text = [NSString stringWithFormat:@"我的Y码：%@", fcode];
                }
                _moneyArray = @[ [NSString stringWithFormat:@"%li", wallet],
                                 [NSString stringWithFormat:@"%li", couponcount],
                                 [NSString stringWithFormat:@"%li", money] ];
                [self.tableView reloadData];
                // 显示我的优惠券信息
                NSString *couponString = @"";
                if (couponcount) {
                    couponString = [NSString stringWithFormat:@"还有%li张兑换券(点击兑换)",couponcount];
                }
                self.headerView.coinCertificateLabel.text = couponString;
                // 存储兑换券
                [AcountManager manager].userCoinCertificate = couponcount;
            }
        }
    }];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 检查新消息
    [self.blockView setupUnreadMessageCount];
}

#pragma mark - action
#pragma mark 头像的点击事件
- (void)iconButtonAction:(UIButton *)sender {
    
    _selectedIdx = -1;
    [self removeSideMenu];
    if ([AcountManager isLogin]) {
        // 登录状态
        EditorUserViewController *editorUserVC = [EditorUserViewController new];
        [(UINavigationController *)([UIApplication sharedApplication].keyWindow.rootViewController) pushViewController:editorUserVC animated:YES];
        
        
    }else {
        // 未登录状态
        [DVVUserManager userNeedLogin];
    }
}
#pragma mark 兑换券
- (void)coinCertificateLabelAction {
    if (![AcountManager manager].userCoinCertificate) {
//        [self showMsg:@"暂无兑换券"];
        return ;
    }
    CoinCertificateController *ccVC = [CoinCertificateController new];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UINavigationController *naviVC = (UINavigationController *)(window.rootViewController);
    [naviVC pushViewController:ccVC animated:YES];
    [self removeSideMenu];
}
#pragma mark 方块的点击事件
- (void)blockAction:(UIButton *)button {
    
    // 设置当前点击的项（用于打开对应的窗体）
    _selectedIdx = button.tag;
    
    if ([AcountManager manager].userLocationShowType == kLocationShowTypeCoach && _selectedIdx == kOpenControllerTypeDrivingViewController) {
//        [self showMsg:@"您所在的地区暂无合作驾校，建议您搜索教练试一试"];
        ToastAlertView *toast = [[ToastAlertView alloc] initWithTitle:@"您所在的地区暂无合作驾校,请搜索教练"];
        [toast show];
    }else {
        // 打开相应的窗体
        [DVVOpenControllerFromSideMenu openControllerWithControllerType:[self checkControllerTypeWithIndex:_selectedIdx]];
        // 移除sideMenu
        [self removeSideMenu];
    }
}
- (kOpenControllerType)checkControllerTypeWithIndex:(NSInteger)index {
    kOpenControllerType type = -1;
    switch (index) {
            
        case 0:
            type = kOpenControllerTypeDrivingViewController;
            break;
        case 1:
            type = kOpenControllerTypeSignInViewController;
            break;
        case 2:
            type = kOpenControllerTypeComplaintController;
            break;
        case 3:
            type = kOpenControllerTypeChatListViewController;
            break;
        case 4:
            type = kOpenControllerTypeHomeActivityController;
            break;
        case 5:
            type = kOpenControllerTypeMyWalletViewController;
            break;
        case 6:
            type = kOpenControllerTypeShuttleBusController;
            break;
        case 7:
            type = kOpenControllerTypeHomeAdvantageController;
            break;
        case 8:
            type = kOpenControllerTypeUserCenterViewController;
            break;
        default:
            break;
    }
    return type;
}

#pragma mark - 从父视图移除SideMenu
- (void)removeSideMenu {
    
    // 以动画的方式滑动到屏幕左侧，然后从父视图移除
    CGRect rect = self.contentView.frame;
    rect.origin.x = - self.contentView.frame.size.width;
    
    [UIView animateWithDuration:AnimateDuration animations:^{
        
        self.backgroundView.alpha = 0;
        self.contentView.frame = rect;
        
        [UIApplication sharedApplication].keyWindow.rootViewController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        _selectedIdx = -1;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _selectedIdx = -1;
    [self removeSideMenu];
}

#pragma mark - tableView delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    DVVSideMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DVVSideMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.tag = indexPath.row;
    cell.iconImageView.image = [UIImage imageNamed:_normalImages[indexPath.row]];
    cell.nameLabel.text = _titleArray[indexPath.row];
    
    cell.contentLabel.text = [_moneyArray objectAtIndex:indexPath.row];
    cell.markLabel.text = _markTitleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 将上次点击的单元格，恢复默认
    if (_lastSelectedCell) {
//        _lastSelectedCell.backgroundImageView.image = nil;
//        _lastSelectedCell.iconImageView.image = [UIImage imageNamed:_normalImages[_lastSelectedCell.tag]];
//        _lastSelectedCell.nameLabel.textColor = [UIColor lightGrayColor];
    }
    DVVSideMenuCell *cell = (DVVSideMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    // 设置本次点击的单元格背景图
//    cell.backgroundImageView.image = [UIImage imageNamed:@"ic_fragment_item_click"];
//    cell.iconImageView.image = [UIImage imageNamed:_selectedImages[indexPath.row]];
    cell.nameLabel.textColor = [UIColor whiteColor];
    
    _lastSelectedCell = cell;
    
//    // 设置当前点击的项（用于打开对应的窗体）
//    _selectedIdx = indexPath.row;
//    // 移除sideMenu（sideMenu移除后，会调用openViewController:打开相应窗体）
//    [self removeSideMenu];
    if (1 == indexPath.row) {
        [DVVOpenControllerFromSideMenu openControllerWithControllerType:kOpenControllerTypeDiscountWalletController];
        // 移除sideMenu
        [self removeSideMenu];
    }
    if (0 == indexPath.row) {
        [DVVOpenControllerFromSideMenu openControllerWithControllerType:kOpenControllerTypeMyWalletViewController];
        // 移除sideMenu
        [self removeSideMenu];
    }
    if (2 == indexPath.row) {
        [DVVOpenControllerFromSideMenu openControllerWithControllerType:kOpenControllerTypeMoneyShopController];
        // 移除sideMenu
        [self removeSideMenu];
    }


}

#pragma mark - config layout
- (void)configLayout {
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    self.backgroundView.frame = screenRect;
    // 先隐藏在左边
    CGFloat contentViewWidth = screenRect.size.width * 0.8;
    self.contentView.frame = CGRectMake(- screenRect.size.width * 0.8, 0, contentViewWidth, screenRect.size.height);
    self.contentBackgroundImageView.frame = self.contentView.bounds;
    
    self.tableView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.headerView.defaultHeight + 44 * 3);
    self.headerView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.headerView.defaultHeight);
    self.footerView.frame = CGRectMake(0, screenRect.size.height - 50, contentViewWidth, 50);

    if (screenRect.size.width > 320) {
        self.blockView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame) + 10, contentViewWidth, CGRectGetMinY(self.footerView.frame) - CGRectGetMaxY(self.tableView.frame) - 10);
    }else {
        self.blockView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame) + 0, contentViewWidth, CGRectGetMinY(self.footerView.frame) - CGRectGetMaxY(self.tableView.frame) - 10);
    }
    
    _contentView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    //    _contentBackgroundImageView.image = [UIImage imageNamed:@"side_menu_bg"];
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0;
    }
    return _backgroundView;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.alpha = 1;
    }
    return _contentView;
}
- (UIImageView *)contentBackgroundImageView {
    if (!_contentBackgroundImageView) {
        _contentBackgroundImageView = [UIImageView new];
        _contentBackgroundImageView.userInteractionEnabled = YES;
    }
    return _contentBackgroundImageView;
}

- (DVVSideMenuHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [DVVSideMenuHeaderView new];
        [_headerView.iconButton addTarget:self action:@selector(iconButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coinCertificateLabelAction)];
        [_headerView.coinCertificateLabel addGestureRecognizer:tapGesture];
        _headerView.coinCertificateLabel.userInteractionEnabled = YES;
    }
    return _headerView;
}

- (DVVSideMenuFooterView *)footerView {
    if (!_footerView) {
        _footerView = [DVVSideMenuFooterView new];
    }
    return _footerView;
}

- (DVVSideMenuBlockView *)blockView {
    if (!_blockView) {
        
        _blockView = [[DVVSideMenuBlockView alloc] initWithTitleArray:_blockTitleArray
                                                      iconNormalArray:_blockImagesArray];
        _blockView.backgroundColor = [UIColor clearColor];
        __weak typeof(self) ws = self;
        [_blockView dvvSideMenuBlockViewItemSelected:^(UIButton *button) {
            
            [ws blockAction:button];
        }];
    }
    return _blockView;
}

#pragma mark - toast
- (void)showMsg:(NSString *)message {
    
    ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:message controller:self];
    [alertView show];
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
