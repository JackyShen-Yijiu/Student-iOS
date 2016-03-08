//
//  CircularMotion.m
//  NubiaMusic
//
//  Created by ma c on 15/9/12.
//  Copyright (c) 2015年 Wei. All rights reserved.
//

#import "CircularMotion.h"
#import "CirclePoint.h"

@interface CircularMotion()

// 圆周运动的对象
@property (nonatomic, strong) UIView * motionView;
// 保存圆周运动的坐标
@property(nonatomic, strong) NSMutableArray *marr;
// 控制圆周运动的计时器
@property(nonatomic, strong) NSTimer *commandTimer;
// 控制停止还是继续
@property(nonatomic, assign) NSInteger playing;
// 保存当前的坐标，所对应的数组的下标
@property(nonatomic, assign) NSInteger num;

@end

@implementation CircularMotion

- (void)circularMotionWithView:(UIView *)view Radius:(CGFloat)radius {
    
    _motionView = view;
    // 做圆周运动的控件原始坐标
    CGPoint viewPoint = _motionView.frame.origin;
    // 把此控件的坐标作为圆周运动的起点
    viewPoint.x -= radius;
    CGPoint centerCircle = viewPoint;
    
    // 初始化数组
    _marr = [NSMutableArray array];
    
    // 保存圆周运动所有的坐标
    for (CGFloat i = 0.f; i<360; i += 1) {
        
        CGPoint point = [CirclePoint circlePointWithCenterCircle:centerCircle Radius:radius Angle:i];
        [_marr addObject:NSStringFromCGPoint(point)];
    }
}

// 开始运动
- (void)startMotionWithTimeInterval:(CGFloat)timeInterval {
    
    if (!_playing) {
        _commandTimer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(commandTimerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_commandTimer forMode:NSDefaultRunLoopMode];
        _playing = 1;
    }
}

// 停止圆周运动
- (void)stopMotion {
    
    if (_playing) {
        [_commandTimer invalidate];
        _playing = 0;
    }
}

// 计时器调用的方法
- (void)commandTimerAction {
    
    if (_num >= _marr.count){
        _num = 0;
    }
    CGRect rect = _motionView.frame;
    rect.origin = CGPointFromString([_marr objectAtIndex:_num]);
    _motionView.frame = rect;
    _num++;
}

@end
