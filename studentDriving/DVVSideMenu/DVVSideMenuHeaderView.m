//
//  DVVSideMenuHeaderView.m
//  DVVSideMenu
//
//  Created by 大威 on 15/12/22.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "DVVSideMenuHeaderView.h"

@implementation DVVSideMenuHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.iconButton];
        [self addSubview:self.nameLabel];
        [self addSubview:self.drivingNameLabel];
        [self addSubview:self.markLabel];
//        [self addSubview:self.integralLabel];
        [self addSubview:self.coinCertificateLabel];
        
        _nameLabel.text = @"用户名";
        _drivingNameLabel.text = @"驾校：未报考";
        _markLabel.text = @"我的Y码：暂无";
//        [self setIntegralLabelText:@"0"];
        _coinCertificateLabel.text = @"暂无兑换券";
    }
    return self;
}

- (void)setIntegralLabelText:(NSString *)string {
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@豆币",string]];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:(NSRange){ attributeStr.length - 2, 2 }];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:(NSRange){ attributeStr.length - 2, 2 }];
    self.integralLabel.attributedText = attributeStr;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _iconButton.frame = CGRectMake(15, 20 + 15, 60, 60);
    [_iconButton.layer setCornerRadius:30];
    
    CGFloat minX = CGRectGetMaxX(self.iconButton.frame) + 5;
    CGFloat labelWidth = self.bounds.size.width - minX;
    CGFloat labelHeight = 20;
    self.nameLabel.frame = CGRectMake(minX,
                                      CGRectGetMinY(self.iconButton.frame),
                                      labelWidth,
                                      labelHeight);
    self.drivingNameLabel.frame = CGRectMake(minX, CGRectGetMaxY(self.nameLabel.frame), labelWidth, labelHeight);
    self.markLabel.frame = CGRectMake(minX, CGRectGetMaxY(self.drivingNameLabel.frame), labelWidth, labelHeight);
    CGFloat iconButtonMaxY = CGRectGetMaxY(self.iconButton.frame);
    CGFloat iconButtonMinX = CGRectGetMinX(self.iconButton.frame);
    self.integralLabel.frame = CGRectMake(iconButtonMinX, iconButtonMaxY + 20, labelWidth, 30);
    self.coinCertificateLabel.frame = CGRectMake(15, iconButtonMaxY + 10, self.bounds.size.width - 15, 30);
}

#pragma mark - lazy load
- (UIButton *)iconButton {
    if (!_iconButton) {
        _iconButton = [UIButton new];
        _iconButton.backgroundColor = [UIColor whiteColor];
        [_iconButton.layer setMasksToBounds:YES];
    }
    return _iconButton;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textAlignment = 0;
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}

- (UILabel *)drivingNameLabel {
    if (!_drivingNameLabel) {
        _drivingNameLabel = [UILabel new];
        _drivingNameLabel.font = [UIFont systemFontOfSize:12];
        _drivingNameLabel.textColor = [UIColor whiteColor];
    }
    return _drivingNameLabel;
}

- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [UILabel new];
        _markLabel.font = [UIFont systemFontOfSize:12];
        _markLabel.textColor = [UIColor whiteColor];
    }
    return _markLabel;
}
- (UILabel *)integralLabel {
    if (!_integralLabel) {
        _integralLabel = [UILabel new];
        _integralLabel.font = [UIFont systemFontOfSize:24];
        _integralLabel.textColor = [UIColor redColor];
    }
    return _integralLabel;
}
- (UILabel *)integralMarkLabel {
    if (!_integralMarkLabel) {
        _integralMarkLabel = [UILabel new];
        _integralMarkLabel.font = [UIFont systemFontOfSize:14];
        _integralMarkLabel.textColor = [UIColor whiteColor];
    }
    return _integralMarkLabel;
}
- (UILabel *)coinCertificateLabel {
    if (!_coinCertificateLabel) {
        _coinCertificateLabel = [UILabel new];
        _coinCertificateLabel.font = [UIFont systemFontOfSize:16];
        _coinCertificateLabel.textColor = [UIColor whiteColor];
    }
    return _coinCertificateLabel;
}

- (CGFloat)defaultHeight {
    return 130;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
