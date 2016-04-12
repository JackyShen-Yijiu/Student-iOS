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

@interface YBSubjectQuestionHeadCountentView ()
@property (nonatomic,strong) OLImageView *Aimv;
@property (nonatomic ,strong) AVPlayer *player;
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
        [self addSubview:_Aimv];
        
        NSString *subjectImgPath = [YBSubjectPath stringByAppendingFormat:@"/ggtkFile/resources/%@",_data.img_url];
        NSLog(@"subjectImgPath:%@",subjectImgPath);
        NSData *GIFDATA = [NSData dataWithContentsOfFile:subjectImgPath];
        _Aimv.image = [OLImage imageWithData:GIFDATA];
        
    }else if (_data.video_url){
        
        NSString *subjectVedioPath = [YBSubjectPath stringByAppendingFormat:@"/ggtkFile/resources/%@",_data.video_url];
        NSLog(@"subjectVedioPath:%@",subjectVedioPath);
        NSURL *sourceMovieURL = [NSURL fileURLWithPath:subjectVedioPath];
        AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        playerLayer.frame = self.layer.bounds;
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.layer addSublayer:playerLayer];
        [player play];
        
    }

    
}
@end
