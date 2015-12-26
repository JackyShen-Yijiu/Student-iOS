//
//  ModifyPhoneNumViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "ModifyPhoneNumViewController.h"
#import "UIDevice+JEsystemVersion.h"

static NSString *const kuserUpdateMobileNum = @"userinfo/updatemobile";
@interface ModifyPhoneNumViewController ()
@property (strong, nonatomic) UITextField *phoneNumTextField;
@property (strong, nonatomic) UITextField *confirmTextField;
@property (strong, nonatomic) UIButton *gainNum;
@property (strong, nonatomic) UILabel *nowPhoneNumLabel;

@property (strong, nonatomic) UIButton *completionButton;
@end

@implementation ModifyPhoneNumViewController

- (UIButton *)completionButton {
    if (_completionButton == nil) {
        _completionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _completionButton.backgroundColor = MAIN_FOREGROUND_COLOR;
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
        _nowPhoneNumLabel.font = [UIFont systemFontOfSize:14];
//        _nowPhoneNumLabel.backgroundColor = [UIColor yellowColor];
    }
    return _nowPhoneNumLabel;
}
- (UITextField *)phoneNumTextField {
    if (_phoneNumTextField == nil) {
        _phoneNumTextField = [[UITextField alloc]init];
        //        _phoneNumTextField.delegate = self;
        _phoneNumTextField.font = [UIFont systemFontOfSize:14];
        _phoneNumTextField.tag = 102;
        _phoneNumTextField.placeholder = @"手机号";
        _phoneNumTextField.backgroundColor = [UIColor whiteColor];
        _phoneNumTextField.layer.borderColor = TEXTGRAYCOLOR.CGColor;
        _phoneNumTextField.layer.borderWidth = 0.5;
        
    }
    return _phoneNumTextField;
}
- (UITextField *)confirmTextField {
    if (_confirmTextField == nil) {
        _confirmTextField = [[UITextField alloc]init];
        //        _confirmTextField.delegate = self;
        _confirmTextField.tag = 103;
        _confirmTextField.font = [UIFont systemFontOfSize:14];
        _confirmTextField.placeholder = @"验证码";
        _confirmTextField.backgroundColor = [UIColor whiteColor];
        _confirmTextField.layer.borderColor = TEXTGRAYCOLOR.CGColor;
        _confirmTextField.layer.borderWidth = 0.5;
    }
    return _confirmTextField;
}
- (UIButton *)gainNum {
    if (_gainNum == nil) {
        _gainNum = [UIButton buttonWithType:UIButtonTypeCustom];
        _gainNum.backgroundColor = RGBColor(255, 151, 40);
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
    [self.view addSubview:self.phoneNumTextField];
    [self.view addSubview:self.confirmTextField];
    [self.view addSubview:self.gainNum];
    [self.view addSubview:self.completionButton];
    [self.nowPhoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.top.mas_equalTo(self.view.mas_top).offset(25);
    }];
    
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.nowPhoneNumLabel.mas_bottom).offset(25);
        make.height.mas_equalTo(@44);
    }];
    
    [self.confirmTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.gainNum.mas_left).with.offset(-10);
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
    }];
    
    [self.gainNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.confirmTextField.mas_right).with.offset(10);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@100);
        
    }];
    
    [self.completionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(@44);
        make.top.mas_equalTo(self.gainNum.mas_bottom).offset(25);
    }];
    DYNSLog(@"phone = %@",[AcountManager manager].userMobile);
    if ([AcountManager manager].userMobile) {
        self.nowPhoneNumLabel.text = [NSString stringWithFormat:@"您当前手机号为%@",[AcountManager manager].userMobile] ;
    }
    
}

- (void)clickCompletion:(UIButton *)sender {
 
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length == 0) {
        [self showTotasViewWithMes:@"请输入手机号"];
        return;
    }
    if (self.confirmTextField.text == nil || self.confirmTextField.text.length == 0) {
        [self showTotasViewWithMes:@"请输入验证码"];
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
            [self showTotasViewWithMes:@"绑定成功"];
            weakSelf.nowPhoneNumLabel.text = [NSString stringWithFormat:@"您当前手机号为%@",weakSelf.phoneNumTextField.text];
            [AcountManager saveUserPhoneNum:weakSelf.phoneNumTextField.text];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self showTotasViewWithMes:@"绑定失败"];
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
}


@end
