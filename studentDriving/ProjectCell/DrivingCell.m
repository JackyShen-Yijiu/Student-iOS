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

#define starViewWidth 100
#define starViewHeight 25

@interface DrivingCell ()
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UIImageView *drivingImage;
@property (strong, nonatomic) UILabel *drivingNameLabel;
@property (strong, nonatomic) UILabel *drivingAddressLabel;
@property (strong, nonatomic) UILabel *moenyLabel;
//@property (strong, nonatomic) UILabel *successRateLabel;
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
        _moenyLabel.text = @"¥2000-¥5000";
        _moenyLabel.textColor = MAINCOLOR;
        _moenyLabel.font = [UIFont systemFontOfSize:15];
    }
    return _moenyLabel;
}
//- (UILabel *)successRateLabel {
//    if (_successRateLabel == nil) {
//        _successRateLabel = [[UILabel alloc] init];
//        _successRateLabel.font = [UIFont systemFontOfSize:12];
//        _successRateLabel.textColor = RGBColor(153, 153, 153);
//        _successRateLabel.text = @"通过率:95%";
//    }
//    return _successRateLabel;
//}
- (UILabel *)distanceLabel {
    if (_distanceLabel == nil) {
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.font = [UIFont systemFontOfSize:12];
        _distanceLabel.textColor = RGBColor(153, 153, 153);
        _distanceLabel.text = @"12789353478m";
    }
    return _distanceLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [UILabel new];
        _commentLabel.text = @"认证教练";
        _commentLabel.textColor = MAINCOLOR;
        _commentLabel.font = [UIFont systemFontOfSize:15];
    }
    return _commentLabel;
}

- (UIImageView *)starBackgroundImageView {
    if (!_starBackgroundImageView) {
        _starBackgroundImageView = [UIImageView new];
//        _starBackgroundImageView.backgroundColor = [UIColor lightGrayColor];
        _starBackgroundImageView.image = [UIImage imageNamed:@"star_background"];
    }
    return _starBackgroundImageView;
}
- (UIImageView *)starImageView {
    if (!_starImageView) {
        _starImageView = [UIImageView new];
//        _starImageView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.1];
        _starImageView.image = [UIImage imageNamed:@"star"];
        _starImageView.contentMode = UIViewContentModeLeft;
    }
    return _starImageView;
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

//    [self.backGroundView addSubview:self.successRateLabel];
    [self.backGroundView addSubview:self.distanceLabel];
    
    [self.backGroundView addSubview:self.commentLabel];
    [self.backGroundView addSubview:self.starBackgroundImageView];
    [self.backGroundView addSubview:self.starImageView];
    
    [self.drivingImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(15);
        make.width.mas_equalTo(@70);
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
    
//    [self.successRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-15);
//        make.top.mas_equalTo(self.backGroundView.mas_top).offset(17);
//    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.drivingAddressLabel.mas_bottom).offset(-1);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.distanceLabel.mas_right);
        make.bottom.mas_equalTo(self.moenyLabel.mas_bottom).offset(0.5);
    }];
    
    [self.starBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.distanceLabel.mas_right);
        make.top.mas_equalTo(self.drivingNameLabel.mas_top).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    [self.starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.starBackgroundImageView.mas_right);
        make.top.mas_equalTo(self.starBackgroundImageView.mas_top);
        make.width.mas_equalTo(self.starBackgroundImageView.mas_width);
        make.height.mas_equalTo(self.starBackgroundImageView.mas_height);
    }];
    self.star = 3;
    [self setStar];
//    self.distanceLabel.backgroundColor = [UIColor lightGrayColor];
    
}

- (void)updateAllContentWith:(DrivingModel *)model {
    [self clearContent];
    
    self.drivingNameLabel.text = model.name;
    
    NSString *address = @"未填写地址";
    if (![model.address isKindOfClass:[NSNull class]] && model.address.length) {
        address = model.address;
    }
    self.drivingAddressLabel.text = address;
    if ([model.minprice isKindOfClass:[NSNull class]] || [model.maxprice isKindOfClass:[NSNull class]]) {
        self.moenyLabel.text = @"未填写价格";
    }else {
        self.moenyLabel.text = [NSString stringWithFormat:@"¥%@-¥%@",model.minprice,model.maxprice];
    }
//    if ([model.coachcount isKindOfClass:[NSNull class]]) {
//        self.coachcount = 0;
//    }
    NSInteger integer = [model.distance integerValue];
    self.distanceLabel.text = [NSString stringWithFormat:@"距离%.2fkm",integer / 1000.f];
    self.star = [model.passingrate floatValue] / 100.f * 10.f / 2.f;
    [self setStar];
    [self.drivingImage sd_setImageWithURL:[NSURL URLWithString:model.logoimg.originalpic] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    if (self.coachcount == 0) {
        self.commentLabel.text = @"已认证教练";
    }else {
        self.commentLabel.text = [NSString stringWithFormat:@"%li名认证教练",self.coachcount];
    }
    
}

//设置星级
- (void)setStar {
    
    CGFloat biLi = self.star * 2.f / 10.f;
    //    NSLog(@"%f",biLi);
    UIImage *tempImage = [UIImage imageNamed:@"star"];
    UIImage *image = [self reSizeImage:tempImage newSize:CGSizeMake(80, 15)];
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    rect.size.width *= biLi;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *catImage = [UIImage imageWithCGImage:imageRef];
    
    self.starImageView.image = catImage;
}

//改变图片的大小
- (UIImage *)reSizeImage:(UIImage *)image newSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    CGRect rect;
    rect.origin = CGPointMake(0, 0);
    rect.size = newSize;
    [image drawInRect:rect];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

- (void)clearContent {
    self.drivingImage.image = nil;
    self.drivingNameLabel.text = nil;
    self.drivingAddressLabel.text = nil;
    self.moenyLabel.text = nil;
//    self.successRateLabel.text = nil;
    self.distanceLabel.text = nil;
}
@end
