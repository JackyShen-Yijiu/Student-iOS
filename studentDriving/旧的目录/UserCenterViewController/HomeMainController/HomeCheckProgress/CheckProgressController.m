//
//  CheckProgressController.m
//  studentDriving
//
//  Created by ytzhang on 16/1/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "CheckProgressController.h"
#import "CheckProgressTextField.h"
static NSString *const kcheckProgressUrl = @"userinfo/enrollverificationv2";

@interface CheckProgressController () <UITextFieldDelegate>

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic)UIButton *sendButton;
@property (strong, nonatomic) NSMutableDictionary *paramsPost;
@property (strong, nonatomic)UITextField *phoneTextField;
@property (strong, nonatomic)UITextField *authCodeTextFild;
@property (strong, nonatomic)UITextField *schoolTextFild;
@property (strong, nonatomic)UITextField *classTextFild;
@property (strong, nonatomic)UITextField *coachTextFild;
@property (strong, nonatomic)UITextField *nameTextFild;
@property (strong, nonatomic)UITextField *idCardTextFild;
@property (strong, nonatomic)UITextField *progressTextFild;
@property (nonatomic, strong) UIView *topLinwView;
@property (nonatomic, strong) UIView *buttomLinwView;
@property (nonatomic, strong) UIView *shortLineView;

@property (nonatomic, strong) UIButton *checkButton;



@end
@implementation CheckProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证学车进度";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f9fb"];
    [self.view addSubview:self.bgView];
    
    [self.bgView addSubview:self.topLinwView];
    
    [self.bgView addSubview:self.phoneTextField];
    
    [self.bgView addSubview:self.authCodeTextFild];
    
    [self.bgView addSubview:self.shortLineView];
    
    [self.bgView addSubview:self.sendButton];
    
    [self.bgView addSubview:self.schoolTextFild];
    
    [self.bgView addSubview:self.classTextFild];
    
    [self.bgView addSubview:self.coachTextFild];
    
    [self.bgView addSubview:self.nameTextFild];
    
    [self.bgView addSubview:self.idCardTextFild];
    
    [self.bgView addSubview:self.progressTextFild];
    
    [self.bgView addSubview:self.buttomLinwView];
    
    
    [self.view addSubview:self.checkButton];

    
}
- (UIView *)topLinwView{
    if (_topLinwView == nil) {
        _topLinwView = [[UIView alloc] init];
        _topLinwView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    }
    return _topLinwView;
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor  = [UIColor whiteColor];
    }
    return _bgView;
}
- (NSMutableDictionary *)paramsPost {
    if (_paramsPost == nil) {
        _paramsPost = [[NSMutableDictionary alloc] init];
    }
    return _paramsPost;
}

- (UIButton *)sendButton{
    if (_sendButton == nil) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.backgroundColor = [UIColor clearColor];
        [_sendButton addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
        //        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sendButton setTitleColor:[UIColor colorWithHexString:@"ff6633"] forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        
    }
    return _sendButton;
}

- (UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[CheckProgressTextField alloc] init];
        _phoneTextField.delegate = self;
        _phoneTextField.tag = 102;
        _phoneTextField.placeholder = @"手机号";
        _phoneTextField.font  = [UIFont systemFontOfSize:14];
        _phoneTextField.textColor = [UIColor colorWithHexString:@"d9d9d9"];
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTextField;
}


- (UITextField *)authCodeTextFild{
    if (_authCodeTextFild == nil) {
        _authCodeTextFild = [[CheckProgressTextField alloc]init];
        _authCodeTextFild.delegate = self;
        _authCodeTextFild.tag = 104;
        _authCodeTextFild.placeholder = @"验证码";
        _authCodeTextFild.font  = [UIFont systemFontOfSize:14];
        _authCodeTextFild.textColor = [UIColor colorWithHexString:@"d9d9d9"];
        _authCodeTextFild.keyboardType = UIKeyboardTypeNumberPad;
        
    }
    return _authCodeTextFild;
}

- (UIView *)shortLineView{
    if (_shortLineView == nil) {
        _shortLineView = [[UIView alloc] init];
        _shortLineView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    }
    return _shortLineView;
}
- (UITextField *)schoolTextFild{
    if (_schoolTextFild == nil) {
        _schoolTextFild = [[CheckProgressTextField alloc]init];
        _schoolTextFild.delegate = self;
        _schoolTextFild.tag = 103;
        _schoolTextFild.placeholder = @"报考驾校";
        _schoolTextFild.font  = [UIFont systemFontOfSize:14];
        _schoolTextFild.textColor = [UIColor colorWithHexString:@"d9d9d9"];
//        _schoolTextFild.secureTextEntry = YES;
    }
    return _schoolTextFild;
}

- (UITextField *)classTextFild{
    if (_classTextFild == nil) {
        _classTextFild = [[CheckProgressTextField alloc]init];
        _classTextFild.delegate = self;
        _classTextFild.tag = 105;
        _classTextFild.placeholder = @"所属班型";
        _classTextFild.font  = [UIFont systemFontOfSize:14];
        _classTextFild.textColor = [UIColor colorWithHexString:@"d9d9d9"];
        _classTextFild.secureTextEntry = YES;
    }
    return _classTextFild;
}

- (UITextField *)coachTextFild{
    if (_coachTextFild == nil) {
        _coachTextFild = [[CheckProgressTextField alloc]init];
        _coachTextFild.delegate = self;
        _coachTextFild.tag = 106;
        _coachTextFild.placeholder = @"所属教练";
        _coachTextFild.font  = [UIFont systemFontOfSize:14];
        _coachTextFild.textColor = [UIColor colorWithHexString:@"d9d9d9"];
    }
    return _coachTextFild;
}
- (UITextField *)nameTextFild{
    if (_nameTextFild == nil) {
        _nameTextFild = [[CheckProgressTextField alloc]init];
        _nameTextFild.delegate = self;
        _nameTextFild.tag = 106;
        _nameTextFild.placeholder = @"姓名";
        _nameTextFild.font  = [UIFont systemFontOfSize:14];
        _nameTextFild.textColor = [UIColor colorWithHexString:@"d9d9d9"];
    }
    return _nameTextFild;
}
- (UITextField *)idCardTextFild{
    if (_idCardTextFild == nil) {
        _idCardTextFild = [[CheckProgressTextField alloc]init];
        _idCardTextFild.delegate = self;
        _idCardTextFild.tag = 106;
        _idCardTextFild.placeholder = @"身份证";
        _idCardTextFild.font  = [UIFont systemFontOfSize:14];
        _idCardTextFild.textColor = [UIColor colorWithHexString:@"d9d9d9"];
    }
    return _idCardTextFild;
}
- (UITextField *)progressTextFild{
    if (_progressTextFild == nil) {
        _progressTextFild = [[CheckProgressTextField alloc]init];
        _progressTextFild.delegate = self;
        _progressTextFild.tag = 106;
        _progressTextFild.placeholder = @"科目进度";
        _progressTextFild.font  = [UIFont systemFontOfSize:14];
        _progressTextFild.textColor = [UIColor colorWithHexString:@"d9d9d9"];
    }
    return _progressTextFild;
}
- (UIView *)buttomLinwView{
    if (_buttomLinwView == nil) {
        _buttomLinwView = [[UIView alloc] init];
        _buttomLinwView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    }
    return _buttomLinwView;
}
- (UIButton *)checkButton {
    if (_checkButton == nil) {
        _checkButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.backgroundColor = RGBColor(255, 102, 51);
        
        [_checkButton addTarget:self action:@selector(dealCheck:) forControlEvents:UIControlEventTouchUpInside];
        
        [_checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_checkButton setTitle:@"提交" forState:UIControlStateNormal];
        
        _checkButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _checkButton;
    
}
#pragma mark ---- Action
- (void)dealCheck:(UIButton *)btn{
    
    if (self.phoneTextField.text == nil || self.phoneTextField.text.length <= 0) {
        
        [self obj_showTotasViewWithMes:@"请输入手机号"];
        
        return;
        
    }else {
        
        if (![AcountManager isValidateMobile:self.phoneTextField.text]) {
            [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
            return;
        }
        
    }
    
    [self.paramsPost setObject:self.phoneTextField.text forKey:@"mobile"];
    if (self.authCodeTextFild.text.length <= 0 || self.authCodeTextFild.text == nil) {
        [self showMsg:@"请输入验证码"];
        return;
    }
    [self.paramsPost setObject:self.authCodeTextFild.text forKey:@"smscode"];
    
    // 向后台提交数据
    
//    NSString *urlString = [NSString stringWithFormat:BASEURL,kcheckProgressUrl];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
/*
 "name": "李亚飞",
 "telephone": "15652305650",
 "code": "1234556",
 "userid": "560539bea694336c25c3acb9",
 "schoolid": "56163c376816a9741248b7f9",
 "coachid": "5616352721ec29041a9af889",
 "classtypeid": "56170d9a053d34d82eef8ae8",
 "subjectid": 2,
 */
//    NSDictionary *param = @{@"name":self.nameTextFild.text,
//                            @"telephone":self.phoneTextField.text,
//                            @"code":self.authCodeTextFild.text,
//                            @"userid":[AcountManager manager].userid,
//                            @"schoolid":[ manager].};
//    
//    
//    
//    
//
//        [JENetwoking startDownLoadWithUrl:urlString postParam:self.paramsPost WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
//    
//            [MBProgressHUD hideHUDForView:self.view animated:NO];
//    
//            DYNSLog(@"向服务器注册用户data = %@",data);
//    
//            NSDictionary *dataDic = data;
//    
//            //        NSString *type = [NSString stringWithFormat:@"%@",dataDic[@"type"]];
//    
//            if ([[data objectForKey:@"type"] integerValue] == 0) {
//    
//                //            [self showTotasViewWithMes:];
//                [self obj_showTotasViewWithMes:dataDic[@"msg"]];
//    
//            }else if ([[data objectForKey:@"type"] integerValue] == 1) {
//    
//                NSString *userid = [NSString stringWithFormat:@"%@",dataDic[@"data"][@"userid"]];
//                NSLog(@"dataDic.userid:%@---userid:%@",dataDic[@"data"][@"userid"],userid);
//    
//                [self loginWithUserID:userid password:passwordString dataDic:dataDic];
//                
//            }
//            
//        }];

}


#pragma make :自动布局

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.topLinwView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).with.offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).with.offset(0);
        make.top.mas_equalTo(self.bgView.mas_top).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(70);
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(@360);
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).with.offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.bgView.mas_top).with.offset(0);
        make.height.mas_equalTo(@45);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@34);
        make.width.mas_equalTo(@82);
    }];
    
    [self.authCodeTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).with.offset(15);
        make.right.mas_equalTo(self.sendButton.mas_left).with.offset(-10);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@45);
    }];
    [self.shortLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.authCodeTextFild.mas_right).with.offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(44);
        make.height.mas_equalTo(@1);
    }];
    
    
    [self.schoolTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).with.offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.authCodeTextFild.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@45);
    }];
    
    [self.classTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).with.offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.schoolTextFild.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@45);
    }];
    
    [self.coachTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).with.offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.classTextFild.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@45);
    }];

    
    [self.nameTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).with.offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.coachTextFild.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@45);
    }];
    
    [self.idCardTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).with.offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.nameTextFild.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@45);
    }];
    [self.progressTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).with.offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.idCardTextFild.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@45);
    }];
    [self.buttomLinwView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).with.offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).with.offset(0);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@44);
        
    }];

    
}

//http://www.ifanying.com/userAgreement.html 用户协议
//http://www.ifanying.com/coachAgreement.html 教练协议

#pragma mark - buttonAction

#define TIME 60
- (void)dealSend:(UIButton *)sender {
    
    NSLog(@"发送验证码");
    
    [self sendYanZhengMa:sender];
    
}

#pragma mark 发送验证码
- (void)sendYanZhengMa:(UIButton *)sender
{
    
    if (self.phoneTextField.text == nil || self.phoneTextField.text.length <= 0) {
        
        [self obj_showTotasViewWithMes:@"请输入手机号"];
        
        return;
        
    }else {
        
        if (![AcountManager isValidateMobile:self.phoneTextField.text]) {
            [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
            return;
        }
        
        NSString *urlString = [NSString stringWithFormat:@"code/%@",self.phoneTextField.text];
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
                self.sendButton.backgroundColor  = [UIColor clearColor];
                [_sendButton setTitleColor:[UIColor colorWithHexString:@"ff6633"] forState:UIControlStateNormal];
                [self.sendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.sendButton.userInteractionEnabled = YES;
            });
        }else {
            NSString *str = [NSString stringWithFormat:@"剩余(%d)s",count];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendButton.backgroundColor = [UIColor clearColor];
                [self.sendButton setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
                [self.sendButton setTitle:str forState:UIControlStateNormal];
                
            });
            count--;
        }
    });
    dispatch_resume(timer);
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _schoolTextFild) {
        if (textField.text.length > 10) {
            [self showTotasViewWithMes:@"报考驾校字符不能超过8个字符!"];
        }
    }else if (textField == _classTextFild) {
        if (textField.text.length > 6) {
            [self showTotasViewWithMes:@"所属班型长度不得超过6个字符!"];
        }
    }else if (textField == _nameTextFild) {
        if (textField.text.length > 8) {
            [self showTotasViewWithMes:@"姓名长度不得超过8个字符!"];
        }
    }else if (textField == _coachTextFild) {
        if (textField.text.length > 8) {
            [self showTotasViewWithMes:@"姓名长度不得超过8个字符!"];
        }
    }else if (textField == _idCardTextFild) {
        if (textField.text.length > 18) {
            [self showTotasViewWithMes:@"身份证长度不得超过18个字符!"];
        }
    }else if (textField == _progressTextFild) {
        if (textField.text.length > 3) {
            [self showTotasViewWithMes:@"科目进度长度不能超过3个字符!"];
        }
    }
}

- (void)dealGoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//// 向服务器注册用户
//- (void)userRegister {
//    
//    NSString *passwordString = nil;
//    passwordString = self.passWordTextFild.text.DY_MD5;
//    
//    [self.paramsPost setObject:passwordString forKey:@"password"];
//    //网络请求
//    
//    if (self.invitationTextFild.text.length >0 && self.invitationTextFild.text != nil) {
//        [self.paramsPost setObject:self.invitationTextFild.text forKey:@"referrerCode"];
//    }
//    [self.paramsPost setObject:@"1" forKey:@"usertype"];
//    
//    NSString *urlString = [NSString stringWithFormat:BASEURL,kregisterUrl];
//    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//    [JENetwoking startDownLoadWithUrl:urlString postParam:self.paramsPost WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
//        
//        [MBProgressHUD hideHUDForView:self.view animated:NO];
//        
//        DYNSLog(@"向服务器注册用户data = %@",data);
//        
//        NSDictionary *dataDic = data;
//        
//        //        NSString *type = [NSString stringWithFormat:@"%@",dataDic[@"type"]];
//        
//        if ([[data objectForKey:@"type"] integerValue] == 0) {
//            
//            //            [self showTotasViewWithMes:];
//            [self obj_showTotasViewWithMes:dataDic[@"msg"]];
//            
//        }else if ([[data objectForKey:@"type"] integerValue] == 1) {
//            
//            NSString *userid = [NSString stringWithFormat:@"%@",dataDic[@"data"][@"userid"]];
//            NSLog(@"dataDic.userid:%@---userid:%@",dataDic[@"data"][@"userid"],userid);
//            
//            [self loginWithUserID:userid password:passwordString dataDic:dataDic];
//            
//        }
//        
//    }];
//}
//
////点击登陆后的操作
//- (void)loginWithUserID:(NSString *)userID password:(NSString *)password dataDic:(NSDictionary *)dataDic
//{
//    [self showHudInView:self.view hint:NSLocalizedString(@"登录中...", @"登录中...")];
//    
//    //异步登陆账号
//    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userID
//                                                        password:password
//                                                      completion:
//     ^(NSDictionary *loginInfo, EMError *error) {
//         
//         [self hideHud];
//         
//         if (loginInfo && !error) {
//             
//             DYNSLog(@"登录成功");
//             
//             [AcountManager configUserInformationWith:dataDic[@"data"]];
//             
//             [AcountManager saveUserName:self.phoneTextField.text andPassword:self.passWordTextFild.text];
//             
//             //             [APService setAlias:[AcountManager manager].userid callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
//             
//             //设置是否自动登录
//             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//             
//             // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
//             [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
//             //获取数据库中数据
//             [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
//             
//             //获取群组列表
//             //             [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
//             
//             EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
//             options.nickname = [AcountManager manager].userName;
//             options.displayStyle = ePushNotificationDisplayStyle_messageSummary;
//             
//             //发送自动登陆状态通知
//             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
//             
//             //保存最近一次登录用户名
//             
//             [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccess" object:nil];
//             
//             [self dismissViewControllerAnimated:NO completion:^{
//                 [[NSNotificationCenter defaultCenter] postNotificationName:kregisterUser object:nil];
//             }];
//             
//         }
//         else
//         {
//             switch (error.errorCode)
//             {
//                 case EMErrorNotFound:
//                     TTAlertNoTitle(error.description);
//                     break;
//                 case EMErrorNetworkNotConnected:
//                     TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
//                     break;
//                 case EMErrorServerNotReachable:
//                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
//                     break;
//                 case EMErrorServerAuthenticationFailure:
//                     TTAlertNoTitle(error.description);
//                     break;
//                 case EMErrorServerTimeout:
//                     TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
//                     break;
//                 default:
//                     TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
//                     break;
//             }
//         }
//     } onQueue:nil];
//}
//- (void)tagsAliasCallback:(int)iResCode
//                     tags:(NSSet *)tags
//                    alias:(NSString *)alias {
//    NSString *callbackString =
//    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
//     tags, alias];
//    
//    DYNSLog(@"TagsAlias回调:%@", callbackString);
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _phoneTextField) {
        if (range.location>10) {
            return NO;
        }
    }
    return YES;
}

- (void)showMsg:(NSString *)message {
    
    ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:message controller:self];
    [alertView show];
}
// 添加底部的线

@end
