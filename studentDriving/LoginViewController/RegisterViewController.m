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
#import "AddlineButtomTextField.h"
#import "ShowWarningMessageView.h"

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

@property (strong, nonatomic) UILabel *phoneNumLabel;
@property (strong, nonatomic) UILabel *gainNumLabel;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UILabel *affirmLabel;
@property (strong, nonatomic) UILabel *invitationLabel;

@property (strong, nonatomic) UIButton *selectButton;
@property (strong, nonatomic) UIView *lineNoteView;

@property (nonatomic, strong) ShowWarningMessageView *showWarningMessageView;

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
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.text = @"注册";
    }
    return _topLabel;
}

- (UIButton *)noteLabel{
    if (_noteLabel == nil) {
        _noteLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_noteLabel setTitle:@"我同意《用户服务协议》" forState:UIControlStateNormal];
        [_noteLabel setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
        _noteLabel.titleLabel.font = [UIFont systemFontOfSize:13];
         _noteLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_noteLabel addTarget:self action:@selector(clickTap1:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noteLabel;
}

- (UIButton *)goBackButton{
    if (_goBackButton == nil) {
        _goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"Back-Icon"] forState:UIControlStateNormal];\
        [_goBackButton addTarget:self action:@selector(dealGoBack:) forControlEvents:UIControlEventTouchUpInside];
        [_goBackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _goBackButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _goBackButton;
}

- (UIButton *)sendButton{
    if (_sendButton == nil) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.backgroundColor = [UIColor clearColor];
        [_sendButton addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
//        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _sendButton.backgroundColor = [UIColor colorWithHexString:@"bd4437"];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        
    }
    return _sendButton;
}

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.backgroundColor = [UIColor colorWithHexString:@"db4437"];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(dealRegister:) forControlEvents:UIControlEventTouchUpInside];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    }
    return _registerButton;
}

- (UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[AddlineButtomTextField alloc] init];
        _phoneTextField.delegate = self;
        _phoneTextField.tag = 102;
//        _phoneTextField.placeholder = @"    手机号";
//        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"账号"];
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

        _phoneTextField.leftView = leftView;
        _phoneTextField.font  = [UIFont systemFontOfSize:15];
        _phoneTextField.textColor = [UIColor colorWithHexString:@"212121"];
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTextField;
}

- (UITextField *)passWordTextFild{
    if (_passWordTextFild == nil) {
        _passWordTextFild = [[AddlineButtomTextField alloc]init];
        _passWordTextFild.delegate = self;
        _passWordTextFild.tag = 103;
//        _passWordTextFild.placeholder = @"    密码";
//        _passWordTextFild.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"密码"];
        _passWordTextFild.leftView = leftView;
        _passWordTextFild.font  = [UIFont systemFontOfSize:15];
        _passWordTextFild.textColor = [UIColor colorWithHexString:@"212121"];
        _passWordTextFild.secureTextEntry = YES;
        _passWordTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;

    }
    return _passWordTextFild;
}

- (UITextField *)authCodeTextFild{
    if (_authCodeTextFild == nil) {
        _authCodeTextFild = [[AddlineButtomTextField alloc]init];
        _authCodeTextFild.delegate = self;
        _authCodeTextFild.tag = 104;
//        _authCodeTextFild.placeholder = @"    验证码";
//        _authCodeTextFild.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"yanzhengma"];
        _authCodeTextFild.leftView = leftView;
        _authCodeTextFild.font  = [UIFont systemFontOfSize:15];
        _authCodeTextFild.textColor = [UIColor colorWithHexString:@"212121"];
        _authCodeTextFild.keyboardType = UIKeyboardTypeNumberPad;
        
    }
    return _authCodeTextFild;
}

- (UITextField *)affirmTextFild{
    if (_affirmTextFild == nil) {
        _affirmTextFild = [[AddlineButtomTextField alloc]init];
        _affirmTextFild.delegate = self;
        _affirmTextFild.tag = 105;
//        _affirmTextFild.placeholder = @"    确认密码";
//        _affirmTextFild.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"密码"];
        _affirmTextFild.leftView = leftView;
        _affirmTextFild.font  = [UIFont systemFontOfSize:15];
        _affirmTextFild.textColor = [UIColor colorWithHexString:@"212121"];
        _affirmTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
        _affirmTextFild.secureTextEntry = YES;
    }
    return _affirmTextFild;
}

- (UITextField *)invitationTextFild{
    if (_invitationTextFild == nil) {
        _invitationTextFild = [[AddlineButtomTextField alloc]init];
        _invitationTextFild.delegate = self;
        _invitationTextFild.tag = 106;
//        _invitationTextFild.placeholder = @"    输入邀请码,获得奖励";
//        _invitationTextFild.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"yaoqingma"];
        _invitationTextFild.leftView = leftView;
        _invitationTextFild.font  = [UIFont systemFontOfSize:15];
        _invitationTextFild.textColor = [UIColor colorWithHexString:@"212121"];
    }
    return _invitationTextFild;
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
- (UILabel *)invitationLabel{
    if (_invitationLabel == nil) {
        _invitationLabel = [[UILabel alloc] init];
        _invitationLabel.text = @"邀请码(可选)";
        _invitationLabel.textColor  = [UIColor colorWithHexString:@"bdbdbd"];
        _invitationLabel.font = [UIFont systemFontOfSize:10];
    }
    return _invitationLabel;
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
- (UIView *)lineNoteView{
    if (_lineNoteView == nil) {
        _lineNoteView  = [[UIView alloc] init];
        _lineNoteView.backgroundColor = [UIColor colorWithHexString:@"bdbdbd"];
    }
    return _lineNoteView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.layer.contents = (id)[UIImage imageNamed:@"login_background"].CGImage;
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    self.title = @"注册";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"bd4437"]];
    
    CGRect backframe= CGRectMake(0, 0, 20, 20);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = backframe;
    [backButton setBackgroundImage:[UIImage imageNamed:@"Back-Icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dealGoBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [self.view addSubview:self.topLabel];
    
    [self.view addSubview:self.goBackButton];
    
    
    
    [self.view addSubview:self.registerButton];
    
    [self.view addSubview:self.phoneTextField];
    
    [self.view addSubview:self.authCodeTextFild];
    
    [self.view addSubview:self.passWordTextFild];
    
    [self.view addSubview:self.invitationTextFild];
    
    [self.view addSubview:self.affirmTextFild];

    [self.view addSubview:self.phoneNumLabel];
    [self.view addSubview:self.gainNumLabel];
    [self.view addSubview:self.passwordLabel];
    [self.view addSubview:self.affirmLabel];
    [self.view addSubview:self.invitationLabel];
    
    [self.view addSubview:self.selectButton];
    [self.view addSubview:self.sendButton];
    [self.view addSubview:self.noteLabel];
    [self.view addSubview:self.lineNoteView];
    
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
        make.left.mas_equalTo(self.view.mas_left).with.offset(10);
        make.top.mas_equalTo(self.view.mas_top).with.offset(30);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@20);
    }];
    // 手机号
    [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.top.mas_equalTo(self.view.mas_top).with.offset(24);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@40);

    }];

    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.phoneNumLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@117);
    }];
    
    // 验证码
    [self.gainNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(16);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@40);
        
    }];

    [self.authCodeTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.gainNumLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    
    // 密码
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.top.mas_equalTo(self.authCodeTextFild.mas_bottom).with.offset(16);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@40);
        
    }];
    [self.passWordTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.passwordLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    // 确认密码
    [self.affirmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.top.mas_equalTo(self.passWordTextFild.mas_bottom).with.offset(16);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@40);
        
    }];
    [self.affirmTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.affirmLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    // 邀请码
    [self.invitationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.top.mas_equalTo(self.affirmTextFild.mas_bottom).with.offset(16);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@80);
        
    }];

    [self.invitationTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.invitationLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    
    // 协议框
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.top.mas_equalTo(self.invitationTextFild.mas_bottom).with.offset(23);
        make.height.mas_equalTo(@24);
        make.width.mas_equalTo(@24);
    }];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.invitationTextFild.mas_bottom).with.offset(70);
        make.height.mas_equalTo(@49);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectButton.mas_right).with.offset(10);
        make.top.mas_equalTo(self.invitationTextFild.mas_bottom).with.offset(26);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@250);
    }];
    [self.lineNoteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectButton.mas_right).with.offset(10);
        make.top.mas_equalTo(self.noteLabel.mas_bottom).with.offset(1);
        make.height.mas_equalTo(@1);
        make.width.mas_equalTo(@140);
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
// 协议框的点击事件
- (void)didClickSelectButton:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
    }else{
    
        btn.selected = YES;
    }
}
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
        _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 8, _phoneNumLabel.frame.origin.y, 120, 18)];
        _showWarningMessageView.isShowWarningMessage  = NO;
        [self.view addSubview:_showWarningMessageView];
        
        return;
        
    }else {
        
        if (![AcountManager isValidateMobile:self.phoneTextField.text]) {
            [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
            _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 8, _phoneNumLabel.frame.origin.y, 120, 18)];
            _showWarningMessageView.isShowWarningMessage  = NO;
            [self.view addSubview:_showWarningMessageView];
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
                _sendButton.backgroundColor = [UIColor colorWithHexString:@"bd4437"];
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

- (void)dealGoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealRegister:(UIButton *)sender {
    
    if (self.phoneTextField.text == nil || self.phoneTextField.text.length <= 0) {
        
        [self obj_showTotasViewWithMes:@"请输入手机号"];
        _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 8, _phoneNumLabel.frame.origin.y, 120, 18)];
        _showWarningMessageView.isShowWarningMessage  = NO;
        [self.view addSubview:_showWarningMessageView];
        
        return;
        
    }else {
        
        if (![AcountManager isValidateMobile:self.phoneTextField.text]) {
            [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
            _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 8, _phoneNumLabel.frame.origin.y, 120, 18)];
            _showWarningMessageView.isShowWarningMessage  = NO;
            [self.view addSubview:_showWarningMessageView];
            return;
        }
        
    }
    
    [self.paramsPost setObject:self.phoneTextField.text forKey:@"mobile"];
    if (self.authCodeTextFild.text.length <= 0 || self.authCodeTextFild.text == nil) {
        [self obj_showTotasViewWithMes:@"请输入验证码"];
        _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 8 - 115, _gainNumLabel.frame.origin.y, 120, 18)];
        _showWarningMessageView.isShowWarningMessage  = NO;
        [self.view addSubview:_showWarningMessageView];
        return;
    }
    [self.paramsPost setObject:self.authCodeTextFild.text forKey:@"smscode"];
    if (self.passWordTextFild.text == nil || self.passWordTextFild.text.length <= 0) {
        [self obj_showTotasViewWithMes:@"请输入密码"];
        _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 8, _passwordLabel.frame.origin.y, 120, 18)];
        _showWarningMessageView.isShowWarningMessage  = NO;
        [self.view addSubview:_showWarningMessageView];
        return;
        
    }
    
    if (self.affirmTextFild.text == nil || self.affirmTextFild.text.length <= 0) {
        [self obj_showTotasViewWithMes:@"请输入确认密码"];
        _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 8, _affirmLabel.frame.origin.y, 120, 18)];
        _showWarningMessageView.isShowWarningMessage  = NO;
        [self.view addSubview:_showWarningMessageView];
        return;
    }
    if (![self.passWordTextFild.text isEqualToString:self.affirmTextFild.text]) {
        [self obj_showTotasViewWithMes:@"两次密码不一样"];
        _showWarningMessageView = [[ShowWarningMessageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - 8, _affirmLabel.frame.origin.y, 120, 18)];
        _showWarningMessageView.isShowWarningMessage  = NO;
        [self.view addSubview:_showWarningMessageView];

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
    NSString *urlString = [NSString stringWithFormat:@"userinfo/userexists?usertype=1&mobile=%@",self.phoneTextField.text];
    NSString *codeUrl = [NSString stringWithFormat:BASEURL,urlString];
    
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
    }];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (!self.showWarningMessageView.isShowWarningMessage) {
        self.showWarningMessageView.hidden = YES;
    }
}

// 向服务器注册用户
- (void)userRegister {
    
    NSString *passwordString = nil;
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
        
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        
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
             
             DYNSLog(@"登录成功");
             
             [AcountManager configUserInformationWith:dataDic[@"data"]];
             
             [AcountManager saveUserName:self.phoneTextField.text andPassword:self.passWordTextFild.text];
             
//             [APService setAlias:[AcountManager manager].userid callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
             
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
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccess" object:nil];
             
             [self dismissViewControllerAnimated:NO completion:^{
                 [[NSNotificationCenter defaultCenter] postNotificationName:kregisterUser object:nil];
             }];
             
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
