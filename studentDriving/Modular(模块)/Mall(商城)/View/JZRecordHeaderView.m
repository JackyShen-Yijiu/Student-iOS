//
//  JZRecordHeaderView.m
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZRecordHeaderView.h"

@interface JZRecordHeaderView ()


@property (nonatomic, strong) UIImageView *flagImageView;

@property (nonatomic, strong) UIView *lineView;

@end




@implementation JZRecordHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.flagImageView];
    [self.flagImageView addSubview:self.lineView];
}
- (void)layoutSubviews{
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
         make.left.mas_equalTo(self.mas_left);
         make.bottom.mas_equalTo(self.mas_bottom);
         make.right.mas_equalTo(self.mas_right);
        
       
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.flagImageView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.flagImageView.mas_left).offset(0);
        make.right.mas_equalTo(self.flagImageView.mas_right).offset(0);
        make.height.mas_equalTo(@0.5);
    }];

    
}
- (UIImageView *)flagImageView{
    if (_flagImageView == nil) {
        _flagImageView = [[UIImageView alloc] init];
        _flagImageView.backgroundColor = [UIColor clearColor];
        _flagImageView.image = [UIImage imageNamed:@"exchange_success"];
    }
    return _flagImageView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}
@end
