//
//  HomeActivityController.m
//  studentDriving
//
//  Created by 大威 on 15/12/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "HomeActivityController.h"
#import "ToolHeader.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
#import "AFNetworkActivityLogger.h"

#define kSystemWide [UIScreen mainScreen].bounds.size.width
#define kSystemHeight [UIScreen mainScreen].bounds.size.height

@interface HomeActivityController ()<NJKWebViewProgressDelegate,UIWebViewDelegate>

@property(nonatomic,strong) UIWebView *webView;
@property (strong, nonatomic) NJKWebViewProgress *webViewProgress;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation HomeActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.webView];
//    [self.view addSubview:self.progressView];
    [self.view addSubview:self.backButton];
    
    [self configUI];
    
    // 加载网址
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.activityUrl]];
    [self.webView loadRequest:request];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    // 背景渐现
    self.view.alpha = 0;
    self.backgroundImageView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 1;
        self.backgroundImageView.alpha = 0.3;
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - action
- (void)backButtonAction {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

#pragma mark - webView delegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:YES];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    DYNSLog(@"startLoad");
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    DYNSLog(@"finishLoad");
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    DYNSLog(@"error");
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self showTotasViewWithMes:@"加载失败"];
}

#pragma mark configUI
- (void)configUI {
    CGFloat leftMargin = 30;
    CGFloat rightMargin = 30;
    CGFloat topMargin = 100;
    CGFloat bottomMargin = 100;
    _backgroundImageView.frame = CGRectMake(0, 0, kSystemWide, kSystemHeight);
    _webView.frame = CGRectMake(leftMargin, topMargin, kSystemWide - leftMargin - rightMargin, kSystemHeight - topMargin - bottomMargin);
    [_webView.layer setMasksToBounds:YES];
    [_webView.layer setCornerRadius:10];
    _progressView.frame = CGRectMake(0, topMargin - 2, kSystemWide, 2);
    _backButton.frame = CGRectMake(leftMargin + 8, topMargin + 8, 20, 20);
    
    _backgroundImageView.backgroundColor = [UIColor blackColor];
}

#pragma mark - lazy load
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
    }
    return _backgroundImageView;
}
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self.webViewProgress;
    }
    return _webView;
}
- (NJKWebViewProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[NJKWebViewProgressView alloc] init];
        _progressView.progressBarView.backgroundColor = [UIColor orangeColor];
    }
    return _progressView;
}
- (NJKWebViewProgress *)webViewProgress {
    if (!_webViewProgress) {
        _webViewProgress = [[NJKWebViewProgress alloc] init];
        _webViewProgress.webViewProxyDelegate = self;
        _webViewProgress.progressDelegate = self;
    }
    return _webViewProgress;
}
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"iconfont-guanbi2"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
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
