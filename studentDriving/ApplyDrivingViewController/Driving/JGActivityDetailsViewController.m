//
//  JGActivityDetailsViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JGActivityDetailsViewController.h"
#import "JGActivityModel.h"
#import "DVVShare.h"

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
    
    // 添加分享
    UIButton *button = [UIButton new];
    [button setTitle:@"分享" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.bounds = CGRectMake(0, 0, 14 * 2, 44);
    [button addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)share {
    
    // 显示分享
    [DVVShare shareWithTitle:DVV_Share_Default_Title content:DVV_Share_Default_Content image:DVV_Share_Default_Image location:nil url:nil success:^(NSString *platformName) {
        [self obj_showTotasViewWithMes:DVV_Share_Default_Success_Mark_Word];
    }];
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
