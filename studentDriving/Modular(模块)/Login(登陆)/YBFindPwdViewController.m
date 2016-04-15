//
//  YBFindPwdViewController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/4.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBFindPwdViewController.h"
#import "DVVBaseTextField.h"
#import "JZRegisterSecondController.h"
#import "YBSettingNewPwdViewController.h"
#import "NSString+DY_MD5.h"

static NSString *const kchangePasswordUrl = @"/userinfo/updatepwd";

static NSString *const kautoCode = @"Verificationsmscode";

@interface YBFindPwdViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) DVVBaseTextField *phoneNumTextFiled; // 手机号
@property (nonatomic, strong) DVVBaseTextField *authCodeTextFiled; // 验证码
@property (strong, nonatomic)UIButton *sendButton;


@property (nonatomic,strong) UIView *codeView;

@property (nonatomic, strong) DVVBaseTextField *pwdTextFiled; // 设置新密码
@property (strong, nonatomic) UIButton *eyeButton;
@property (strong, nonatomic)UIButton *nextRegisterButton;

@end

@implementation YBFindPwdViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.title = @"找回密码";
    
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
    [self.view addSubview:self.pwdTextFiled];
    [self.view addSubview:self.eyeButton];
    [self.view addSubview:self.nextRegisterButton];
}
#pragma mark -- UItextFiledNotification
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
        if (self.authCodeTextFiled.text.length && self.pwdTextFiled.text.length) {
            _nextRegisterButton.backgroundColor = YBNavigationBarBgColor;
            _nextRegisterButton.userInteractionEnabled = YES;
        }
        
    }
}
#pragma mark ---- 验证码改变的通知
- (void)authCodeTextFieldTextDidChange:(NSNotification *)obj{
    UITextField *autoTextFiled = (UITextField *)obj.object;
    if (autoTextFiled.text.length && self.phoneNumTextFiled.text.length && self.pwdTextFiled.text.length ) {
        _nextRegisterButton.backgroundColor = YBNavigationBarBgColor;
        _nextRegisterButton.userInteractionEnabled = YES;
    }else{
        _nextRegisterButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _nextRegisterButton.userInteractionEnabled = NO;
    }
}
#pragma mark ---- 密码改变的通知
- (void)pwdTextFieldTextDidChange:(NSNotification *)obj{
    UITextField *passwordTextFiled = (UITextField *)obj.object;
    if (passwordTextFiled.text.length && self.phoneNumTextFiled.text.length && self.pwdTextFiled.text.length ) {
        _nextRegisterButton.backgroundColor = YBNavigationBarBgColor;
        _nextRegisterButton.userInteractionEnabled = YES;
    }else{
        _nextRegisterButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _nextRegisterButton.userInteractionEnabled = NO;
    }
    
}

#pragma mark - buttonAction
- (void)didEyeButton:(UIButton *)btn{
    if (!btn.selected) {
        self.pwdTextFiled.secureTextEntry = NO;
        btn.selected = YES;
    }else if (btn.selected) {
        self.pwdTextFiled.secureTextEntry = YES;
        btn.selected = NO;
    }
}

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
            [self.authCodeTextFiled becomeFirstResponder];
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
                [self.sendButton setTitleColor:[UIColor colorWithHexString:@"fedbd8"] forState:UIControlStateNormal];
                [self.sendButton setTitle:str forState:UIControlStateNormal];
                
            });
            count--;
        }
    });
    dispatch_resume(timer);
}
// 点击下一步
- (void)nextRegisterButton:(UIButton *)sender{
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
            [self obj_showTotasViewWithMes:param[@"msg"]];
            return ;
        }
        if (1 == [data[@"type"] integerValue]) {
           
            NSLog(@"设置新密码");
            [self nextAuto];
        }
        
    } withFailure:^(id data) {
        
    }];
    
}
- (void)nextAuto
{
    // 手机号的判断
    if (self.phoneNumTextFiled.text == nil) {
        return;
    }
    
    // 密码的判断
    if (self.pwdTextFiled.text == nil || self.pwdTextFiled.text.length <= 0) {
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kchangePasswordUrl];
    
    NSDictionary *param = @{@"smscode":self.authCodeTextFiled.text,
                            @"password":[self.pwdTextFiled.text DY_MD5],
                            @"mobile":self.phoneNumTextFiled.text};
    
    NSLog(@"param:%@",param);
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *resultData = data;
        
        DYNSLog(@"resultData.message = %@",resultData[@"msg"]);
        NSLog(@"data:%@",data);
        
        NSString *type = [NSString stringWithFormat:@"%@",resultData[@"type"]];
        NSLog(@"type:%@",type);
        
        if ([type isEqualToString:@"1"]) {
            
            [self obj_showTotasViewWithMes:@"修改成功"];
            
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
        }else {
            
            [self obj_showTotasViewWithMes:resultData[@"msg"]];
            
        }
    }];
    
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
    
    [self.pwdTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeView.mas_bottom).offset(18);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(@44);
        
    }];
    
    [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.pwdTextFiled.mas_right).with.offset(-14);
        make.top.mas_equalTo(self.pwdTextFiled.mas_top).with.offset(44/2-8/2);
        make.height.mas_equalTo(@8);
        make.width.mas_equalTo(@16);
    }];

    [self.nextRegisterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdTextFiled.mas_bottom).offset(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.height.mas_equalTo(@44);
        
        
    }];
    
    
}
#pragma mark ----- Lazy 加载
- (DVVBaseTextField *)phoneNumTextFiled{
    if (_phoneNumTextFiled == nil) {
        _phoneNumTextFiled  = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"user"] placeholder:@"请输入手机号" borderColor:[UIColor colorWithHexString:@"b7b7b7"]];
        _phoneNumTextFiled.keyboardType = UIKeyboardTypeNumberPad;
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
        _authCodeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
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
- (DVVBaseTextField *)pwdTextFiled{
    if (_pwdTextFiled == nil) {
        _pwdTextFiled  = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"password"] placeholder:@"请设置新密码" borderColor:[UIColor colorWithHexString:@"b7b7b7"]];
        _pwdTextFiled.tag = 5000;
        _pwdTextFiled.delegate = self;
        _pwdTextFiled.secureTextEntry = YES;
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(pwdTextFieldTextDidChange:)
         name:UITextFieldTextDidChangeNotification
         object:_pwdTextFiled];
    }
    return _pwdTextFiled;
}

- (UIButton *)nextRegisterButton{
    if (_nextRegisterButton == nil) {
        _nextRegisterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextRegisterButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _nextRegisterButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextRegisterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextRegisterButton addTarget:self action:@selector(nextRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
        [_nextRegisterButton setTitle:@"找回密码" forState:UIControlStateNormal];
        _nextRegisterButton.layer.masksToBounds = YES;
        _nextRegisterButton.layer.cornerRadius = 10;
        _nextRegisterButton.layer.borderWidth = 1;
        _nextRegisterButton.layer.borderColor = [UIColor colorWithHexString:@"fb7064"].CGColor;
        _nextRegisterButton.userInteractionEnabled = NO;
    }
    return _nextRegisterButton;
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

@end
