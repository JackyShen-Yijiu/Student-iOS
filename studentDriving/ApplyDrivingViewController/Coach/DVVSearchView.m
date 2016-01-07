//
//  DVVSearchView.m
//  studentDriving
//
//  Created by 大威 on 16/1/6.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVSearchView.h"

@interface DVVSearchView ()

@property (nonatomic, copy) DVVSearchViewUITextFieldDelegateBlock didBeginEditingBlock;
@property (nonatomic, strong) DVVSearchViewUITextFieldDelegateBlock didEndEditingBlock;

@end
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
    // 搜索按钮在中心显示
    _searchButton.frame = CGRectMake((viewWidth - searchButtonWidth) / 2.f, 0, searchButtonWidth, viewHeight);
    
    [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _textField.font = [UIFont systemFontOfSize:13];
    
    _backgroundImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    _textField.tintColor = [UIColor grayColor];
    // 设置背景视图为圆角
    [_backgroundImageView.layer setMasksToBounds:YES];
    [_backgroundImageView.layer setCornerRadius:radius];
    
//    _textField.backgroundColor = [UIColor redColor];
//    _searchButton.backgroundColor = [UIColor orangeColor];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // 回调
    if (_didBeginEditingBlock) {
        _didBeginEditingBlock(textField);
    }
    [UIView animateWithDuration:0.2 animations:^{
        
        // 搜索按钮在左侧显示
        CGFloat viewWidth = self.bounds.size.width;
        CGFloat viewHeight = self.bounds.size.height;
//        CGFloat radius = viewHeight / 2.f;
        CGFloat searchButtonWidth = 40;
        _searchButton.frame = CGRectMake(viewWidth - searchButtonWidth, 0, searchButtonWidth, viewHeight);
    } completion:^(BOOL finished) {
        _textField.placeholder = @"请输入搜索内容";
        _searchButton.userInteractionEnabled = YES;
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (_didEndEditingBlock) {
        _didEndEditingBlock(textField);
    }
    // 如果textField内容不为空时则搜索按钮不回到中心，还可以响应用户点击
    if (textField.text.length) {
        return ;
    }
    
    _textField.placeholder = @"";
    [UIView animateWithDuration:0.2 animations:^{
        
        // 搜索按钮在中心显示
        CGFloat viewWidth = self.bounds.size.width;
        CGFloat viewHeight = self.bounds.size.height;
        CGFloat searchButtonWidth = 40;
        _searchButton.frame = CGRectMake((viewWidth - searchButtonWidth) / 2.f, 0, searchButtonWidth, viewHeight);
    } completion:^(BOOL finished) {
        
        _searchButton.userInteractionEnabled = NO;
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark set block
- (void)setDVVTextFieldDidBeginEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle {
    _didBeginEditingBlock = handle;
}
- (void)setDVVTextFieldDidEndEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle {
    _didEndEditingBlock = handle;
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
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeDefault;
    }
    return _textField;
}
- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [UIButton new];
        _searchButton.userInteractionEnabled = NO;
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
