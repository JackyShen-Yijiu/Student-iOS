//
//  SignUpSuccessViewController.m
//  studentDriving
//
//  Created by 胡东苑 on 15/12/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "SignUpSuccessViewController.h"
#import "ChooseBtnView.h"
#import "SignSuccessView.h"
#import "SignUpInfoManager.h"
#import "SignUpListViewController.h"
#import "UIColor+Hex.h"
#import "YBSignUpSuccessRootClass.h"
#import "YYModel.h"

static NSString *const kUserInfo = @"/userinfo/getapplyschoolinfo";

@interface SignUpSuccessViewController ()

//@property (strong, nonatomic) NSString *kRealScanauditUrl;
//@property (strong, nonatomic) NSString *kRealApplytime;
//@property (strong, nonatomic) NSString *kRealEndtime;
//@property (strong, nonatomic) NSString *kRealOrderNumber;
//@property (strong, nonatomic) NSString *imageStr;
//@property (strong, nonatomic) NSString *explainStr;

@property (strong, nonatomic) UIScrollView *sv;

@property (nonatomic,strong) YBSignUpSuccessRootClass *signUpSuccessClass;

@end

@implementation SignUpSuccessViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    return;
    
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kinfomationCheck];
    NSDictionary *param = @{@"userid":[AcountManager manager].userid};
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"viewWillAppear data:%@",data);
        
        if (!data) {
            return ;
        }
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        
        if ([type isEqualToString:@"1"]) {
            /*
             
             {
             data =     {
             "_id" = 56e6b1b238ad72723dcebf74;
             applycount = 3;
             applyinfo =         {
             applytime = "2016-03-15T04:06:43.906Z";
             handelmessage =             (
             );
             handelstate = 0;
             };
             applystate = 0;
             paytype = 2;
             paytypestatus = 0;
             };
             msg = "";
             type = 1;
             }
             
             */
            
            NSDictionary *dataDic = [param objectForKey:@"data"];
            if (!dataDic || ![dataDic isKindOfClass:[NSDictionary class]]) {
                return;
            }
            if (2 == [dataDic[@"paytype"] integerValue]) {
                [self obj_showTotasViewWithMes:@"您已经支付,请等待我们的审核"];
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            if ([[dataDic objectForKey:@"applystate"] integerValue] == 0) {
                [AcountManager saveUserApplyState:@"0"];
            }else if ([[dataDic objectForKey:@"applystate"] integerValue] == 1) {
                [AcountManager saveUserApplyState:@"1"];
            }else if ([[dataDic objectForKey:@"applystate"] integerValue] == 2){
                [AcountManager saveUserApplyState:@"2"];
            }else {
                [AcountManager saveUserApplyState:@"3"];
            }
            [AcountManager saveUserApplyCount:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"applycount"]]];
            if ([[AcountManager manager].userApplycount isEqualToString:@"0"]) {
//                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.registAgainButton];
            }
        }else {
            
            NSLog(@"1:%s [data objectForKey:msg:%@",__func__,[data objectForKey:@"msg"]);
            
            [self showTotasViewWithMes:[data objectForKey:@"msg"]];
        }
    } withFailure:^(id data) {
        [self showTotasViewWithMes:@"网络错误"];
    }];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.title = @"报名成功";
        
    [self startNetWork];

    self.view.backgroundColor = RGBColor(245, 247, 250);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back"] style:UIBarButtonItemStyleDone   target:self action:@selector(leftBarDidClick)];
    
}

- (void)leftBarDidClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
            
//            NSDictionary * useData = [data objectForKey:@"data"];
//            _kRealScanauditUrl   = [useData objectForKey:@"scanauditurl"];
//            _kRealApplytime      = [useData objectForKey:@"applytime"];
//            _kRealEndtime        = [useData objectForKey:@"endtime"];
//            _kRealOrderNumber    = [useData objectForKey:@"userid"];
//            _explainStr          = [useData objectForKey:@"applynotes"];
//            NSString *applyUrlStr = [NSString stringWithFormat:BASEURL,kCreatQrcode];
//            NSString *scanaiditurl = [NSString stringWithFormat:@"%@?text=%@&size=10",applyUrlStr,_kRealScanauditUrl];
//            _imageStr = scanaiditurl;
            
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
