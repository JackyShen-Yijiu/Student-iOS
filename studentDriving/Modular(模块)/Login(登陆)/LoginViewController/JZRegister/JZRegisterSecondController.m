//
//  JZRegisterSecondController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/4.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZRegisterSecondController.h"
#import "DVVBaseTextField.h"
#import "RegistNoteController.h"
#import "NSString+DY_MD5.h"
#import <JPush/APService.h>
static NSString *const kkregisterUser = @"userinfo/signup";

@interface JZRegisterSecondController ()<UITextFieldDelegate>
@property (nonatomic, strong) DVVBaseTextField *passwordTextFiled; // 密码
@property (nonatomic, strong) DVVBaseTextField *invitiTextFiled; // 验证码
@property (strong, nonatomic)UIButton *registButton;

@property (strong, nonatomic)UIButton *noteLabel;
@property (strong, nonatomic) UIButton *selectButton;
@property (strong, nonatomic) UIButton *eyeButton;

@property (strong, nonatomic) NSMutableDictionary *paramsPost;




@end
@implementation JZRegisterSecondController
- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    [self initUI];
    
}

- (void)initUI{
    [self.view addSubview:self.passwordTextFiled];
    [self.view addSubview:self.eyeButton];
    [self.view addSubview:self.invitiTextFiled];
    [self.view addSubview:self.registButton];
    [self.view addSubview:self.selectButton];
    [self.view addSubview:self.noteLabel];
    
}
#pragma mark -- UItextFiledDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (5000 == textField.tag) {
        // 手机号开始输入
        //        self.sendButton.backgroundColor = YBNavigationBarBgColor;
        //        self.sendButton.userInteractionEnabled = YES;
        
    }
    if (5001 == textField.tag) {
        // 验证码开始输入
        //        self.nextRegisterButton.backgroundColor = YBNavigationBarBgColor;
        //        self.nextRegisterButton.userInteractionEnabled = YES;
        
    }
    
}
// 点击下一步
- (void)nextRegisterButton:(UIButton *)sender{
    
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
    [self.paramsPost setObject:self.phoneStr forKey:@"mobile"];
    // 验证码字段
    [self.paramsPost setObject:self.autoStr forKey:@"smscode"];
    
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
                 [AcountManager saveUserName:self.phoneStr andPassword:self.passwordTextFiled.text];
                 
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

#pragma mark 验证用户是否存在
- (void)userExist {
    
    __weak typeof(self) ws = self;
    
    NSString *urlString = [NSString stringWithFormat:@"userinfo/userexists?usertype=1&mobile=%@",self.phoneStr];
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
    
//    [JENetwoking startDownLoadWithUrl:codeUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
//        
//        NSLog(@"%@", data);
//        
//        NSDictionary *params = data;
//        BOOL type = [[params objectForKey:@"type"] boolValue];
//        if (type) {
//            if ([[params objectForKey:@"data"] boolValue]) {
//                [self obj_showTotasViewWithMes:@"此用户已经注册"];
//            }else {
//                [self userRegister];
//            }
//        }else {
//            [ws obj_showTotasViewWithMes:@"网络错误"];
//        }
//    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(48);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(@44);
        
    }];
    
    [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.passwordTextFiled.mas_right).with.offset(-14);
        make.top.mas_equalTo(self.passwordTextFiled.mas_top).with.offset(44/2-8/2);
        make.height.mas_equalTo(@8);
        make.width.mas_equalTo(@16);
    }];

    [self.invitiTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextFiled.mas_bottom).offset(24);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(@44);
    }];
    
    
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.invitiTextFiled.mas_bottom).offset(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.height.mas_equalTo(@44);
        
        
    }];
    // 协议框
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.top.mas_equalTo(self.registButton.mas_bottom).with.offset(21);
        make.height.mas_equalTo(@24);
        make.width.mas_equalTo(@24);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectButton.mas_right).with.offset(9);
        make.top.mas_equalTo(self.registButton.mas_bottom).with.offset(27);
        make.height.mas_equalTo(@12);
        make.width.mas_equalTo(@164);
    }];

    
}
#pragma mark -- ActionTatarget
#pragma  mark -----
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
- (void)passwordTextFieldTextDidChange:(NSNotification *)obj{
    UITextField *phoneTextFiled = (UITextField *)obj.object;
    if (phoneTextFiled.text.length == 0) {
        _registButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _registButton.userInteractionEnabled = NO;
    }else{
        _registButton.backgroundColor = YBNavigationBarBgColor;
        _registButton.userInteractionEnabled = YES;
        
    }
}

#pragma mark ----- Lazy 加载
- (DVVBaseTextField *)passwordTextFiled{
    if (_passwordTextFiled == nil) {
        _passwordTextFiled  = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"password"] placeholder:@"请输入密码" borderColor:YBNavigationBarBgColor];
        _passwordTextFiled.tag = 5000;
        _passwordTextFiled.delegate = self;
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(passwordTextFieldTextDidChange:)
         name:UITextFieldTextDidChangeNotification
         object:_passwordTextFiled];
    }
    return _passwordTextFiled;
}

- (DVVBaseTextField *)invitiTextFiled{
    if (_invitiTextFiled == nil) {
        _invitiTextFiled  = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"JZphone"] placeholder:@"邀请人的电话号码(非必填)" borderColor:YBNavigationBarBgColor];
        _invitiTextFiled.tag = 5001;
        _invitiTextFiled.delegate = self;
        
        }
    return _invitiTextFiled;
}
- (UIButton *)registButton{
    if (_registButton == nil) {
        _registButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _registButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registButton addTarget:self action:@selector(nextRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
        [_registButton setTitle:@"完成" forState:UIControlStateNormal];
        _registButton.layer.masksToBounds = YES;
        _registButton.layer.cornerRadius = 10;
        _registButton.layer.borderWidth = 1;
        _registButton.layer.borderColor = [UIColor colorWithHexString:@"fb7064"].CGColor;
        _registButton.userInteractionEnabled = NO;
    }
    return _registButton;
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
        [_eyeButton setBackgroundImage:[UIImage imageNamed:@"look_off"] forState:UIControlStateNormal];
        [_eyeButton setBackgroundImage:[UIImage imageNamed:@"look_on"] forState:UIControlStateSelected];
        [_eyeButton addTarget:self action:@selector(didEyeButton:) forControlEvents:UIControlEventTouchUpInside];
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
