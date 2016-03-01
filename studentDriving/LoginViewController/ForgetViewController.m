#import "ForgetViewController.h"
#import <Masonry/Masonry.h>
#import "ToolHeader.h"
#import "GainPasswordViewController.h"
#import "AddlineButtomTextField.h"
#import "NSString+DY_MD5.h"
#import "ShowWarningMessageView.h"
#import <JPush/APService.h>
static NSString *const kchangePassword = @"kchangePassword";

static NSString *const kchangePasswordUrl = @"/userinfo/updatepwd";




static NSString *const kloginUrl = @"userinfo/userlogin";

static NSString *const kregisterUser = @"kregisterUser";

static NSString *const kmobileNum = @"mobile";

static NSString *const kpassword = @"password";

static NSString *const kuserType = @"usertype";

@interface ForgetViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *phoneNumTextField;
@property (strong, nonatomic) UITextField *confirmTextField;
@property (strong, nonatomic) UITextField *passWordTextFild;
//@property (strong, nonatomic) UITextField *affirmTextFild;

@property (strong, nonatomic) UIButton *gainNum;
@property (strong, nonatomic) UIButton *runNextButton;
@property (strong, nonatomic) UIButton *goBackButton;

@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UILabel *phoneNumLabel;
@property (strong, nonatomic) UILabel *gainNumLabel;
@property (strong, nonatomic) UILabel *passwordLabel;

@property (strong, nonatomic) UIButton *eyeButton;
//@property (strong, nonatomic) UILabel *affirmLabel;
//@property (nonatomic, strong) ShowWarningMessageView *showWarningMessageView;

@property (nonatomic, strong) ShowWarningMessageView *phoneWarngingView;
@property (nonatomic, strong) ShowWarningMessageView *gainNumWarningView;
@property (nonatomic, strong) ShowWarningMessageView *passwordWarningView;

@property (strong, nonatomic) NSMutableDictionary *userParam;
@end

@implementation ForgetViewController

- (NSMutableDictionary *)userParam {
    if (_userParam == nil) {
        _userParam = [[NSMutableDictionary alloc] init];
    }
    return _userParam;
}

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
        _phoneNumTextField.tag = 50001;
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
        _confirmTextField.tag = 50002;
        _confirmTextField.delegate = self;
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
        _passWordTextFild.tag = 50003;
        _passWordTextFild.delegate = self;
//        _passWordTextFild.placeholder = @"密码";
        _passWordTextFild.font  = [UIFont systemFontOfSize:15];
        _passWordTextFild.textColor = [UIColor colorWithHexString:@"212121"];
        _passWordTextFild.secureTextEntry = YES;
        _passWordTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _passWordTextFild;
}

//- (UITextField *)affirmTextFild{
//    if (_affirmTextFild == nil) {
//        _affirmTextFild = [[AddlineButtomTextField alloc]init];
//        _affirmTextFild.tag = 203;
////        _affirmTextFild.placeholder = @"确认密码";
//        _affirmTextFild.font  = [UIFont systemFontOfSize:15];
//        _affirmTextFild.delegate = self;
//        _affirmTextFild.textColor = [UIColor colorWithHexString:@"212121"];
//        _affirmTextFild.secureTextEntry = YES;
////        _affirmTextFild.backgroundColor = [UIColor cyanColor];
//        _affirmTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
//
//        
//    }
//    return _affirmTextFild;
//}
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

//- (UILabel *)affirmLabel{
//    if (_affirmLabel == nil) {
//        _affirmLabel = [[UILabel alloc] init];
//        _affirmLabel.text = @"确认密码";
//        _affirmLabel.textColor  = [UIColor colorWithHexString:@"bdbdbd"];
//        _affirmLabel.font = [UIFont systemFontOfSize:10];
//    }
//    return _affirmLabel;
//}


- (UIButton *)gainNum {
    if (_gainNum == nil) {
        _gainNum = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gainNum addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
        _gainNum.titleLabel.font = [UIFont systemFontOfSize:15];
        _gainNum.backgroundColor = YBNavigationBarBgColor;
        [_gainNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_gainNum setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return _gainNum;
}

- (UIButton *)runNextButton {
    if (_runNextButton == nil) {
        _runNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _runNextButton.backgroundColor = YBNavigationBarBgColor;
        [_runNextButton addTarget:self action:@selector(dealNext:) forControlEvents:UIControlEventTouchUpInside];
        [_runNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _runNextButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [_runNextButton setTitle:@"提交" forState:UIControlStateNormal];
    }
    return _runNextButton;
}
- (ShowWarningMessageView *)gainNumWarningView{
    if (_gainNumWarningView == nil) {
        _gainNumWarningView = [[ShowWarningMessageView alloc] init];
        _gainNumWarningView.hidden = YES;
    }
    return _gainNumWarningView;
}
- (ShowWarningMessageView *)phoneWarngingView{
    if (_phoneWarngingView == nil) {
        _phoneWarngingView = [[ShowWarningMessageView alloc] init];
        _phoneWarngingView.hidden = YES;
    }
    return _phoneWarngingView;
}
- (ShowWarningMessageView *)passwordWarningView{
    if (_passwordWarningView == nil) {
        _passwordWarningView = [[ShowWarningMessageView alloc] init];
        _passwordWarningView.hidden = YES;
    }
    return _passwordWarningView;
}

- (UIButton *)eyeButton{
    if (_eyeButton == nil) {
        _eyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyeButton setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        [_eyeButton setBackgroundImage:[UIImage imageNamed:@"1-1"] forState:UIControlStateSelected];
        [_eyeButton addTarget:self action:@selector(didEyeButton:) forControlEvents:UIControlEventTouchUpInside];
        _eyeButton.backgroundColor = [UIColor cyanColor];
    }
    return _eyeButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    [self.navigationController.navigationBar setBarTintColor:YBNavigationBarBgColor];
    
    CGRect backframe= CGRectMake(0, 0, 20, 20);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = backframe;
    [backButton setBackgroundImage:[UIImage imageNamed:@"Back-Icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dealGoBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

//    [self.navigationController.navigationBar setBackgroundImage:[UIImage ] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.layer.contents = (id)[UIImage imageNamed:@"login_background"].CGImage;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealChangePassword) name:kchangePassword object:nil];
    
    [self.view addSubview:self.topLabel];
    
    [self.view addSubview:self.phoneNumTextField];
    [self.view addSubview:self.phoneWarngingView];
    [self.view addSubview:self.confirmTextField];
    [self.view addSubview:self.gainNumWarningView];
    [self.view addSubview:self.passWordTextFild];
    [self.view addSubview:self.passwordWarningView];
    [self.view addSubview:self.eyeButton];
//    [self.view addSubview:self.affirmTextFild];
    
    [self.view addSubview:self.phoneNumLabel];
    [self.view addSubview:self.gainNumLabel];
    [self.view addSubview:self.passwordLabel];
//    [self.view addSubview:self.affirmLabel];
    
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
        make.top.mas_equalTo(self.view.mas_top).with.offset(50);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@40);
    }];

    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.phoneNumLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    [self.phoneWarngingView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-80);
        make.top.mas_equalTo(self.phoneNumLabel.mas_top).with.offset(0);
        make.height.mas_equalTo(@18);
        make.width.mas_equalTo(@40);
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
    [self.gainNumWarningView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-200);
        make.top.mas_equalTo(self.gainNumLabel.mas_top).with.offset(0);
        make.height.mas_equalTo(@18);
        make.width.mas_equalTo(@40);
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
    [self.passwordWarningView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-80);
        make.top.mas_equalTo(self.passwordLabel.mas_top).with.offset(0);
        make.height.mas_equalTo(@18);
        make.width.mas_equalTo(@40);
    }];
    [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.confirmTextField.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@40);
    }];

//    [self.affirmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
//        make.top.mas_equalTo(self.passWordTextFild.mas_bottom).with.offset(16);
//        make.height.mas_equalTo(@10);
//        make.width.mas_equalTo(@40);
//    }];
//    [self.affirmTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
//        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
//        make.top.mas_equalTo(self.affirmLabel.mas_bottom).with.offset(0);
//        make.height.mas_equalTo(@40);
//    }];

    
    
    
    
    [self.runNextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWordTextFild.mas_bottom).with.offset(180);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.height.mas_equalTo(@49);
    }];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (50001 == textField.tag) {
        self.phoneWarngingView.hidden = YES;
    }
    if (50002 == textField.tag) {
        self.gainNumWarningView.hidden = YES;
    }
    if (50003 == textField.tag) {
        self.passwordWarningView.hidden = YES;
    }



}

#define TIME 60
- (void)dealSend:(UIButton *)sender {
    NSLog(@"发送验证码");
    
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length <= 0) {
        self.phoneWarngingView.hidden = NO;
        return;
    }else {
        
        if (![AcountManager isValidateMobile:self.phoneNumTextField.text]) {
            self.phoneWarngingView.hidden = NO;

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
        [self obj_showTotasViewWithMes:@"发送成功"];
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
                    _gainNum.backgroundColor = YBNavigationBarBgColor;
                    [_gainNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
    // 手机号的判断
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length <= 0) {
        self.phoneWarngingView.hidden = NO;
        return;
    }else {
        
        if (![AcountManager isValidateMobile:self.phoneNumTextField.text]) {
                    self.phoneWarngingView.hidden = NO;
            
            return;
        }
    }
    // 验证码的判断
    if (self.confirmTextField.text == nil || self.confirmTextField.text.length <= 0) {
        self.gainNumWarningView.hidden = NO;
        return;
    }
    // 密码的判断
    if (self.passWordTextFild.text == nil || self.passWordTextFild.text.length <= 0) {
        self.passwordWarningView.hidden = NO;
        return;
    }

        NSString *urlString = [NSString stringWithFormat:BASEURL,kchangePasswordUrl];
    
    NSDictionary *param = @{@"smscode":self.confirmTextField.text,
                            @"password":[self.passWordTextFild.text DY_MD5],
                            @"mobile":self.phoneNumTextField.text};
    
    NSLog(@"param:%@",param);
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *resultData = data;
        
        DYNSLog(@"resultData.message = %@",resultData[@"msg"]);
        NSLog(@"data:%@",data);
        
        NSString *type = [NSString stringWithFormat:@"%@",resultData[@"type"]];
        NSLog(@"type:%@",type);
        
        if ([type isEqualToString:@"1"]) {
            
            [self obj_showTotasViewWithMes:@"修改成功"];
            
//            [DVVUserManager userNeedLogin];
            
//            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//            [self dismissViewControllerAnimated:YES completion:^{
////                [[NSNotificationCenter defaultCenter] postNotificationName:kchangePassword object:nil];
//            }];
            
            
            // 修改成功后直接登录
        // 1.
            [self userLogin];
            
        }else {
            
            [self obj_showTotasViewWithMes:resultData[@"msg"]];
            
        }
    }];

    }
#pragma  mark -----
- (void)didEyeButton:(UIButton *)btn{
    if (!btn.selected) {
        self.passWordTextFild.secureTextEntry = NO;
        btn.selected = YES;
        
    }else if (btn.selected) {
        self.passWordTextFild.secureTextEntry = YES;
        btn.selected = NO;
    }
    
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
                [ws obj_showTotasViewWithMes:@"此用户未注册"];
            }
        }else {
            [ws obj_showTotasViewWithMes:@"网络错误"];
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
            _confirmString = ws.confirmTextField.text;
            _mobile = ws.phoneNumTextField.text;
        }else {
            ws.confirmTextField.text = @"";
            [ws obj_showTotasViewWithMes:@"验证码错误"];
            self.gainNumWarningView.hidden = NO;
        }
    }];
}
- (void)userLogin {
    
    //网络请求
    [self.passWordTextFild resignFirstResponder];
    [self.phoneNumTextField resignFirstResponder];
    
    [self.userParam setObject:@"1" forKey:kuserType];
    [self.userParam setObject:self.phoneNumTextField.text forKey:kmobileNum];
    NSString *pwdKey = [self.passWordTextFild.text DY_MD5];
    [self.userParam setObject:pwdKey forKey:kpassword];
    
    NSString *url = [NSString stringWithFormat:BASEURL,kloginUrl];
    
    DYNSLog(@"%s url:%@ self.userParam:%@",__func__,url,self.userParam);
    
    [JENetwoking startDownLoadWithUrl:url postParam:self.userParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *dataDic = data;
        DYNSLog(@"%s dataDic:%@",__func__,dataDic);
        
        NSString *type = [NSString stringWithFormat:@"%@",dataDic[@"type"]];
        
        if ([type isEqualToString:@"0"]) {
            
            [self obj_showTotasViewWithMes:@"密码错误"];
            self.passwordWarningView.hidden = NO;
            
        }else if ([type isEqualToString:@"1"]) {
            
            // 存储用户设置
            [self saveUserSetWithData:dataDic];
            
            NSLog(@"[AcountManager manager].userid:%@",[AcountManager manager].userid);
            NSLog(@"self.phoneNumTextField.text:%@",self.phoneNumTextField.text);
            NSLog(@"self.passwordTextField.text:%@",self.passWordTextFild.text);
            
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
// 点击登陆后的操作
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
             [AcountManager saveUserName:self.phoneNumTextField.text andPassword:self.passWordTextFild.text];
             
             [AcountManager configUserInformationWith:dataDic[@"data"]];
             
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

