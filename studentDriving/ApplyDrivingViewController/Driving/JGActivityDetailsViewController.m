//
//  JGActivityDetailsViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JGActivityDetailsViewController.h"
#import "JGActivityModel.h"

@interface JGActivityDetailsViewController ()
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation JGActivityDetailsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = _activityModel.name;
    
    self.view.backgroundColor = RGBColor(244, 249, 250);
    
    _webView = [[UIWebView alloc] init];
    _webView.frame = self.view.bounds;
    _webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    _webView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
    _webView.backgroundColor = RGBColor(244, 249, 250);
    [self.view addSubview:_webView];
    
    NSLog(@"_activityModel.contenturl:%@",_activityModel.contenturl);
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_activityModel.contenturl]]];
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
