//
//  YBSubjectQuestionsFooter.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectQuestionsFooter.h"
#import "YBSubjectData.h"

@interface YBSubjectQuestionsFooter()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *explainLabel;

@end

@implementation YBSubjectQuestionsFooter

- (UIView *)contentView
{
    if (_contentView==nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIButton *)confimBtn
{
    if (_confimBtn==nil) {
        
        _confimBtn = [[UIButton alloc] init];
        [_confimBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confimBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _confimBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _confimBtn.backgroundColor = YBNavigationBarBgColor;
        [_confimBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confimBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        _confimBtn.layer.masksToBounds = YES;
        _confimBtn.layer.cornerRadius = 3;
        
    }
    return _confimBtn;
}

- (UILabel *)titleLabel
{
    if (_titleLabel==nil) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor colorWithHexString:@"5698fd"];
        _titleLabel.text = @"答案详解";
        
    }
    return _titleLabel;
}

- (UILabel *)explainLabel
{
    if (_explainLabel==nil) {
        
        _explainLabel = [[UILabel alloc]init];
        _explainLabel.textAlignment = NSTextAlignmentLeft;
        _explainLabel.numberOfLines = 0;
        _explainLabel.font = [UIFont systemFontOfSize:14];
        _explainLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        
    }
    return _explainLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.confimBtn];
        [self.confimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self).offset(-15);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(self).offset(-10);
        }];
        
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(0);
        }];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.explainLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(20);
        }];
        
        [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.right.mas_equalTo(self).offset(-15);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        }];
        
    }
    return self;
}

- (void)setData:(YBSubjectData *)data
{
    _data = data;
    
    self.explainLabel.text = [NSString stringWithFormat:@"%@",_data.explain];
    
}

@end

