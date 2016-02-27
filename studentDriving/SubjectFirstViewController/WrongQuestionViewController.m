//
//  QuestionBankViewController.m
//  studentDriving
//
//  Created by bestseller on 15/10/26.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "WrongQuestionViewController.h"
#import "ToolHeader.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
@interface WrongQuestionViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NJKWebViewProgress *webviewProgress;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;

@end

@implementation WrongQuestionViewController

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight)];
//        _webView.backgroundColor = [UIColor blackColor];//RGBColor(251, 251, 251);
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.view.backgroundColor = [UIColor blackColor];//RGBColor(251, 251, 251);;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    DYNSLog(@"request = %@",self.questionerrorurl);
   
    [self.view addSubview:self.webView];
   
    if (self.isModal==YES) {
        CGFloat X = 5;
        if ([UIScreen mainScreen].bounds.size.height>640) {
            X = 15;
        }
        UIButton *backBtn = [[UIButton alloc] init];
        backBtn.frame = CGRectMake(X, 10, 44, 44);
//        backBtn.backgroundColor = [UIColor clearColor];
        [backBtn setImage:[UIImage imageNamed:@"navi_back.png"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navi_back.png"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBtn];
    }
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@?userid=%@",self.questionerrorurl,[AcountManager manager].userid];
    NSLog(@"urlString:%@",urlString);

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
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self showTotasViewWithMes:@"加载失败"];
    DYNSLog(@"error");
    
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
