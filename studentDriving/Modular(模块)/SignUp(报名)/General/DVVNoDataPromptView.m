//
//  DVVNoDataPromptView.m
//  studentDriving
//
//  Created by 大威 on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVNoDataPromptView.h"

@interface DVVNoDataPromptView ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation DVVNoDataPromptView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image {
    
    self = [super init];
    if (self) {
        [self initSelf];
        _titleLabel.text = title;
        _imageView.image = image;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                     subTitle:(NSString *)subTitle {
    self = [super init];
    if (self) {
        [self initSelf];
        _titleLabel.text = title;
        _imageView.image = image;
        _subTitleLabel.text = subTitle;
    }
    return self;
}

- (void)initSelf {
    
    self.backgroundColor = YBMainViewControlerBackgroundColor;
    [self addSubview:self.contentView];
    [_contentView addSubview:self.imageView];
    [_contentView addSubview:self.titleLabel];
    [_contentView addSubview:self.subTitleLabel];
    
//    _imageView.backgroundColor = [UIColor lightGrayColor];
//    _titleLabel.backgroundColor = [UIColor orangeColor];
//    _subTitleLabel.backgroundColor = [UIColor magentaColor];
}

#pragma mark - config UI

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.frame.size.width && !self.frame.size.height) {
        self.frame = self.superview.bounds;
    }
    CGSize size = self.bounds.size;
    CGFloat contentWidth = size.width;
    // 图片的高
    CGFloat imageHeight = 75.0f;
    CGFloat titleTopMargin = 20.0f;
    // 标题的高
    CGFloat titleHeight = 0;
    if (_titleLabel.text && _titleLabel.text.length) {
        titleHeight = 14.0f;
    }
    // 副标题的高
    CGFloat subTitleHeight = 0;
    if (_subTitleLabel.text && _subTitleLabel.text.length) {
        subTitleHeight = 14.0f;
    }
    
    CGFloat contentHeight = imageHeight + titleTopMargin + titleHeight + subTitleHeight;
    
    _contentView.bounds = CGRectMake(0, 0, contentWidth, contentHeight);
    _contentView.center = CGPointMake(size.width / 2.0f, size.height / 2.0f);
    _imageView.frame = CGRectMake(0, 0, contentWidth, imageHeight);
    _titleLabel.frame = CGRectMake(5, imageHeight + titleTopMargin, contentWidth, titleHeight);
    _subTitleLabel.frame = CGRectMake(0, imageHeight + titleTopMargin + titleHeight, contentWidth, subTitleHeight);
    
//    NSLog(@"%f, %f", self.superview.bounds.size.width, self.superview.bounds.size.height);
}

#pragma mark - 从父视图移除（有渐隐动画效果）

- (void)remove {
    
//    [UIView animateWithDuration:0.1 animations:^{
//        self.alpha = 0;
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
    [self removeFromSuperview];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
//    [super willMoveToSuperview:newSuperview];
//    [UIView animateWithDuration:0.3 animations:^{
//        self.alpha = 1;
//    }];
}

#pragma mark - lazy load

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.textColor = [UIColor lightGrayColor];
        _subTitleLabel.font = [UIFont systemFontOfSize:10];
    }
    return _subTitleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
