//
//  SignUpOneTableViewCell.m
//  BlackCat
//
//  Created by 董博 on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "SignUpCell.h"

#import "ToolHeader.h"
@interface SignUpCell ()<UITextFieldDelegate>
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UILabel *signUpLabel;
@property (strong, nonatomic) UITextField *signUpTextField;
@end
@implementation SignUpCell

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 44)];
    }
    return _backGroundView;
}
- (UILabel *)signUpLabel {
    if (_signUpLabel == nil) {
        _signUpLabel = [WMUITool initWithTextColor:RGBColor(153, 153, 153) withFont:[UIFont systemFontOfSize:14]];
        _signUpLabel.text = @"真实姓名";
    }
    return _signUpLabel;
}
- (UITextField *)signUpTextField {
    if (_signUpTextField == nil) {
        _signUpTextField = [[UITextField alloc] init];
        _signUpTextField.delegate = self;
        _signUpTextField.returnKeyType = UIReturnKeyDone;
    }
    return _signUpTextField;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self setUp];
    }
    return self;
}

- (void)setUp {
    [self.contentView addSubview:self.backGroundView];
    [self.backGroundView addSubview:self.signUpLabel];
    [self.backGroundView addSubview:self.signUpTextField];
    [self.signUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.centerY.mas_equalTo(self.backGroundView.mas_centerY);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@44);
    }];
    
    [self.signUpTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.signUpLabel.mas_right).offset(0);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.backGroundView.mas_centerY);
        make.height.mas_equalTo(@40);

    }];
}

- (void)receiveTitile:(NSString *)titleString andSignUpBlock:(SIGNUPCOMPLETION)signUpCompletion {
    [self clearCellUIData];
    
    self.signUpLabel.text = titleString;
    if ([titleString isEqualToString:@"验证Y码"]) {
        self.signUpTextField.placeholder = @"(Y码不影响报名!如有Y码,可得丰厚奖励)";
        [self.signUpTextField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    }else {
        self.signUpTextField.placeholder = @"";
    }
    self.signUpCompletion = signUpCompletion;

}

- (void)receiveTextContent:(NSString *)content {
    DYNSLog(@"content = %@",content);
    self.signUpTextField.text = nil;
    self.signUpTextField.text = content;
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.signUpCompletion) {
        self.signUpCompletion(textField.text);
    }
}

- (void)clearCellUIData {
    self.signUpLabel.text = nil;
//    self.signUpTextField.text = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self.signUpLabel.text isEqualToString:@"联系电话"]) {
        if (range.location>10) {
            return NO;
        }
    }else if ([self.signUpLabel.text isEqualToString:@"真实姓名"]) {
        if (range.location>5) {
            return NO;
        }
    }
    return YES;
}


@end
