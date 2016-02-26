//
//  ShowWarningMessageView.m
//  studentDriving
//
//  Created by zyt on 16/2/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ShowWarningMessageView.h"

@interface ShowWarningMessageView ()
@property (nonatomic, strong) UILabel *textMessageLael;
@property (nonatomic, strong) UIImageView *warningImageView;
@end

@implementation ShowWarningMessageView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.textMessageLael];
        [self addSubview:self.warningImageView];
    }
    return self;
}
- (UILabel *)textMessageLael{
    if (_textMessageLael == nil) {
        _textMessageLael = [[UILabel alloc] init];
        _textMessageLael.text = @"您填入的信息有误";
        _textMessageLael.textColor = YBNavigationBarBgColor;
        _textMessageLael.font = [UIFont systemFontOfSize:10];
        _textMessageLael.textAlignment = NSTextAlignmentRight;
        
     }
    return _textMessageLael;
}
- (UIImageView *)warningImageView{
    if (_warningImageView == nil) {
        _warningImageView = [[UIImageView alloc] init];
        _warningImageView.image = [UIImage imageNamed:@"warning_Message"];
    }
    return _warningImageView;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.textMessageLael mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo (@80);
    }];
    [self.warningImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.textMessageLael.mas_right).offset(5);
        make.height.mas_equalTo(@16);
        make.width.mas_equalTo (@18);
    }];
    
    if (self.message&&[self.message length]!=0) {
        _textMessageLael.text = _message;
    }

}
@end
