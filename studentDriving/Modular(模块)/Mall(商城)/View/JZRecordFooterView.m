//
//  JZRecordFooterView.m
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZRecordFooterView.h"

@interface JZRecordFooterView ()

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIImageView *codeImageView;

@property (nonatomic, strong) UILabel *stateLable;

@end




@implementation JZRecordFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.titleLable];
    [self addSubview:self.addressLabel];
    [self addSubview:self.codeImageView];
    [self addSubview:self.stateLable];
}
- (void)layoutSubviews{
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(14);
        
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLable.mas_bottom).offset(12);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(14);
        
    }];
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressLabel.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(174);
        make.width.mas_equalTo(174);
        
    }];
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeImageView.mas_bottom).offset(12);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(16);
        
    }];

}
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.text = @"请出示二维码 扫码领取";
        _titleLable.font = [UIFont systemFontOfSize:14];
        _titleLable.textColor = JZ_FONTCOLOR_DRAK;
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}
- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"领取地点: 北京致远驾校前厅超市";
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = JZ_FONTCOLOR_DRAK;
        _addressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _addressLabel;
}
- (UIImageView *)codeImageView{
    if (_codeImageView == nil) {
        _codeImageView = [[UIImageView alloc] init];
        _codeImageView.backgroundColor = [UIColor grayColor];
    }
    return _codeImageView;
}
- (UILabel *)stateLable{
    if (_stateLable == nil) {
        _stateLable = [[UILabel alloc] init];
        _stateLable.text = @"未领取";
        _stateLable.font = [UIFont systemFontOfSize:16];
        _stateLable.textColor = YBNavigationBarBgColor;
        _stateLable.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLable;
}


@end
