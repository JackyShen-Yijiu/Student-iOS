//
//  YBSettingNewPwdViewController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/4.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSettingNewPwdViewController.h"
#import "DVVBaseTextField.h"
#import "JZRegisterSecondController.h"
#import "YBSettingNewPwdViewController.h"
#import "NSString+DY_MD5.h"

static NSString *const kchangePasswordUrl = @"/userinfo/updatepwd";

@interface YBSettingNewPwdViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) DVVBaseTextField *pwdTextFiled; // 设置新密码

@property (strong, nonatomic)UIButton *nextRegisterButton;

@property (strong, nonatomic) UIButton *eyeButton;

@end

@implementation YBSettingNewPwdViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"找回密码";
    
    [self initUI];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    
    [self.view addSubview:self.pwdTextFiled];
    [self.view addSubview:self.eyeButton];
    [self.view addSubview:self.nextRegisterButton];
    
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

#pragma mark -- UItextFiledNotification
- (void)phoenTextFieldTextDidChange:(NSNotification *)obj{
    UITextField *phoneTextFiled = (UITextField *)obj.object;
    if (phoneTextFiled.text.length == 0) {
        _nextRegisterButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _nextRegisterButton.userInteractionEnabled = NO;
    }else{
        _nextRegisterButton.backgroundColor = YBNavigationBarBgColor;
        _nextRegisterButton.userInteractionEnabled = YES;
    }
}

- (void)authCodeTextFieldTextDidChange:(NSNotification *)obj{
    UITextField *autoTextFiled = (UITextField *)obj.object;
    
    if (autoTextFiled.text.length == 0) {
        _nextRegisterButton.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
        _nextRegisterButton.userInteractionEnabled = NO;
    }else if(self.pwdTextFiled.text.length){
        _nextRegisterButton.backgroundColor = YBNavigationBarBgColor;
        _nextRegisterButton.userInteractionEnabled = YES;
    }
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
   
    [self.pwdTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(48);
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
- (DVVBaseTextField *)pwdTextFiled{
    if (_pwdTextFiled == nil) {
        _pwdTextFiled  = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"password"] placeholder:@"请设置新密码" borderColor:YBNavigationBarBgColor];
        _pwdTextFiled.tag = 5000;
        _pwdTextFiled.delegate = self;
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(phoenTextFieldTextDidChange:)
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
        [_nextRegisterButton addTarget:self action:@selector(nextRegisterButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [_nextRegisterButton setTitle:@"完成" forState:UIControlStateNormal];
        _nextRegisterButton.layer.masksToBounds = YES;
        _nextRegisterButton.layer.cornerRadius = 10;
        _nextRegisterButton.layer.borderWidth = 1;
        _nextRegisterButton.layer.borderColor = [UIColor colorWithHexString:@"fb7064"].CGColor;
        _nextRegisterButton.userInteractionEnabled = NO;
    }
    return _nextRegisterButton;
}

#pragma  mark -----
- (void)didEyeButton:(UIButton *)btn{
    if (!btn.selected) {
        self.pwdTextFiled.secureTextEntry = NO;
        btn.selected = YES;
    }else if (btn.selected) {
        self.pwdTextFiled.secureTextEntry = YES;
        btn.selected = NO;
    }
}

- (void)nextRegisterButtonDidClick
{
    // 手机号的判断
    if (self.phoneNumber == nil) {
        return;
    }
    
    // 密码的判断
    if (self.pwdTextFiled.text == nil || self.pwdTextFiled.text.length <= 0) {
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kchangePasswordUrl];
    
    NSDictionary *param = @{@"smscode":self.codeNumber,
                            @"password":[self.pwdTextFiled.text DY_MD5],
                            @"mobile":self.phoneNumber};
    
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
            
            //[DVVUserManager userNeedLogin];
            
        }else {
            
            [self obj_showTotasViewWithMes:resultData[@"msg"]];
            
        }
    }];
    
}

@end
