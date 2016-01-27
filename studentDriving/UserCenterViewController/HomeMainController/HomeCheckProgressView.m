
//
//  HomeCheckProgressView.m
//  studentDriving
//
//  Created by ytzhang on 16/1/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "HomeCheckProgressView.h"
#import <Masonry.h>
@interface HomeCheckProgressView ()



@end

@implementation HomeCheckProgressView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];

        
    }
    return self;
}

- (void)initUI{
    self.groundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight)];
    self.groundView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
    [self.groundView addSubview:self.bgView];
    [self.bgView addSubview:self.imgView];
    [self.bgView addSubview:self.topLabel];
    [self.bgView addSubview:self.bottomLabel];
    [self.bgView addSubview:self.rightButtton];
    [self.bgView addSubview:self.wrongButton];
    [self addSubview:self.groundView];

}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.groundView.mas_left).with.offset(20);
        make.right.mas_equalTo(self.groundView.mas_right).with.offset(-20);
        make.centerY.mas_equalTo(self.groundView.mas_centerY);
        make.height.mas_equalTo(@210);
        
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).with.offset(25);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@65);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
    }];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).with.offset(20);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.width.mas_equalTo(@300);
        make.height.mas_equalTo(@20);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLabel.mas_bottom).with.offset(5);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.width.mas_equalTo(@300);
        make.height.mas_equalTo(@20);
    }];
    [self.rightButtton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).with.offset(4);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).with.offset(-10);
        NSNumber *wide = [NSNumber numberWithFloat:((kSystemWide - 45) / 2)];
        make.width.equalTo(wide);
        make.top.mas_equalTo(self.bottomLabel.mas_bottom).with.offset(15);
        
    }];
    [self.wrongButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rightButtton.mas_right).with.offset(7);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).with.offset(-10);
        make.top.mas_equalTo(self.bottomLabel.mas_bottom).with.offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).with.offset(-4);
        
    }];


}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setMasksToBounds:YES];
        [_bgView.layer setCornerRadius:5];
        
    }
    return _bgView;
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"question_mark"];
        
    }
    return _imgView;
}
- (UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.text = @"闲着也是闲着,小步与您玩个小游戏吧!";
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont systemFontOfSize:12];
    }
    return _topLabel;
}
- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.text = @"小步猜您已经在学车了,亲对吗?";
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.font = [UIFont systemFontOfSize:12];
    }
    return _bottomLabel;
}

- (UIButton *)rightButtton {
    if (_rightButtton == nil) {
        _rightButtton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_rightButtton setTitle:@"猜对了,你真聪明" forState:UIControlStateNormal];
        [_rightButtton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         _rightButtton.backgroundColor = MAINCOLOR;
        _rightButtton.titleLabel.font = [UIFont systemFontOfSize:15];
        _rightButtton.layer.borderColor = MAINCOLOR.CGColor;
        _rightButtton.layer.borderWidth = 1;
        _rightButtton.layer.cornerRadius = 2;
        _rightButtton.tag = 200;
        _rightButtton.userInteractionEnabled = YES;
        [_rightButtton addTarget:self action:@selector(dikClickBackTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButtton;
}
- (UIButton *)wrongButton {
    if (_wrongButton == nil) {
        _wrongButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_wrongButton setTitle:@"笨死了,答错了" forState:UIControlStateNormal];
        [_wrongButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _wrongButton.backgroundColor = [UIColor whiteColor];
        _wrongButton.titleLabel.font = [UIFont systemFontOfSize:15];
       _wrongButton.layer.borderColor = MAINCOLOR.CGColor;
        _wrongButton.layer.borderWidth = 1;
        _wrongButton.layer.cornerRadius = 2;
        _wrongButton.tag = 201;
//        [_wrongButton addTarget:self action:@selector(dikClickBack:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _wrongButton;
}

#pragma mark --- action
- (void)dikClickBackTouch:(UIButton *)btn
{
    
    
//    if (_didClickBlock) {
//        _didClickBlock(btn.tag);
//    }
}

@end
