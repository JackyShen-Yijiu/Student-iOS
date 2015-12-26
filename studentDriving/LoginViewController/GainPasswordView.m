////
////  GainPasswordView.m
////  BlackCat
////
////  Created by 董博 on 15/9/5.
////  Copyright (c) 2015年 lord. All rights reserved.
////
//
//#import "GainPasswordView.h"
//#import <Masonry/Masonry.h>
//#import "ToolHeader.h"
//
//@interface GainPasswordView ()
//@property (strong, nonatomic, readwrite) UITextField *phoneNumTextField;
//@property (strong, nonatomic, readwrite) UITextField *confirmTextField;
//@property (strong, nonatomic, readwrite) UIButton *gainNum;
//@property (strong, nonatomic, readwrite) UIButton *runNextButton;
//@end
//@implementation GainPasswordView
//
//- (UITextField *)phoneNumTextField {
//    if (_phoneNumTextField == nil) {
//        _phoneNumTextField = [[UITextField alloc]init];
//        //        _phoneNumTextField.delegate = self;
//        _phoneNumTextField.tag = 102;
//        _phoneNumTextField.placeholder = @"  手机号";
//        _phoneNumTextField.font = [UIFont systemFontOfSize:15];
//        _phoneNumTextField.textColor = RGBColor(153, 153, 153);
//        _phoneNumTextField.layer.borderWidth = 1;
//        _phoneNumTextField.layer.borderColor = RGBColor(230, 230, 230).CGColor;
//    }
//    return _phoneNumTextField;
//}
//- (UITextField *)confirmTextField {
//    if (_confirmTextField == nil) {
//        _confirmTextField = [[UITextField alloc]init];
//        _confirmTextField.tag = 103;
//        _confirmTextField.placeholder = @"  验证码";
//        _confirmTextField.font = [UIFont systemFontOfSize:15];
//        _confirmTextField.textColor = RGBColor(153, 153, 153);
//        _confirmTextField.layer.borderWidth = 1;
//        _confirmTextField.layer.borderColor = RGBColor(230, 230, 230).CGColor;
//    }
//    return _confirmTextField;
//}
//- (UIButton *)gainNum {
//    if (_gainNum == nil) {
//        _gainNum = [UIButton buttonWithType:UIButtonTypeCustom];
//        _gainNum.backgroundColor = RGBColor(255, 102, 51);
//        [_gainNum addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
//        _gainNum.titleLabel.font = [UIFont systemFontOfSize:15];
//        
//        [_gainNum setTitle:@"获取验证码" forState:UIControlStateNormal];
//    }
//    return _gainNum;
//}
//
//- (UIButton *)runNextButton {
//    if (_runNextButton == nil) {
//        _runNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _runNextButton.backgroundColor = RGBColor(255, 102, 51);
//        [_runNextButton addTarget:self action:@selector(dealNext:) forControlEvents:UIControlEventTouchUpInside];
//        [_runNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _runNextButton.titleLabel.font = [UIFont systemFontOfSize:16];
//        
//        [_runNextButton setTitle:@"下一步" forState:UIControlStateNormal];
//    }
//    return _runNextButton;
//}
//
//- (id)initWithFrame:(CGRect)frame With:(id<GainPasswordViewDelegate>)delegate{
//    if (self = [super initWithFrame:frame]) {
//        
//        self.backgroundColor = [UIColor whiteColor];
//        
//        self.delegate = delegate;
//        
//        [self createUI];
//    }
//    return self;
//}
//
//- (id)initWith:(id<GainPasswordViewDelegate>)delegate {
//    return [self initWithFrame:CGRectMake(0, 0, 0, 0)With:delegate];
//}
//
//- (void)createUI {
//    
//    [self addSubview:self.phoneNumTextField];
//    [self addSubview:self.confirmTextField];
//    [self addSubview:self.runNextButton];
//    [self addSubview:self.gainNum];
//    
//    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.mas_left).with.offset(15);
//        make.right.mas_equalTo(self.mas_right).with.offset(-15);
//        make.top.mas_equalTo(self.mas_top).with.offset(20+55);
//        make.height.mas_equalTo(@44);
//    }];
//    
//    [self.gainNum mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.mas_right).with.offset(-15);
//        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(10);
//        make.height.mas_equalTo(@44);
//        make.width.mas_equalTo(@117);
//    }];
//    
//    [self.confirmTextField mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.mas_left).with.offset(15);
//        make.right.mas_equalTo(self.gainNum.mas_left).with.offset(-10);
//        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(10);
//        make.height.mas_equalTo(@44);
//    }];
//    
//    
//    
//    [self.runNextButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.confirmTextField.mas_bottom).with.offset(20);
//        make.right.mas_equalTo(self.mas_right).with.offset(-20);
//        make.left.mas_equalTo(self.mas_left).with.offset(20);
//        make.height.mas_equalTo(@44);
//    }];
//    
//    
//    
//}
//
//#define TIME 60
//- (void)dealSend:(UIButton *)sender {
//    
//    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length <= 0) {
//        [self showTotasViewWithMes:@"请输入手机号"];
//        return;
//    }else {
//        
//    }
//    
//    sender.userInteractionEnabled = NO;
//    __block int count = TIME;
//    dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, myQueue);
//    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(timer, ^{
//        if (count < 0) {
//            dispatch_source_cancel(timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                [self.gainNum setTitle:@"获取验证码" forState:UIControlStateNormal];
//                self.gainNum.userInteractionEnabled = YES;
//            });
//        }else {
//            NSString *str = [NSString stringWithFormat:@"剩余(%d)s",count];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.gainNum.backgroundColor = RGBColor(204, 204, 204);
//                [self.gainNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                [self.gainNum setTitle:str forState:UIControlStateNormal];
//                
//            });
//            count--;
//        }
//    });
//    dispatch_resume(timer);
//}
//
//
//
//
//
//- (void)dealNext:(UIButton *)sender {
//    BOOL isRunNext = NO;
//    NSString *phoneNum = self.phoneNumTextField.text;
//    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isMatch = [pred evaluateWithObject:phoneNum];
//    if (!isMatch) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号" maskType:SVProgressHUDMaskTypeBlack];
//        return;
//    }
//    
//    if (self.confirmTextField.text.length <= 0 || self.confirmTextField.text == nil) {
//        [SVProgressHUD showErrorWithStatus:@"请输入验证码" maskType:SVProgressHUDMaskTypeBlack];
//        return;
//    }
//    isRunNext = YES;
//    //逻辑判断
//    if ([_delegate respondsToSelector:@selector(GPViewSenderMessegte:)]) {
//        [_delegate GPViewSenderMessegte:isRunNext];
//    }
//}
//
//@end
