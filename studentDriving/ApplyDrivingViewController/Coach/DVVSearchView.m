//
//  DVVSearchView.m
//  studentDriving
//
//  Created by 大威 on 16/1/6.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVSearchView.h"

@implementation DVVSearchView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.textField];
        [self addSubview:self.searchButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat radius = viewHeight / 2.f;
    CGFloat searchButtonWidth = 40;
    _backgroundImageView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    _textField.frame = CGRectMake(radius, 0, viewWidth - radius - searchButtonWidth + 8, viewHeight);
    _searchButton.frame = CGRectMake(viewWidth - searchButtonWidth, 0, searchButtonWidth, viewHeight);
    
    [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
    
    _backgroundImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    _textField.tintColor = [UIColor lightGrayColor];
    // 设置背景视图为圆角
    [_backgroundImageView.layer setMasksToBounds:YES];
    [_backgroundImageView.layer setCornerRadius:radius];
    
//    _textField.backgroundColor = [UIColor redColor];
//    _searchButton.backgroundColor = [UIColor orangeColor];
}

#pragma mark - lazy load
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
    }
    return _backgroundImageView;
}
- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.keyboardType = UIKeyboardTypeDefault;
    }
    return _textField;
}
- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [UIButton new];
    }
    return _searchButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
