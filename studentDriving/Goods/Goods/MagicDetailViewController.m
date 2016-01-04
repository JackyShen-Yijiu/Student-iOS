//
//  MagicDetailViewController.m
//  TestShop
//
//  Created by ytzhang on 15/12/19.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "MagicDetailViewController.h"
#import "PrivateMessageController.h"
#import "UIImageView+EMWebCache.h"
#import "UIColor+Hex.h"
#import "MyWalletViewController.h"
#import "VirtualViewController.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>


@interface MagicDetailViewController ()<NJKWebViewProgressDelegate,UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webView;
@property (strong, nonatomic) NJKWebViewProgress *webviewProgress;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;

@property (nonatomic,strong) NSString *walletstr;
@end

@implementation MagicDetailViewController
- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kSystemWide - 40, kSystemHeight - 104)];
        _webView.hidden = YES;
    }
    return _webView;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    for (UIViewController *viewCon in self.navigationController.viewControllers) {
        if ([viewCon isKindOfClass:[MyWalletViewController class]]) {
            MyWalletViewController *myWalletVC = (MyWalletViewController *)viewCon;
            [myWalletVC refreshWalletData];
        }
        
    }
    [self.navigationController.navigationBar addSubview:_progressView];
     [self addBottomView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.webView];
    _webviewProgress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = _webviewProgress;
    self.webviewProgress.webViewProxyDelegate = self;
    self.webviewProgress.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height, navigationBarBounds.size.width, progressBarHeight);
    self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    self.progressView.progressBarView.backgroundColor = [UIColor orangeColor];
    self.progressView.hidden = YES;
    
    NSString *urlString = self.mainModel.detailurl;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    
    [self.webView loadRequest:request];

    
   
}
#pragma mark -----加载底部View
- (void)addBottomView
{
    // 加载底部View
    _bottomView = [LTBottomView instanceBottomView];
    // 取出积分的Label
    UILabel *numberLabel = [_bottomView viewWithTag:103];
    NSUserDefaults *defaules = [NSUserDefaults standardUserDefaults];
    _walletstr = [defaules objectForKey:@"walletStr"];
//
    numberLabel.text = _walletstr;
    // 取出立即购买按钮,添加点击事件
    _didClickBtn = [_bottomView viewWithTag:102];
//    NSLog(@"_main = %@",_mainModel.is_scanconsumption);
    if ((_mainModel.is_scanconsumption == 1)) {
        [_didClickBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
        //// 判断按钮是否能点击
        _didClickBtn.selected = [_walletstr intValue]  >=  _mainModel.productprice ? 1 : 0;
        if (_didClickBtn.selected) {
            _didClickBtn.tag = 301;
            [_didClickBtn setBackgroundColor:[UIColor colorWithHexString:@"ff5d35"]];
            [_didClickBtn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        }

    }else
    {
       [_didClickBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        //// 判断按钮是否能点击
        _didClickBtn.selected = [_walletstr intValue]  >=  _mainModel.productprice ? 0 : 1;
        if (_didClickBtn.selected) {
            _didClickBtn.tag = 302;
            [_didClickBtn setBackgroundColor:[UIColor colorWithHexString:@"ff5d35"]];
            [_didClickBtn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        }

    }
    
    
    
    CGFloat kWight = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHight = [UIScreen mainScreen].bounds.size.height;
    CGFloat kbottonViewh = 50;
    _bottomView.frame = CGRectMake(0,kHight - 50 , kWight, kbottonViewh);
    [self.view addSubview:_bottomView];
    
    
}
#pragma mark ----- 立即购买按钮的点击事件

- (void)didClick:(UIButton *)btn
{
    
    PrivateMessageController *privateMessageVC = [[PrivateMessageController alloc] init];
    privateMessageVC.shopId = _mainModel.productid;
    [self.navigationController pushViewController:privateMessageVC animated:YES];
    

    
}
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:YES];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    DYNSLog(@"startLoad");
    self.progressView.hidden = NO;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    DYNSLog(@"finishLoad");
    _webView.hidden = NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    DYNSLog(@"error");
    [self showTotasViewWithMes:@"加载失败"];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSString *string =  [self.webView stringByEvaluatingJavaScriptFromString:@"save()"];
    [_progressView removeFromSuperview];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
