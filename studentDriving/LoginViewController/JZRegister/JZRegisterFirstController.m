//
//  JZRegisterFirstController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/4.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZRegisterFirstController.h"
#import "DVVBaseTextField.h"

@interface JZRegisterFirstController ()<UITextFieldDelegate>
@property (nonatomic, strong) DVVBaseTextField *phoneNumTextFiled; // 手机号
@property (nonatomic, strong) DVVBaseTextField *authCodeTextFiled; // 验证码
@property (strong, nonatomic)UIButton *sendButton;
@property (strong, nonatomic)UIButton *nextRegisterButton;

@property (nonatomic,strong) UIView *codeView;

@end

@implementation JZRegisterFirstController
- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    [self initUI];
    
}

- (void)initUI{
        [self.view addSubview:self.phoneNumTextFiled];
        [self.view addSubview:self.codeView];
        [self.codeView addSubview:self.authCodeTextFiled];
        [self.codeView addSubview:self.sendButton];
        [self.view addSubview:self.nextRegisterButton];
}
#pragma mark -- UItextFiledDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (5000 == textField.tag) {
        // 手机号开始输入
        self.sendButton.backgroundColor = YBNavigationBarBgColor;
        self.sendButton.userInteractionEnabled = YES;
        
    }
    if (5001 == textField.tag) {
        // 验证码开始输入
    }

}
#pragma mark -- UItextFiledNotification
- (void)phoenTextFieldTextDidChange:(NSNotification *)obj{
    UITextField *phoneTextFiled = (UITextField *)obj;
    if (phoneTextFiled.text.length == 0) {
         _sendButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _sendButton.userInteractionEnabled = NO;
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
// 点击下一步
- (void)nextRegisterButton:(UIButton *)sender{
    
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
    
    [self.nextRegisterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.authCodeTextFiled.mas_bottom).offset(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.height.mas_equalTo(@44);
        
        
    }];


}
#pragma mark ----- Lazy 加载
- (DVVBaseTextField *)phoneNumTextFiled{
    if (_phoneNumTextFiled == nil) {
        _phoneNumTextFiled  = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"user"] placeholder:@"请输入手机号" borderColor:YBNavigationBarBgColor];
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
        _codeView.layer.borderColor = YBNavigationBarBgColor.CGColor;
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
        [_nextRegisterButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextRegisterButton.layer.masksToBounds = YES;
        _nextRegisterButton.layer.cornerRadius = 10;
        _nextRegisterButton.layer.borderWidth = 1;
        _nextRegisterButton.layer.borderColor = [UIColor colorWithHexString:@"fb7064"].CGColor;
        _nextRegisterButton.userInteractionEnabled = NO;
    }
    return _nextRegisterButton;
}

@end
