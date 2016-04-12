//
//  YBSubjectQuestionsHeader.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectQuestionsHeader.h"
#import "YBSubjectData.h"
#import "YBSubjectQuestionHeadCountentView.h"

@interface YBSubjectQuestionsHeader()

@property (nonatomic,strong) UIView *headView;

@property (nonatomic,strong) UIImageView *typeImg;

@property (nonatomic,strong) YBSubjectQuestionHeadCountentView *contentView;

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
        
        _contentView = [[YBSubjectQuestionHeadCountentView alloc] init];
        _contentView.hidden = YES;
        [self addSubview:_contentView];
        
    }
    return self;
}

- (void)setData:(YBSubjectData *)data
{
    _data = data;
    NSLog(@"_data.img_url:%@ _data.video_url:%@",_data.img_url,_data.video_url);
    // // 1:正确错误 2：单选4个选项 3：4个选项,多选
    if (_data.type==1) {
        _typeImg.image = [UIImage imageNamed:@"YBStudySubjectpattern_judgeselect"];
    }else if (_data.type==2){
        _typeImg.image = [UIImage imageNamed:@"YBStudySubjectpattern_radioiselect"];
    }else if (_data.type==3){
        _typeImg.image = [UIImage imageNamed:@"YBStudySubjectpattern_multiselect"];
    }
    
    NSString *title = [NSString stringWithFormat:@"%d、%@",(int)self.currentPage,data.question];
    CGFloat sizeH = [title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kSystemWide - 15 - 24 - 10 - 15, MAXFLOAT)].height + 20;

    NSLog(@"sizeH:%f",sizeH);
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(sizeH);
    }];
    
    [_typeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(14);
        make.centerY.mas_equalTo(_titleLable.mas_centerY);
    }];
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeImg.mas_right).offset(10);
        make.right.mas_equalTo(self).offset(-15);
        make.centerY.mas_equalTo(_headView.centerY);
    }];
    
    // 如果有图片、视频的话多加 185
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeImg.mas_left);
        make.right.mas_equalTo(self).offset(-15);
        make.top.mas_equalTo(_headView.mas_bottom);
        make.height.mas_equalTo(175);
    }];
    
    if (_data.img_url || _data.video_url) {
    
        _contentView.hidden = NO;
        _contentView.data = _data;

    }
        
}

@end
