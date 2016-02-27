//
//  ModifyPhoneNumViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "ModifyPhoneNumViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "AddlineButtomTextField.h"

static NSString *const kuserUpdateMobileNum = @"userinfo/updatemobile";
@interface ModifyPhoneNumViewController () <UITextFieldDelegate>
@property (strong, nonatomic) UITextField *phoneNumTextField;
@property (strong, nonatomic) UITextField *confirmTextField;
@property (strong, nonatomic) UIButton *gainNum;
@property (strong, nonatomic) UILabel *nowPhoneNumLabel;

@property (strong, nonatomic) UIButton *completionButton;

@property (strong, nonatomic) UILabel *phoneNumLabel;
@property (strong, nonatomic) UILabel *gainNumLabel;
@end

@implementation ModifyPhoneNumViewController

- (UIButton *)completionButton {
    if (_completionButton == nil) {
        _completionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _completionButton.backgroundColor = YBNavigationBarBgColor;
        [_completionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_completionButton setTitle:@"完成" forState:UIControlStateNormal];
        [_completionButton addTarget:self action:@selector(clickCompletion:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completionButton;
}
- (UILabel *)nowPhoneNumLabel {
    if (_nowPhoneNumLabel == nil) {
        _nowPhoneNumLabel = [[UILabel alloc] init];
        _nowPhoneNumLabel.text = @"";
        _nowPhoneNumLabel.numberOfLines = 0;
        _nowPhoneNumLabel.textColor = TEXTGRAYCOLOR;
        _nowPhoneNumLabel.font = [UIFont systemFontOfSize:10];
//        _nowPhoneNumLabel.backgroundColor = [UIColor yellowColor];
    }
    return _nowPhoneNumLabel;
}
- (UIButton *)gainNum {
    if (_gainNum == nil) {
        _gainNum = [UIButton buttonWithType:UIButtonTypeCustom];
        _gainNum.backgroundColor = YBNavigationBarBgColor;
        [_gainNum addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
        [_gainNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _gainNum.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_gainNum setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
    return _gainNum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"绑定手机号";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = RGBColor(245, 247, 250);
    
    [self.view addSubview:self.nowPhoneNumLabel];
    [self.view addSubview:self.phoneNumLabel];
    [self.view addSubview:self.phoneNumTextField];
    [self.view addSubview:self.gainNumLabel];
    [self.view addSubview:self.confirmTextField];
    [self.view addSubview:self.gainNum];
    [self.view addSubview:self.completionButton];
    
    [self.nowPhoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.top.mas_equalTo(self.view.mas_top).offset(25);
    }];
    // 手机号
    [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.top.mas_equalTo(self.nowPhoneNumLabel.mas_bottom).with.offset(24);
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
    
    // 验证码
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
    
    [self.completionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(@44);
        make.top.mas_equalTo(self.gainNum.mas_bottom).offset(60);
    }];
    DYNSLog(@"phone = %@",[AcountManager manager].userMobile);
    if ([AcountManager manager].userMobile) {
        self.nowPhoneNumLabel.text = [NSString stringWithFormat:@"您当前手机号为%@",[AcountManager manager].userMobile] ;
    }
    
}

- (void)clickCompletion:(UIButton *)sender
{
 
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length == 0) {
        [self obj_showTotasViewWithMes:@"请输入手机号"];
        return;
    }
    if (self.confirmTextField.text == nil || self.confirmTextField.text.length == 0) {
        [self obj_showTotasViewWithMes:@"请输入验证码"];
        return;
    }
    if (![AcountManager isValidateMobile:self.phoneNumTextField.text]) {
        [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
        return;
    }
   
    NSDictionary *param = @{@"smscode":self.confirmTextField.text,@"mobile":self.phoneNumTextField.text};
    
    NSString *kupdateMobileNum = [NSString stringWithFormat:BASEURL,kuserUpdateMobileNum];
    DYNSLog(@"url = %@",kupdateMobileNum);
    
    __weak ModifyPhoneNumViewController *weakSelf = self;
    [JENetwoking startDownLoadWithUrl:kupdateMobileNum postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        if (messege.intValue == 1) {
            
            [self obj_showTotasViewWithMes:@"绑定成功"];
            weakSelf.nowPhoneNumLabel.text = [NSString stringWithFormat:@"您当前手机号为%@",weakSelf.phoneNumTextField.text];
            [AcountManager saveUserPhoneNum:weakSelf.phoneNumTextField.text];
            [[NSNotificationCenter defaultCenter] postNotificationName:kphone object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            [self obj_showTotasViewWithMes:@"绑定失败"];
        }
    }];
    
}

#define TIME 60
- (void)dealSend:(UIButton *)sender {
    NSLog(@"发送验证码");
    
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length <= 0) {
        [self showTotasViewWithMes:@"请输入手机号"];
        return;
    }else {
        
        if (![AcountManager isValidateMobile:self.phoneNumTextField.text]) {
            [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
            return;
        }
        
        NSString *urlString = [NSString stringWithFormat:@"code/%@",self.phoneNumTextField.text];
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
                self.gainNum.titleLabel.font = [UIFont systemFontOfSize:15];
                self.gainNum.backgroundColor  = YBNavigationBarBgColor;
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
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _phoneNumTextField) {
        if (range.location>10) {
            return NO;
        }
    }
    return YES;
}

- (UITextField *)phoneNumTextField {
    if (_phoneNumTextField == nil) {
        _phoneNumTextField = [[AddlineButtomTextField alloc]init];
        _phoneNumTextField.delegate = self;
        _phoneNumTextField.tag = 200;
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
        _confirmTextField.tag = 201;
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

@end
