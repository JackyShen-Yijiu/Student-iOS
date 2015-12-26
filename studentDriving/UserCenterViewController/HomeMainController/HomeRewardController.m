//
//  HomeRewardController.m
//  studentDriving
//
//  Created by ytzhang on 15/12/19.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "HomeRewardController.h"

#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
#import "ToolHeader.h"
#import "SignUpListViewController.h"
#import "SignUpSuccessViewController.h"
#import "LoginViewController.h"

#import "DVVUserManager.h"

static NSString *advantage = @"liuchengt.html";

#define kSystemWide [UIScreen mainScreen].bounds.size.width

#define kSystemHeight [UIScreen mainScreen].bounds.size.height

@interface HomeRewardController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property(nonatomic,strong) UIWebView *webView;
@property (strong, nonatomic) NJKWebViewProgress *webviewProgress;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;
@end

@implementation HomeRewardController

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight-64)];
        _webView.hidden = YES;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
self.title = @"一步流程";
    [self addSignUp];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
    
    NSString *urlString = [NSString stringWithFormat:BTH5,advantage];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    
    [self.webView loadRequest:request];
    
    
}
- (void)addSignUp
{
    CGRect backframe= CGRectMake(0, 0, 44, 44);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = backframe;
    [backButton setTitle:@"报名" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backButton addTarget:self action:@selector(sideMenuButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)sideMenuButtonAction
{
    if (![AcountManager isLogin]) {
        [DVVUserManager userNeedLogin];
    }else
    {
        if ([[AcountManager manager].userApplystate isEqualToString:@"0"]) {
            SignUpListViewController *signUpListVC = [[SignUpListViewController alloc] init];
            [self.navigationController pushViewController:signUpListVC animated:YES];
        } else if ([[AcountManager manager].userApplystate isEqualToString:@"1"]) {
            [self.navigationController pushViewController:[SignUpSuccessViewController new] animated:YES];
        }else {
            [self showTotasViewWithMes:@"您已经报过名"];
        }
        
    }
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
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _webView.hidden = NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self showTotasViewWithMes:@"加载失败"];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    NSString *string =  [self.webView stringByEvaluatingJavaScriptFromString:@"save()"];
    DYNSLog(@"store = %@",string);
    [_progressView removeFromSuperview];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
