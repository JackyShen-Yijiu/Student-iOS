//
//  JZCoachDetailHeaderCell.m
//  studentDriving
//
//  Created by ytzhang on 16/4/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZCoachDetailHeaderView.h"

@interface JZCoachDetailHeaderView ()

@property (nonatomic, strong) UIView *titleView;



@end

@implementation JZCoachDetailHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.titleView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.arrowImgView];
    [self addSubview:self.lineView];
    
    
}
- (void)layoutSubviews{
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(14);
        make.left.mas_equalTo(self.mas_left).offset(16);
        make.height.mas_equalTo(@16);
        make.width.mas_equalTo(@2);
       
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_top);
        make.left.mas_equalTo(self.titleView.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@14);
        
    }];

    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@16);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@0.5);
        
    }];
    
}
- (UIImageView *)arrowImgView{
    if (_arrowImgView == nil) {
        _arrowImgView = [[UIImageView alloc] init];
        _arrowImgView.image = [UIImage imageNamed:@"more_down"];
        
    }
    return _arrowImgView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"基本信息";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = JZ_FONTCOLOR_DRAK;
    }
    return _titleLabel;
}
- (UIView *)titleView{
    if (_titleView == nil) {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = YBNavigationBarBgColor;
    }
    return _titleView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}
- (void)setIsShowClassTypeDetail:(BOOL)isShowClassTypeDetail{
    if (!isShowClassTypeDetail) {
        
        [UIView animateWithDuration:0.5 animations:^{
          _arrowImgView.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
        }];
    }
}
- (void)setIsShowCommentDetail:(BOOL)isShowCommentDetail{
    if (!isShowCommentDetail) {
        
        [UIView animateWithDuration:0.5 animations:^{
            _arrowImgView.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
        }];
    }

}

@end
