//
//  ExamCarCollectionViewCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/30.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "ExamCarCollectionViewCell.h"
#import "ToolHeader.h"
@interface ExamCarCollectionViewCell ()
@property (strong, nonatomic) UIView *WMSelectedbackGroundView;
@property (strong, nonatomic) UIView *WMBackGroundView;

@end
@implementation ExamCarCollectionViewCell
- (UIView *)WMSelectedbackGroundView {
    if (_WMSelectedbackGroundView == nil) {
        _WMSelectedbackGroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, kSystemWide-20, 70)];
        _WMSelectedbackGroundView.backgroundColor = [UIColor whiteColor];
        _WMSelectedbackGroundView.layer.borderColor = MAINCOLOR.CGColor;
        _WMSelectedbackGroundView.layer.borderWidth = 2;
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

- (UIView *)WMBackGroundView {
    if (_WMBackGroundView == nil) {
        _WMBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide-30, 120)];
        
    }
    return _WMBackGroundView;
}

- (UILabel *)drivingTypeLabel{
    if (_drivingTypeLabel == nil) {
        _drivingTypeLabel = [[UILabel alloc]init];
        _drivingTypeLabel.text = @"C1";
        _drivingTypeLabel.font = [UIFont systemFontOfSize:40];
        _drivingTypeLabel.textColor = [UIColor blackColor];
    }
    return _drivingTypeLabel;
}

- (UILabel *)drivingTypeDetailLabel{
    if (_drivingTypeDetailLabel == nil) {
        _drivingTypeDetailLabel = [[UILabel alloc]init];
        _drivingTypeDetailLabel.text = @"手动挡和自动挡";
        _drivingTypeDetailLabel.font = [UIFont systemFontOfSize:14];
        _drivingTypeDetailLabel.textColor = TEXTGRAYCOLOR;
    }
    return _drivingTypeDetailLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.drivingTypeLabel];
        [self addSubview:self.drivingTypeDetailLabel];
        self.selectedBackgroundView = self.WMSelectedbackGroundView;
        [self.drivingTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).offset(30);
        }];
        [self.drivingTypeDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.drivingTypeLabel.mas_bottom).offset(0);
        }];
    }
    return self;
}
@end
