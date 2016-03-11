//
//  JZRegisterController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZRegisterController.h"
#import "DVVBaseTextField.h"
#import "JZRegisterSecondController.h"
#import "RegistNoteController.h"
#import "NSString+DY_MD5.h"
#import <JPush/APService.h>

static NSString *const kkregisterUser = @"userinfo/signup";
static NSString *const kautoCode = @"Verificationsmscode";

@interface JZRegisterController ()<UITextFieldDelegate>
@property (nonatomic, strong) DVVBaseTextField *phoneNumTextFiled; // 手机号
@property (nonatomic, strong) DVVBaseTextField *authCodeTextFiled; // 验证码
@property (strong, nonatomic)UIButton *sendButton;
@property (strong, nonatomic)UIButton *nextRegisterButton;
@property (nonatomic,strong) UIView *codeView;

@property (nonatomic, strong) DVVBaseTextField *passwordTextFiled; // 密码
@property (nonatomic, strong) DVVBaseTextField *invitiTextFiled; // 验证码

@property (strong, nonatomic)UIButton *noteLabel;
@property (strong, nonatomic) UIButton *selectButton;
@property (strong, nonatomic) UIButton *eyeButton;

@property (strong, nonatomic) NSMutableDictionary *paramsPost;

@end

@implementation JZRegisterController
- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    
    [self initUI];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
}

- (void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)initUI{
    [self.view addSubview:self.phoneNumTextFiled];
    [self.view addSubview:self.codeView];
    [self.codeView addSubview:self.authCodeTextFiled];
    [self.codeView addSubview:self.sendButton];
    [self.view addSubview:self.passwordTextFiled];
    [self.view addSubview:self.eyeButton];
    [self.view addSubview:self.nextRegisterButton];
//    [self.view addSubview:self.invitiTextFiled];
    [self.view addSubview:self.selectButton];
    [self.view addSubview:self.noteLabel];
}

#pragma mark -- UItextFiledNotification
#pragma mark ---- 手机号改变的通知
- (void)phoenTextFieldTextDidChange:(NSNotification *)obj{
    UITextField *phoneTextFiled = (UITextField *)obj.object;
    if (phoneTextFiled.text.length == 0) {
        _sendButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _sendButton.userInteractionEnabled = NO;
        
        // 注册按钮不可编辑
        _nextRegisterButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _nextRegisterButton.userInteractionEnabled = NO;

    }else{
        _sendButton.backgroundColor = YBNavigationBarBgColor;
        _sendButton.userInteractionEnabled = YES;
        // 判断注册按钮是否可编辑
        if (self.authCodeTextFiled.text.length && self.passwordTextFiled.text.length) {
            _nextRegisterButton.backgroundColor = YBNavigationBarBgColor;
            _nextRegisterButton.userInteractionEnabled = YES;
        }
        
    }
}
#pragma mark ---- 验证码改变的通知
- (void)authCodeTextFieldTextDidChange:(NSNotification *)obj{
    UITextField *autoTextFiled = (UITextField *)obj.object;
    if (autoTextFiled.text.length && self.phoneNumTextFiled.text.length && self.passwordTextFiled.text.length ) {
        _nextRegisterButton.backgroundColor = YBNavigationBarBgColor;
        _nextRegisterButton.userInteractionEnabled = YES;
    }else{
        _nextRegisterButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _nextRegisterButton.userInteractionEnabled = NO;
    }
}
#pragma mark ---- 密码改变的通知
- (void)passwordTextFieldTextDidChange:(NSNotification *)obj{
    UITextField *passwordTextFiled = (UITextField *)obj.object;
    if (passwordTextFiled.text.length && self.phoneNumTextFiled.text.length && self.passwordTextFiled.text.length ) {
        _nextRegisterButton.backgroundColor = YBNavigationBarBgColor;
        _nextRegisterButton.userInteractionEnabled = YES;
    }else{
        _nextRegisterButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _nextRegisterButton.userInteractionEnabled = NO;
    }

}
#pragma mark - buttonAction
//- (void)sideMenuButtonAction:(UIButton *)btn{
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}
#define TIME 60
- (void)dealSend:(UIButton *)sender {
    
    NSLog(@"发送验证码");
    
    [self sendYanZhengMa:sender];
    
}

#pragma mark 发送验证码
- (void)sendYanZhengMa:(UIButton *)sender
{
    
    if (self.phoneNumTextFiled.text == nil || self.phoneNumTextFiled.text.length <= 0) {
        [self obj_showTotasViewWithMes:@"请输入手机号"];
        return;
        
    }else {
        
        if (![AcountManager isValidateMobile:self.phoneNumTextFiled.text]) {
            [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
            return;
        }
        
        NSString *urlString = [NSString stringWithFormat:@"code/%@",self.phoneNumTextFiled.text];
        NSString *codeUrl = [NSString stringWithFormat:BASEURL,urlString];
        
        [JENetwoking startDownLoadWithUrl:codeUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            [self obj_showTotasViewWithMes:@"发送成功"];
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
                _sendButton.backgroundColor = YBNavigationBarBgColor;
                [self.sendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.sendButton.userInteractionEnabled = YES;
            });
        }else {
            NSString *str = [NSString stringWithFormat:@"剩余(%d)s",count];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
                [self.sendButton setTitleColor:[UIColor colorWithHexString:@"fed"] forState:UIControlStateNormal];
                [self.sendButton setTitle:str forState:UIControlStateNormal];
                
            });
            count--;
        }
    });
    dispatch_resume(timer);
}
// 点击注册
- (void)nextRegisterButton:(UIButton *)sender{
    
    // 验证验证码是否正确
    NSString *urlStr = [NSString stringWithFormat:BASEURL,kautoCode];
    //    /api/v1/Verificationsmscode?mobile=15652305650&code=123456
    
    NSDictionary *param = @{@"mobile":self.phoneNumTextFiled.text,
                            @"code":self.authCodeTextFiled.text};
    [JENetwoking startDownLoadWithUrl:urlStr postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        /*
         {
         "type": 0,
         "msg": "验证码错误，请重新发送",
         "data": ""
         }
         */
        NSDictionary *param = data;
        if (0 == [data[@"type"] integerValue]) {
            // 验证码错误
            [self obj_showTotasViewWithMes:param[@"msg"]];
            return ;
        }
        if (1 == [data[@"type"] integerValue]) {
         // 验证码正确
            [self nextRegister];
        
        }
        
    } withFailure:^(id data) {
        
    }];
    
}
// 进一步验证
- (void)nextRegister{
    
    [self.passwordTextFiled endEditing:YES];
    
    if (self.passwordTextFiled.text == nil || self.passwordTextFiled.text.length <= 0) {
        [self obj_showTotasViewWithMes:@"请输入密码"];
        return;
        
    }
    if (!self.selectButton) {
        [self obj_showTotasViewWithMes:@"请同意用户服务协议"];
    }
    // 测试手机号是否注册
    [self userExist];
    
}

#pragma mark 验证用户是否存在
- (void)userExist {
    
    __weak typeof(self) ws = self;
    
    NSString *urlString = [NSString stringWithFormat:@"userinfo/userexists?usertype=1&mobile=%@",self.phoneNumTextFiled.text];
    NSString *codeUrl = [NSString stringWithFormat:BASEURL,urlString];
    NSLog(@"codeUrl:%@",codeUrl);
    
    [JENetwoking startDownLoadWithUrl:codeUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSLog(@"%@", data);
        
        NSDictionary *params = data;
        BOOL type = [[params objectForKey:@"type"] boolValue];
        if (type) {
            if ([[params objectForKey:@"data"] boolValue]) {
                [self obj_showTotasViewWithMes:@"此用户已经注册"];
            }else {
                [self userRegister];
            }
        }else {
            [ws obj_showTotasViewWithMes:@"网络错误"];
        }
        
    } withFailure:^(id data) {
        
    }];
    
}
// 向服务器注册用户
- (void)userRegister {
    
    NSString *passwordString = nil;
    passwordString = self.passwordTextFiled.text.DY_MD5;
    
    // 密码字段
    [self.paramsPost setObject:passwordString forKey:@"password"];
    //网络请求
    
    if (self.invitiTextFiled.text.length >0 && self.invitiTextFiled.text != nil) {
        [self.paramsPost setObject:self.invitiTextFiled.text forKey:@"referrerCode"];
    }
    [self.paramsPost setObject:@"1" forKey:@"usertype"];
    
    // 手机号字段
    [self.paramsPost setObject:self.phoneNumTextFiled.text forKey:@"mobile"];
    // 验证码字段
    [self.paramsPost setObject:self.authCodeTextFiled.text forKey:@"smscode"];
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kkregisterUser];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:self.paramsPost WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        DYNSLog(@"向服务器注册用户data = %@",data);
        
        NSDictionary *dataDic = data;
        
        //        NSString *type = [NSString stringWithFormat:@"%@",dataDic[@"type"]];
        
        if ([[data objectForKey:@"type"] integerValue] == 0) {
            
            //            [self showTotasViewWithMes:];
            [self obj_showTotasViewWithMes:dataDic[@"msg"]];
            
        }else if ([[data objectForKey:@"type"] integerValue] == 1) {
            
            NSString *userid = [NSString stringWithFormat:@"%@",dataDic[@"data"][@"userid"]];
            NSLog(@"dataDic.userid:%@---userid:%@",dataDic[@"data"][@"userid"],userid);
            [self obj_showTotasViewWithMes:@"注册成功!"];
            [self loginWithUserID:userid password:passwordString dataDic:dataDic];
            
        }
        
    }];
}

//点击登陆后的操作
- (void)loginWithUserID:(NSString *)userID password:(NSString *)password dataDic:(NSDictionary *)dataDic
{
    [self showHudInView:self.view hint:NSLocalizedString(@"登录中...", @"登录中...")];
    
    //异步登陆账号
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userID
                                                        password:password
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         
         [self hideHud];
         
         if (loginInfo && !error) {
             
             NSLog(@"error:%@",error);
             [MBProgressHUD hideHUDForView:self.view animated:NO];
             
             if (loginInfo && !error) {
                 
                 DYNSLog(@"登录成功");
                 
                 //保存最近一次登录用户名
                 [AcountManager saveUserName:self.phoneNumTextFiled.text andPassword:self.passwordTextFiled.text];
                 
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
- (void)didEyeButton:(UIButton *)btn{
    if (!btn.selected) {
        self.passwordTextFiled.secureTextEntry = NO;
        btn.selected = YES;
        
    }else if (btn.selected) {
        self.passwordTextFiled.secureTextEntry = YES;
        btn.selected = NO;
    }
    
}
// 协议框的点击事件
- (void)didClickSelectButton:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
    }else{
        
        btn.selected = YES;
    }
}
- (void)clickTap1:(UIButton *)btn {
    
    NSLog(@"---=---");
    RegistNoteController *homeVc = [[RegistNoteController alloc] init];
    UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:homeVc];
    [self presentViewController:NC animated:YES completion:nil];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.phoneNumTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(48);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(@44);
        
    }];
    
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneNumTextFiled.mas_bottom).offset(18);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.phoneNumTextFiled.mas_right);
        make.height.mas_equalTo(@44);
    }];
    
    [self.authCodeTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(self.codeView.mas_right).offset(-86);
        make.height.mas_equalTo(self.codeView.mas_height);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@86);
    }];
    
    
    [self.passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeView.mas_bottom).offset(18);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(@44);
        
    }];
    
    [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.passwordTextFiled.mas_right).with.offset(-14);
        make.top.mas_equalTo(self.passwordTextFiled.mas_top).with.offset(0);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@44);
    }];
    
//    [self.invitiTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.passwordTextFiled.mas_bottom).offset(24);
//        make.left.mas_equalTo(self.view.mas_left).offset(20);
//        make.right.mas_equalTo(self.view.mas_right).offset(-20);
//        make.height.mas_equalTo(@44);
//    }];
    
    
    [self.nextRegisterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextFiled.mas_bottom).offset(32);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.height.mas_equalTo(@44);
        
        
    }];
    // 协议框
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.top.mas_equalTo(self.nextRegisterButton.mas_bottom).with.offset(21);
        make.height.mas_equalTo(@24);
        make.width.mas_equalTo(@24);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectButton.mas_right).with.offset(9);
        make.top.mas_equalTo(self.nextRegisterButton.mas_bottom).with.offset(27);
        make.height.mas_equalTo(@12);
        make.width.mas_equalTo(@164);
    }];
    
    
}
#pragma mark ----- Lazy 加载
- (DVVBaseTextField *)phoneNumTextFiled{
    if (_phoneNumTextFiled == nil) {
        _phoneNumTextFiled  = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"user"] placeholder:@"请输入手机号" borderColor:[UIColor colorWithHexString:@"b7b7b7"]];
        _phoneNumTextFiled.tag = 5000;
        _phoneNumTextFiled.delegate = self;
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(phoenTextFieldTextDidChange:)
         name:UITextFieldTextDidChangeNotification
         object:_phoneNumTextFiled];
    }
    return _phoneNumTextFiled;
}
- (UIView *)codeView
{
    if (_codeView==nil) {
        _codeView = [[UIView alloc] init];
        _codeView.layer.masksToBounds = YES;
        _codeView.layer.cornerRadius = 10;
        _codeView.layer.borderWidth = 1;
        _codeView.layer.borderColor = [UIColor colorWithHexString:@"b7b7b7"].CGColor;
    }
    return _codeView;
}

- (DVVBaseTextField *)authCodeTextFiled{
    if (_authCodeTextFiled == nil) {
        _authCodeTextFiled  = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"test"] placeholder:@"请输入验证码" borderColor:[UIColor clearColor]];
        _authCodeTextFiled.tag = 5001;
        _authCodeTextFiled.delegate = self;
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(authCodeTextFieldTextDidChange:)
         name:UITextFieldTextDidChangeNotification
         object:_authCodeTextFiled];
    }
    return _authCodeTextFiled;
}
- (DVVBaseTextField *)passwordTextFiled{
    if (_passwordTextFiled == nil) {
        _passwordTextFiled  = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"password"] placeholder:@"请输入密码" borderColor:[UIColor colorWithHexString:@"b7b7b7"]];
        _passwordTextFiled.tag = 5002;
        _passwordTextFiled.delegate = self;
        _passwordTextFiled.secureTextEntry = YES;
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(passwordTextFieldTextDidChange:)
         name:UITextFieldTextDidChangeNotification
         object:_passwordTextFiled];
    }
    return _passwordTextFiled;
}

- (UIButton *)sendButton{
    if (_sendButton == nil) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
        //        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _sendButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        _sendButton.userInteractionEnabled = NO;
        
    }
    return _sendButton;
}
- (UIButton *)nextRegisterButton{
    if (_nextRegisterButton == nil) {
        _nextRegisterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextRegisterButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _nextRegisterButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextRegisterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextRegisterButton addTarget:self action:@selector(nextRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
        [_nextRegisterButton setTitle:@"注册" forState:UIControlStateNormal];
        _nextRegisterButton.layer.masksToBounds = YES;
        _nextRegisterButton.layer.cornerRadius = 10;
        _nextRegisterButton.layer.borderWidth = 1;
        _nextRegisterButton.layer.borderColor = [UIColor colorWithHexString:@"fb7064"].CGColor;
        _nextRegisterButton.userInteractionEnabled = NO;
    }
    return _nextRegisterButton;
}
- (UIButton *)noteLabel{
    if (_noteLabel == nil) {
        _noteLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_noteLabel setTitle:@"我已同意《用户使用协议》" forState:UIControlStateNormal];
        [_noteLabel setTitleColor:[UIColor colorWithHexString:@"6c8efd"] forState:UIControlStateNormal];
        _noteLabel.titleLabel.font = [UIFont systemFontOfSize:12];
        _noteLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_noteLabel addTarget:self action:@selector(clickTap1:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noteLabel;
}
- (UIButton *)selectButton{
    if (_selectButton == nil) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectButton setBackgroundImage:[UIImage imageNamed:@"selectButton_select"] forState:UIControlStateSelected];
        [self.selectButton setBackgroundImage:[UIImage imageNamed:@"selectButton_normal"] forState:UIControlStateNormal];
        [self.selectButton addTarget:self action:@selector(didClickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        _selectButton.selected = YES;
    }
    return _selectButton;
}
- (UIButton *)eyeButton{
    if (_eyeButton == nil) {
        _eyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyeButton setImage:[UIImage imageNamed:@"look_off"] forState:UIControlStateNormal];
        [_eyeButton setImage:[UIImage imageNamed:@"look_on"] forState:UIControlStateSelected];
        [_eyeButton addTarget:self action:@selector(didEyeButton:) forControlEvents:UIControlEventTouchUpInside];
        [_eyeButton setImageEdgeInsets:UIEdgeInsetsMake(14, 28, 14, 0)];
        _eyeButton.backgroundColor = [UIColor clearColor];
    }
    return _eyeButton;
}
- (NSMutableDictionary *)paramsPost {
    if (_paramsPost == nil) {
        _paramsPost = [[NSMutableDictionary alloc] init];
    }
    return _paramsPost;
}

@end
