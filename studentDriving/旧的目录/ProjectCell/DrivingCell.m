//
//  DrivingCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/30.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "DrivingCell.h"
#import "DrivingModel.h"
#import "RatingBar.h"

#define starViewWidth 100
#define starViewHeight 25

@interface DrivingCell ()
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UIImageView *drivingImage;
@property (strong, nonatomic) UILabel *drivingNameLabel;
@property (strong, nonatomic) UILabel *drivingAddressLabel;
@property (strong, nonatomic) UILabel *moenyLabel;
@property (strong, nonatomic) UIView *lineBottomView;
@property (strong, nonatomic) RatingBar *rateBar;
@property (strong, nonatomic) UIView *WMSelectedbackGroundView;
@end
@implementation DrivingCell

- (UIView *)WMSelectedbackGroundView {
    if (_WMSelectedbackGroundView == nil) {
        _WMSelectedbackGroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, kSystemWide-20, 70)];
        _WMSelectedbackGroundView.backgroundColor = [UIColor whiteColor];
        _WMSelectedbackGroundView.layer.borderColor = MAINCOLOR.CGColor;
        _WMSelectedbackGroundView.layer.borderWidth = 1;
        UIImageView *selectedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSelected"]];
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
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 90)];
    }
    return _backGroundView;
}
- (UIImageView *)drivingImage {
    if (_drivingImage == nil) {
        _drivingImage = [WMUITool initWithImage:nil];
        _drivingImage.backgroundColor = MAINCOLOR;
        [_drivingImage.layer setMasksToBounds:YES];
        [_drivingImage.layer setCornerRadius:20];
    }
    return _drivingImage;
}
- (UILabel *)drivingNameLabel{
    if (_drivingNameLabel == nil) {
        _drivingNameLabel = [[UILabel alloc]init];
        _drivingNameLabel.text = @"海淀中关村驾校";
        _drivingNameLabel.font = [UIFont systemFontOfSize:14];
        _drivingNameLabel.textColor = [UIColor blackColor];
    }
    return _drivingNameLabel;
}
- (UILabel *)drivingAddressLabel{
    if (_drivingAddressLabel == nil) {
        _drivingAddressLabel = [[UILabel alloc]init];
        _drivingAddressLabel.text = @"北京海淀区";
        _drivingAddressLabel.textColor = RGBColor(153, 153, 153);
        _drivingAddressLabel.font = [UIFont systemFontOfSize:12];
    }
    return _drivingAddressLabel;
}
- (UILabel *)moenyLabel{
    if (_moenyLabel == nil) {
        _moenyLabel = [[UILabel alloc]init];
        _moenyLabel.text = @"¥2000-¥5000";
        _moenyLabel.textColor = YBNavigationBarBgColor;
        _moenyLabel.font = [UIFont systemFontOfSize:14];
    }
    return _moenyLabel;
}

- (UILabel *)distanceLabel {
    if (_distanceLabel == nil) {
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.font = [UIFont systemFontOfSize:12];
        _distanceLabel.textAlignment = NSTextAlignmentRight;
        _distanceLabel.textColor = RGBColor(153, 153, 153);
        _distanceLabel.text = @"12789353478m";
        _distanceLabel.hidden = YES;
    }
    return _distanceLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [UILabel new];
        _commentLabel.text = @"认证教练";
        _commentLabel.textColor = YBNavigationBarBgColor;
        _commentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _commentLabel;
}

- (UIView *)lineBottomView{
    
    if (_lineBottomView == nil) {
        _lineBottomView = [[UIView alloc] init];
        _lineBottomView.backgroundColor = HM_LINE_COLOR;
        
    }
    return _lineBottomView;
}
- (RatingBar *)rateBar{
    if (_rateBar == nil) {
        _rateBar = [[RatingBar alloc] init];
        [_rateBar setImageDeselected:@"YBAppointMentDetailsstar.png" halfSelected:nil fullSelected:@"YBAppointMentDetailsstar_fill.png" andDelegate:nil];

    }
    return _rateBar;
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

    [self.backGroundView addSubview:self.distanceLabel];
    
    [self.backGroundView addSubview:self.commentLabel];
    [self.backGroundView addSubview:self.rateBar];
    [self.backGroundView addSubview:self.lineBottomView];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.drivingImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(15);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@40);
    }];
    
    [self.drivingNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.drivingImage.mas_right).offset(10);
        make.top.mas_equalTo(self.drivingImage.mas_top);
        make.height.mas_equalTo(@14);
        
    }];

    [self.drivingAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.drivingNameLabel.mas_left).offset(0);
        make.top.mas_equalTo(self.drivingNameLabel.mas_bottom).offset(7);
        make.height.mas_equalTo(@12);
        
    }];

    [self.moenyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.drivingAddressLabel.mas_left).offset(0);
        make.top.mas_equalTo(self.drivingAddressLabel.mas_bottom).offset(10);
        make.width.equalTo(self.drivingNameLabel);
        
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.distanceLabel.mas_right);
        make.bottom.mas_equalTo(self.moenyLabel.mas_bottom).offset(-1);
    }];
    
    
    [self.rateBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.drivingNameLabel.mas_top);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-15);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(80);
    }];
    [self.lineBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.drivingNameLabel.mas_left).offset(0);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.height.mas_equalTo(@0.5);
    
    }];
}
- (void)updateAllContentWith:(DrivingModel *)model {
    [self clearContent];
    
    self.drivingNameLabel.text = @"未填写";
    if (model.name) {
        self.drivingNameLabel.text = model.name;
    }
    
    NSString *address = @"未填写地址";
    if (![model.address isKindOfClass:[NSNull class]] && model.address.length) {
        address = model.address;
    }
    
    
    

    NSInteger integer = [model.distance integerValue];
    self.distanceLabel.text = [NSString stringWithFormat:@"距离%.2fkm",integer / 1000.f];
    
    self.drivingAddressLabel.text = address;
    
    if (!model.minprice || !model.maxprice) {
        self.moenyLabel.text = @"未填写价格";
    }else {
        self.moenyLabel.text = [NSString stringWithFormat:@"¥%@-¥%@",model.minprice,model.maxprice];
    }
    
    CGFloat starLevel = 0;
    if (model.schoollevel) {
        starLevel = [model.schoollevel floatValue];
    }
    NSLog(@"%@",model.schoollevel);
    [self.rateBar setUpRating:starLevel];
    [self.drivingImage sd_setImageWithURL:[NSURL URLWithString:model.logoimg.originalpic] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    self.commentLabel.text = @"暂无认证教练";
    if (model.coachcount) {
        self.commentLabel.text = [NSString stringWithFormat:@"%@位认证教练",model.coachcount];
    }
}
- (void)clearContent {
    self.drivingImage.image = nil;
    self.drivingNameLabel.text = nil;
    self.drivingAddressLabel.text = nil;
    self.moenyLabel.text = nil;
    self.distanceLabel.text = nil;
}
@end
