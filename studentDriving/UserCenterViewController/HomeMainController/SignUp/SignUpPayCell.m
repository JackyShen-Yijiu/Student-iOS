//
//  SignUpPayCell.m
//  studentDriving
//
//  Created by ytzhang on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SignUpPayCell.h"

@implementation SignUpPayCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
        [self.contentView addSubview:self.payLineUPButton];
        [self.contentView addSubview:self.payLineUPLabel];
        [self.contentView addSubview:self.payLineDownLabel];
        [self.contentView addSubview:self.payLineDownButton];
    
}
- (void)layoutSubviews{
    
    [self.payLineUPButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15);
        make.width.mas_equalTo(@25);
        make.height.mas_equalTo(@25);
        
    }];
    [self.payLineUPLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(45);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@15);
        
    }];
    [self.payLineDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-50);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@15);
        
    }];

    [self.payLineDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10);
        make.right.mas_equalTo(self.payLineDownButton.mas_left).with.offset(-15);
        make.width.mas_equalTo(@25);
        make.height.mas_equalTo(@25);
        
    }];
    
}
- (UIButton *)payLineUPButton{
    if (_payLineDownButton == nil) {
        _payLineDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payLineDownButton setBackgroundImage:[UIImage imageNamed:@"cancelSelect"] forState:UIControlStateNormal];
        [_payLineDownButton setBackgroundImage:[UIImage imageNamed:@"cancelSelect_click"] forState:UIControlStateSelected];
    }
    return _payLineUPButton;
    
}
- (UIButton *)payLineDownButton{
    if (_payLineDownButton == nil) {
        _payLineDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payLineDownButton setBackgroundImage:[UIImage imageNamed:@"cancelSelect"] forState:UIControlStateNormal];
        [_payLineDownButton setBackgroundImage:[UIImage imageNamed:@"cancelSelect_click"] forState:UIControlStateSelected];
    }
    return _payLineDownButton;
    
}
- (UILabel *)payLineUPLabel{
    if (_payLineUPLabel == nil) {
        _payLineUPLabel = [[UILabel alloc] init];
        _payLineUPLabel.text = @"线上支付";
        _payLineUPLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _payLineUPLabel.font = [UIFont systemFontOfSize:14];
    }
    return _payLineUPLabel;
}
- (UILabel *)payLineDownLabel{
    if (_payLineDownLabel == nil) {
        _payLineDownLabel = [[UILabel alloc] init];
        _payLineDownLabel.text = @"线下支付";
        _payLineDownLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _payLineDownLabel.font = [UIFont systemFontOfSize:14];
    }
    return _payLineDownLabel;
}
@end
