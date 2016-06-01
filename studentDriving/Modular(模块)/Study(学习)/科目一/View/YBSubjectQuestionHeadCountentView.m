//
//  YBSubjectQuestionHeadCountentView.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectQuestionHeadCountentView.h"
#import "YBSubjectData.h"


@interface YBSubjectQuestionHeadCountentView ()

@end

@implementation YBSubjectQuestionHeadCountentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 图片
        
        
    }
    return self;
}

- (void)setData:(YBSubjectData *)data
{
    _data = data;
    
    

}


/*
 @method 当视频播放完毕释放对象
 */
//-(void)myMovieFinishedCallback:(NSNotification*)notify
//{
//    NSLog(@"%s notify:%@",__func__,notify);
//    MPMoviePlayerController *movie = notify.object;
//    
//    [UIView animateWithDuration:1.0 animations:^{
//        
//        [movie play];
//
//    }];
//
//}

- (void)dealloc
{
    
    NSLog(@"%s",__func__);
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.movie];
//    [self.movie stop];
//    [self.movie.view removeFromSuperview];
    
}
@end
