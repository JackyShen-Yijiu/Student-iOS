#import "ForgetViewController.h"
#import <Masonry/Masonry.h>
#import "ToolHeader.h"
#import "GainPasswordViewController.h"
#import "AddlineButtomTextField.h"

static NSString *const kchangePassword = @"kchangePassword";


@interface ForgetViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *phoneNumTextField;
@property (strong, nonatomic) UITextField *confirmTextField;
@property (strong, nonatomic) UITextField *passWordTextFild;
@property (strong, nonatomic) UITextField *affirmTextFild;

@property (strong, nonatomic) UIButton *gainNum;
@property (strong, nonatomic) UIButton *runNextButton;
@property (strong, nonatomic) UIButton *goBackButton;

@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UILabel *phoneNumLabel;
@property (strong, nonatomic) UILabel *gainNumLabel;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UILabel *affirmLabel;


@end

@implementation ForgetViewController

- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont boldSystemFontOfSize:18];
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.text = @"找回密码";
    }
    return _topLabel;
}

- (UIButton *)goBackButton{
    if (_goBackButton == nil) {
        _goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"Back-Icon"] forState:UIControlStateNormal];
        [_goBackButton addTarget:self action:@selector(dealGoBack:) forControlEvents:UIControlEventTouchUpInside];
        [_goBackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _goBackButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _goBackButton;
}
- (UITextField *)phoneNumTextField {
    if (_phoneNumTextField == nil) {
        _phoneNumTextField = [[AddlineButtomTextField alloc]init];
        _phoneNumTextField.delegate = self;
        _phoneNumTextField.tag = 102;
//        _phoneNumTextField.placeholder = @"  手机号";
//        _phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"账号"];
        _phoneNumTextField.leftView = leftView;
        _phoneNumTextField.font = [UIFont systemFontOfSize:15];
        _phoneNumTextField.textColor = [UIColor colorWithHexString:@"212121"];
        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

    }
    return _phoneNumTextField;
}
- (UITextField *)confirmTextField {
    if (_confirmTextField == nil) {
        _confirmTextField = [[AddlineButtomTextField alloc]init];
        _confirmTextField.tag = 103;
//        _confirmTextField.placeholder = @"验证码";
//        _confirmTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"yanzhengma"];
        _confirmTextField.leftView = leftView;
        _confirmTextField.font = [UIFont systemFontOfSize:15];
        _confirmTextField.textColor = [UIColor colorWithHexString:@"212121"];
        _confirmTextField.keyboardType = UIKeyboardTypeNumberPad;

    }
    return _confirmTextField;
}
- (UITextField *)passWordTextFild{
    if (_passWordTextFild == nil) {
        _passWordTextFild = [[AddlineButtomTextField alloc]init];
        _passWordTextFild.tag = 105;
//        _passWordTextFild.placeholder = @"密码";
        _passWordTextFild.font  = [UIFont systemFontOfSize:15];
        _passWordTextFild.textColor = [UIColor colorWithHexString:@"212121"];
        _passWordTextFild.secureTextEntry = YES;
        _passWordTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _passWordTextFild;
}

- (UITextField *)affirmTextFild{
    if (_affirmTextFild == nil) {
        _affirmTextFild = [[AddlineButtomTextField alloc]init];
        _affirmTextFild.tag = 106;
//        _affirmTextFild.placeholder = @"确认密码";
        _affirmTextFild.font  = [UIFont systemFontOfSize:15];
        _affirmTextFild.textColor = [UIColor colorWithHexString:@"212121"];
        _affirmTextFild.secureTextEntry = YES;
//        _affirmTextFild.backgroundColor = [UIColor cyanColor];
        _affirmTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;

        
    }
    return _affirmTextFild;
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
- (UILabel *)gainNumLabel{
    if (_gainNumLabel == nil) {
        _gainNumLabel = [[UILabel alloc] init];
        _gainNumLabel.text = @"验证码";
        _gainNumLabel.textColor  = [UIColor colorWithHexString:@"bdbdbd"];
        _gainNumLabel.font = [UIFont systemFontOfSize:10];
    }
    return _gainNumLabel;
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

- (UILabel *)affirmLabel{
    if (_affirmLabel == nil) {
        _affirmLabel = [[UILabel alloc] init];
        _affirmLabel.text = @"确认密码";
        _affirmLabel.textColor  = [UIColor colorWithHexString:@"bdbdbd"];
        _affirmLabel.font = [UIFont systemFontOfSize:10];
    }
    return _affirmLabel;
}


- (UIButton *)gainNum {
    if (_gainNum == nil) {
        _gainNum = [UIButton buttonWithType:UIButtonTypeCustom];
        _gainNum.backgroundColor = [UIColor colorWithHexString:@"bd4437"];
        [_gainNum addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
        _gainNum.titleLabel.font = [UIFont systemFontOfSize:15];
        [_gainNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_gainNum setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return _gainNum;
}

- (UIButton *)runNextButton {
    if (_runNextButton == nil) {
        _runNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _runNextButton.backgroundColor = [UIColor colorWithHexString:@"bd4437"];
        [_runNextButton addTarget:self action:@selector(dealNext:) forControlEvents:UIControlEventTouchUpInside];
        [_runNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _runNextButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [_runNextButton setTitle:@"提交" forState:UIControlStateNormal];
    }
    return _runNextButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"bd4437"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.goBackButton];

//    [self.navigationController.navigationBar setBackgroundImage:[UIImage ] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.layer.contents = (id)[UIImage imageNamed:@"login_background"].CGImage;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealChangePassword) name:kchangePassword object:nil];
    
    [self.view addSubview:self.topLabel];
    
    [self.view addSubview:self.phoneNumTextField];
    [self.view addSubview:self.confirmTextField];
    [self.view addSubview:self.passWordTextFild];
    [self.view addSubview:self.affirmTextFild];
    
    [self.view addSubview:self.phoneNumLabel];
    [self.view addSubview:self.gainNumLabel];
    [self.view addSubview:self.passwordLabel];
    [self.view addSubview:self.affirmLabel];
    
    [self.view addSubview:self.runNextButton];
    [self.view addSubview:self.gainNum];
    [self.view addSubview:self.goBackButton];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.height.mas_equalTo(@50);
    }];
    
    [self.goBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(10);
        make.top.mas_equalTo(self.view.mas_top).with.offset(35);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@20);
    }];
    
    [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20+55 + 40);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@40);
    }];

    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.phoneNumLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    
    [self.gainNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@117);
    }];
    
    [self.gainNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(16);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@40);
    }];
    [self.confirmTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.gainNumLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.top.mas_equalTo(self.confirmTextField.mas_bottom).with.offset(16);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@40);
    }];
    [self.passWordTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.passwordLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@40);
    }];

    [self.affirmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.top.mas_equalTo(self.passWordTextFild.mas_bottom).with.offset(16);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@40);
    }];
    [self.affirmTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.affirmLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@40);
    }];

    
    
    
    
    [self.runNextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.confirmTextField.mas_bottom).with.offset(180);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.height.mas_equalTo(@49);
    }];
}
#define TIME 60
- (void)dealSend:(UIButton *)sender {
    NSLog(@"发送验证码");
    
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length <= 0) {
        [self showMsg:@"请输入手机号"];
        return;
    }else {
        
        if (![AcountManager isValidateMobile:self.phoneNumTextField.text]) {
            [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
            return;
        }
        
        // 检测用户是否存在
        [self userExist];
    }
    
}

#pragma mark 发送验证码
- (void)sendSMS {
    
    NSString *urlString = [NSString stringWithFormat:@"code/%@",self.phoneNumTextField.text];
    NSString *codeUrl = [NSString stringWithFormat:BASEURL,urlString];
    
    [JENetwoking startDownLoadWithUrl:codeUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        [self showMsg:@"发送成功"];
        // 验证码输入框获取焦点
        [self.confirmTextField becomeFirstResponder];
        
        self.gainNum.userInteractionEnabled = NO;
        __block int count = TIME;
        dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, myQueue);
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            if (count < 0) {
                dispatch_source_cancel(timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.gainNum.titleLabel.font = [UIFont systemFontOfSize:15];
                    [self.gainNum setTitle:@"获取验证码" forState:UIControlStateNormal];
                    [_gainNum setTitleColor:[UIColor colorWithHexString:@"ff6633"] forState:UIControlStateNormal];
                    self.gainNum.userInteractionEnabled = YES;
                    
                });
            }else {
                NSString *str = [NSString stringWithFormat:@"剩余(%d)s",count];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.gainNum.backgroundColor = [UIColor clearColor];
                    [self.gainNum setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
                    [self.gainNum setTitle:str forState:UIControlStateNormal];
                    
                });
                count--;
            }
        });
        dispatch_resume(timer);
    }];
}

- (void)dealNext:(UIButton *)sender {
    
    if (![AcountManager isValidateMobile:self.phoneNumTextField.text]) {
        [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
        return;
    }
    
    if (self.confirmTextField.text.length <= 0 || self.confirmTextField.text == nil) {
        [self showMsg:@"请输入验证码"];
        return;
    }
    
    // 验证验证码
    [self verificationSMSCode];
}

#pragma mark - 验证用户是否存在
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
                // 发送验证码
                [self sendSMS];
            }else {
                ws.confirmTextField.text = @"";
                [ws showMsg:@"此用户未注册"];
            }
        }else {
            [ws showMsg:@"网络错误"];
        }
    }];
}

#pragma mark - 验证验证码
- (void)verificationSMSCode {
    
    __weak typeof(self) ws = self;
    NSString *urlString = [NSString stringWithFormat:@"Verificationsmscode?mobile=%@&code=%@",self.phoneNumTextField.text,self.confirmTextField.text];
    NSString *codeUrl = [NSString stringWithFormat:BASEURL,urlString];
    
    [JENetwoking startDownLoadWithUrl:codeUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"%@", data);
        NSDictionary *params = data;
        BOOL type = [[params objectForKey:@"type"] boolValue];
        if (type) {
            GainPasswordViewController *gain = [[GainPasswordViewController alloc] init];
            gain.confirmString = ws.confirmTextField.text;
            gain.mobile = ws.phoneNumTextField.text;
            [ws presentViewController:gain animated:YES completion:nil];
        }else {
            ws.confirmTextField.text = @"";
            [ws showMsg:@"验证码错误"];
        }
    }];
}

- (void)showMsg:(NSString *)message {
    
    ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:message controller:self];
    [alertView show];
}

- (void)dealChangePassword{
    DYNSLog(@"%s",__PRETTY_FUNCTION__);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealGoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _phoneNumTextField) {
        if (range.location>10) {
            return NO;
        }
    }
    return YES;
}

@end

