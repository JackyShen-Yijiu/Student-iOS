//
//  YBSubjectQuestionRightButton.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectQuestionRightButton.h"

#define imgW 18
#define imgH 18

@implementation YBSubjectQuestionRightButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    CGFloat titleW = self.width;
    CGFloat titleH = 10;
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height - titleH - 3;
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = imgW;
    CGFloat imageH = imgH;
    CGFloat imageX = contentRect.size.width/2-imageW/2;
    CGFloat imageY = 3;
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}

@end
