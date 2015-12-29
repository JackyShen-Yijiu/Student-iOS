//
//  RegisterViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/4.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "RegisterViewController.h"
#import <Masonry/Masonry.h>
#import "ToolHeader.h"
#import "NSString+DY_MD5.h"
#import <JPush/APService.h>
#import "RegistNoteController.h"
static NSString *const kregisterUser = @"kregisterUser";

static NSString *const kregisterUrl = @"userinfo/signup";

static NSString *const kcodeGainUrl = @"code";

@interface RegisterViewController ()<UITextFieldDelegate>

@property (strong, nonatomic)UIButton *goBackButton;
@property (strong, nonatomic)UIButton *sendButton;
@property (strong, nonatomic)UIButton *registerButton;
@property (strong, nonatomic)UITextField *phoneTextField;
@property (strong, nonatomic)UITextField *authCodeTextFild;
@property (strong, nonatomic)UITextField *passWordTextFild;
@property (strong, nonatomic)UITextField *affirmTextFild;
@property (strong, nonatomic)UITextField *invitationTextFild;
@property (strong, nonatomic)UIButton *noteLabel;
@property (strong, nonatomic) UILabel *topLabel;

@property (strong, nonatomic) NSMutableDictionary *paramsPost;
@end

@implementation RegisterViewController

- (NSMutableDictionary *)paramsPost {
    if (_paramsPost == nil) {
        _paramsPost = [[NSMutableDictionary alloc] init];
    }
    return _paramsPost;
}
- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont boldSystemFontOfSize:18];
        _topLabel.textColor = RGBColor(51, 51, 51);
        _topLabel.text = @"注册";
    }
    return _topLabel;
}

- (UIButton *)noteLabel{
    if (_noteLabel == nil) {
        _noteLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        _noteLabel.backgroundColor = [UIColor whiteColor];
        [_noteLabel setTitle:@"点击注册则表示您同意《用户服务协议》" forState:UIControlStateNormal];
        [_noteLabel setTitleColor:RGBColor(0x28, 0x79, 0xF3) forState:UIControlStateNormal];
        _noteLabel.titleLabel.font = [UIFont systemFontOfSize:13];
        _noteLabel.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_noteLabel addTarget:self action:@selector(clickTap1:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noteLabel;
}

- (UIButton *)goBackButton{
    if (_goBackButton == nil) {
        _goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回_click"] forState:UIControlStateNormal];
        [_goBackButton addTarget:self action:@selector(dealGoBack:) forControlEvents:UIControlEventTouchUpInside];
        [_goBackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _goBackButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _goBackButton;
}

- (UIButton *)sendButton{
    if (_sendButton == nil) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.backgroundColor = RGBColor(255, 102, 51);
        [_sendButton addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        
    }
    return _sendButton;
}

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.backgroundColor = RGBColor(255, 102, 51);
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(dealRegister:) forControlEvents:UIControlEventTouchUpInside];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    }
    return _registerButton;
}

- (UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc]init];
        _phoneTextField.delegate = self;
        _phoneTextField.tag = 102;
        _phoneTextField.placeholder = @"    手机号";
        _phoneTextField.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _phoneTextField.layer.borderWidth = 1;
        _phoneTextField.font  = [UIFont systemFontOfSize:15];
        _phoneTextField.textColor = RGBColor(153, 153, 153);
    }
    return _phoneTextField;
}

- (UITextField *)passWordTextFild{
    if (_passWordTextFild == nil) {
        _passWordTextFild = [[UITextField alloc]init];
        _passWordTextFild.delegate = self;
        _passWordTextFild.tag = 103;
        _passWordTextFild.placeholder = @"    密码";
        _passWordTextFild.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _passWordTextFild.layer.borderWidth = 1;
        _passWordTextFild.font  = [UIFont systemFontOfSize:15];
        _passWordTextFild.textColor = RGBColor(153, 153, 153);
        _passWordTextFild.secureTextEntry = YES;
    }
    return _passWordTextFild;
}

- (UITextField *)authCodeTextFild{
    if (_authCodeTextFild == nil) {
        _authCodeTextFild = [[UITextField alloc]init];
        _authCodeTextFild.delegate = self;
        _authCodeTextFild.tag = 104;
        _authCodeTextFild.placeholder = @"    验证码";
        _authCodeTextFild.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _authCodeTextFild.layer.borderWidth = 1;
        _authCodeTextFild.font  = [UIFont systemFontOfSize:15];
        _authCodeTextFild.textColor = RGBColor(153, 153, 153);
    }
    return _authCodeTextFild;
}

- (UITextField *)affirmTextFild{
    if (_affirmTextFild == nil) {
        _affirmTextFild = [[UITextField alloc]init];
        _affirmTextFild.delegate = self;
        _affirmTextFild.tag = 105;
        _affirmTextFild.placeholder = @"    确认密码";
        _affirmTextFild.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _affirmTextFild.layer.borderWidth = 1;
        _affirmTextFild.font  = [UIFont systemFontOfSize:15];
        _affirmTextFild.textColor = RGBColor(153, 153, 153);
        _affirmTextFild.secureTextEntry = YES;
    }
    return _affirmTextFild;
}

- (UITextField *)invitationTextFild{
    if (_invitationTextFild == nil) {
        _invitationTextFild = [[UITextField alloc]init];
        _invitationTextFild.delegate = self;
        _invitationTextFild.tag = 106;
        _invitationTextFild.placeholder = @"    输入邀请码,获得奖励";
        _invitationTextFild.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _invitationTextFild.layer.borderWidth = 1;
        _invitationTextFild.font  = [UIFont systemFontOfSize:15];
        _invitationTextFild.textColor = RGBColor(153, 153, 153);
    }
    return _invitationTextFild;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.topLabel];
    
    [self.view addSubview:self.goBackButton];
    
    [self.view addSubview:self.sendButton];
    
    [self.view addSubview:self.registerButton];
    
    [self.view addSubview:self.phoneTextField];
    
    [self.view addSubview:self.authCodeTextFild];
    
    [self.view addSubview:self.passWordTextFild];
    
    [self.view addSubview:self.invitationTextFild];
    
    [self.view addSubview:self.affirmTextFild];
    
    [self.view addSubview:self.noteLabel];
    
}




#pragma make :自动布局


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.height.mas_equalTo(@50);
    }];
    
    
    [self.goBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@50);
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.goBackButton.mas_bottom).with.offset(7);
        make.height.mas_equalTo(@44);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@117);
    }];
    
    [self.authCodeTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.sendButton.mas_left).with.offset(-10);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
    }];
    
    
    
    [self.passWordTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.authCodeTextFild.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.affirmTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.passWordTextFild.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.invitationTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.affirmTextFild.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.invitationTextFild.mas_bottom).with.offset(20);
        make.height.mas_equalTo(@44);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(10);
        make.top.mas_equalTo(self.registerButton.mas_bottom).with.offset(20);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@250);
    }];
    
    
}

//http://www.ifanying.com/userAgreement.html 用户协议
//http://www.ifanying.com/coachAgreement.html 教练协议
- (void)clickTap1:(UIButton *)btn {
    
    NSLog(@"---=---");
    RegistNoteController *homeVc = [[RegistNoteController alloc] init];
    UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:homeVc];
    [self presentViewController:NC animated:YES completion:nil];
    
}

#pragma mark - buttonAction

#define TIME 60
- (void)dealSend:(UIButton *)sender {
    NSLog(@"发送验证码");
    
    if (self.phoneTextField.text == nil || self.phoneTextField.text.length <= 0) {
        [self showTotasViewWithMes:@"请输入手机号"];
        return;
    }else {
        NSString *urlString = [NSString stringWithFormat:@"code/%@",self.phoneTextField.text];
        NSString *codeUrl = [NSString stringWithFormat:BASEURL,urlString];
        
        [JENetwoking startDownLoadWithUrl:codeUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            [self showTotasViewWithMes:@"发送成功"];
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
                self.sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
                self.sendButton.backgroundColor  = MAINCOLOR;
                [self.sendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.sendButton.userInteractionEnabled = YES;
            });
        }else {
            NSString *str = [NSString stringWithFormat:@"剩余(%d)s",count];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendButton.backgroundColor = RGBColor(204, 204, 204);
                [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.sendButton setTitle:str forState:UIControlStateNormal];

    
            });
            count--;
        }
    });
    dispatch_resume(timer);
}

- (void)dealGoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealRegister:(UIButton *)sender {
    
    NSString *phoneNum = self.phoneTextField.text;
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNum];
    if (!isMatch) {
        [self showTotasViewWithMes:@"请输入正确的手机号"];
        return;
    }
    [self.paramsPost setObject:self.phoneTextField.text forKey:@"mobile"];
    if (self.authCodeTextFild.text.length <= 0 || self.authCodeTextFild.text == nil) {
        [self showTotasViewWithMes:@"请输入验证码"];
        return;
    }
    [self.paramsPost setObject:self.authCodeTextFild.text forKey:@"smscode"];
    if (self.passWordTextFild.text == nil || self.passWordTextFild.text.length <= 0) {
        [self showTotasViewWithMes:@"请输入密码"];
        return;

    }
    
    if (self.affirmTextFild.text == nil || self.affirmTextFild.text.length <= 0) {
        [self showTotasViewWithMes:@"请输入确认密码"];
        return;
    }
    NSString *passwordString = nil;
    if (![self.passWordTextFild.text isEqualToString:self.affirmTextFild.text]) {
        [self showTotasViewWithMes:@"两次密码不一样"];
        return;
    }
    passwordString = self.passWordTextFild.text.DY_MD5;
    [self.paramsPost setObject:passwordString forKey:@"password"];
    //网络请求
    
    if (self.invitationTextFild.text.length >0 && self.invitationTextFild.text != nil) {
        [self.paramsPost setObject:self.invitationTextFild.text forKey:@"referrerCode"];
    }
    [self.paramsPost setObject:@"1" forKey:@"usertype"];
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kregisterUrl];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:self.paramsPost WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        DYNSLog(@"data = %@",data);
        
        NSDictionary *dataDic = data;
        
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        
        NSString *type = [NSString stringWithFormat:@"%@",dataDic[@"type"]];
        
        if ([type isEqualToString:@"0"]) {
            [self showTotasViewWithMes:dataDic[@"msg"]];
        }else if ([type isEqualToString:@"1"]) {
            [AcountManager configUserInformationWith:dataDic[@"data"]];
            [self showTotasViewWithMes:@"登录成功"];
            [AcountManager saveUserName:self.phoneTextField.text andPassword:self.passWordTextFild.text];
            if ([AcountManager manager].userid) {
                [APService setAlias:[AcountManager manager].userid callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
                [self registerUserId:[AcountManager manager].userid withPassword:self.passWordTextFild.text.DY_MD5];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccess" object:nil];
            [self dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kregisterUser object:nil];
            }];
        }
        
    } withFailure:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view animated:NO];

    }];
    
}

//注册账号
- (void)registerUserId:(NSString *)userid withPassword:(NSString *)password {
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:userid
                                                         password:password
                                                   withCompletion:
     ^(NSString *username, NSString *password, EMError *error) {
         [self hideHud];
         
         if (!error) {
             TTAlertNoTitle(NSLocalizedString(@"register.success", @"Registered successfully, please log in"));
             [self loginWithUsername:userid password:password];
         }else{
             switch (error.errorCode) {
                 case EMErrorServerNotReachable:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                     break;
                 case EMErrorServerDuplicatedAccount:
                     TTAlertNoTitle(NSLocalizedString(@"register.repeat", @"You registered user already exists!"));
                     break;
                 case EMErrorNetworkNotConnected:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                     break;
                 case EMErrorServerTimeout:
                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                     break;
                 default:
                     TTAlertNoTitle(NSLocalizedString(@"register.fail", @"Registration failed"));
                     break;
             }
         }
     } onQueue:nil];
}
//点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    [self showHudInView:self.view hint:NSLocalizedString(@"login.ongoing", @"Is Login...")];
    //异步登陆账号
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username
                                                        password:password
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         [self hideHud];
         if (loginInfo && !error) {
             DYNSLog(@"登录");
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


@end
