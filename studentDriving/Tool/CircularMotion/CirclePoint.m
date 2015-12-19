//
//  CirclePoint.m
//  得到一个圆圈的所有坐标
//
//  Created by ma c on 15/9/11.
//  Copyright (c) 2015年 Wei. All rights reserved.
//

#import "CirclePoint.h"

@implementation CirclePoint


//圆点坐标：(x0,y0)
//半径：r
//角度：radius
//
//则圆上任一点为：（x1,y1）
//x1   =   x0   +   r   *   cos(radius   *   3.14   /180   )
//y1   =   y0   +   r   *   sin(radius   *   3.14   /180   )

+ (CGPoint)circlePointWithCenterCircle:(CGPoint)centerCircle Radius:(CGFloat)radius Angle:(CGFloat)angle {
    
    CGFloat cX ; //圆的X坐标轨迹
    CGFloat cY ; //圆的Y坐标轨迹
    
    cX = centerCircle.x + radius * cos(angle * M_PI /180);
    cY = centerCircle.y + radius * sin(angle * M_PI /180);
    
    return CGPointMake(cX, cY);
    
}


@end
