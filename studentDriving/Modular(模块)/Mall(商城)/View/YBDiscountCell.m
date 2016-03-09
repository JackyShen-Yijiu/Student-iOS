//
//  YBDiscountCell.m
//  studentDriving
//
//  Created by ytzhang on 16/3/9.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBDiscountCell.h"
@interface YBDiscountCell ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *mallImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *integralLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *surplusLabel;
@property (nonatomic, strong) UILabel *integralLabelTitle;
@property (nonatomic, strong) UILabel *surplusLabelTitle;

@end

@implementation YBDiscountCell
- (void)awakeFromNib {
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.backView];
    self.backgroundColor = [UIColor whiteColor];
    //    self.backView.backgroundColor = [UIColor grayColor];
    [self.backView addSubview:self.mallImageView];
    [self.backView addSubview:self.nameLabel];
    [self.backView addSubview:self.integralLabel];
    [self.backView addSubview:self.integralLabelTitle];
    [self.backView addSubview:self.addressLabel];
    [self.backView addSubview:self.surplusLabel];
    [self.backView addSubview:self.surplusLabelTitle];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(12);
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.right.mas_equalTo (self.mas_right).offset(-12);
        make.height.mas_equalTo(237);
        
    }];
    [self.mallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView.mas_top).offset(0);
        make.left.mas_equalTo(self.backView.mas_left).offset(0);
        make.bottom.mas_equalTo(self.backView.mas_bottom).offset(-80);
        make.right.mas_equalTo(self.backView.mas_right).offset(0);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mallImageView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.backView.mas_left).offset(0);
        make.right.mas_equalTo (self.backView.mas_right).offset(0);
        make.height.mas_equalTo(14);
        
    }];
    // 截止日期
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(self.backView.mas_left).offset(0);
        make.right.mas_equalTo (self.backView.mas_right).offset(0);
        make.height.mas_equalTo(12);
        
    }];
    
    
    [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(self.backView.mas_left).offset(0);
//        make.width.mas_equalTo(30);
        make.height.mas_equalTo(14);
        
    }];
    [self.integralLabelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.integralLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(self.integralLabel.mas_right).offset(4);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(12);
        
    }];
    
    [self.surplusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.integralLabel.mas_top).offset(0);
        make.right.mas_equalTo (self.backView.mas_right).offset(-12);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(14);
        
    }];
    [self.surplusLabelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.surplusLabel.mas_bottom).offset(0);
        make.right.mas_equalTo (self.surplusLabel.mas_left).offset(-4);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(14);
        
    }];
    
    
}
// Lazy ---- 加载
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        [_backView.layer setMasksToBounds:YES];
        [_backView.layer setCornerRadius:2.0];
        _backView.layer.shadowColor = [UIColor blackColor].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(7.0, 7.0);
        _backView.layer.shadowOpacity = YES;
    }
    return _backView;
}
- (UIImageView *)mallImageView{
    if (_mallImageView == nil) {
        _mallImageView = [[UIImageView alloc] init];
        _mallImageView.backgroundColor = [UIColor cyanColor];
    }
    return _mallImageView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"价值399元的车载蓝牙mp3";
        _nameLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}
- (UILabel *)integralLabel{
    if (_integralLabel == nil) {
        _integralLabel = [[UILabel alloc] init];
        _integralLabel.text = @"兑换积分：800";
        _integralLabel.textColor = YBNavigationBarBgColor;
        _integralLabel.font = [UIFont systemFontOfSize:14];
    }
    return _integralLabel;
}
- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"地址：此商品无地址信息";
        _addressLabel.numberOfLines = 0;
        _addressLabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _addressLabel.font = [UIFont systemFontOfSize:12];
    }
    return _addressLabel;
}
- (UILabel *)surplusLabel{
    if (_surplusLabel == nil) {
        _surplusLabel = [[UILabel alloc] init];
        _surplusLabel.text = @"剩余3份";
        _surplusLabel.textAlignment  = NSTextAlignmentRight;
        _surplusLabel.textColor = YBNavigationBarBgColor;
        _surplusLabel.font = [UIFont systemFontOfSize:12];
    }
    return _surplusLabel;
}
- (UILabel *)integralLabelTitle{
    if (_integralLabelTitle == nil) {
        _integralLabelTitle = [[UILabel alloc] init];
        _integralLabelTitle.text = @"积分";
        _integralLabelTitle.textColor = [UIColor colorWithHexString:@"b7b7b7"];
        _integralLabelTitle.font = [UIFont systemFontOfSize:12];
    }
    return _integralLabelTitle;
}
- (UILabel *)surplusLabelTitle{
    if (_surplusLabelTitle == nil) {
        _surplusLabelTitle = [[UILabel alloc] init];
        _surplusLabelTitle.text = @"剩余";
        _surplusLabelTitle.textAlignment  = NSTextAlignmentRight;
        _surplusLabelTitle.textColor = [UIColor colorWithHexString:@"b7b7b7"];
        _surplusLabelTitle.font = [UIFont systemFontOfSize:12];
    }
    return _surplusLabelTitle;
}
- (void)setDiscountModel:(YBDiscountModel *)discountModel{
    /*
     
     @property (nonatomic,strong) NSString *productid;
     @property (nonatomic,strong) NSString *productname;
     @property (nonatomic,assign) int  productprice;
     @property (nonatomic,strong) NSString *productimg;
     @property (nonatomic,strong) NSString *productdesc;
     @property (nonatomic,assign) int  viewcount;
     @property (nonatomic,assign) int  buycount;
     @property (nonatomic,strong) NSString *detailsimg;
     @property (nonatomic,assign) BOOL is_scanconsumption;
     
     @property (nonatomic,strong) NSString *detailurl;
     
     */
    [self.mallImageView sd_setImageWithURL:[NSURL URLWithString:discountModel.productimg] placeholderImage:nil];
    self.nameLabel.text = discountModel.productname;
    self.integralLabel.text = [NSString stringWithFormat:@"%d",discountModel.productprice];
    self.addressLabel.text = [NSString stringWithFormat:@"地址:%@",discountModel.address];
    self.surplusLabel.text = [NSString stringWithFormat:@"%d份",discountModel.productcount];

}




@end
