//
//  HomeAdvantageController.m
//  studentDriving
//
//  Created by ytzhang on 15/12/18.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "HomeAdvantageController.h"

static NSString *advantage = @"3.html";

#define kSystemWide [UIScreen mainScreen].bounds.size.width

#define kSystemHeight [UIScreen mainScreen].bounds.size.height



@interface HomeAdvantageController ()
@property(nonatomic,strong) UIWebView *webView;

@end

@implementation HomeAdvantageController


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
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.webView];

   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
