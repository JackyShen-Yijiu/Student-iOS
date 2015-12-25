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
        
        _nameLabel.text = @"哒哒塔塔";
        _drivingNameLabel.text = @"驾校：未报考";
        _markLabel.text = @"我的Y码：1001010101";
    }
    return self;
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
        _drivingNameLabel.font = [UIFont systemFontOfSize:14];
        _drivingNameLabel.textColor = [UIColor whiteColor];
    }
    return _drivingNameLabel;
}

- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [UILabel new];
        _markLabel.font = [UIFont systemFontOfSize:14];
        _markLabel.textColor = [UIColor whiteColor];
    }
    return _markLabel;
}

- (CGFloat)defaultHeight {
    return 110;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
