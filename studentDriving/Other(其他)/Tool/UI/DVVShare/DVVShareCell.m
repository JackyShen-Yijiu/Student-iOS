//
//  DVVShareCell.m
//  DVVTestUMSocial
//
//  Created by 大威 on 16/1/19.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import "DVVShareCell.h"

@implementation DVVShareCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        
        // config UI
        CGFloat viewWidth = frame.size.width;
        CGFloat viewHeight = frame.size.height;
        CGFloat labelHeight = 25.f;
        CGRect imageViewFrame = CGRectMake(0, 0, viewWidth, viewHeight - labelHeight);
        CGRect labelFrame = CGRectMake(0, viewHeight - labelHeight, viewWidth, labelHeight);
        _imageView.frame = imageViewFrame;
        _label.frame = labelFrame;
        
//        _imageView.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

#pragma mark lazy load
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeCenter;
        [_imageView.layer setMasksToBounds:YES];
        [_imageView.layer setCornerRadius:5];
    }
    return _imageView;
}
- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.font = [UIFont systemFontOfSize:12];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = 1;
    }
    return _label;
}

@end
