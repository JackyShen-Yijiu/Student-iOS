//
//  IntruductionTableViewCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/14.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "DrivingDetailCell.h"
#import "ToolHeader.h"
@interface DrivingDetailCell ()
@property (strong, nonatomic) UIView *backGroundView;

@property (strong, nonatomic) UIImageView *locationImageView;


@end
@implementation DrivingDetailCell
- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , 86)];
    }
    return _backGroundView;
}
- (UILabel *)locationLabel {
    if (_locationLabel == nil) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.text = @"地址:北京市海淀区沙河训练基地";
        _locationLabel.font = [UIFont systemFontOfSize:14];
        _locationLabel.textColor = [UIColor blackColor];
    }
    return _locationLabel;
}
- (UILabel *)drivingNameLabel {
    if (_drivingNameLabel == nil) {
        _drivingNameLabel = [[UILabel alloc] init];
//        _drivingNameLabel.text = @"朝阳区大名驾校";
        _drivingNameLabel.font = [UIFont boldSystemFontOfSize:16];
        _drivingNameLabel.textColor = [UIColor blackColor];
    }
    return _drivingNameLabel;
}
- (UIImageView *)locationImageView {
    if (_locationImageView == nil) {
        _locationImageView = [[UIImageView alloc] init];
        _locationImageView.image = [UIImage imageNamed:@"locationImage.png"];
    }
    return _locationImageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    [self.contentView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.drivingNameLabel];

    
    [self.backGroundView addSubview:self.locationImageView];
    
    [self.backGroundView addSubview:self.locationLabel];
    
    [self.drivingNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(18);
    }];
    
    [self.locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.drivingNameLabel.mas_left).offset(0);
        make.top.mas_equalTo(self.drivingNameLabel.mas_bottom).offset(12);
        make.width.mas_equalTo(@15);
        make.height.mas_equalTo(@15);
    }];
    
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.locationImageView.mas_right).offset(4);
        make.top.mas_equalTo(self.locationImageView.mas_top).offset(-1);
    }];
}

@end
