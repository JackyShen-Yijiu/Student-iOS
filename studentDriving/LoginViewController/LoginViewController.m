//
//  LoginViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/3.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "LoginViewController.h"
//#import "MainViewController.h"
#import "NSUserStoreTool.h"
#import "ForgetViewController.h"
#import "RegisterViewController.h"
#import <Masonry/Masonry.h>
#import "ToolHeader.h"
#import "JENetwoking.h"
#import "NSString+DY_MD5.h"
#import <AFNetworking.h>
#import "AcountManager.h"
#import <JPush/APService.h>
#import "RESideMenu.h"
#import "MenuController.h"
#import "AppDelegate.h"
#import "HomeMainController.h"
#import "DVVUserManager.h"
#import "VerifyPhoneController.h"

static NSString *const kloginUrl = @"userinfo/userlogin";

static NSString *const kregisterUser = @"kregisterUser";


static NSString *const kmobileNum = @"mobile";

static NSString *const kpassword = @"password";

static NSString *const kuserType = @"usertype";

@interface LoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UITextField *phoneNumTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIButton *forgetButton;
@property (strong, nonatomic) UIButton *registerButton;
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIButton *bottomButton;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) NSMutableDictionary *userParam;
@property (strong, nonatomic) UIView *bottomLineView;
@property (strong, nonatomic) UILabel *bottomLabel;

@property (nonatomic, strong) UIButton *checkButton;
@end

@implementation LoginViewController

- (UIView *)bottomLineView {
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(15, kSystemHeight-95, kSystemWide-30, 1)];
        _bottomLineView.backgroundColor = [UIColor clearColor];
    }
    return _bottomLineView;
}
- (UILabel *)bottomLabel {
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc ] initWithFrame:CGRectMake((kSystemWide-300)/2-30/2, -15, 300, 30)];
        _bottomLabel.text = @"验证学车进度";
        _bottomLabel.textColor = RGBColor(255, 102, 51);
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.backgroundColor = [UIColor clearColor];
        _bottomLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _bottomLabel;
}
- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [UIButton new];
        [_checkButton setTitle:@"验证学车进度" forState:UIControlStateNormal];
        [_checkButton setTitleColor:RGBColor(255, 102, 51) forState:UIControlStateNormal];
        _checkButton.titleLabel.textAlignment = 1;
        _checkButton.backgroundColor = [UIColor clearColor];
        _checkButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_checkButton addTarget:self action:@selector(checkButtonAction) forControlEvents:UIControlEventTouchDown];
    }
    return _checkButton;
}
- (NSMutableDictionary *)userParam {
    if (_userParam == nil) {
        _userParam = [[NSMutableDictionary alloc] init];
    }
    return _userParam;
}

- (UIImageView *)rightImageView {
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"随便看看"];
    }
    return _rightImageView;
}

- (UIButton *)bottomButton {
    if (_bottomButton == nil) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setTitle:@"先随便看看" forState:UIControlStateNormal];
        //        _bottomButton.layer.borderColor = RGBColor(253, 86, 50).CGColor;
        //        _bottomButton.layer.borderWidth = 1;
        [_bottomButton setTitleColor:RGBColor(255, 102, 51) forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_bottomButton addTarget:self action:@selector(dealBottom:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    }
    return _bottomButton;
    
}

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        _backGroundView.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _backGroundView.layer.borderWidth = 1;
        _backGroundView.userInteractionEnabled = YES;
    }
    return _backGroundView;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.layer.borderWidth = 1;
        _lineView.layer.borderColor = RGBColor(230, 230, 230).CGColor;
    }
    return _lineView;
}
- (UIImageView *)logoImageView {
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"loginLogo"];
        _logoImageView.backgroundColor = [UIColor clearColor];
        [_logoImageView.layer setMasksToBounds:YES];
        [_logoImageView.layer setCornerRadius:16];
    }
    return _logoImageView;
}

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.backgroundColor = [UIColor clearColor];
        [_registerButton addTarget:self action:@selector(dealRegister:) forControlEvents:UIControlEventTouchUpInside];
        [_registerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_registerButton setTitle:@"现在注册账号" forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_registerButton setTitleColor:RGBColor(255, 102, 51)  forState:UIControlStateNormal];
        
    }
    return _registerButton;
}

- (UIButton *)forgetButton{
    if (_forgetButton == nil) {
        _forgetButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _forgetButton.backgroundColor = [UIColor clearColor];
        [_forgetButton addTarget:self action:@selector(dealForget:) forControlEvents:UIControlEventTouchUpInside];
        [_forgetButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_forgetButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.6] forState:UIControlStateNormal];
    }
    return _forgetButton;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = RGBColor(255, 102, 51);
        
        [_loginButton addTarget:self action:@selector(dealLogin:) forControlEvents:UIControlEventTouchUpInside];
        
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _loginButton;
    
}

- (UITextField *) phoneNumTextField {
    
    if (_phoneNumTextField == nil) {
        
        _phoneNumTextField                    = [[UITextField alloc] init];
        
        _phoneNumTextField.delegate           = self;
        
        _phoneNumTextField.font = [UIFont systemFontOfSize:15];
        _phoneNumTextField.textColor = RGBColor(51, 51, 51);
        
        _phoneNumTextField.tag = 100;
        
        _phoneNumTextField.placeholder        = @" 请填写手机号";
        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
        
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"账号"];
        
        _phoneNumTextField.leftView = leftView;
        
        _phoneNumTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        
    }
    
    return _phoneNumTextField;
    
}

- (UITextField *)passwordTextField {
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.delegate = self;
        _passwordTextField.placeholder = @" 请填写密码";
        _passwordTextField.tag = 101;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.font = [UIFont systemFontOfSize:15];
        _passwordTextField.textColor = RGBColor(51, 51, 51);
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"密码"];
        
        _passwordTextField.leftView = leftView;
        _passwordTextField.secureTextEntry = YES;
        
        _passwordTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    }
    return _passwordTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.contents = (id)[UIImage imageNamed:@"login_background"].CGImage;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DYdealRegister) name:kregisterUser object:nil];
    
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.backGroundView];
    [self.backGroundView addSubview:self.lineView];
    [self.backGroundView addSubview:self.phoneNumTextField];
    [self.backGroundView addSubview:self.passwordTextField];
    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.bottomButton];
    
    [self.bottomButton addSubview:self.rightImageView];
    
    [self.view addSubview:self.bottomLineView];
    //    [self.bottomLineView addSubview:self.bottomLabel];
    [self.view addSubview:self.checkButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)DYdealRegister {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - action
- (void)checkButtonAction {
    VerifyPhoneController *verifyPhoneVC = [VerifyPhoneController new];
    [self.navigationController pushViewController:verifyPhoneVC animated:YES];
}

#pragma mark - loginAction

- (void)dealLogin:(UIButton *)sender {
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length  == 0) {
        [self showTotasViewWithMes:@"请输入手机号"];
        return;
    }
    if (self.passwordTextField.text == nil || self.passwordTextField.text.length  == 0) {
        [self showTotasViewWithMes:@"请输入密码"];
        return;
    }
    
    [self userExist];
}

- (void)userLogin {
    
    //网络请求
    [self.passwordTextField resignFirstResponder];
    [self.phoneNumTextField resignFirstResponder];
    
    [self.userParam setObject:@"1" forKey:kuserType];
    [self.userParam setObject:self.phoneNumTextField.text forKey:kmobileNum];
    NSString *pwdKey = [self.passwordTextField.text DY_MD5];
    [self.userParam setObject:pwdKey forKey:kpassword];
    
    NSString *url = [NSString stringWithFormat:BASEURL,kloginUrl];
    
    DYNSLog(@"%s url:%@ self.userParam:%@",__func__,url,self.userParam);
    
    [JENetwoking startDownLoadWithUrl:url postParam:self.userParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *dataDic = data;
        DYNSLog(@"%s dataDic:%@",__func__,dataDic);
        
        NSString *type = [NSString stringWithFormat:@"%@",dataDic[@"type"]];
        
        if ([type isEqualToString:@"0"]) {
            
            [self showTotasViewWithMes:@"密码错误"];
            
        }else if ([type isEqualToString:@"1"]) {
            
            NSLog(@"[AcountManager manager].userid:%@",[AcountManager manager].userid);
            NSLog(@"self.phoneNumTextField.text:%@",self.phoneNumTextField.text);
            NSLog(@"self.passwordTextField.text:%@",self.passwordTextField.text);
            
            [self loginWithUsername:self.phoneNumTextField.text password:pwdKey  dataDic:dataDic];
            
        }
    }];
}

#pragma mark 验证用户是否存在
- (void)userExist {
    
    __weak typeof(self) ws = self;
    NSString *urlString = [NSString stringWithFormat:@"userinfo/userexists?usertype=1&mobile=%@",self.phoneNumTextField.text];
    NSString *codeUrl = [NSString stringWithFormat:BASEURL,urlString];
    
    [JENetwoking startDownLoadWithUrl:codeUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"%@", data);
        NSDictionary *params = data;
        BOOL type = [[params objectForKey:@"type"] boolValue];
        if (type) {
            if ([[params objectForKey:@"data"] boolValue]) {
                [self userLogin];
            }else {
                [ws showMsg:@"此用户未注册"];
            }
        }else {
            [ws showMsg:@"网络错误"];
        }
    }];
}


// 点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password  dataDic:(NSDictionary *)dataDic
{
    [self showHudInView:self.view hint:NSLocalizedString(@"登陆中...", @"登陆中...")];
   
    BOOL isLoggedIn = [[EaseMob sharedInstance].chatManager isLoggedIn];
    NSLog(@"isLoggedIn:%d",isLoggedIn);
    
    NSLog(@"username:%@ password:%@",username,password);
    
    NSString *userid = [NSString stringWithFormat:@"%@",dataDic[@"data"][@"userid"]];
    NSLog(@"dataDic.userid:%@---userid:%@",dataDic[@"data"][@"userid"],userid);
    
    if (userid==nil) {
        userid = @"";
     }
    NSLog(@"dataDic.userid:%@---userid:%@",dataDic[@"data"][@"userid"],userid);
    
    // 异步登陆账号
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userid
                                                        password:password
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         
         NSLog(@"error:%@",error);
         [MBProgressHUD hideHUDForView:self.view animated:NO];
         
         if (loginInfo && !error) {
             
             DYNSLog(@"登录成功");
             
             [AcountManager saveUserName:userid andPassword:password];
             
             [AcountManager configUserInformationWith:dataDic[@"data"]];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccess" object:nil];
             
             NSLog(@"[AcountManager manager].userid:%@",[AcountManager manager].userid);
             
             [APService setAlias:[AcountManager manager].userid callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
             
             //设置是否自动登录
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
             
             // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
             [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
             //获取数据库中数据
             [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
             
             //获取群组列表
             //             [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
             
             EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
             options.nickname = [AcountManager manager].userName;
             options.displayStyle = ePushNotificationDisplayStyle_messageSummary;
             
             //发送自动登陆状态通知
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
             
             //保存最近一次登录用户名
             
             // 用户登录成功，打开相应的窗体
             [DVVUserManager userLoginSucces];
             
         }
         else
         {
             switch (error.errorCode)
             {
                 case EMErrorNotFound:
                     TTAlertNoTitle(error.description);
                     break;
                 case EMErrorNetworkNotConnected:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                     break;
                 case EMErrorServerNotReachable:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                     break;
                 case EMErrorServerAuthenticationFailure:
                     TTAlertNoTitle(error.description);
                     break;
                 case EMErrorServerTimeout:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                     break;
                 default:
                     TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                     break;
             }
         }
         
     } onQueue:nil];
    
    
}
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
     tags, alias];
    
    DYNSLog(@"TagsAlias回调:%@", callbackString);
}
#pragma mark - textfieldDelegate 业务逻辑

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 100) {
        NSString *phoneNum = textField.text;
        NSString *regex = @"^((17[0-9])|(13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:phoneNum];
        if (!isMatch) {
            [self showTotasViewWithMes:@"请输入正确的手机号"];
            return;
        }
    }else if (textField.tag == 101) {
        DYNSLog(@"password = %@",[textField.text DY_MD5]);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _phoneNumTextField) {
        if (range.location>10) {
            return NO;
        }
    }
    return YES;
}

#pragma mark 随便看看
- (void)dealBottom:(UIButton *)sender {
    
    // 用户需要随便看看，打开相应的窗体
    [DVVUserManager userNeedBrowsing];
}

- (void)dealForget:(UIButton *)sender{
    ForgetViewController *forgetVc = [[ForgetViewController alloc]init];
    [self presentViewController:forgetVc animated:YES completion:nil];
}

- (void)dealRegister:(UIButton *)sender{
    RegisterViewController *registerVc = [[RegisterViewController alloc]init];
    [self presentViewController:registerVc animated:YES completion:nil];
    
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
#pragma make - 自动布局
    
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(50);
        make.height.mas_equalTo(@90);
        make.width.mas_equalTo(@90);
    }];
    
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.top.mas_equalTo(self.logoImageView.mas_bottom).with.offset(42);
        make.height.mas_equalTo(@80);
    }];
    
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(0);
        
        make.top.mas_equalTo(self.backGroundView.mas_top).with.offset(0);
        
        make.height.mas_equalTo(@40);
        
    }];
    
    
    
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(0);
        
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(0);
        
        make.height.mas_equalTo(@40);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_top).with.offset(40.5);
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        
        make.top.mas_equalTo(self.backGroundView.mas_bottom).with.offset(20);
        
        make.height.mas_equalTo(@44);
        
    }];
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.top.mas_equalTo(self.loginButton.mas_bottom).with.offset(14);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@25);
    }];
    
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@122);
        make.height.mas_equalTo(@25);
    }];
    
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.bottomButton.mas_width);
        make.height.mas_equalTo(self.bottomButton.mas_height);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.bottomButton.mas_top).offset(-10);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.checkButton.mas_top).offset(-10);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@25);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomButton.mas_centerY);
        make.right.mas_equalTo(self.bottomButton.mas_right).with.offset(-15);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@15);
    }];
    
    
    
}

- (void)showMsg:(NSString *)message {
    
    ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:message controller:self];
    [alertView show];
}

@end
