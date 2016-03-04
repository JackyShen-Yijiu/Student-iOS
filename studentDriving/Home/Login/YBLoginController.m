//
//  YBLoginController.m
//  studentDriving
//
//  Created by 大威 on 16/3/4.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBLoginController.h"
#import "DVVBaseTextField.h"

@interface YBLoginController ()

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) DVVBaseTextField *loginNameTextField;
@property (nonatomic, strong) DVVBaseTextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *retrievePasswordButton;

@property (nonatomic, strong) UIButton *bottomButton;

@end

@implementation YBLoginController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    self.view.layer.contents = (id)([UIImage imageNamed:@"background_login"].CGImage);
    
    [self.view addSubview:self.logoImageView];
    
    [self.view addSubview:self.contentView];
    [_contentView addSubview:self.loginNameTextField];
    [_contentView addSubview:self.passwordTextField];
    [_contentView addSubview:self.loginButton];
    [_contentView addSubview:self.registerButton];
    [_contentView addSubview:self.retrievePasswordButton];
    
    [self.view addSubview:self.bottomButton];
    
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - configUI

- (void)configUI {
    
    __weak typeof(self) ws = self;
    
    CGFloat height = 44;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat contentViewWidth = 0;
    if (screenWidth <= 320) {
        // 小屏幕
        contentViewWidth = screenWidth - 30*2;
    }else {
        // 大屏幕
        contentViewWidth = screenWidth - 53*2;
    }
    
    
    [_loginNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentViewWidth);
        make.height.mas_equalTo(height);
        make.left.and.top.mas_equalTo(0);
    }];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentViewWidth);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(ws.loginNameTextField.mas_bottom).offset(20);
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentViewWidth);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(ws.passwordTextField.mas_bottom).offset(32);
    }];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(12 * 4);
        make.height.mas_equalTo(12);
        make.top.mas_equalTo(ws.loginButton.mas_bottom).offset(18);
        make.left.mas_equalTo(contentViewWidth / 2.f - 18 - 12*4);
    }];
    [_retrievePasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(12 * 4);
        make.height.mas_equalTo(12);
        make.top.mas_equalTo(ws.loginButton.mas_bottom).offset(18);
        make.left.mas_equalTo(contentViewWidth / 2.f + 18);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentViewWidth);
        make.height.mas_equalTo(214);
        make.centerX.mas_equalTo(ws.view.mas_centerX);
        make.centerY.mas_equalTo(ws.view.mas_centerY).offset(50);
    }];
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(ws.contentView.mas_top);
    }];
    
    [_bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(12 * 4);
        make.height.mas_equalTo(12);
        make.centerX.mas_equalTo(ws.view.mas_centerX);
        make.bottom.mas_equalTo(-24);
    }];
    
//    _contentView.backgroundColor = [UIColor lightGrayColor];
//    _registerButton.backgroundColor = [UIColor redColor];
}

#pragma mark - lazy load

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
        _logoImageView.image = [UIImage imageNamed:@"logo"];
        _logoImageView.bounds = CGRectMake(0, 0, 166, 120);
        _logoImageView.contentMode = UIViewContentModeCenter;
    }
    return _logoImageView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (DVVBaseTextField *)loginNameTextField {
    if (!_loginNameTextField) {
        _loginNameTextField = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"user_white"] placeholder:@"请输入手机号"];
        _loginNameTextField.cornerRadius = 18;
    }
    return _loginNameTextField;
}

- (DVVBaseTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"password_white"] placeholder:@"请输入密码"];
        _passwordTextField.cornerRadius = 18;
    }
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton new];
        [_loginButton.layer setMasksToBounds:YES];
        [_loginButton.layer setCornerRadius:18];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.backgroundColor = YBNavigationBarBgColor;
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton new];
        [_registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _registerButton;
}

- (UIButton *)retrievePasswordButton {
    if (!_retrievePasswordButton) {
        _retrievePasswordButton = [UIButton new];
        [_retrievePasswordButton setTitle:@"找回密码" forState:UIControlStateNormal];
        _retrievePasswordButton.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _retrievePasswordButton;
}

- (UIButton *)bottomButton {
    if (!_bottomButton) {
        _bottomButton = [UIButton new];
        [_bottomButton setTitle:@"先看看去" forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _bottomButton;
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
