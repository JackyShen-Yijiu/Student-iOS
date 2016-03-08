//
//  CoachDetailCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "CoachDetailCell.h"
#import "ToolHeader.h"
@interface CoachDetailCell ()<RatingBarDelegate>
@property (strong, nonatomic) UIView *backGroundView;

@property (strong, nonatomic) UIImageView *locationImageView;


@end
@implementation CoachDetailCell

- (UILabel *)locationLabel {
    if (_locationLabel == nil) {
        _locationLabel = [[UILabel alloc] init];
//        _locationLabel.text = @"北京海淀区驾校 AJ787";
        _locationLabel.font = [UIFont systemFontOfSize:14];
        _locationLabel.textColor = [UIColor blackColor];
    }
    return _locationLabel;
}
- (UIImageView *)locationImageView {
    if (_locationImageView == nil) {
        _locationImageView = [[UIImageView alloc] init];
        _locationImageView.image = [UIImage imageNamed:@"locationImage.png"];
    }
    return _locationImageView;
}

- (RatingBar *)starBar {
    if (_starBar == nil) {
        _starBar = [[RatingBar alloc] init];
        [_starBar setImageDeselected:@"starUnSelected.png" halfSelected:nil fullSelected:@"starSelected.png" andDelegate:self];
        _starBar.isIndicator = YES;
        [_starBar displayRating:3];
    }
    return _starBar;
}

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , 106)];
    }
    return _backGroundView;
}
- (UILabel *)coachNameLabel {
    if (_coachNameLabel == nil) {
        _coachNameLabel = [[UILabel alloc] init];
//        _coachNameLabel.text = @"李敏申";
        _coachNameLabel.font = [UIFont boldSystemFontOfSize:16];
        _coachNameLabel.textColor = [UIColor blackColor];
    }
    return _coachNameLabel;
}

- (UIButton *)coachStateSend {
    if (_coachStateSend == nil) {
        _coachStateSend = [UIButton buttonWithType:UIButtonTypeCustom];
        _coachStateSend.hidden = YES;
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
        _coachStateAll.hidden = YES;
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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    
    [self.contentView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.coachNameLabel];
    
    [self.backGroundView addSubview:self.coachStateSend];
    
    [self.backGroundView addSubview:self.coachStateAll];
    
    [self.backGroundView addSubview:self.starBar];
    
    [self.backGroundView addSubview:self.locationImageView];
    
    [self.backGroundView addSubview:self.locationLabel];
    
    [self.coachNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(18);
    }];
    
    [self.coachStateSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coachNameLabel.mas_right).offset(7);
        make.top.mas_equalTo(self.coachNameLabel.mas_top).offset(2);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@14);
    }];
    
    [self.coachStateAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coachStateSend.mas_right).offset(5);
        make.top.mas_equalTo(self.coachNameLabel.mas_top).offset(2);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@14);
    }];
    
    [self.starBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coachNameLabel.mas_left).offset(0);
        make.top.mas_equalTo(self.coachNameLabel.mas_bottom).offset(7);
        make.width.mas_equalTo(@75);
        make.height.mas_equalTo(@15);
    }];
    
    [self.locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coachNameLabel.mas_left).offset(0);
        make.top.mas_equalTo(self.starBar.mas_bottom).offset(12);
        make.width.mas_equalTo(@15);
        make.height.mas_equalTo(@15);
    }];
    
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.locationImageView.mas_right).offset(4);
        make.top.mas_equalTo(self.locationImageView.mas_top).offset(-1);
    }];
}
- (void)ratingChanged:(CGFloat)newRating {
    
}


@end
