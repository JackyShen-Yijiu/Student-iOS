//
//  YBStudeyProgressView.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBStudeyProgressView.h"
#import "KOAProgressBar.h"

@interface YBStudeyProgressView ()

@property (nonatomic,weak) UILabel *progressLabel;


@end

@implementation YBStudeyProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 0, kSystemWide, 47);
        
        self.backgroundColor = RGBColor(232, 232, 232);
        
        // 学习进度
        UILabel *progressLabel = [[UILabel alloc] init];
        progressLabel.text = @"学习进度";
        progressLabel.textColor = [UIColor grayColor];
        progressLabel.font = [UIFont systemFontOfSize:12];
        progressLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:progressLabel];
        self.progressLabel = progressLabel;
        
        // 顶部模拟考试 官方学时 规定学时
        UILabel *topLabel = [[UILabel alloc] init];
        topLabel.textColor = [UIColor grayColor];
        topLabel.font = [UIFont systemFontOfSize:12];
        topLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:topLabel];
        self.topLabel = topLabel;
        
        // 进度条
        KOAProgressBar *progressSliderView = [[KOAProgressBar alloc] init];
        progressSliderView.backgroundColor = RGBColor(189, 189, 189);
        progressSliderView.userInteractionEnabled = NO;
        [progressSliderView setMinValue:0.0];
        [progressSliderView setMaxValue:1.0];
        [progressSliderView setDisplayedWhenStopped:YES];
        [progressSliderView setAnimationDuration:0.0];
        [progressSliderView startAnimation:self];
        [self addSubview:progressSliderView];
        self.progressSliderView = progressSliderView;

        [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(50);
        }];
        
        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.progressLabel.mas_right).offset(10);
            make.top.mas_equalTo(10);
        }];
        
        [self.progressSliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.topLabel);
            make.top.mas_equalTo(self.topLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
            make.width.mas_equalTo(kSystemWide-50-30);
        }];
    }
    return self;
}

@end
