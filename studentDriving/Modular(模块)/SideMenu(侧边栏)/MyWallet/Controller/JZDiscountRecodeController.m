//
//  JZDiscountRecodeController.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZDiscountRecodeController.h"

#import "JZSideMenuOrderDiscountView.h"
#import "JZNoDataShowBGView.h"

@interface JZDiscountRecodeController ()<JZSideMenuOrderListDiscountDelegate>

@property (nonatomic, strong) JZSideMenuOrderDiscountView *sideMenuOrderDiscountView;

@end

@implementation JZDiscountRecodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换券";
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self.view addSubview:self.sideMenuOrderDiscountView];
    self.sideMenuOrderDiscountView.sideMenuOrderListDiscountDelegate = self;
    [self.sideMenuOrderDiscountView begainRefresh];
    
}
//// 显示占位图片
//- (void)initWithNoDataOrderLsitDiscountBG{
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (JZSideMenuOrderDiscountView *)sideMenuOrderDiscountView{
    if (_sideMenuOrderDiscountView == nil) {
        _sideMenuOrderDiscountView = [[JZSideMenuOrderDiscountView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight - 64)];
    }
    return _sideMenuOrderDiscountView;
}
#pragma mark --- 兑换劵无数据的占位图片


- (void)initWithNoDataOrderLsitDiscountBG{
    JZNoDataShowBGView *noData = [[JZNoDataShowBGView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:noData];
}

@end
