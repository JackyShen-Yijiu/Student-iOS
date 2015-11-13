//
//  DrivingCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/30.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "DrivingCell.h"
#import "ToolHeader.h"
#import "DrivingModel.h"
@interface DrivingCell ()
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UIImageView *drivingImage;
@property (strong, nonatomic) UILabel *drivingNameLabel;
@property (strong, nonatomic) UILabel *drivingAddressLabel;
@property (strong, nonatomic) UILabel *moenyLabel;
@property (strong, nonatomic) UILabel *successRateLabel;
@property (strong, nonatomic) UIView *WMSelectedbackGroundView;

@end
@implementation DrivingCell

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

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 100)];
    }
    return _backGroundView;
}
- (UIImageView *)drivingImage {
    if (_drivingImage == nil) {
        _drivingImage = [WMUITool initWithImage:nil];
        _drivingImage.backgroundColor = MAINCOLOR;
    }
    return _drivingImage;
}
- (UILabel *)drivingNameLabel{
    if (_drivingNameLabel == nil) {
        _drivingNameLabel = [[UILabel alloc]init];
        _drivingNameLabel.text = @"海淀中关村驾校";
        _drivingNameLabel.font = [UIFont systemFontOfSize:16];
        _drivingNameLabel.textColor = [UIColor blackColor];
    }
    return _drivingNameLabel;
}
- (UILabel *)drivingAddressLabel{
    if (_drivingAddressLabel == nil) {
        _drivingAddressLabel = [[UILabel alloc]init];
        _drivingAddressLabel.text = @"北京海淀区";
        _drivingAddressLabel.textColor = RGBColor(153, 153, 153);
        _drivingAddressLabel.adjustsFontSizeToFitWidth = YES;
        _drivingAddressLabel.font = [UIFont systemFontOfSize:14];
    }
    return _drivingAddressLabel;
}
- (UILabel *)moenyLabel{
    if (_moenyLabel == nil) {
        _moenyLabel = [[UILabel alloc]init];
        _moenyLabel.text = @"¥2000/¥5000";
        _moenyLabel.textColor = MAINCOLOR;
        _moenyLabel.font = [UIFont systemFontOfSize:15];
    }
    return _moenyLabel;
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
- (UILabel *)distanceLabel {
    if (_distanceLabel == nil) {
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.font = [UIFont systemFontOfSize:12];
        _distanceLabel.textColor = RGBColor(153, 153, 153);
        _distanceLabel.text = @"1278km";
        
    }
    return _distanceLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    
    self.selectedBackgroundView = self.WMSelectedbackGroundView;
    
    [self.contentView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.drivingImage];
    [self.backGroundView addSubview:self.drivingNameLabel];
    
    [self.backGroundView addSubview:self.moenyLabel];

    [self.backGroundView addSubview:self.drivingAddressLabel];

    [self.backGroundView addSubview:self.successRateLabel];
    [self.backGroundView addSubview:self.distanceLabel];
    
    
    [self.drivingImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(15);
        make.width.mas_equalTo(@90);
        make.height.mas_equalTo(@70);
    }];
    
    [self.drivingNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.drivingImage.mas_right).offset(10);
        make.top.mas_equalTo(self.drivingImage.mas_top).offset(0);
    }];
    
    [self.drivingAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.drivingNameLabel.mas_left).offset(0);
        make.top.mas_equalTo(self.drivingNameLabel.mas_bottom).offset(7);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide/2];
        make.width.mas_equalTo(wide);
    }];
    
    [self.moenyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.drivingAddressLabel.mas_left).offset(0);
        make.top.mas_equalTo(self.drivingAddressLabel.mas_bottom).offset(7);
//        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide-100];
//        make.width.mas_equalTo(wide);
    }];
    
    [self.successRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(17);
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.backGroundView.mas_bottom).offset(-17);
    }];
    
}

- (void)updateAllContentWith:(DrivingModel *)model {
    [self clearContent];
    
    self.drivingNameLabel.text = model.name;
    self.drivingAddressLabel.text = model.address;
    self.moenyLabel.text = [NSString stringWithFormat:@"¥%@/¥%@",model.minprice,model.maxprice];
    self.distanceLabel.text = [NSString stringWithFormat:@"距离%@m",model.distance];
    self.successRateLabel.text = [NSString stringWithFormat:@"通过率:%@%@",model.passingrate,@"%"];
    [self.drivingImage sd_setImageWithURL:[NSURL URLWithString:model.logoimg.originalpic] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
}
- (void)clearContent {
    self.drivingImage.image = nil;
    self.drivingNameLabel.text = nil;
    self.drivingAddressLabel.text = nil;
    self.moenyLabel.text = nil;
    self.successRateLabel.text = nil;
    self.distanceLabel.text = nil;
}
@end
