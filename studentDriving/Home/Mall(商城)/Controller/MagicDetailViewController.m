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
#import "YBIntegrationMessageController.h"

static NSString *const kIntegralMall = @"userinfo/getmywallet?userid=%@&usertype=1&seqindex=0&count=10";

static NSString *const kDiscountMall = @"userinfo/getmycupon?userid=%@";

@interface MagicDetailViewController ()<NJKWebViewProgressDelegate,UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webView;
@property (strong, nonatomic) NJKWebViewProgress *webviewProgress;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIButton *exchangeButton;
@property (nonatomic, assign) NSInteger integralNumber;
@property (nonatomic, assign) NSInteger discountNumber;

@end

@implementation MagicDetailViewController
- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight - 64 - 50 - 5)];
        _webView.hidden = YES;
    }
    return _webView;
}

- (void)viewWillAppear:(BOOL)animated
{
//    for (UIViewController *viewCon in self.navigationController.viewControllers) {
//        if ([viewCon isKindOfClass:[MyWalletViewController class]]) {
//            MyWalletViewController *myWalletVC = (MyWalletViewController *)viewCon;
//            [myWalletVC refreshWalletData];
//        }
//        
//    }
//    [self.navigationController.navigationBar addSubview:_progressView];
//     [self addBottomView];
    [self initData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.webView];
    [self.bgView addSubview:self.moneyLabel];
    [self.bgView addSubview:self.exchangeButton];
    [self.view addSubview:self.bgView];
    
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
    NSString *urlString = nil;
    if (0 == _mallWay) {
        // 积分商城
        urlString = _integralModel.detailurl;
    }else if (1 == _mallWay){
        // 兑换劵商城
        urlString = _discountModel.detailurl;
    }
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    
    [self.webView loadRequest:request];

    
   
}
- (void)initData{
    if (0 == _mallWay) {
        // 积分商城
        NSString *appendString = [NSString stringWithFormat:kIntegralMall,[AcountManager manager].userid];
        NSString *finalString = [NSString stringWithFormat:BASEURL,appendString];
        [JENetwoking startDownLoadWithUrl:finalString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            if (1 == [data[@"type"] integerValue]) {
                NSDictionary *parm = data[@"data"];
                self.integralNumber = [parm[@"wallet"] integerValue];
                if ([parm[@"wallet"] integerValue] < _integralModel.productprice) {
                    _exchangeButton.selected = YES;
                    _exchangeButton.backgroundColor = YBNavigationBarBgColor;
                }else if ([parm[@"wallet"] integerValue] >= _integralModel.productprice){
                    NSLog(@"%lu%d",[parm[@"wallet"] integerValue],_integralModel.productprice);
                    _exchangeButton.selected = NO;
                    _exchangeButton.backgroundColor = [UIColor colorWithHexString:@"bdbdbd"];
                }
            }
        } withFailure:^(id data) {
            NSString *str = data[@"msg"];
            [self obj_showTotasViewWithMes:str];
        }];

    }else if (1 == _mallWay){
        // 兑换劵商城
        NSString *appendString = [NSString stringWithFormat:kDiscountMall,[AcountManager manager].userid];
        NSString *finalString = [NSString stringWithFormat:BASEURL,appendString];
        [JENetwoking startDownLoadWithUrl:finalString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            if (1 == [data[@"type"] integerValue]) {
                /*
                 { "type": 1, "msg": "", "data": [ { "_id": "56812f877b340f4e48423164", 优惠卷编码 "userid": "562cb02e93d4ca260b40e544", userid "state": 0, 优惠卷状态// 0未领取 1领取 2过期 3作废 4 已消费 "is_forcash": true, 是否可以兑换现金 "couponcomefrom": 1,// 优惠券来源 1 报名奖励 2 活动奖励 "createtime": "2015-12-28T12:48:07.805Z" } ] }
                 */
                NSArray  *array = data[@"data"];
                if (array.count) {
                    NSDictionary *parm = array[0];
                    self.discountNumber = [parm[@"state"] integerValue];
                    if (0 == [parm[@"state"] integerValue] || 2 == [parm[@"state"] integerValue] || 3 ==[parm[@"state"] integerValue] || 4 == [parm[@"state"] integerValue]) {
                        _exchangeButton.selected = NO;
                         _exchangeButton.userInteractionEnabled = NO;
                        _exchangeButton.backgroundColor = [UIColor colorWithHexString:@"bdbdbd"];
                    }else if (1 == [parm[@"state"] integerValue]){
                        _exchangeButton.selected = YES;
                         _exchangeButton.userInteractionEnabled = YES;
                        _exchangeButton.backgroundColor = YBNavigationBarBgColor;
                    }
                }else if (array.count == 0){
                    _exchangeButton.selected = NO;
                    _exchangeButton.userInteractionEnabled = NO;
                    _exchangeButton.backgroundColor = [UIColor colorWithHexString:@"bdbdbd"];
                    
                }
                
            }
        } withFailure:^(id data) {
            NSString *str = data[@"msg"];
            [self obj_showTotasViewWithMes:str];
        }];

        
    }
    
}

- (void)didClick:(UIButton *)btn
{
    if (btn.tag == 301) {
        // 实体商品
        PrivateMessageController *privateMessageVC = [[PrivateMessageController alloc] init];
        privateMessageVC.shopId = _mainModel.productid;
        [self.navigationController pushViewController:privateMessageVC animated:YES];
    }else if (btn.tag == 302){
        // 虚拟商品
        VirtualViewController *birtualViewVC = [[VirtualViewController alloc] init];
        birtualViewVC.shopId = _mainModel.productid;
        [self.navigationController pushViewController:birtualViewVC animated:YES];
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
- (void)didExchange:(UIButton *)btn{
    if (0 == _mallWay) {
        // 积分商城
        YBIntegrationMessageController *integrationMessageVC = [[YBIntegrationMessageController alloc] init];
        integrationMessageVC.mallWay = 0;
        integrationMessageVC.integraMallModel = self.integralModel;
        [self.navigationController pushViewController:integrationMessageVC animated:YES];
    }else if (1 == _mallWay){
        // 兑换劵商城
        YBIntegrationMessageController *integrationMessageVC = [[YBIntegrationMessageController alloc] init];
        integrationMessageVC.mallWay = 1;
        integrationMessageVC.discountMallModel = self.discountModel;
        [self.navigationController pushViewController:integrationMessageVC animated:YES];
    }
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kSystemHeight - 114, kSystemWide, 50)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 18, 150, 14)];
        if (0 == _mallWay) {
            // 积分商城
            _moneyLabel.text = [NSString stringWithFormat:@"需要消费积分:%d",_integralModel.productprice];
        }else if (1 == _mallWay){
            // 兑换劵商城
            _moneyLabel.text = @"需要消费一张兑换劵";
        }
        _moneyLabel.font = [UIFont systemFontOfSize:14];
        _moneyLabel.textColor = YBNavigationBarBgColor;
    }
    return _moneyLabel;
}
- (UIButton *)exchangeButton{
    if (_exchangeButton == nil) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _exchangeButton.frame = CGRectMake(self.bgView.frame.size.width - 100 - 25, 7.5, 100, 35);
        _exchangeButton.backgroundColor = YBNavigationBarBgColor;
        [_exchangeButton setTitle:@"立即兑换" forState:UIControlStateNormal];
        [_exchangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_exchangeButton addTarget:self action:@selector(didExchange:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeButton;
}
@end
