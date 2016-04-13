//
//  YBSubjectQuestionHeadCountentView.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectQuestionHeadCountentView.h"
#import "YBSubjectData.h"
#import "OLImageView.h"
#import "OLImage.h"
#import <AVFoundation/AVFoundation.h>
#import "YBMoviePlayerController.h"

@interface YBSubjectQuestionHeadCountentView ()
@property (nonatomic,strong) OLImageView *Aimv;
@property (nonatomic ,strong) MPMoviePlayerController *movie;
@end

@implementation YBSubjectQuestionHeadCountentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 图片
        
        // 播放器
       
        
    }
    return self;
}

- (void)setData:(YBSubjectData *)data
{
    _data = data;
    
    if (_data.img_url) {
        
        _Aimv = [[OLImageView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide-30, 175)];
        _Aimv.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_Aimv];
        
        NSString *subjectImgPath = [YBSubjectPath stringByAppendingFormat:@"/ggtkFile/resources/%@",_data.img_url];
        NSLog(@"subjectImgPath:%@",subjectImgPath);
        NSData *GIFDATA = [NSData dataWithContentsOfFile:subjectImgPath];
        _Aimv.image = [OLImage imageWithData:GIFDATA];
        
    }else if (_data.video_url){
        
        NSString *subjectVedioPath = [YBSubjectPath stringByAppendingFormat:@"/ggtkFile/resources/%@",_data.video_url];
        NSLog(@"subjectVedioPath:%@",subjectVedioPath);
        
        _movie = [[MPMoviePlayerController alloc] init];
        
        _movie.controlStyle = MPMovieControlStyleNone;
        
        //_movie.initialPlaybackTime = -1;
        
        _movie.view.frame = CGRectMake(0, 0, kSystemWide-30, 175);
        
        // 注册一个播放结束的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myMovieFinishedCallback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:_movie];
        
        [self addSubview:_movie.view];
        NSURL *url = [NSURL fileURLWithPath:subjectVedioPath];
        _movie.contentURL = url;
        [_movie play];
        
    }

}


/*
 @method 当视频播放完毕释放对象
 */
-(void)myMovieFinishedCallback:(NSNotification*)notify
{
    NSLog(@"%s notify:%@",__func__,notify);
    MPMoviePlayerController *movie = notify.object;
    
    [UIView animateWithDuration:1.0 animations:^{
        
        [movie play];

    }];

}

- (void)dealloc
{
    
    NSLog(@"%s",__func__);
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.movie];
    //[self.movie stop];
    //[self.movie.view removeFromSuperview];
    
}
@end
