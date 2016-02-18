//
//  DVVStarView.m
//  studentDriving
//
//  Created by 大威 on 16/2/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVStarView.h"

@implementation DVVStarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _backgroundImageView = [UIImageView new];
        _backgroundImageView.contentMode = UIViewContentModeLeft;
        [self addSubview:_backgroundImageView];
        _foregroundImageView = [UIImageView new];
        _foregroundImageView.contentMode = UIViewContentModeLeft;
        [self addSubview:_foregroundImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _backgroundImageView.frame = self.bounds;
    _foregroundImageView.frame = self.bounds;
}

- (void)dvv_setBackgroundImage:(NSString *)background
               foregroundImage:(NSString *)foreground
                         width:(CGFloat)width
                        height:(CGFloat)height {
    _backgroundImageView.image = [UIImage imageNamed:background];
    _foregroundImage = [UIImage imageNamed:foreground];
    _size = CGSizeMake(width, height);
}

//设置星级
- (void)dvv_setStar:(CGFloat)starValue {
    CGFloat biLi = starValue * 2.f / 10.f;
    
    UIImage *image = [self resizeImage:_foregroundImage newSize:_size];
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    rect.size.width *= biLi;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *catImage = [UIImage imageWithCGImage:imageRef];
    
    _foregroundImageView.image = catImage;
}

//改变图片的大小
- (UIImage *)resizeImage:(UIImage *)image newSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    CGRect rect;
    rect.origin = CGPointMake(0, 0);
    rect.size = newSize;
    [image drawInRect:rect];
    UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizeImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
