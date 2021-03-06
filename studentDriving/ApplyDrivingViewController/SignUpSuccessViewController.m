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

#import "DVVShare.h"

static NSString *const kUserInfo = @"/userinfo/getapplyschoolinfo";
static NSString *const kCreatQrcode = @"/create_qrcode";
//static NSString *kinfomationCheck = @"userinfo/getmyapplystate";

@interface SignUpSuccessViewController ()

@property (strong, nonatomic) UIButton *referButton;
@property (strong, nonatomic) UIButton *goBackButton;
@property (strong, nonatomic) NSString *kRealScanauditUrl;
@property (strong, nonatomic) NSString *kRealApplytime;
@property (strong, nonatomic) NSString *kRealEndtime;
@property (strong, nonatomic) NSString *kRealOrderNumber;
@property (strong, nonatomic) NSString *imageStr;
@property (strong, nonatomic) NSString *explainStr;

@property (strong, nonatomic) UIScrollView *sv;

@end

@implementation SignUpSuccessViewController

- (UIButton *)goBackButton{
    if (_goBackButton == nil) {
        _goBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回_click"] forState:UIControlStateNormal];
        [_goBackButton addTarget:self action:@selector(dealGoBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBackButton;
}

- (UIButton *)referButton{
    if (_referButton == nil) {
        _referButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _referButton.backgroundColor = [UIColor colorWithHexString:@"ff5d35"];
        _referButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_referButton setTitle:@"完成" forState:UIControlStateNormal];
        [_referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_referButton addTarget:self action:@selector(dealRefer:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _referButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kinfomationCheck];
    NSDictionary *param = @{@"userid":[AcountManager manager].userid};
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        if (!data) {
            return ;
        }
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            /*
             { "type": 1, "msg": "", "data": 
             
             { "_id": "560539bea694336c25c3acb9", 用户id "applyinfo": 
             
             {
             "handelmessage": [], 处理消息 
             "handelstate": 0, //处理状态 0 未处理 1 处理中 2 处理成功 
             "applytime": "2015-10-11T02:56:09.281Z" 
             },
             
             "applystate": 2 申请状态 0 未报名 1 申请中 2 申请成功 "paytypestatus": 0, 0 未支付 20支付成功(等待验证) 30 支付失败
             "paytype": 1, 1 线下支付， 2 线上支付
             } 
             
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
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self startNetWork];
    self.view.backgroundColor = RGBColor(245, 247, 250);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UILabel new]];
    
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

- (void)initUI {
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSystemHeight, kSystemHeight - 64-49)];
    scrollview.contentSize = CGSizeMake(kSystemWide, 500);
    [self.view addSubview:scrollview];
    
//    ChooseBtnView *cbv = [[ChooseBtnView alloc] initWithSelectedBtn:2 leftTitle:@"选择驾校" midTitle:@"填写信息" rightTitle:@"报名验证" frame:CGRectMake(0, 10, kSystemWide, 77)];
//    cbv.backgroundColor = [UIColor whiteColor];
//    [scrollview addSubview:cbv];
    

    SignSuccessView *ssv = [[SignSuccessView alloc] initWithFrame:CGRectMake(0, 10, kSystemWide, kSystemHeight-64-49-87) imageStr:_imageStr orderNumStr:_kRealOrderNumber timeStr:[NSString stringWithFormat:@"%@到%@",_kRealApplytime,_kRealEndtime] CarrydataExplainContentLb:_explainStr];
    [scrollview addSubview:ssv];
    [self.view addSubview:self.referButton];
    
    scrollview.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    ssv.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    
    [self.referButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)startNetWork {
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kUserInfo];
    NSDictionary *param = @{@"userid":[AcountManager manager].userid};
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];
        if ([type isEqualToString:@"1"]) {
            // 报名成功时清除
            NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
            [defauts setObject:@" " forKey:@"SignUp"];
            
            NSDictionary * useData = [data objectForKey:@"data"];
            _kRealScanauditUrl   = [useData objectForKey:@"scanauditurl"];
            _kRealApplytime      = [useData objectForKey:@"applytime"];
            _kRealEndtime        = [useData objectForKey:@"endtime"];
            _kRealOrderNumber    = [useData objectForKey:@"userid"];
            _explainStr          = [useData objectForKey:@"applynotes"];
            NSString *applyUrlStr = [NSString stringWithFormat:BASEURL,kCreatQrcode];
            NSString *scanaiditurl = [NSString stringWithFormat:@"%@?text=%@&size=10",applyUrlStr,_kRealScanauditUrl];
            _imageStr = scanaiditurl;
            
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

- (void)dealRefer:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
