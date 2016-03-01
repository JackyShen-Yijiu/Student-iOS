//
//  YBStudyWebViewController.m
//  studentDriving
//
//  Created by bestseller on 15/10/26.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "YBStudyWebViewController.h"
#import "ToolHeader.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
@interface YBStudyWebViewController ()<NJKWebViewProgressDelegate,UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NJKWebViewProgress *webviewProgress;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;
@end

@implementation YBStudyWebViewController

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight-64)];
        _webView.backgroundColor = [UIColor lightGrayColor];//RGBColor(251, 251, 251);
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(232, 232, 237);
    
    self.title = @"自助约考";
    
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
    self.progressView.progressBarView.backgroundColor = MAINCOLOR;
    self.progressView.hidden = YES;
    
    NSString *urlString = self.weburl;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    
    [self.webView loadRequest:request];
    
}

- (void)back
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
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
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    DYNSLog(@"error");
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self showTotasViewWithMes:@"加载失败"];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
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
@end
