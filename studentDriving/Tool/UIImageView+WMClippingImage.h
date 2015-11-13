//
//  UIImageView+WMClippingImage.h
//  BlackCat
//
//  Created by bestseller on 15/9/30.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WMClippingImage)
- (UIImage *)clippingWithSize:(CGSize)imageSize withclippingView:(UIView *)clippingView;
@end
