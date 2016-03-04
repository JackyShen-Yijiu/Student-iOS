//
//  JZRegisterFirstController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/4.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZRegisterFirstController.h"
#import "DVVBaseTextField.h"

@interface JZRegisterFirstController ()
@property (nonatomic, strong) DVVBaseTextField *phoneNumTextFiled; // 手机号
@property (nonatomic, strong) DVVBaseTextField *authCodeTextFiled; // 验证码
@property (strong, nonatomic)UIButton *sendButton;
@property (strong, nonatomic)UIButton *nextRegisterButton;

@end

@implementation JZRegisterFirstController
- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    
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
#pragma mark ----- Lazy 加载
- (DVVBaseTextField *)phoneNumTextFiled{
    if (_phoneNumTextFiled == nil) {
        _phoneNumTextFiled  = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"user"] placeholder:@"请输入手机号" borderColor:YBNavigationBarBgColor];
    }
    return _phoneNumTextFiled;
}
- (DVVBaseTextField *)authCodeTextFiled{
    if (_authCodeTextFiled == nil) {
        _authCodeTextFiled  = [[DVVBaseTextField alloc] initWithLeftImage:[UIImage imageNamed:@"test"] placeholder:@"请输入验证码" borderColor:YBNavigationBarBgColor];
    }
    return _authCodeTextFiled;
}
- (UIButton *)sendButton{
    if (_sendButton == nil) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.backgroundColor = [UIColor clearColor];
        [_sendButton addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
        //        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _sendButton.backgroundColor = YBNavigationBarBgColor;
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        
    }
    return _sendButton;
}
- (UIButton *)nextRegisterButton{
    if (_nextRegisterButton == nil) {
        _nextRegisterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextRegisterButton.backgroundColor = YBNavigationBarBgColor;
        _nextRegisterButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextRegisterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextRegisterButton addTarget:self action:@selector(nextRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
        [_nextRegisterButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
    return _nextRegisterButton;
}

@end
