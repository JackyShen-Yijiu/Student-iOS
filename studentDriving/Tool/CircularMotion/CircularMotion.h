//
//  CircularMotion.h
//  NubiaMusic
//
//  Created by ma c on 15/9/12.
//  Copyright (c) 2015年 Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CircularMotion : NSObject

- (void)circularMotionWithView:(UIView *)view
                        Radius:(CGFloat)radius;

- (void)startMotionWithTimeInterval:(CGFloat)timeInterval;
- (void)stopMotion;

@end
