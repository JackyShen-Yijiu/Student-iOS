//
//  SignInHelpViewController.m
//  studentDriving
//
//  Created by yyx on 15/12/31.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "SignInHelpViewController.h"

@interface SignInHelpViewController ()<UIWebViewDelegate>
@property (nonatomic , weak) UIWebView *webView;
@end

@implementation SignInHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"使用帮助";
    
    
    CGFloat height = self.view.frame.size.height;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    webView.delegate = self;
    self.webView = webView;
    [self.view addSubview:webView];

    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    webView.scalesPageToFit=YES;
    webView.backgroundColor = [UIColor whiteColor];
    [webView loadRequest:request];
    
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
