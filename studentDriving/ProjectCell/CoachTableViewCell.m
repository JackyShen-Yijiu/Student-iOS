//
//  CoachTableViewCell.m
//  BlackCat
//
//  Created by 董博 on 15/9/9.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "CoachTableViewCell.h"
#import "ToolHeader.h"
#import <Masonry.h>
#import "CoachModel.h"
#import "RatingBar.h"
@interface CoachTableViewCell ()
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *coachNameLabel;
@property (strong, nonatomic) UILabel *carDriveNameLabel;
@property (strong, nonatomic) UILabel *starLabel;
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UILabel *successRateLabel;
@property (strong, nonatomic) UILabel *dringAgeLabel;
@property (strong, nonatomic) RatingBar *starBar;
@property (strong, nonatomic) UIView *WMSelectedbackGroundView;


@property (strong, nonatomic) UILabel *distanceLabel;
@property (strong, nonatomic) UIButton *coachStateSend;
@property (strong, nonatomic) UIButton *coachStateAll;

@end
@implementation CoachTableViewCell

- (UIView *)WMSelectedbackGroundView {
    if (_WMSelectedbackGroundView == nil) {
        _WMSelectedbackGroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, kSystemWide-20, 70)];
        _WMSelectedbackGroundView.backgroundColor = [UIColor whiteColor];
        _WMSelectedbackGroundView.layer.borderColor = MAINCOLOR.CGColor;
        _WMSelectedbackGroundView.layer.borderWidth = 1;
        UIImageView *selectedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSelected.png"]];
        [_WMSelectedbackGroundView addSubview:selectedImage];
        [selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_WMSelectedbackGroundView.mas_right).offset(0);
            make.top.mas_equalTo(_WMSelectedbackGroundView.mas_top).offset(0);
            make.height.mas_equalTo(@30);
            make.width.mas_equalTo(@30);
        }];
        
        
    }
    return _WMSelectedbackGroundView;
}

- (RatingBar *)starBar {
    if (_starBar == nil) {
        _starBar = [[RatingBar alloc] init];
        [_starBar setImageDeselected:@"starUnSelected.png" halfSelected:nil fullSelected:@"starSelected.png" andDelegate:nil];
    }
    return _starBar;
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

- (UILabel *)distanceLabel {
    if (_distanceLabel == nil) {
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.font = [UIFont systemFontOfSize:12];
        _distanceLabel.textColor = RGBColor(153, 153, 153);
        _distanceLabel.text = @"1278km";
        
    }
    return _distanceLabel;
}
- (UILabel *)dringAgeLabel {
    if (_dringAgeLabel == nil) {
        _dringAgeLabel = [[UILabel alloc] init];
        _dringAgeLabel.font = [UIFont systemFontOfSize:12];
        _dringAgeLabel.textColor = RGBColor(153, 153, 153);
        _dringAgeLabel.text = @"驾龄:5年";
        
    }
    return _dringAgeLabel;
}


- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 100)];
        _backGroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backGroundView;
}

- (UIImageView *)headImageView {
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 70, 70)];
        _headImageView.backgroundColor = MAINCOLOR;
    }
    return _headImageView;
}

- (UILabel *)coachNameLabel{
    if (_coachNameLabel == nil) {
        _coachNameLabel = [[UILabel alloc]init];
        _coachNameLabel.text = @"李文正";
        _coachNameLabel.font = [UIFont systemFontOfSize:16];
        _coachNameLabel.textColor = [UIColor blackColor];
    }
    return _coachNameLabel;
}

- (UILabel *)carDriveNameLabel{
    if (_carDriveNameLabel == nil) {
        _carDriveNameLabel = [[UILabel alloc]init];
        _carDriveNameLabel.text = @"北京海淀区明城驾校";
        _carDriveNameLabel.textColor = RGBColor(153, 153, 153);
        _carDriveNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _carDriveNameLabel;
}

- (UILabel *)starLabel{
    if (_starLabel == nil) {
        _starLabel = [[UILabel alloc]init];
        _starLabel.text = @"星级";
        _starLabel.font = [UIFont systemFontOfSize:10];
    }
    return _starLabel;
}

- (UILabel *)successRateLabel {
    if (_successRateLabel == nil) {
        _successRateLabel = [[UILabel alloc] init];
        _successRateLabel.font = [UIFont systemFontOfSize:12];
        _successRateLabel.textColor = RGBColor(153, 153, 153);
        _successRateLabel.text = @"通过率:95%";
    }
    return _successRateLabel;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCellUI];
    }
    return self;
}
- (void)createCellUI {
    
    self.selectedBackgroundView = self.WMSelectedbackGroundView;
    
    [self.contentView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.headImageView];
    [self.backGroundView addSubview:self.coachNameLabel];
    [self.backGroundView addSubview:self.carDriveNameLabel];
    [self.backGroundView addSubview:self.starLabel];
    [self.backGroundView addSubview:self.successRateLabel];
    [self.backGroundView addSubview:self.dringAgeLabel];
    [self.backGroundView addSubview:self.distanceLabel];
    [self.backGroundView addSubview:self.starBar];
    
    [self.coachNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(20);
    }];
    [self.carDriveNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coachNameLabel.mas_left).offset(0);
        make.top.mas_equalTo(self.coachNameLabel.mas_bottom).offset(5);
    }];
    
    [self.successRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coachNameLabel.mas_left).offset(0);
        make.top.mas_equalTo(self.carDriveNameLabel.mas_bottom).offset(5);
    }];
    
    [self.dringAgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.successRateLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.successRateLabel.mas_top).offset(0);
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.backGroundView.mas_bottom).offset(-20);
    }];
    [self.starBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-10);
        make.top.mas_equalTo(self.coachNameLabel.mas_top).offset(2);
        make.width.mas_equalTo(@75);
        make.height.mas_equalTo(@15);
    }];
    
}

- (void)receivedCellModelWith:(CoachModel *)coachModel {
    [self resetContent];
    
    //    if ([[AcountManager manager].applycoach.infoId isEqualToString:coachModel.coachid]) {
    //        self.selected = YES;
    //    }
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:coachModel.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    self.coachNameLabel.text = coachModel.name;
    if (coachModel.distance) {
        CGFloat distance = [coachModel.distance integerValue] / 1000.f;
        self.distanceLabel.text = [NSString stringWithFormat:@"距离:%.2fkm",distance];
    }
    
    self.carDriveNameLabel.text = coachModel.driveschoolinfo.name;
    self.dringAgeLabel.text = [NSString stringWithFormat:@"%@驾龄",coachModel.Seniority] ;
    if (coachModel.passrate) {
        self.successRateLabel.text = [NSString stringWithFormat:@"通过率:%@%@",coachModel.passrate,@"%"];
    }else {
        self.successRateLabel.text = [NSString stringWithFormat:@"通过率:暂无"];
    }
    //    self.starLabel.text = @"5";
    CGFloat starLevel = 0;
    if (coachModel.starlevel) {
        starLevel = [coachModel.starlevel floatValue];
    }
    [self.starBar displayRating:starLevel];
    if (coachModel.is_shuttle) {
        [self.backGroundView addSubview:self.coachStateSend];
        [self.coachStateSend mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coachNameLabel.mas_right).offset(10);
            make.top.mas_equalTo(self.coachNameLabel.mas_top).offset(2);
            make.width.mas_equalTo(@20);
            make.height.mas_equalTo(@14);
        }];
    }
    
    
}
- (void)resetContent {
    [self.coachStateAll removeFromSuperview];
    [self.coachStateSend removeFromSuperview];
    self.headImageView.image = nil;
    self.coachNameLabel.text = nil;
    self.carDriveNameLabel.text = nil;
    self.successRateLabel.text = nil;
    self.dringAgeLabel.text = nil;
    self.distanceLabel.text = nil;
    [self.starBar displayRating:0];
}
@end
