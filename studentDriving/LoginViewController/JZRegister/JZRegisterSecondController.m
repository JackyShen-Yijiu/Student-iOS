//
//  JZRegisterSecondController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/4.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZRegisterSecondController.h"
#import "DVVBaseTextField.h"
@interface JZRegisterSecondController ()<UITextFieldDelegate>
@property (nonatomic, strong) DVVBaseTextField *passwordTextFiled; // 密码
@property (nonatomic, strong) DVVBaseTextField *invitiTextFiled; // 验证码
@property (strong, nonatomic)UIButton *registButton;




@end
@implementation JZRegisterSecondController
- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    [self initUI];
    
}

- (void)initUI{
    [self.view addSubview:self.passwordTextFiled];
    [self.view addSubview:self.invitiTextFiled];
    [self.view addSubview:self.registButton];
    
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
//    NSString *urlStr = [NSString stringWithFormat:BASEURL,kautoCode];
//    //    /api/v1/Verificationsmscode?mobile=15652305650&code=123456
//    
//    NSDictionary *param = @{@"mobile":self.phoneNumTextFiled.text,
//                            @"code":self.authCodeTextFiled.text};
//    [JENetwoking startDownLoadWithUrl:urlStr postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
//        /*
//         {
//         "type": 0,
//         "msg": "验证码错误，请重新发送",
//         "data": ""
//         }
//         */
//        NSDictionary *param = data;
//        if (0 == [data[@"type"] integerValue]) {
//            [self obj_showTotasViewWithMes:param[@"msg"]];
//            return ;
//        }
//        if (1 == [data[@"type"] integerValue]) {
//            //  验证成功,跳转下界面
//            JZRegisterSecondController *secondVC = [[JZRegisterSecondController alloc] init];
//            [self.navigationController pushViewController:secondVC animated:YES];
//        }
//        
//    } withFailure:^(id data) {
//        
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
    
    
}
#pragma mark ----- Lazy 加载
- (DVVBaseTextField *)passwordTextFiled{
    if (_passwordTextFiled == nil) {
        _passwordTextFiled  = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"user"] placeholder:@"请输入手机号" borderColor:YBNavigationBarBgColor];
        _passwordTextFiled.tag = 5000;
        _passwordTextFiled.delegate = self;
    }
    return _passwordTextFiled;
}

- (DVVBaseTextField *)invitiTextFiled{
    if (_invitiTextFiled == nil) {
        _invitiTextFiled  = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"test"] placeholder:@"请输入验证码" borderColor:[UIColor clearColor]];
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

@end
