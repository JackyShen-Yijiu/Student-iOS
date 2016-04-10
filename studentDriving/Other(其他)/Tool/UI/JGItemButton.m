//
//  JGItemButton.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JGItemButton.h"

@implementation JGItemButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleX = 8;
    CGFloat titleY = 0;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 10;
    CGFloat imageH = 5;
    CGFloat imageX = self.frame.size.width-imageW-5;
    CGFloat imageY = self.frame.size.height/2-imageH/2;
    return CGRectMake(imageX, imageY, imageW, imageH);
}


@end
