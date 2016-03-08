//
//  CoachHeadCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/22.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "CoachHeadCell.h"
#import "ToolHeader.h"
#import "AppointmentCoachModel.h"
@interface CoachHeadCell ()


@property (strong, nonatomic) UIView *unSelectedBackGroundView;
@property (strong, nonatomic) UIView *selectedBackView;
@end
@implementation CoachHeadCell

- (UIView *)selectedBackView {
    if (_selectedBackView == nil) {
        _selectedBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 78)];
        _selectedBackView.layer.borderWidth = 1;
        _selectedBackView.layer.borderColor = MAINCOLOR.CGColor;
    }
    return _selectedBackView;
}
- (UIView *)unSelectedBackGroundView {
    if (_unSelectedBackGroundView == nil ) {
        _unSelectedBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 78)];
        _unSelectedBackGroundView.layer.borderColor = RGBColor(230, 230, 230).CGColor;
        _unSelectedBackGroundView.layer.borderWidth = 1;
    }
    return _unSelectedBackGroundView;
}

- (UIButton *)coachStateSend {
    if (_coachStateSend == nil) {
        _coachStateSend = [UIButton buttonWithType:UIButtonTypeCustom];
        _coachStateSend.layer.borderColor = MAINCOLOR.CGColor;
        _coachStateSend.layer.borderWidth = 0.8;
        _coachStateSend.layer.cornerRadius = 2;
        _coachStateSend.titleLabel.font  = [UIFont systemFontOfSize:8];
        _coachStateSend.userInteractionEnabled = NO;
        [_coachStateSend setTitle:@"接送" forState:UIControlStateNormal];
        [_coachStateSend setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    }
    return _coachStateSend;
}

- (UIButton *)coachStateAll {
    if (_coachStateAll == nil) {
        _coachStateAll = [UIButton buttonWithType:UIButtonTypeCustom];
        _coachStateAll.layer.borderColor = RGBColor(44, 143, 245).CGColor;
        _coachStateAll.layer.borderWidth = 0.8;
        _coachStateAll.layer.cornerRadius = 2;
        _coachStateAll.titleLabel.font = [UIFont systemFontOfSize:8];
        _coachStateAll.userInteractionEnabled = NO;
        [_coachStateAll setTitle:@"全科" forState:UIControlStateNormal];
        [_coachStateAll setTitleColor:RGBColor(44, 143, 245) forState:UIControlStateNormal];
    }
    return _coachStateAll;
}

- (UILabel *)coachAddress {
    if (_coachAddress == nil) {
        _coachAddress = [WMUITool initWithTextColor:TEXTGRAYCOLOR withFont:[UIFont systemFontOfSize:14]];
        _coachAddress.text = @"北京市海淀区中观村海淀驾校";
    }
    return _coachAddress;
}
- (UILabel *)coachNameLabel {
    if (_coachNameLabel == nil) {
        _coachNameLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont boldSystemFontOfSize:16]];
        _coachNameLabel.text = @"李敏申";
    }
    return _coachNameLabel;
}
- (UIImageView *)coachHeadImageView {
    if (_coachHeadImageView == nil) {
        _coachHeadImageView = [[UIImageView alloc] init];
        _coachHeadImageView.backgroundColor = MAINCOLOR;
    }
    return _coachHeadImageView;
}
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
- (void)createUI {
    
   
    
    [self addSubview:self.coachAddress];
    [self addSubview:self.coachHeadImageView];
    [self addSubview:self.coachNameLabel];
    [self addSubview:self.coachStateAll];
    [self addSubview:self.coachStateSend];
    
        [self.coachHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(9);
            make.top.mas_equalTo(self.mas_top).offset(9);
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(@60);
        }];
    
        [self addSubview:self.coachNameLabel];
    
        [self.coachNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coachHeadImageView.mas_right).offset(5);
            make.top.mas_equalTo(self.coachHeadImageView.mas_top).offset(8);
        }];
    
        [self addSubview:self.coachAddress];
        [self.coachAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coachNameLabel.mas_left).offset(0);
            make.right.mas_equalTo(self.mas_right).offset(5);
            make.top.mas_equalTo(self.coachNameLabel.mas_bottom).offset(7);
        }];
        [self addSubview:self.coachStateSend];
        [self.coachStateSend mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coachNameLabel.mas_right).offset(7);
            make.top.mas_equalTo(self.coachNameLabel.mas_top).offset(2);
            make.width.mas_equalTo(@20);
            make.height.mas_equalTo(@14);
        }];
        [self addSubview:self.coachStateAll];
        [self.coachStateAll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coachStateSend.mas_right).offset(5);
            make.top.mas_equalTo(self.coachNameLabel.mas_top).offset(2);
            make.width.mas_equalTo(@20);
            make.height.mas_equalTo(@14);
        }];
    
    self.backgroundView = self.unSelectedBackGroundView;
    self.selectedBackgroundView = self.selectedBackView;
}
- (void)recevieCoachData:(AppointmentCoachModel *)coachModel {
    
    self.coachNameLabel.text =  nil;
    self.coachAddress.text = nil;
    self.coachHeadImageView.image = nil;
    self.coachNameLabel.text = coachModel.name;
    self.coachAddress.text = coachModel.driveschoolinfo.name;
    [self.coachHeadImageView sd_setImageWithURL:[NSURL URLWithString:coachModel.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
}

@end
