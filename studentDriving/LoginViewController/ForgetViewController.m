#import "ForgetViewController.h"
#import <Masonry/Masonry.h>
#import "ToolHeader.h"
#import "GainPasswordViewController.h"

static NSString *const kchangePassword = @"kchangePassword";


@interface ForgetViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *phoneNumTextField;
@property (strong, nonatomic) UITextField *confirmTextField;
@property (strong, nonatomic) UIButton *gainNum;
@property (strong, nonatomic) UIButton *runNextButton;
@property (strong, nonatomic) UIButton *goBackButton;
@property (strong, nonatomic) UILabel *topLabel;

@end

@implementation ForgetViewController

- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont boldSystemFontOfSize:18];
        _topLabel.textColor = RGBColor(51, 51, 51);
        _topLabel.text = @"找回密码";
    }
    return _topLabel;
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
- (UITextField *)phoneNumTextField {
    if (_phoneNumTextField == nil) {
        _phoneNumTextField = [[UITextField alloc]init];
        _phoneNumTextField.delegate = self;
        _phoneNumTextField.tag = 102;
        _phoneNumTextField.placeholder = @"  手机号";
        _phoneNumTextField.font = [UIFont systemFontOfSize:15];
        _phoneNumTextField.textColor = RGBColor(153, 153, 153);
        _phoneNumTextField.layer.borderWidth = 1;
        _phoneNumTextField.layer.borderColor = RGBColor(230, 230, 230).CGColor;
    }
    return _phoneNumTextField;
}
- (UITextField *)confirmTextField {
    if (_confirmTextField == nil) {
        _confirmTextField = [[UITextField alloc]init];
        _confirmTextField.tag = 103;
        _confirmTextField.placeholder = @"  验证码";
        _confirmTextField.font = [UIFont systemFontOfSize:15];
        _confirmTextField.textColor = RGBColor(153, 153, 153);
        _confirmTextField.layer.borderWidth = 1;
        _confirmTextField.layer.borderColor = RGBColor(230, 230, 230).CGColor;
    }
    return _confirmTextField;
}
- (UIButton *)gainNum {
    if (_gainNum == nil) {
        _gainNum = [UIButton buttonWithType:UIButtonTypeCustom];
        _gainNum.backgroundColor = RGBColor(255, 102, 51);
        [_gainNum addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
        _gainNum.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_gainNum setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return _gainNum;
}

- (UIButton *)runNextButton {
    if (_runNextButton == nil) {
        _runNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _runNextButton.backgroundColor = RGBColor(255, 102, 51);
        [_runNextButton addTarget:self action:@selector(dealNext:) forControlEvents:UIControlEventTouchUpInside];
        [_runNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _runNextButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [_runNextButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
    return _runNextButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealChangePassword) name:kchangePassword object:nil];
    
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.phoneNumTextField];
    [self.view addSubview:self.confirmTextField];
    [self.view addSubview:self.runNextButton];
    [self.view addSubview:self.gainNum];
    [self.view addSubview:self.goBackButton];
    
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
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20+55);
        make.height.mas_equalTo(@44);
    }];
    
    [self.gainNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@117);
    }];
    
    [self.confirmTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.gainNum.mas_left).with.offset(-10);
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
    }];
    
    
    
    [self.runNextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.confirmTextField.mas_bottom).with.offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.height.mas_equalTo(@44);
    }];
}
#define TIME 60
- (void)dealSend:(UIButton *)sender {
    NSLog(@"发送验证码");
    
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length <= 0) {
        [self showMsg:@"请输入手机号"];
        return;
    }else {
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
                    self.gainNum.backgroundColor  = MAINCOLOR;
                    [self.gainNum setTitle:@"获取验证码" forState:UIControlStateNormal];
                    self.gainNum.userInteractionEnabled = YES;
                    
                });
            }else {
                NSString *str = [NSString stringWithFormat:@"剩余(%d)s",count];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.gainNum.backgroundColor = RGBColor(204, 204, 204);
                    [self.gainNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.gainNum setTitle:str forState:UIControlStateNormal];
                    
                });
                count--;
            }
        });
        dispatch_resume(timer);
    }];
}

- (void)dealNext:(UIButton *)sender {
    
    NSString *phoneNum = self.phoneNumTextField.text;
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNum];
    if (!isMatch) {
        [self showMsg:@"请输入正确的手机号"];
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

