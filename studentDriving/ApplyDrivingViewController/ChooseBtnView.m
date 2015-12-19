//
//  ChooseBtnView.m
//  chooseView
//
//  Created by 胡东苑 on 15/12/13.
//  Copyright © 2015年 胡东苑. All rights reserved.
//

#import "ChooseBtnView.h"
#import "Masonry.h"

@interface ChooseBtnView ()

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *midBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation ChooseBtnView

- (id)initWithSelectedBtn:(NSInteger)whichBtn leftTitle:(NSString *)leftStr midTitle:(NSString *)midTitle rightTitle:(NSString *)rightStr frame:(CGRect)frame{
    self = [super init];
    if (self) {
        self.frame = frame;
        [self addUI];
        [self configeUI:whichBtn leftTitle:leftStr midTitle:midTitle rightTitle:rightStr];
        [self setUpUI];
    }
    return self;
}

- (void)addUI {
    _leftBtn = [[UIButton alloc] init];
    _midBtn = [[UIButton alloc] init];
    _rightBtn = [[UIButton alloc] init];
    [self addSubview:_leftBtn];
    [self addSubview:_midBtn];
    [self addSubview:_rightBtn];
}

- (void)configeUI:(NSInteger)whichBtn leftTitle:(NSString *)leftStr midTitle:(NSString *)midTitle rightTitle:(NSString *)rightStr{
    [_leftBtn setTitle:leftStr forState:UIControlStateNormal];
    [_midBtn setTitle:midTitle forState:UIControlStateNormal];
    [_rightBtn setTitle:rightStr forState:UIControlStateNormal];
    
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _midBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    switch (whichBtn) {
        case 0:{
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"第一框橙"] forState:UIControlStateNormal];
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"第一框橙"] forState:UIControlStateHighlighted];
            [_midBtn setBackgroundImage:[UIImage imageNamed:@"第二框灰"] forState:UIControlStateNormal];
            [_midBtn setBackgroundImage:[UIImage imageNamed:@"第二框灰"] forState:UIControlStateHighlighted];
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"第三框灰"] forState:UIControlStateNormal];
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"第三框灰"] forState:UIControlStateHighlighted];
            [_midBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
            break;
        case 1:{
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"第一框灰"] forState:UIControlStateNormal];
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"第一框灰"] forState:UIControlStateHighlighted];
            [_midBtn setBackgroundImage:[UIImage imageNamed:@"第二框橙"] forState:UIControlStateNormal];
            [_midBtn setBackgroundImage:[UIImage imageNamed:@"第二框橙"] forState:UIControlStateHighlighted];
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"第三框灰"] forState:UIControlStateNormal];
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"第三框灰"] forState:UIControlStateHighlighted];
            [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
            break;
        case 2:{
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"第一框灰"] forState:UIControlStateNormal];
            [_leftBtn setBackgroundImage:[UIImage imageNamed:@"第一框灰"] forState:UIControlStateHighlighted];
            [_midBtn setBackgroundImage:[UIImage imageNamed:@"第二框灰"] forState:UIControlStateNormal];
            [_midBtn setBackgroundImage:[UIImage imageNamed:@"第二框灰"] forState:UIControlStateHighlighted];
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"第三框橙"] forState:UIControlStateNormal];
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"第三框橙"] forState:UIControlStateHighlighted];
            [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_midBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (void)setUpUI {
    __weak typeof(self) weakSelf = self;
    [_midBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 25));
        make.right.mas_equalTo(_midBtn.mas_left).offset(-10);
        make.centerY.mas_equalTo(_midBtn.mas_centerY);
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 25));
        make.left.mas_equalTo(_midBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(_midBtn.mas_centerY);
    }];
}


@end
