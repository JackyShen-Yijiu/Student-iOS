//
//  JZPasswordLoginController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZPasswordLoginController.h"

#import "DVVBaseTextField.h"
#import <JPush/APService.h>
#import "NSString+DY_MD5.h"
#import "DVVToast.h"
#import "YBFindPwdViewController.h"
#import "WMNavigationController.h"
#import "JZRegisterFirstController.h"
#import "JZRegisterController.h"
@interface JZPasswordLoginController () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) DVVBaseTextField *loginNameTextField;
@property (nonatomic, strong) DVVBaseTextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *retrievePasswordButton;
@property (nonatomic, strong) NSMutableDictionary *userParam;
@property (nonatomic, strong) UIView *lineView;
@property (strong, nonatomic) UIButton *eyeButton;
@end

@implementation JZPasswordLoginController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"登录";
    
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.eyeButton];
    [_contentView addSubview:self.loginNameTextField];
    [_contentView addSubview:self.passwordTextField];
    [_contentView addSubview:self.loginButton];
    [_contentView addSubview:self.registerButton];
    [_contentView addSubview:self.lineView];
    [_contentView addSubview:self.retrievePasswordButton];
    [self configUI];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
}

- (void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - UItextField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _loginNameTextField) {
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

#pragma mark - action

#pragma mark 登录按钮的点击事件

- (void)loginButtonAction:(UIButton *)sender {
    
    if (!_loginNameTextField.text || _loginNameTextField.text.length == 0) {
        [DVVToast showMessage:@"请输入手机号"];
        return ;
    }
    
    if (_loginNameTextField.text.length != 11) {
        [DVVToast showMessage:@"请检查手机号是否正确"];
        return ;
    }
    
    if (!_passwordTextField.text || _passwordTextField.text.length == 0) {
        [DVVToast showMessage:@"请输入密码"];
        return;
    }
    
    [self userExist];
}

#pragma mark 注册按钮
- (void)registerButtonAction:(UIButton *)sender {
    
    JZRegisterController *vc = [[JZRegisterController alloc] init];
    WMNavigationController *inav = [[WMNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:inav animated:NO completion:nil];
    
}

#pragma mark 重置密码
- (void)retrievePasswordButtonAction:(UIButton *)sender {
    
    YBFindPwdViewController *vc = [[YBFindPwdViewController alloc] init];
    WMNavigationController *inav = [[WMNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:inav animated:NO completion:nil];
    
}

#pragma mark 随便看看
- (void)bottomButtonAction:(UIButton *)sender {
    [DVVUserManager userLoginSucces];
}
- (void)didEyeButton:(UIButton *)btn{
    if (!btn.selected) {
        self.passwordTextField.secureTextEntry = NO;
        btn.selected = YES;
        
    }else if (btn.selected) {
        self.passwordTextField.secureTextEntry = YES;
        btn.selected = NO;
    }
    
}

#pragma mark - network

#pragma mark 验证用户是否存在
- (void)userExist {
    
    __weak typeof(self) ws = self;
    NSString *urlString = [NSString stringWithFormat:@"userinfo/userexists?usertype=1&mobile=%@",_loginNameTextField.text];
    NSString *codeUrl = [NSString stringWithFormat:BASEURL,urlString];
    
    [JENetwoking startDownLoadWithUrl:codeUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"验证用户是否存在:%@", data);
        
        NSDictionary *params = data;
        BOOL type = [[params objectForKey:@"type"] boolValue];
        if (type) {
            if ([[params objectForKey:@"data"] boolValue]) {
                [self userLogin];
            }else {
                [DVVToast showMessage:@"此用户未注册"];
            }
        }else {
            [DVVToast showMessage:@"网络错误"];
        }
    }];
}

#pragma mark 调用登录接口登录
- (void)userLogin {
    
    //网络请求
    [_passwordTextField resignFirstResponder];
    [_loginNameTextField resignFirstResponder];
    [self.userParam setObject:@"1" forKey:@"usertype"];
    [self.userParam setObject:_loginNameTextField.text forKey:@"mobile"];
    NSString *pwdKey = [self.passwordTextField.text DY_MD5];
    [self.userParam setObject:pwdKey forKey:@"password"];
    
    NSString *url = [NSString stringWithFormat:BASEURL, @"userinfo/userlogin"];
    
    DYNSLog(@"%s url:%@ self.userParam:%@",__func__,url,self.userParam);
    
    [JENetwoking startDownLoadWithUrl:url postParam:self.userParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *dataDic = data;
        DYNSLog(@"%s dataDic:%@",__func__,dataDic);
        
        NSString *type = [NSString stringWithFormat:@"%@",dataDic[@"type"]];
        
        if ([type isEqualToString:@"0"]) {
            
            [DVVToast showMessage:@"密码错误"];
            
        }else if ([type isEqualToString:@"1"]) {
            
            // 存储用户设置
            [self saveUserSetWithData:dataDic];
            
            NSLog(@"[AcountManager manager].userid:%@",[AcountManager manager].userid);
            NSLog(@"self.phoneNumTextField.text:%@",_loginNameTextField.text);
            NSLog(@"self.passwordTextField.text:%@",_passwordTextField.text);
            
            [self loginWithUsername:_loginNameTextField.text password:pwdKey  dataDic:dataDic];
            
        }
    }];
}

#pragma mark 保存用户的偏好设置
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

#pragma mark 登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password  dataDic:(NSDictionary *)dataDic
{
    [self showHudInView:self.view hint:NSLocalizedString(@"登录中...", @"登录中...")];
    
    NSLog(@"点击登录后的操作:dataDic:%@",dataDic);
    
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
             
             //保存最近一次登录用户名
             [AcountManager saveUserName:_loginNameTextField.text andPassword:_passwordTextField.text];
             
             [AcountManager configUserInformationWith:dataDic[@"data"]];
             
             NSSet *set = [NSSet setWithObjects:@"", nil];
             NSLog(@"[AcountManager manager].userid:%@",[AcountManager manager].userid);
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
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccess" object:nil];
             
             //发送自动登陆状态通知
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
             
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


#pragma mark - configUI

- (void)configUI {
    
    __weak typeof(self) ws = self;
    
    CGFloat height = 44;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat contentViewWidth = 0;
    if (screenWidth <= 320) {
        // 小屏幕
        contentViewWidth = screenWidth - 30*2;
    }else {
        // 大屏幕
        contentViewWidth = screenWidth - 53*2;
    }
    
    
    [_loginNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentViewWidth);
        make.height.mas_equalTo(height);
        make.left.and.top.mas_equalTo(0);
    }];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentViewWidth);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(ws.loginNameTextField.mas_bottom).offset(20);
    }];
    [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.passwordTextField.mas_right).with.offset(-14);
        make.top.mas_equalTo(self.passwordTextField.mas_top).with.offset(44/2-8/2);
        make.height.mas_equalTo(@8);
        make.width.mas_equalTo(@16);
    }];

    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentViewWidth);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(ws.passwordTextField.mas_bottom).offset(32);
    }];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(12 * 4);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(ws.loginButton.mas_bottom).offset(18);
        make.left.mas_equalTo(contentViewWidth / 2.f - 18 - 12*4);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(12);
        make.top.mas_equalTo(ws.loginButton.mas_bottom).offset(18);
        make.left.mas_equalTo(contentViewWidth / 2.f);
    }];

    [_retrievePasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(12 * 4);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(ws.loginButton.mas_bottom).offset(18);
        make.left.mas_equalTo(contentViewWidth / 2.f + 18);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentViewWidth);
        make.height.mas_equalTo(246);
        make.centerX.mas_equalTo(ws.view.mas_centerX);
//        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(-30);
        make.top.mas_equalTo(ws.view.mas_top).offset(48);
    }];
    
    }

#pragma mark - lazy load

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (DVVBaseTextField *)loginNameTextField {
    if (!_loginNameTextField) {
        _loginNameTextField = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"user"] placeholder:@"请输入手机号"];
        _loginNameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _loginNameTextField.cornerRadius = 18;
        _loginNameTextField.foregroundColor = [UIColor colorWithHexString:@"b7b7b7"];
        _loginNameTextField.delegate = self;
    }
    return _loginNameTextField;
}

- (DVVBaseTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"password"] placeholder:@"请输入密码"];
        _passwordTextField.cornerRadius = 18;
        _passwordTextField.secureTextEntry = YES;
         _passwordTextField.foregroundColor = [UIColor colorWithHexString:@"b7b7b7"];
    }
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton new];
        [_loginButton.layer setMasksToBounds:YES];
        [_loginButton.layer setCornerRadius:18];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.backgroundColor = YBNavigationBarBgColor;
        
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton new];
        [_registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:12];
       [_registerButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 44 - 12, 0)];
        [_registerButton setTitleColor:YBNavigationBarBgColor forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"6e6e6e"];
    }
    return _lineView;
}

- (UIButton *)retrievePasswordButton {
    if (!_retrievePasswordButton) {
        _retrievePasswordButton = [UIButton new];
        [_retrievePasswordButton setTitle:@"找回密码" forState:UIControlStateNormal];
        _retrievePasswordButton.titleLabel.font = [UIFont systemFontOfSize:12];
         [_retrievePasswordButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 44 - 12, 0)];
        [_retrievePasswordButton setTitleColor:[UIColor colorWithHexString:@"6e6e6e"] forState:UIControlStateNormal];
        [_retrievePasswordButton addTarget:self action:@selector(retrievePasswordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retrievePasswordButton;
}
- (UIButton *)eyeButton{
    if (_eyeButton == nil) {
        _eyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyeButton setBackgroundImage:[UIImage imageNamed:@"look_off"] forState:UIControlStateNormal];
        [_eyeButton setBackgroundImage:[UIImage imageNamed:@"look_on"] forState:UIControlStateSelected];
        [_eyeButton addTarget:self action:@selector(didEyeButton:) forControlEvents:UIControlEventTouchUpInside];
        _eyeButton.backgroundColor = [UIColor clearColor];
    }
    return _eyeButton;
}

- (NSMutableDictionary *)userParam {
    if (!_userParam) {
        _userParam = [NSMutableDictionary new];
    }
    return _userParam;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end