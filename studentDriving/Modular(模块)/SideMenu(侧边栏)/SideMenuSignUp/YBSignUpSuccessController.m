//
//  YBSignUpSuccessController.m
//  studentDriving
//
//  Created by 胡东苑 on 15/12/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "YBSignUpSuccessController.h"
#import "ChooseBtnView.h"
#import "SignSuccessView.h"
#import "SignUpInfoManager.h"
#import "SignUpListViewController.h"
#import "UIColor+Hex.h"
#import "YBSignUpSuccessRootClass.h"
#import "YYModel.h"

static NSString *const kUserInfo = @"/userinfo/getapplyschoolinfo";

@interface YBSignUpSuccessController ()

@property (strong, nonatomic) UIScrollView *sv;

@property (nonatomic,strong) YBSignUpSuccessRootClass *signUpSuccessClass;

@end

@implementation YBSignUpSuccessController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.title = @"报名成功";
    
    [self startNetWork];
    
    self.view.backgroundColor = RGBColor(245, 247, 250);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)initUI {
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight - 64)];
    [self.view addSubview:scrollview];
    
    SignSuccessView *ssv = [[SignSuccessView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight-64) signUpSuccessClass:self.signUpSuccessClass];
    ssv.parentViewController = self;
    [scrollview addSubview:ssv];
    
    NSLog(@"[ssv successViewH]:%f",[ssv successViewH]);
    
    scrollview.contentSize = CGSizeMake(kSystemWide, [ssv successViewH]);
    
    scrollview.backgroundColor = [UIColor whiteColor];
    ssv.backgroundColor = [UIColor whiteColor];
    
}

- (void)startNetWork {
    
    NSString *url = [NSString stringWithFormat:kgetmyorderk,[AcountManager manager].userid];
    
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,url];
    
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"startNetWork applyUrlString:%@ data:%@",applyUrlString,data);
        
        NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];
        
        if ([type isEqualToString:@"1"]) {
            
            self.signUpSuccessClass = [YBSignUpSuccessRootClass yy_modelWithDictionary:data];
            
            // 报名成功时清除
            NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
            [defauts setObject:@" " forKey:@"SignUp"];
      
            [self initUI];
            
        }else {
            
            [self showTotasViewWithMes:[data objectForKey:@"msg"]];
            
        }
        
    } withFailure:^(id data) {
        [self showTotasViewWithMes:@"网络错误"];
    }];
    
}

- (void)dealGoBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)callBtnClick {
    [SignUpInfoManager removeSignData];
    [AcountManager saveUserApplyState:@"0"];
    //1为重新报名，0为报名
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"1" forKey:@"applyAgain"];
    [ud synchronize];
    
    [self.navigationController pushViewController:[SignUpListViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
