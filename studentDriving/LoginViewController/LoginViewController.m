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
#import "AppDelegate.h"
#import "HomeMainController.h"
#import "DVVUserManager.h"
#import "VerifyPhoneController.h"
#import "UIColor+Extension.h"
#import "ShowWarningMessageView.h"

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
@property (strong, nonatomic) UIView *lineViewBottom;
@property (strong, nonatomic) UIButton *bottomButton;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) NSMutableDictionary *userParam;
@property (strong, nonatomic) UIView *bottomLeftLineView;
@property (strong, nonatomic) UIView *bottomRightLineView;
@property (strong, nonatomic) UILabel *bottomLabel;

@property (nonatomic, strong) UIButton *checkButton;

@property (nonatomic, strong) UILabel *phoneNumLabel;
@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) ShowWarningMessageView *showWarningMessageView;

@end

@implementation LoginViewController

//- (UIView *)bottomLeftLineView {
//    if (_bottomLeftLineView == nil) {
//        _bottomLeftLineView = [[UIView alloc] initWithFrame:CGRectMake(15, kSystemHeight-43, (kSystemWide-60)/2, 1)];
//        _bottomLeftLineView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
//    }
//    return _bottomLeftLineView;
//}
//
//- (UIView *)bottomRightLineView {
//    if (_bottomRightLineView == nil) {
//        _bottomRightLineView = [[UIView alloc] initWithFrame:CGRectMake(kSystemWide/2+15, kSystemHeight-43, (kSystemWide-60)/2, 1)];
//        _bottomRightLineView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
//    }
//    return _bottomRightLineView;
//}

//- (UILabel *)bottomLabel {
//    if (_bottomLabel == nil) {
//        _bottomLabel = [[UILabel alloc ] initWithFrame:CGRectMake(0, 0, 30, 30)];
//        _bottomLabel.center = CGPointMake(kSystemWide/2, kSystemHeight-43);
//        _bottomLabel.text = @"or";
//        _bottomLabel.layer.cornerRadius = 10;
//        _bottomLabel.clipsToBounds = YES;
//        _bottomLabel.textColor = [UIColor colorWithWhite:1 alpha:0.6];
//        _bottomLabel.textAlignment = NSTextAlignmentCenter;
//        _bottomLabel.backgroundColor = [UIColor clearColor];
//        _bottomLabel.font = [UIFont systemFontOfSize:14];
//        
//    }
//    return _bottomLabel;
//}
- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [UIButton new];
        [_checkButton setTitle:@"" forState:UIControlStateNormal];
        [_checkButton setTitleColor:RGBColor(255, 102, 51) forState:UIControlStateNormal];
        _checkButton.titleLabel.textAlignment = 1;
        _checkButton.backgroundColor = [UIColor clearColor];
        _checkButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_checkButton addTarget:self action:@selector(checkButtonAction) forControlEvents:UIControlEventTouchDown];
        _checkButton.userInteractionEnabled = NO;
        
    }
    return _checkButton;
}
- (NSMutableDictionary *)userParam {
    if (_userParam == nil) {
        _userParam = [[NSMutableDictionary alloc] init];
    }
    return _userParam;
}
//- (UIImageView *)rightImageView {
//    if (_rightImageView == nil) {
//        _rightImageView = [[UIImageView alloc] init];
//        _rightImageView.image = [UIImage imageNamed:@"随便看看"];
//        _rightImageView.alpha = 0.6;
//    }
//    return _rightImageView;
//}

- (UIButton *)bottomButton {
    if (_bottomButton == nil) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setTitle:@"随便看看" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:[UIColor colorWithHexString:@"bd4437"] forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_bottomButton addTarget:self action:@selector(dealBottom:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    }
    return _bottomButton;
    
}

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        _backGroundView.userInteractionEnabled = YES;
        
//        _backGroundView.backgroundColor = [UIColor cyanColor];
    }
    return _backGroundView;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.layer.borderWidth = 0.5;
        _lineView.layer.borderColor = [UIColor colorWithHexString:@"bdbdbd"].CGColor;
        
    }
    return _lineView;
}
- (UIView *)lineViewBottom {
    if (_lineViewBottom == nil) {
        _lineViewBottom = [[UIView alloc] init];
        _lineViewBottom.layer.borderWidth = 0.5;
        _lineViewBottom.layer.borderColor = [UIColor colorWithHexString:@"bdbdbd"].CGColor;
    }
    return _lineViewBottom;
}

- (UIImageView *)logoImageView {
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"loginLogo"];
        _logoImageView.backgroundColor = [UIColor clearColor];
        [_logoImageView.layer setMasksToBounds:YES];
        [_logoImageView.layer setCornerRadius:30];
    }
    return _logoImageView;
}

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.backgroundColor = [UIColor clearColor];
        [_registerButton addTarget:self action:@selector(dealRegister:) forControlEvents:UIControlEventTouchUpInside];
        [_registerButton setTitle:@"注册新用户" forState:UIControlStateNormal];
        _registerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_registerButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"]  forState:UIControlStateNormal];
        
    }
    return _registerButton;
}

- (UIButton *)forgetButton{
    if (_forgetButton == nil) {
        _forgetButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _forgetButton.backgroundColor = [UIColor clearColor];
        [_forgetButton addTarget:self action:@selector(dealForget:) forControlEvents:UIControlEventTouchUpInside];
        [_forgetButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        _forgetButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_forgetButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"]  forState:UIControlStateNormal];
    }
    return _forgetButton;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [UIColor colorWithHexString:@"db4437"];
        
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
          _phoneNumTextField.textColor = [UIColor colorWithHexString:@"212121"];
    
        
        _phoneNumTextField.tag = 100;
        
//        _phoneNumTextField.placeholder        = @" 手机号";
        [_phoneNumTextField setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
        [_phoneNumTextField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
//        _phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
        
        _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"账号"];
        
        _phoneNumTextField.leftView = leftView;
        _phoneNumTextField.backgroundColor = [UIColor clearColor];
        
    }
    
    return _phoneNumTextField;
    
}

- (UITextField *)passwordTextField {
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.delegate = self;
//        _passwordTextField.placeholder = @" 密码";
        [_passwordTextField setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
        [_passwordTextField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        _passwordTextField.tag = 101;
//        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.font = [UIFont systemFontOfSize:15];
         _passwordTextField.textColor = [UIColor colorWithHexString:@"212121"];
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"密码"];
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

        _passwordTextField.leftView = leftView;
        _passwordTextField.secureTextEntry = YES;
        
//        _passwordTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    }
    return _passwordTextField;
}
- (UILabel *)phoneNumLabel{
    if (_phoneNumLabel == nil) {
        _phoneNumLabel = [[UILabel alloc] init];
        _phoneNumLabel.text = @"手机号";
        _phoneNumLabel.textColor  = [UIColor colorWithHexString:@"bdbdbd"];
        _phoneNumLabel.font = [UIFont systemFontOfSize:10];
    }
    return _phoneNumLabel;
}
- (UILabel *)passwordLabel{
    if (_passwordLabel == nil) {
        _passwordLabel = [[UILabel alloc] init];
        _passwordLabel.text = @"密码";
        _passwordLabel.textColor  = [UIColor colorWithHexString:@"bdbdbd"];
        _passwordLabel.font = [UIFont systemFontOfSize:10];
    }
    return _passwordLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.layer.contents = (id)[UIImage imageNamed:@"login_background"].CGImage;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DYdealRegister) name:kregisterUser object:nil];
    
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.backGroundView];
    [self.backGroundView addSubview:self.lineView];
    [self.backGroundView addSubview:self.phoneNumTextField];
    [self.backGroundView addSubview:self.passwordTextField];
    [self.backGroundView addSubview:self.lineViewBottom];
    [self.backGroundView addSubview:self.phoneNumLabel];
    [self.backGroundView addSubview:self.passwordLabel];
    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.bottomButton];
    
//    [self.bottomButton addSubview:self.rightImageView];
    
//    [self.view addSubview:self.bottomLeftLineView];
//    [self.view addSubview:self.bottomRightLineView];
//    [self.view addSubview:self.bottomLabel];
    [self.view addSubview:self.checkButton];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (!self.showWarningMessageView.isShowWarningMessage) {
        self.showWarningMessageView.hidden = YES;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)DYdealRegister {
    
    // 用户登录成功，打开相应的窗体
    [DVVUserManager userLoginSucces];
    
}

#pragma mark - action
- (void)checkButtonAction {
    VerifyPhoneController *verifyPhoneVC = [VerifyPhoneController new];
    [self.navigationController pushViewController:verifyPhoneVC animated:YES];
}

#pragma mark - loginAction

- (void)dealLogin:(UIButton *)sender {
    
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length  == 0) {
        [self obj_showTotasViewWithMes:@"请输入手机号"];
        _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 8, _backGroundView.frame.origin.y, 120, 18)];
        _showWarningMessageView.isShowWarningMessage  = NO;
        [self.view addSubview:self.showWarningMessageView];
        return;
    }
    
    if (self.passwordTextField.text == nil || self.passwordTextField.text.length  == 0) {
        [self obj_showTotasViewWithMes:@"请输入密码"];
        _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 8, _backGroundView.frame.origin.y + 70, 120, 18)];
        _showWarningMessageView.isShowWarningMessage  = NO;
        [self.view addSubview:self.showWarningMessageView];
        return;
    }
    
    if (![AcountManager isValidateMobile:self.phoneNumTextField.text]) {
        [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
        _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 8, _backGroundView.frame.origin.y, 120, 18)];
        _showWarningMessageView.isShowWarningMessage  = NO;
        [self.view addSubview:self.showWarningMessageView];
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
            
            [self obj_showTotasViewWithMes:@"密码错误"];
            _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 8, _backGroundView.frame.origin.y + 70, 120, 18)];
            _showWarningMessageView.isShowWarningMessage  = NO;
            [self.view addSubview:_showWarningMessageView];
            
        }else if ([type isEqualToString:@"1"]) {
            
            // 存储用户设置
            [self saveUserSetWithData:dataDic];
            
            NSLog(@"[AcountManager manager].userid:%@",[AcountManager manager].userid);
            NSLog(@"self.phoneNumTextField.text:%@",self.phoneNumTextField.text);
            NSLog(@"self.passwordTextField.text:%@",self.passwordTextField.text);
            
            [self loginWithUsername:self.phoneNumTextField.text password:pwdKey  dataDic:dataDic];
            
        }
    }];
}

- (void)saveUserSetWithData:(NSDictionary *)data {
//    usersetting =         {
//        classremind = 0;
//        newmessagereminder = 1;
//        reservationreminder = 1;
//    };
    NSDictionary *setDict = [data objectForKey:@"usersetting"];
    NSString *newMsg = [setDict objectForKey:@"newmessagereminder"];
    NSString *reservation = [setDict objectForKey:@"reservationreminder"];
    if (newMsg) {
        [AcountManager manager].newmessagereminder = [newMsg boolValue];
    }
    if (reservation) {
        [AcountManager manager].reservationreminder = [reservation boolValue];
    }
}

#pragma mark 验证用户是否存在
- (void)userExist {
    
    __weak typeof(self) ws = self;
    NSString *urlString = [NSString stringWithFormat:@"userinfo/userexists?usertype=1&mobile=%@",self.phoneNumTextField.text];
    NSString *codeUrl = [NSString stringWithFormat:BASEURL,urlString];
    
    [JENetwoking startDownLoadWithUrl:codeUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"验证用户是否存在:%@", data);
        
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
    [self showHudInView:self.view hint:NSLocalizedString(@"登录中...", @"登录中...")];
   
    BOOL isLoggedIn = [[EaseMob sharedInstance].chatManager isLoggedIn];
    NSLog(@"isLoggedIn:%d",isLoggedIn);
    if (isLoggedIn) {
        [[EaseMob sharedInstance].chatManager logoffWithUnbindDeviceToken:YES error:nil];
        
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
        
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
            DYNSLog(@"asyncLogoffWithUnbindDeviceToken%@",error);
        } onQueue:nil];
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
            DYNSLog(@"退出成功 = %@ %@",info,error);
            if (!error && info) {
            }
        } onQueue:nil];
    }
    
    NSLog(@"username:%@ password:%@",username,password);
    
    NSString *userid = [NSString stringWithFormat:@"%@",dataDic[@"data"][@"userid"]];
    NSLog(@"dataDic.userid:%@---userid:%@",dataDic[@"data"][@"userid"],userid);
    
    if (!userid) {
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
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccess" object:nil];
             
             NSSet *set = [NSSet setWithObjects:@"", nil];
             [APService setTags:set alias:[AcountManager manager].userid callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
             
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
             
             [AcountManager saveUserName:self.phoneNumTextField.text andPassword:self.passwordTextField.text];
             
             [AcountManager configUserInformationWith:dataDic[@"data"]];

             
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _phoneNumTextField) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (range.location>10) {
            return NO;
        }else {
            if (11 - textField.text.length >0) {
                return YES;
            }else {
                return NO;
            }
        }
    }
    
    return YES;
}

#pragma mark 随便看看
- (void)dealBottom:(UIButton *)sender {
    // 用户需要随便看看，打开相应的窗体
//    [DVVUserManager userNeedBrowsing];
    [DVVUserManager userLoginSucces];
}

- (void)dealForget:(UIButton *)sender{
    ForgetViewController *forgetVc = [[ForgetViewController alloc]init];
    UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:forgetVc];
    [self presentViewController:NC animated:YES completion:nil];
}

- (void)dealRegister:(UIButton *)sender{
    RegisterViewController *registerVc = [[RegisterViewController alloc]init];
     UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:registerVc];
    [self presentViewController:NC animated:YES completion:nil];

}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
#pragma make - 自动布局
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(50);
        make.height.mas_equalTo(@60);
        make.width.mas_equalTo(@60);
    }];
    
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.logoImageView.mas_bottom).with.offset(42);
        make.height.mas_equalTo(@130);
    }];
    [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(0);
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@40);
    }];
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(0);
        
        make.top.mas_equalTo(self.phoneNumLabel.mas_bottom).with.offset(5);
        
        make.height.mas_equalTo(@25);
        
    }];
    
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_top).offset(18);
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@20);
    }];

    
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(0);
        
        make.top.mas_equalTo(self.passwordLabel.mas_bottom).with.offset(5);
        
        make.height.mas_equalTo(@25);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    [self.lineViewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(0);
        make.height.mas_equalTo(@1);
    }];

    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        
        make.top.mas_equalTo(self.lineViewBottom.mas_bottom).with.offset(100);
        
        make.height.mas_equalTo(@49);
        
    }];
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineViewBottom.mas_bottom).offset(13);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-13);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@10);

    }];
    
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).with.offset(18);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@122);
        make.height.mas_equalTo(@25);
    }];
    
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.bottomButton.mas_width);
        make.height.mas_equalTo(self.bottomButton.mas_height);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.bottomButton.mas_top).offset(30);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineViewBottom.mas_bottom).offset(13);
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@10);
    }];
    
//    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.bottomButton.mas_centerY);
//        make.right.mas_equalTo(self.bottomButton.mas_right).with.offset(-22);
//        make.height.mas_equalTo(@15);
//        make.width.mas_equalTo(@15);
//    }];
    
    
    
}

- (void)showMsg:(NSString *)message {
    
    ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:message controller:self];
    [alertView show];
}

@end
