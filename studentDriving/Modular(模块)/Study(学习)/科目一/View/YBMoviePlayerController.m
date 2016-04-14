//
//  YBMoviePlayerController.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/13.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBMoviePlayerController.h"

@implementation YBMoviePlayerController

+ (instancetype)sharedInstance
{
//    static YBMoviePlayerController *sharedInstance = nil;
//    
//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken,^{
//        
//        sharedInstance = [[self alloc] init];
//
//    });
    
    // 注册一个播放结束的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self];
    
    return [[self alloc] init];
    
}

/**
 @method 播放电影
 */
-(void)playMovie:(NSString *)fileName{
    
    //视频URL
    NSURL *url = [NSURL fileURLWithPath:fileName];
    //视频播放对象
//    _movie = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.contentURL = url;
    self.controlStyle = MPMovieControlStyleNone;
//    [self.view setFrame:CGRectMake(0, 0, kSystemWide-30, 175)];
//    [self addSubview:_movie.view];
    self.initialPlaybackTime = -1;

    [self play];
    
}

#pragma mark -------------------视频播放结束委托--------------------

/*
 @method 当视频播放完毕释放对象
 */
-(void)myMovieFinishedCallback:(NSNotification*)notify
{
    NSLog(@"%s",__func__);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self play];
    });
    
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self stop];
//    [self.view removeFromSuperview];
    
}

@end
