//
//  DVVHorizontalScrollImagesCell.m
//  DVVTest_内容横向滑动的CollectionView
//
//  Created by 大威 on 16/1/20.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import "DVVHorizontalScrollImagesCell.h"

@implementation DVVHorizontalScrollImagesCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

@end
