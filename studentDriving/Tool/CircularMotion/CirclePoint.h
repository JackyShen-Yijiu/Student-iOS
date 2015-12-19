//
//  CirclePoint.h
//  得到一个圆圈的所有坐标
//
//  Created by ma c on 15/9/11.
//  Copyright (c) 2015年 Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CirclePoint : NSObject

+ (CGPoint)circlePointWithCenterCircle:(CGPoint)centerCircle Radius:(CGFloat)radius Angle:(CGFloat)angle;

@end
