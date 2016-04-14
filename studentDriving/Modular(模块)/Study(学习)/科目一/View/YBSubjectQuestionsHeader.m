//
//  YBSubjectQuestionsHeader.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectQuestionsHeader.h"
#import "YBSubjectData.h"
//#import "YBSubjectQuestionHeadCountentView.h"
#import "OLImageView.h"
#import "OLImage.h"
#import <AVFoundation/AVFoundation.h>

@interface YBSubjectQuestionsHeader()

@property (nonatomic,strong) UIView *headView;

@property (nonatomic,strong) UIImageView *typeImg;

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) OLImageView *Aimv;

@end

@implementation YBSubjectQuestionsHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _headView = [[UIView alloc] init];
        [self addSubview:_headView];
        
        _titleLable = [[UILabel alloc]init];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.numberOfLines = 0;
        _titleLable.font = [UIFont systemFontOfSize:14];
        _titleLable.textColor = [UIColor lightGrayColor];
        [_headView addSubview:_titleLable];
        
        _typeImg = [[UIImageView alloc] init];
        [_headView addSubview:_typeImg];
        
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
        
    }
    return self;
}

- (void)reloadData:(YBSubjectData *)data
{

    // // 1:正确错误 2：单选4个选项 3：4个选项,多选
    if (data.type==1) {
        _typeImg.image = [UIImage imageNamed:@"YBStudySubjectpattern_judgeselect"];
    }else if (data.type==2){
        _typeImg.image = [UIImage imageNamed:@"YBStudySubjectpattern_radioiselect"];
    }else if (data.type==3){
        _typeImg.image = [UIImage imageNamed:@"YBStudySubjectpattern_multiselect"];
    }
    
    NSString *title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage,data.question];
    CGFloat sizeH = [title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kSystemWide - 15 - 24 - 10 - 15, MAXFLOAT)].height + 20;
    
    NSLog(@"sizeH:%f",sizeH);
    
    [_headView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(sizeH);
    }];
    
    [_typeImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(14);
        make.centerY.mas_equalTo(_titleLable.mas_centerY);
    }];
    
    [_titleLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeImg.mas_right).offset(10);
        make.right.mas_equalTo(self).offset(-15);
        make.centerY.mas_equalTo(_headView.centerY);
    }];
    
    self.contentView.hidden = YES;
    
    if (data.video_url || data.img_url) {
        
        self.contentView.hidden = NO;

        // 如果有图片、视频的话多加 185
        [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_typeImg.mas_left);
            make.right.mas_equalTo(self).offset(-15);
            make.top.mas_equalTo(_headView.mas_bottom);
            make.height.mas_equalTo(175);
        }];
        
        if (data.img_url && [data.img_url length]!=0) {
            
            _Aimv = [[OLImageView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide-30, 175)];
            _Aimv.contentMode = UIViewContentModeScaleAspectFit;
            [_contentView addSubview:_Aimv];
            
            NSString *subjectImgPath = [YBSubjectPath stringByAppendingFormat:@"/ggtkFile/resources/%@",data.img_url];
            NSLog(@"subjectImgPath:%@",subjectImgPath);
            NSData *GIFDATA = [NSData dataWithContentsOfFile:subjectImgPath];
            _Aimv.image = [OLImage imageWithData:GIFDATA];
            
        }else if (data.video_url && [data.video_url length]!=0){
            
            // 播放器
            _movie = [[MPMoviePlayerController alloc] init];
            _movie.view.frame = CGRectMake(0, 0, kSystemWide-30, 175);
            
            _movie.controlStyle = MPMovieControlStyleNone;
    
            _movie.repeatMode = MPMovieRepeatModeOne;
    
            _movie.initialPlaybackTime = -1;
            
            [_contentView addSubview:_movie.view];
         
        }
    }
    
}

- (void)playMovie:(YBSubjectData *)data
{
    
    if (data.video_url && [data.video_url length]!=0){
        
        NSString *subjectVedioPath = [YBSubjectPath stringByAppendingFormat:@"/ggtkFile/resources/%@",data.video_url];
        NSLog(@"++++++++++++++subjectVedioPath:%@",subjectVedioPath);
        
        NSURL *url = [NSURL fileURLWithPath:subjectVedioPath];
        _movie.contentURL = url;
        [_movie play];
        
        // 注册一个播放结束的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myMovieFinishedCallback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:_movie];
        
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

- (void)dealloc{
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.movie];
//    [self.movie stop];
//    [self.movie.view removeFromSuperview];
    
}

@end
