//
//  JZAutoLoginController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZAutoLoginController.h"

#import "DVVBaseTextField.h"
#import <JPush/APService.h>
#import "NSString+DY_MD5.h"
#import "DVVToast.h"
#import "YBFindPwdViewController.h"
#import "WMNavigationController.h"
#import "JZPasswordLoginController.h"
static NSString *const kcodeLogin = @"userinfo/studentloginbycode";

@interface JZAutoLoginController () <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) DVVBaseTextField *loginNameTextField;
@property (nonatomic, strong) DVVBaseTextField *autoTextField;
@property (nonatomic, strong) UIButton *loginButton; // 验证登录
@property (nonatomic, strong) UIButton *registerButton; // 密码登录
@property (nonatomic, strong) UIButton *retrievePasswordButton; // 随便看看
@property (nonatomic, strong) UIView *lineView;
@property (strong, nonatomic)UIButton *sendButton;
@property (nonatomic, strong) NSMutableDictionary *userParam;
@property (nonatomic, strong) NSString *passwordStr;

@end

@implementation JZAutoLoginController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    self.view.layer.contents = (id)([UIImage imageNamed:@"background_login"].CGImage);
    
    [self.view addSubview:self.logoImageView];
    
    [self.view addSubview:self.contentView];
    [_contentView addSubview:self.loginNameTextField];
    [_contentView addSubview:self.autoTextField];
    [_autoTextField addSubview:self.sendButton];
    [_contentView addSubview:self.loginButton];
    [_contentView addSubview:self.registerButton];
    [_contentView addSubview:self.lineView];
    [_contentView addSubview:self.retrievePasswordButton];
    
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
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
#pragma mark -- UItextFiledNotification
- (void)passwordTextFieldTextDidChange:(NSNotification *)obj{
    UITextField *passwordTextFiled = (UITextField *)obj.object;
    if (passwordTextFiled.text.length == 0) {
        _loginButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _loginButton.userInteractionEnabled = NO;
    }else{
        _loginButton.backgroundColor = YBNavigationBarBgColor;
        _loginButton.userInteractionEnabled = YES;
        
    }
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
    
    if (!_autoTextField.text || _autoTextField.text.length == 0) {
        [DVVToast showMessage:@"请输入验证码"];
        return;
    }
    
//    [self userExist];
    [self userLogin];

}

#pragma mark 注册按钮
- (void)registerButtonAction:(UIButton *)sender {
    
    JZPasswordLoginController *vc = [[JZPasswordLoginController alloc] init];
    WMNavigationController *inav = [[WMNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:inav animated:NO completion:nil];
    
}

#define TIME 60
- (void)dealSend:(UIButton *)sender {
    
    NSLog(@"发送验证码");
    
    [self sendYanZhengMa:sender];
    
}

#pragma mark 发送验证码
- (void)sendYanZhengMa:(UIButton *)sender
{
    
    if (self.loginNameTextField.text == nil || self.loginNameTextField.text.length <= 0) {
        [self obj_showTotasViewWithMes:@"请输入手机号"];
        return;
        
    }else {
        
        if (![AcountManager isValidateMobile:self.loginNameTextField.text]) {
            [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
            return;
        }
        
        NSString *urlString = [NSString stringWithFormat:@"code/%@",self.loginNameTextField.text];
        NSString *codeUrl = [NSString stringWithFormat:BASEURL,urlString];
        
        [JENetwoking startDownLoadWithUrl:codeUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            [self obj_showTotasViewWithMes:@"发送成功"];
            [_autoTextField becomeFirstResponder];
        }];
        
    }
    
    sender.userInteractionEnabled = NO;
    __block int count = TIME;
    dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, myQueue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (count < 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendButton.titleLabel.font = [UIFont systemFontOfSize:12];
                _sendButton.backgroundColor = [UIColor clearColor];
                [self.sendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.sendButton.userInteractionEnabled = YES;
            });
        }else {
            NSString *str = [NSString stringWithFormat:@"%d秒后重发",count];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendButton.backgroundColor = [UIColor clearColor];;
                [self.sendButton setTitleColor:[UIColor colorWithHexString:@"e7afaa"] forState:UIControlStateNormal];
                [self.sendButton setTitle:str forState:UIControlStateNormal];
                
            });
            count--;
        }
    });
    dispatch_resume(timer);
}

#pragma mark 随便看看
- (void)bottomButtonAction:(UIButton *)sender {
    [DVVUserManager userLoginSucces];
}

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
    [_autoTextField resignFirstResponder];
    [_loginNameTextField resignFirstResponder];
    [self.userParam setObject:_loginNameTextField.text forKey:@"mobile"];
    [self.userParam setObject:_autoTextField.text forKey:@"smscode"];
    
    NSString *url = [NSString stringWithFormat:BASEURL, kcodeLogin];
    
    DYNSLog(@"%s url:%@ self.userParam:%@",__func__,url,self.userParam);
    
    [JENetwoking startDownLoadWithUrl:url postParam:self.userParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *dataDic = data;
        DYNSLog(@"%s dataDic:%@",__func__,dataDic);
        
        NSString *type = [NSString stringWithFormat:@"%@",dataDic[@"type"]];
        
        if ([type isEqualToString:@"0"]) {
            
            [DVVToast showMessage:@"验证码错误"];
            
        }else if ([type isEqualToString:@"1"]) {
            self.passwordStr = data[@"data"][@"password"];
            DYNSLog(@"%s dataDic:%@",__func__,self.passwordStr);
            // 存储用户设置
            [self saveUserSetWithData:dataDic];
            
            NSLog(@"[AcountManager manager].userid:%@",[AcountManager manager].userid);
            NSLog(@"self.phoneNumTextField.text:%@",_loginNameTextField.text);
            NSLog(@"self.passwordTextField.text:%@",_autoTextField.text);
            
            [self loginWithUsername:_loginNameTextField.text password:self.passwordStr  dataDic:dataDic];
            
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
             [AcountManager saveUserName:_loginNameTextField.text andPassword:password];
             
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
             [DVVUserManager loginSuccsssAndSetupMainVc];
             
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
    [_autoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentViewWidth);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(ws.loginNameTextField.mas_bottom).offset(20);
    }];
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.autoTextField.mas_top).offset(0);
        make.width.mas_equalTo(86);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(ws.autoTextField.mas_right).offset(-10);
        
    }];

    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentViewWidth);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(ws.autoTextField.mas_bottom).offset(32);
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
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(50);
    }];
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(ws.contentView.mas_top);
    }];
    
}

#pragma mark - lazy load

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
        _logoImageView.image = [UIImage imageNamed:@"logo"];
        _logoImageView.bounds = CGRectMake(0, 0, 166, 120);
        _logoImageView.contentMode = UIViewContentModeCenter;
    }
    return _logoImageView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (DVVBaseTextField *)loginNameTextField {
    if (!_loginNameTextField) {
        _loginNameTextField = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"user_white"] placeholder:@"请输入手机号"];
        _loginNameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _loginNameTextField.cornerRadius = 10;
        _loginNameTextField.foregroundColor = [UIColor whiteColor];
        _loginNameTextField.delegate = self;
    }
    return _loginNameTextField;
}

- (DVVBaseTextField *)autoTextField {
    if (!_autoTextField) {
        _autoTextField = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"test"] placeholder:@"请输入验证码"];
        _autoTextField.cornerRadius = 10;
        _autoTextField.foregroundColor = [UIColor whiteColor];
        _autoTextField.keyboardType=UIKeyboardTypeNumberPad;
//        _passwordTextField.secureTextEntry = YES;
//        [[NSNotificationCenter defaultCenter]
//         addObserver:self
//         selector:@selector(passwordTextFieldTextDidChange:)
//         name:UITextFieldTextDidChangeNotification
//         object:_passwordTextField];
    }
    return _autoTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton new];
        [_loginButton.layer setMasksToBounds:YES];
        [_loginButton.layer setCornerRadius:10];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_loginButton setTitle:@"验证登录" forState:UIControlStateNormal];
        _loginButton.backgroundColor = YBNavigationBarBgColor;
        
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton new];
        [_registerButton setTitle:@"密码登录" forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_registerButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 44 - 12, 0)];
        [_registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}
- (UIButton *)retrievePasswordButton {
    if (!_retrievePasswordButton) {
        _retrievePasswordButton = [UIButton new];
        [_retrievePasswordButton setTitle:@"随便看看" forState:UIControlStateNormal];
        _retrievePasswordButton.titleLabel.font = [UIFont systemFontOfSize:12];
//        _retrievePasswordButton.backgroundColor = [UIColor cyanColor];
        [_retrievePasswordButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 44 - 12, 0)];
        [_retrievePasswordButton addTarget:self action:@selector(bottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retrievePasswordButton;
}
- (UIButton *)sendButton{
    if (_sendButton == nil) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
        //        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _sendButton.backgroundColor = [UIColor clearColor];
        [self.sendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sendButton.userInteractionEnabled = YES;
    }
    return _sendButton;
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

