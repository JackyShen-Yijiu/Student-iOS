//
//  ExamClassCollectionViewCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/30.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "ExamClassCollectionViewCell.h"
#import "ToolHeader.h"
@interface ExamClassCollectionViewCell ()
@property (strong, nonatomic) UIView *WMSelectedbackGroundView;


@end
@implementation ExamClassCollectionViewCell

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



- (UILabel *)drivingName{
    if (_drivingName == nil) {
        _drivingName = [[UILabel alloc]init];
        _drivingName.text = @"海淀中关村驾校";
        _drivingName.font = [UIFont systemFontOfSize:16];
        _drivingName.textColor = [UIColor blackColor];
    }
    return _drivingName;
}

- (UILabel *)drivingAdress{
    if (_drivingAdress == nil) {
        _drivingAdress = [[UILabel alloc]init];
        _drivingAdress.text = @"北京市海淀区";
        _drivingAdress.font = [UIFont systemFontOfSize:14];
        _drivingAdress.numberOfLines = 0;
        _drivingAdress.textColor = TEXTGRAYCOLOR;
    }
    return _drivingAdress;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.text = @"¥5000";
        _moneyLabel.font = [UIFont systemFontOfSize:16];
        _moneyLabel.textColor = MAINCOLOR;
    }
    return _moneyLabel;
}
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    [self addSubview:self.drivingName];
    [self addSubview:self.drivingAdress];
    [self addSubview:self.moneyLabel];
    self.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = self.WMSelectedbackGroundView;
    [self.drivingName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(18);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@16);
    }];
    
    [self.drivingAdress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.drivingName.mas_bottom).offset(10);
        make.width.mas_equalTo(@250);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.mas_top).offset(18);
        make.height.mas_equalTo(@16);
    }];
}
- (void)setModel:(ExamClassModel *)model{
    self.drivingName.text = model.classname;
    self.drivingAdress.text = model.classdesc;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
}
- (CGFloat)getLabelWidthWithString:(NSString *)string {
    CGRect bounds = [string boundingRectWithSize:
                     CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000) options:
                     NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil];
    return bounds.size.height + 26;
}

@end
