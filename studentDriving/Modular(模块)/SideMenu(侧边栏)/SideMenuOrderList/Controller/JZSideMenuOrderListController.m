//
//  JZSideMenuOrderListController.m
//  studentDriving
//
//  Created by ytzhang on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZSideMenuOrderListController.h"
#import "JZExchangeRecordController.h"
#import "YBOrderListViewController.h"
#import "JZSideMenuOrderDiscountView.h"
#import "JZNoDataShowBGView.h"

#define HeaderH 40

@interface JZSideMenuOrderListController ()<UIScrollViewDelegate,JZSideMenuOrderListDiscountDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) JZExchangeRecordController *exchangeVC;

@property (nonatomic, strong) YBOrderListViewController *signUpVC;

@property (nonatomic, strong) JZSideMenuOrderDiscountView *sideMenuOrderDiscountView;

@property (nonatomic, strong) JZNoDataShowBGView *noData;
@end

@implementation JZSideMenuOrderListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.toolBarView];
    
    // 积分兑换记录
    _exchangeVC = [[JZExchangeRecordController alloc] init];
    _exchangeVC.pareVC = self;
    _exchangeVC.isFormallOrder = YES;
    [self.scrollView addSubview:self.exchangeVC.view];
    
    // 兑换券记录
    self.sideMenuOrderDiscountView.sideMenuOrderListDiscountDelegate = self;
    [self.scrollView addSubview:self.sideMenuOrderDiscountView];
    
    
    // 报名记录
    _signUpVC= [[YBOrderListViewController alloc] init];
    _signUpVC.view.frame = CGRectMake(kSystemWide * 2, 0, kSystemWide, self.scrollView.height);
    _signUpVC.pareVC = self;
    _signUpVC.isFormallOrder = YES;
    [self.scrollView addSubview:self.signUpVC.view];
    [_exchangeVC beginRefresh];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [_noData removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark ----- UIScrollerView Delegate
#pragma mark --- UIScroller delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.noData removeFromSuperview];
    CGFloat width = self.view.width;
    
    if (0 == scrollView.contentOffset.x) {
        // 积分兑换
        [_toolBarView selectItem:0];
    }
    if (width == scrollView.contentOffset.x) {
        // 兑换劵使用
        [_toolBarView selectItem:1];
    }
    if (2 * width== scrollView.contentOffset.x) {
        // 报名订单
        [_toolBarView selectItem:2];
        
    }
    
}

#pragma mark ---- Action
#pragma mark 筛选条件
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    [self.noData removeFromSuperview];
    /*
     
     学员状态：0 全部学员 1在学学员 2未考学员 3约考学员 4补考学员 5通过学员
     */
    if (0 == index) {
        CGFloat contentOffsetX = 0;
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        }];
        _exchangeVC = [[JZExchangeRecordController alloc] init];
        _exchangeVC.view.frame = CGRectMake(0, 0, kSystemWide, self.scrollView.height);
//        _exchangeVC.pareVC = self;
//        _exchangeVC.isFormallOrder = YES;
//        [self.scrollView addSubview:self.exchangeVC.view];
        [_exchangeVC beginRefresh];
        
    }else if (1 == index) {
        CGFloat contentOffsetX = self.view.width;
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        }];
        [self.sideMenuOrderDiscountView begainRefresh];
        
    }else if (2 == index) {
        CGFloat contentOffsetX = 2 * self.view.width;
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        }];
        [_signUpVC  startDownLoad];
    }
    
}
#pragma mark --- 兑换劵无数据的占位图片
- (void)initWithNoDataOrderLsitDiscountBG{
    
    
    JZNoDataShowBGView *noData = [[JZNoDataShowBGView alloc] initWithFrame:CGRectMake(kSystemWide, 0, self.scrollView.width, self.scrollView.height)];
    [self.scrollView addSubview:noData];
}

#pragma mark --- Lazy

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, HeaderH)];
        _bgView.backgroundColor  = [UIColor whiteColor];
        _bgView.layer.shadowColor = [UIColor blackColor].CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(0, 2);
        _bgView.layer.shadowOpacity = 0.048;
        _bgView.layer.shadowRadius = 2;
    }
    return _bgView;
}
- (JZSideMenuOrderToorBarView *)toolBarView {
    if (_toolBarView == nil) {
        _toolBarView = [JZSideMenuOrderToorBarView new];
        _toolBarView.frame = CGRectMake(0, 0, kSystemWide, HeaderH);
        _toolBarView.titleNormalColor = JZ_FONTCOLOR_DRAK;
        _toolBarView.titleSelectColor = YBNavigationBarBgColor;
        _toolBarView.followBarColor = YBNavigationBarBgColor;
        _toolBarView.titleFont = [UIFont systemFontOfSize:14];
        _toolBarView.titleArray = @[ @"积分兑换", @"兑换劵使用",@"报名订单"];
        __weak typeof(self) ws = self;
        [_toolBarView dvvToolBarViewItemSelected:^(UIButton *button)
        {
            [ws dvvToolBarViewItemSelectedAction:button.tag];
        }];
        
        if (ScreenWidthIs_6Plus_OrWider) {
            _toolBarView.titleFont = [UIFont systemFontOfSize:14*YBRatio];
    }
    }
        return _toolBarView;
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HeaderH, self.view.width, self.view.height - HeaderH - 64)];
        _scrollView.contentSize = CGSizeMake(3* self.view.width, 0);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (JZSideMenuOrderDiscountView *)sideMenuOrderDiscountView{
    if (_sideMenuOrderDiscountView == nil) {
        _sideMenuOrderDiscountView = [[JZSideMenuOrderDiscountView alloc] initWithFrame:CGRectMake(kSystemWide, 0, kSystemWide, self.scrollView.height)];
    }
    return _sideMenuOrderDiscountView;
}
@end
