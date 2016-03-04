//
//  DVVBaseTextField.m
//  DVVBaseTextField
//
//  Created by 大威 on 16/3/4.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import "DVVBaseTextField.h"

#define VIEW_HEIGHT 44.0f
#define FONT [UIFont systemFontOfSize:14]
#define FOREGROUND_COLOR [UIColor whiteColor]
#define CORNER_RADIUS 9

@interface DVVBaseTextField ()

@property (nonatomic, strong) UIImageView *leftImageView;

@end

@implementation DVVBaseTextField

#pragma mark - init
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (instancetype)initWithLeftImage:(UIImage *)leftImage
                      placeholder:(NSString *)placeHolder
                      borderColor:(UIColor *)borderColor {
    self = [super init];
    if (self) {
        
        [self initSelfWithLeftImage:leftImage placeholder:placeHolder borderColor:borderColor cornerRadius:CORNER_RADIUS];
    }
    return self;
}

- (instancetype)initWithLeftImage:(UIImage *)leftImage
                      placeholder:(NSString *)placeHolder
                      borderColor:(UIColor *)borderColor
                     cornerRadius:(CGFloat)cornerRadius {
    self = [super init];
    if (self) {
        [self initSelfWithLeftImage:leftImage placeholder:placeHolder borderColor:borderColor cornerRadius:cornerRadius];
    }
    return self;
}

- (void)initSelfWithLeftImage:(UIImage *)leftImage
                  placeholder:(NSString *)placeHolder
                  borderColor:(UIColor *)borderColor
                 cornerRadius:(CGFloat)cornerRadius{
    
    [self initSelf];
    
    if (leftImage) {
        self.leftImage = leftImage;
    }
    
    if (placeHolder && placeHolder.length) {
        self.placeHolderString = placeHolder;
    }
    
    if (borderColor) {
        self.borderColor = borderColor;
    }
    
    [self.layer setCornerRadius:cornerRadius];
}

- (void)initSelf {
    
    // 圆角
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:18];
    // 边框
    [self.layer setBorderWidth:1];
    [self.layer setBorderColor:FOREGROUND_COLOR.CGColor];
    
    // 光标颜色
    self.tintColor = FOREGROUND_COLOR;
    
    // 文字颜色
    self.textColor = FOREGROUND_COLOR;
    // 字体大小
    self.font = FONT;
    
    // 总是显示leftView
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!_placeHolderColor) {
        [self setValue:FOREGROUND_COLOR forKeyPath:@"placeholderLabel.textColor"];
    }
    if (!_placeHolderFont) {
        [self setValue:FONT forKeyPath:@"_placeholderLabel.font"];
    }
}

#pragma mark - set method

- (void)setLeftImage:(UIImage *)leftImage {
    _leftImage = leftImage;
    
    self.leftImageView.image = _leftImage;
    _leftImageView.bounds = CGRectMake(0, 0, VIEW_HEIGHT, VIEW_HEIGHT);
    self.leftView = _leftImageView;
}

- (void)setPlaceHolderString:(NSString *)placeHolderString {
    _placeHolderString = placeHolderString;
    
    self.placeholder = _placeHolderString;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self.layer setBorderColor:_borderColor.CGColor];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    _placeHolderColor = placeHolderColor;
    
    [self setValue:_placeHolderColor forKeyPath:@"placeholderLabel.textColor"];
}

- (void)setPlaceHolderFont:(UIFont *)placeHolderFont {
    _placeHolderFont = placeHolderFont;
    
    [self setValue:_placeHolderFont forKeyPath:@"_placeholderLabel.font"];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    
    [self.layer setCornerRadius:_cornerRadius];
}

#pragma mark - lazy laod

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [UIImageView new];
        _leftImageView.contentMode = UIViewContentModeCenter;
    }
    return _leftImageView;
}

- (CGFloat)defaultHeight {
    return VIEW_HEIGHT;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
