//
//  DVVSignUpDetailPayView.m
//  studentDriving
//
//  Created by 大威 on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVSignUpDetailPayView.h"

@implementation DVVSignUpDetailPayView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubview:self.label];
        [self addSubview:self.button];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGFloat buttonWidth = 88;
    CGFloat buttonHeight = 37;
    
    CGFloat leftMargin = 16.0f;
    CGFloat rightMargin = 14.0f;
    
    _button.frame = CGRectMake(size.width - buttonWidth - rightMargin, (size.height - buttonHeight)/2.f, buttonWidth, buttonHeight);
    _label.frame = CGRectMake(leftMargin, 0, size.width - leftMargin - rightMargin - buttonWidth - 8, size.height);
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.font = [UIFont systemFontOfSize:14];
    }
    return _label;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton new];
        [_button setBackgroundImage:[UIImage imageNamed:@"signUpButton_icon"] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _button;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
