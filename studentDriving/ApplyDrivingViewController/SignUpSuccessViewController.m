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
#import <SVProgressHUD.h>
#import "UIColor+Hex.h"


static NSString *const kUserInfo = @"/userinfo/getapplyschoolinfo";
static NSString *const kCreatQrcode = @"/create_qrcode";

@interface SignUpSuccessViewController ()

@property (strong, nonatomic) UIButton *referButton;
@property (strong, nonatomic) UIButton *goBackButton;
@property (strong, nonatomic) UIButton *registAgainButton;

@property (strong, nonatomic) NSString *kRealScanauditUrl;
@property (strong, nonatomic) NSString *kRealApplytime;
@property (strong, nonatomic) NSString *kRealEndtime;
@property (strong, nonatomic) NSString *kRealOrderNumber;
@property (strong, nonatomic) NSString *imageStr;
@property (strong, nonatomic) NSString *explainStr;

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

- (UIButton *)registAgainButton {
    if (_registAgainButton == nil) {
        _registAgainButton = [WMUITool initWithTitle:@"重新报名" withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _registAgainButton.frame = CGRectMake(0, 0, 80, 44);
        [_registAgainButton addTarget:self action:@selector(callBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registAgainButton;
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
    [SVProgressHUD show];
    [self startNetWork];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBColor(245, 247, 250);
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.goBackButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.registAgainButton];
}

- (void)initUI {
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kSystemHeight, kSystemHeight - 64-49)];
    scrollview.contentSize = CGSizeMake(kSystemWide, 500);
    [self.view addSubview:scrollview];
    
    ChooseBtnView *cbv = [[ChooseBtnView alloc] initWithSelectedBtn:2 leftTitle:@"选择驾校" midTitle:@"填写信息" rightTitle:@"报名验证" frame:CGRectMake(0, 10, kSystemWide, 77)];
    cbv.backgroundColor = [UIColor whiteColor];
    [scrollview addSubview:cbv];
    

    SignSuccessView *ssv = [[SignSuccessView alloc] initWithFrame:CGRectMake(0, 97, kSystemWide, kSystemHeight-64-49-87) imageStr:_imageStr orderNumStr:_kRealOrderNumber timeStr:[NSString stringWithFormat:@"%@到%@",_kRealApplytime,_kRealEndtime] CarrydataExplainContentLb:_explainStr];
    ssv.backgroundColor = [UIColor whiteColor];
    [scrollview addSubview:ssv];
    [self.view addSubview:self.referButton];
    
    [self.referButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
}

- (void)startNetWork {
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kUserInfo];
    NSDictionary *param = @{@"userid":[AcountManager manager].userid};
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];
        if ([type isEqualToString:@"1"]) {
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
            [SVProgressHUD showInfoWithStatus:[data objectForKey:@"msg"]];
        }
       
    } withFailure:^(id data) {
        [SVProgressHUD showInfoWithStatus:@"网络错误"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end