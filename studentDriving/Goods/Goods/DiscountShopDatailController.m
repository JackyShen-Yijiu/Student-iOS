//
//  DiscountShopDatailController.m
//  studentDriving
//
//  Created by ytzhang on 15/12/31.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DiscountShopDatailController.h"


#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
#import "ToolHeader.h"

#import "DVVUserManager.h"

#import "LoginViewController.h"


#define kSystemWide [UIScreen mainScreen].bounds.size.width

#define kSystemHeight [UIScreen mainScreen].bounds.size.height
static NSString *kDiscountShopAPI = @"userinfo/buyproduct";


@interface DiscountShopDatailController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property(nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UIButton *changebutton;
@property (strong, nonatomic) NJKWebViewProgress *webviewProgress;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;
@end

@implementation DiscountShopDatailController

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kSystemWide - 40, kSystemHeight - 104)];
        _webView.hidden = YES;
    }
    return _webView;
}
- (UIButton *)changebutton
{
    if (_changebutton == nil) {
        _changebutton = [[UIButton alloc] initWithFrame:CGRectMake(15,kSystemHeight - 40, self.view.frame.size.width - 30, 40)];
        _changebutton.backgroundColor = [UIColor colorWithHexString:@"ff6633"];
        [_changebutton setTitle:@"立即兑换" forState:UIControlStateNormal];
        [_changebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _changebutton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_changebutton.layer setMasksToBounds:YES];
        [_changebutton.layer setCornerRadius:5.0];
        [_changebutton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changebutton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换商城";
//    [self addSignUp];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.webView];
    [self.view addSubview:self.changebutton];
    
    
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
    
    NSString *urlString = self.discountShopModel.detailurl;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    
    [self.webView loadRequest:request];

   
}
//- (void)startDownLoad {
//    
//   
//    NSString *urlString = [NSString stringWithFormat:BASEURL,kDiscountShopAPI];
//    NSDictionary *parm = @{@"usertype":@"1",
//                           @"userid":[AcountManager manager].userid,
//                           @"productid":self.discountShopModel.productid,
//                           @"couponid":self.discountShopModel.};
//    
//    [JENetwoking startDownLoadWithUrl:urlString postParam:parm WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data)  {
//        DYNSLog(@"我的钱包start data = %@",data);
//        
//        DYNSLog(@"data = %@",data);
//        if (data == nil) {
//            return ;
//        }
//        NSDictionary *dataDic = [data objectForKey:@"data"];
//        
//        {
//            NSArray *array = [dataDic objectForKey:@"mainlist"];
//            for (NSDictionary *dic in array)
//            {
//                DiscountShopModel *mainDodel = [[DiscountShopModel alloc] init];
//                [mainDodel setValuesForKeysWithDictionary:dic];
//                [self.disCountListArray addObject:mainDodel];
//            }
//        }
//        
//        [self.discountView reloadData];
//        
//        
//    } withFailure:^(id data) {
//        
//        
//    }];
//    
//    
//}


- (void)didClick:(UIButton *)btn{
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
