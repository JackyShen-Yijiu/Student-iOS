//
//  GainPasswordViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/25.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "GainPasswordViewController.h"
#import <Masonry/Masonry.h>
#import "ToolHeader.h"
#import "NSString+DY_MD5.h"
static NSString *const kchangePassword = @"kchangePassword";

static NSString *const kchangePasswordUrl = @"/userinfo/updatepwd";

@interface GainPasswordViewController ()
@property (strong, nonatomic) UIButton *accomplishButton;
@property (strong, nonatomic) UITextField *passWordTextFild;
@property (strong, nonatomic) UITextField *affirmTextFild;
@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UIButton *goBackButton;

@end

@implementation GainPasswordViewController

- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont boldSystemFontOfSize:18];
        _topLabel.textColor = RGBColor(51, 51, 51);
        _topLabel.text = @"更改密码";
    }
    return _topLabel;
}
- (UIButton *)goBackButton{
    if (_goBackButton == nil) {
        _goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回_click"] forState:UIControlStateNormal];
        [_goBackButton addTarget:self action:@selector(dealGoBack:) forControlEvents:UIControlEventTouchUpInside];
        [_goBackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _goBackButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _goBackButton;
}
- (UIButton *)accomplishButton{
    if (_accomplishButton == nil) {
        _accomplishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _accomplishButton.backgroundColor = RGBColor(255, 102, 51);
        _accomplishButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_accomplishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_accomplishButton addTarget:self action:@selector(dealNext:) forControlEvents:UIControlEventTouchUpInside];
        [_accomplishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_accomplishButton setTitle:@"完成" forState:UIControlStateNormal];
        
    }
    return _accomplishButton;
}

- (UITextField *)passWordTextFild{
    if (_passWordTextFild == nil) {
        _passWordTextFild = [[UITextField alloc]init];
        _passWordTextFild.tag = 105;
        _passWordTextFild.placeholder = @"    请输入新的密码";
        _passWordTextFild.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _passWordTextFild.layer.borderWidth = 1;
        _passWordTextFild.font  = [UIFont systemFontOfSize:15];
        _passWordTextFild.textColor = RGBColor(153, 153, 153);
        _passWordTextFild.secureTextEntry = YES;
    }
    return _passWordTextFild;
}

- (UITextField *)affirmTextFild{
    if (_affirmTextFild == nil) {
        _affirmTextFild = [[UITextField alloc]init];
        _affirmTextFild.tag = 106;
        _affirmTextFild.placeholder = @"    确认新密码";
        _affirmTextFild.layer.borderColor = RGBColor(204, 204, 204).CGColor;
        _affirmTextFild.layer.borderWidth = 1;
        _affirmTextFild.font  = [UIFont systemFontOfSize:15];
        _affirmTextFild.textColor = RGBColor(153, 153, 153);
        _affirmTextFild.secureTextEntry = YES;

    }
    return _affirmTextFild;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.passWordTextFild];
    [self.view addSubview:self.accomplishButton];
    [self.view addSubview:self.affirmTextFild];
    [self.view addSubview:self.goBackButton];

    
    [self.goBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@50);
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.height.mas_equalTo(@50);
    }];
    
    [self.passWordTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20+55);
        make.height.mas_equalTo(@44);
    }];
    
    [self.affirmTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.passWordTextFild.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
    }];
    
    [self.accomplishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.affirmTextFild.mas_bottom).with.offset(20);
        make.height.mas_equalTo(@44);
    }];
}
- (void)dealNext:(UIButton *)sender {
    
    if (![self.passWordTextFild.text isEqualToString:self.affirmTextFild.text]) {
        [self showTotasViewWithMes:@"请输入相同的密码"];
        return;
    }
      
    NSString *urlString = [NSString stringWithFormat:BASEURL,kchangePasswordUrl];
    
    NSDictionary *param = @{@"smscode":self.confirmString,@"password":[self.passWordTextFild.text DY_MD5],@"mobile":self.mobile};
    
    NSLog(@"param:%@",param);
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSDictionary *resultData = data;
        
        DYNSLog(@"resultData.message = %@",resultData[@"msg"]);
        NSLog(@"data:%@",data);
        
        NSString *type = [NSString stringWithFormat:@"%@",resultData[@"type"]];
        NSLog(@"type:%@",type);
        
        if ([type isEqualToString:@"1"]) {
            
            [self obj_showTotasViewWithMes:@"修改成功"];
            
            [self dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kchangePassword object:nil];
            }];
            
        }else {
            
            [self obj_showTotasViewWithMes:param[@"msg"]];

        }
    }];
    
    
    
}

- (void)dealGoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
