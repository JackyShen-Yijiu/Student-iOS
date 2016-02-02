//
//  SignUpInfoCell.m
//  studentDriving
//
//  Created by ytzhang on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SignUpInfoCell.h"
#import "ToolHeader.h"
@interface SignUpInfoCell ()<UITextFieldDelegate>
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UILabel *signUpLabel;

@end
@implementation SignUpInfoCell

- (SignUpTextField *)signUpTextField {
    if (_signUpTextField == nil) {
        _signUpTextField = [[SignUpTextField alloc] init];
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
    [self.contentView addSubview:self.signUpTextField];
    [self.signUpTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.top.mas_equalTo(self.contentView.mas_top).offset(17);
        NSNumber *weigh = [[NSNumber alloc] initWithFloat:kSystemWide - 30];
        make.width.mas_equalTo(weigh);
        make.height.mas_equalTo(@45);
        
    }];
}

- (void)receiveTitile:(NSString *)titleString andSignUpBlock:(SIGNUPCOMPLETION)signUpCompletion {
    [self clearCellUIData];
    
    self.signUpLabel.text = titleString;
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
        if (range.location > 10) {
            return NO;
        }
    }
    return YES;
}




@end

