//
//  YBAppointmentSectionHeaderView.m
//  studentDriving
//
//  Created by 大威 on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointmentSectionHeaderView.h"

@implementation YBAppointmentSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        self.backgroundView = view;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.button];
        [self.contentView addSubview:self.statusLabel];
        [self.contentView addSubview:self.lineImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    
    _titleLabel.frame = CGRectMake(16, 0, size.width/2.0, size.height);
    _arrowImageView.frame = CGRectMake(size.width - 14 - 12*2, 0, 14 + 12*2, size.height);
    _button.frame = self.bounds;
    _statusLabel.frame = CGRectMake(size.width - 14 - 14, 0, 14, size.height);
    _lineImageView.frame = CGRectMake(0, size.height - 0.5, size.width, 0.5);
    
//    _titleLabel.backgroundColor = [UIColor orangeColor];
//    _arrowImageView.backgroundColor = [UIColor redColor];
//    _button.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
}

#pragma mark - lazy load

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
    return _titleLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.contentMode = UIViewContentModeCenter;
        _arrowImageView.image = [UIImage imageNamed:@"more_right"];
    }
    return _arrowImageView;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton new];
    }
    return _button;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.font = [UIFont systemFontOfSize:14];
        _statusLabel.text = @"无";
    }
    return _statusLabel;
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }
    return _lineImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
