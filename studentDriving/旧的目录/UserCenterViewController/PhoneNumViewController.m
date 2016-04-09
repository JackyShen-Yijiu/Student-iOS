//
//  PhoneNumViewController.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/16.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "PhoneNumViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "NSUserStoreTool.h"

//#import "ToolHeader.h"
//static NSString *const kupdateUserInfo = @"userinfo/updatecoachinfo";
static NSString *const kuserUpdateMobileNum = @"userinfo/updatemobile";

#define margin 10
@interface PhoneNumViewController ()

@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) UIButton *naviBarLeftButton;

@property (nonatomic, strong) UIView *bgView;
@property (strong, nonatomic) UITextField *modifyNameTextField;
@property (nonatomic, strong) UIView *lineView;
@property (strong, nonatomic) UITextField *confirmTextField;
@property (strong, nonatomic) UIButton *gainNum;



@end

@implementation PhoneNumViewController

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kSystemWide, 89)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UITextField *)modifyNameTextField {
    if (_modifyNameTextField == nil) {
        _modifyNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(margin, 0, kSystemWide - margin, 44)];
        _modifyNameTextField.backgroundColor = [UIColor clearColor];
        _modifyNameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _modifyNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        if ([AcountManager manager].userName) {
            _modifyNameTextField.text = [AcountManager manager].userMobile;
        }
    }
    return _modifyNameTextField;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(margin,CGRectGetMaxY(self.modifyNameTextField.frame), kSystemWide - margin, 0.5)];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}
- (UITextField *)confirmTextField {
    if (_confirmTextField == nil) {
        _confirmTextField = [[UITextField alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.lineView.frame), kSystemWide - margin, 49)];
        _confirmTextField.tag = 103;
        _confirmTextField.placeholder = @"请输入验证码";
        _confirmTextField.font = [UIFont systemFontOfSize:14];
        //        _confirmTextField.textColor = JZ_FONTCOLOR_DRAK;
        _confirmTextField.keyboardType = UIKeyboardTypeNumberPad;
        _confirmTextField.backgroundColor = [UIColor clearColor];
        
        
    }
    return _confirmTextField;
}
- (UIButton *)gainNum {
    if (_gainNum == nil) {
        _gainNum = [UIButton buttonWithType:UIButtonTypeCustom];
        _gainNum.frame = CGRectMake(kSystemWide - 100 - 16, 5, 100, 34);
        _gainNum.backgroundColor = YBNavigationBarBgColor;
        [_gainNum addTarget:self action:@selector(sendYanZhengMa:) forControlEvents:UIControlEventTouchUpInside];
        _gainNum.titleLabel.font = [UIFont systemFontOfSize:14];
        _gainNum.layer.masksToBounds = YES;
        _gainNum.layer.cornerRadius = 4;
        [_gainNum setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return _gainNum;
}

- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"保存" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (UIButton *)naviBarLeftButton {
    if (_naviBarLeftButton == nil) {
        _naviBarLeftButton = [WMUITool initWithTitle:@"取消" withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarLeftButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarLeftButton addTarget:self action:@selector(clickLeft:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarLeftButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"手机号码绑定";
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    //
    //    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarLeftButton];
    //    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    [self.bgView addSubview:self.modifyNameTextField];
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.confirmTextField];
    [self.confirmTextField addSubview:self.gainNum];
    [self.view addSubview:self.bgView];
    
    //    [self.modifyNameTextField becomeFirstResponder];
}
- (void)clickLeft:(UIButton *)sender {
    if (self.modifyNameTextField.text == nil || self.modifyNameTextField.text.length == 0) {
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)isValidateMobile:(NSString *)mobile
{
    //    NSString *regex = @"^((17[0-9])|(13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSString *regex = @"^(1[0-9])\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobile];
    return isMatch;
}
- (void)clickRight:(UIButton *)sender {
    //
    
    BOOL isRight = [self isValidateMobile:_modifyNameTextField.text];
    if (!isRight) {
        
        [self obj_showTotasViewWithMes:@"请输入正确的手机号码"];
        
        return;
    }
    if (_confirmTextField.text == nil || [_confirmTextField.text isEqualToString:@""]) {
        
        [self obj_showTotasViewWithMes:@"请输入验证码"];
        return;
    }
    NSDictionary *param = @{@"smscode":self.confirmTextField.text,@"mobile":self.modifyNameTextField.text,@"usertype":@1};
    //    coachChangePhoneNumber:_modifyNameTextField.text smscode:_confirmTextField.text userType:2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSString *kupdateMobileNum = [NSString stringWithFormat:BASEURL,kuserUpdateMobileNum];
    NSLog(@"kupdateMobileNum = %@",kupdateMobileNum);
    
    [JENetwoking startDownLoadWithUrl:kupdateMobileNum postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        NSDictionary *dataParam = data;
        NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
        
        if ([dataParam[@"type"] integerValue] == 1) {
            
            [self obj_showTotasViewWithMes:@"修改成功"];
            
            [AcountManager saveUserPhoneNum:self.modifyNameTextField.text];
            
            [NSUserStoreTool storeWithId:self.modifyNameTextField.text WithKey:@"mobile"];
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:kPhoneNumChange object:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            
            [self obj_showTotasViewWithMes:msg];
        }
        
        
    } withFailure:^(id data) {
        
        
        [self obj_showTotasViewWithMes:@"网络错误"];
    }];
    
    
    
    
    
    
    
    
}
#define TIME 60
#pragma mark 发送验证码
- (void)sendYanZhengMa:(UIButton *)sender
{
    
    if (self.modifyNameTextField.text == nil || self.modifyNameTextField.text.length <= 0) {
        [self obj_showTotasViewWithMes:@"请输入手机号"];
        return;
        
    }else {
        
        if (![AcountManager isValidateMobile:self.modifyNameTextField.text]) {
            [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
            return;
        }
        
        NSString *urlString = [NSString stringWithFormat:@"code/%@",self.modifyNameTextField.text];
        NSString *codeUrl = [NSString stringWithFormat:BASEURL,urlString];
        
        [JENetwoking startDownLoadWithUrl:codeUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            [self obj_showTotasViewWithMes:@"发送成功"];
            [self.confirmTextField becomeFirstResponder];
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
                _gainNum.backgroundColor = YBNavigationBarBgColor;
                [self.gainNum setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.gainNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.gainNum.userInteractionEnabled = YES;
            });
        }else {
            NSString *str = [NSString stringWithFormat:@"剩余(%d)s",count];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.gainNum.backgroundColor = [UIColor colorWithHexString:@"fb7064"];
                [self.gainNum setTitleColor:[UIColor colorWithHexString:@"fedbd8"] forState:UIControlStateNormal];
                [self.gainNum setTitle:str forState:UIControlStateNormal];
                
            });
            count--;
        }
    });
    dispatch_resume(timer);
}
@end
