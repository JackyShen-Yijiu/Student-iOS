//
//  DiscountOrderController.m
//  studentDriving
//
//  Created by ytzhang on 16/1/3.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DiscountOrderController.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>

static NSString *kDiscountShopAPI = @"userinfo/buyproduct";
@interface DiscountOrderController ()<NJKWebViewProgressDelegate,UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webView;
@property (strong, nonatomic) NJKWebViewProgress *webviewProgress;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;
@end

@implementation DiscountOrderController
- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kSystemWide , kSystemHeight)];
        _webView.hidden = YES;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易详情";
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
    self.progressView.hidden = NO;
    [self startDownLoad];


    
}
- (void)startDownLoad {
    
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kDiscountShopAPI];
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    if (nil == [defaults objectForKey:@"DiscountWalletStr"]) {
        [self obj_showTotasViewWithMes:@"您还没有订单"];
        return;
    }
    NSString *discount_Id = [defaults objectForKey:@"DiscountWalletStr"];
    NSDictionary *parm = @{@"usertype":@"1",
                           @"userid":[AcountManager manager].userid,
                           @"productid":self.productid,
                           @"couponid":discount_Id};
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:parm WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data)  {
        DYNSLog(@"我的钱包start data = %@",data);
        
        DYNSLog(@"data = %@",data);
        
        NSDictionary *dataDic = [data objectForKey:@"extra"];
        if (dataDic == nil) {
            return ;
        }
        
        {
                NSString *urlString = [dataDic objectForKey:@"finishorderurl"];
                NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
                [self.webView loadRequest:request];
           
        }
        
        
        
    } withFailure:^(id data) {
        
        
    }];
    
    
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
    _webView.hidden = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    DYNSLog(@"error");
    [self showTotasViewWithMes:@"加载失败"];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    NSString *string =  [self.webView stringByEvaluatingJavaScriptFromString:@"save()"];
    [_progressView removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
