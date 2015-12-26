//
//  VerifyPhoneController.m
//  studentDriving
//
//  Created by 胡东苑 on 15/12/15.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "VerifyPhoneController.h"
#import "ChooseBtnView.h"
#import "KindlyReminderView.h"
#import "VerifyInformationController.h"
#import "SignUpInfoManager.h"

@interface VerifyPhoneController () <UITextFieldDelegate>

@property (nonatomic, strong)        UITextField *phoneTextField;
@property (nonatomic, strong)        UITextField *realNameTF;
@property (nonatomic, strong)        UITextField *authCodeTextFild;
@property (nonatomic, strong)           UIButton *sendButton;
@property (nonatomic, strong)      ChooseBtnView *cbv;
@property (nonatomic, strong) KindlyReminderView *krv;
@property (strong, nonatomic)           UIButton *referButton;

@end

@implementation VerifyPhoneController

- (UIButton *)referButton{
    if (_referButton == nil) {
        _referButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _referButton.backgroundColor = MAINCOLOR;
        _referButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_referButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_referButton addTarget:self action:@selector(dealRefer:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _referButton;
}

- (UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc]init];
        _phoneTextField.backgroundColor = [UIColor whiteColor];
        _phoneTextField.delegate = self;
        _phoneTextField.tag = 102;
        _phoneTextField.placeholder = @"    报名时填写的手机号";
        _phoneTextField.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _phoneTextField.layer.borderWidth = 1;
        _phoneTextField.font  = [UIFont systemFontOfSize:15];
        _phoneTextField.textColor = RGBColor(153, 153, 153);
    }
    return _phoneTextField;
}

- (UITextField *)realNameTF {
    if (!_realNameTF) {
        _realNameTF = [[UITextField alloc] init];
        _realNameTF.backgroundColor = [UIColor whiteColor];
        _realNameTF.delegate = self;
        _realNameTF.tag = 102;
        _realNameTF.placeholder = @"    真实姓名";
        _realNameTF.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _realNameTF.layer.borderWidth = 1;
        _realNameTF.font  = [UIFont systemFontOfSize:15];
        _realNameTF.textColor = RGBColor(153, 153, 153);
    }
    return _realNameTF;
}

- (UITextField *)authCodeTextFild{
    if (_authCodeTextFild == nil) {
        _authCodeTextFild = [[UITextField alloc]init];
        _authCodeTextFild.backgroundColor = [UIColor whiteColor];
        _authCodeTextFild.delegate = self;
        _authCodeTextFild.tag = 104;
        _authCodeTextFild.placeholder = @"    输入验证码";
        _authCodeTextFild.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _authCodeTextFild.layer.borderWidth = 1;
        _authCodeTextFild.font  = [UIFont systemFontOfSize:15];
        _authCodeTextFild.textColor = RGBColor(153, 153, 153);
    }
    return _authCodeTextFild;
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

- (ChooseBtnView *)cbv {
    if (!_cbv) {
        _cbv = [[ChooseBtnView alloc] initWithSelectedBtn:0 leftTitle:@"验证手机号" midTitle:@"验证信息" rightTitle:@"提交验证" frame:CGRectMake(0, 74, kSystemWide, 67)];
        _cbv.backgroundColor = [UIColor whiteColor];
    }
    return _cbv;
}

- (KindlyReminderView *)krv {
    if (!_krv) {
        _krv = [[KindlyReminderView alloc] initWithContentStr:@"请认真填写以下信息，如果系统没有自动载入请自行添加各项信息" frame:CGRectMake(0, 138, kSystemWide, 72)];
        _krv.backgroundColor = RGBColor(245, 247, 250);
    }
    return _krv;
}

#pragma mark -   action

#define TIME 60
- (void)dealSend:(UIButton *)sender {
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

- (void)dealRefer:(UIButton *)sender{

    [SignUpInfoManager signUpInfoSaveRealTelephone:_phoneTextField.text];
    [SignUpInfoManager signUpInfoSaveRealName:_realNameTF.text];
    [SignUpInfoManager signUpInfoSaveRealcode:_authCodeTextFild.text];
    [self.navigationController pushViewController:[VerifyInformationController new] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBColor(245, 247, 250);
    
   
    [self.view addSubview:self.cbv];
    [self.view addSubview:self.krv];
    
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.realNameTF];
    [self.view addSubview:self.authCodeTextFild];
    [self.view addSubview:self.sendButton];
    [self.view addSubview:self.referButton];

}

- (void)viewWillLayoutSubviews {
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.krv.mas_bottom).with.offset(1);
        make.height.mas_equalTo(@44);
    }];
    [self.realNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
    }];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.realNameTF.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@117);
    }];
    [self.authCodeTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.sendButton.mas_left).with.offset(-10);
        make.top.mas_equalTo(self.realNameTF.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
    }];
    [self.referButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
