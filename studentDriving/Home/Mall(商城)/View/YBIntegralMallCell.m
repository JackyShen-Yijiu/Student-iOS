//
//  YBIntegralMallCell.m
//  studentDriving
//
//  Created by zyt on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBIntegralMallCell.h"

@interface YBIntegralMallCell ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *mallImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *integralLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *peopleNumberLabel;
@property (nonatomic, strong) UILabel *surplusLabel;

@end

@implementation YBIntegralMallCell

- (void)awakeFromNib {
   
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)initUI{
    
    [self addSubview:self.backView];
    [self.backView addSubview:self.mallImageView];
    [self.backView addSubview:self.nameLabel];
    [self.backView addSubview:self.integralLabel];
    [self.backView addSubview:self.addressLabel];
    [self.backView addSubview:self.lineView];
    [self.backView addSubview:self.peopleNumberLabel];
    [self.backView addSubview:self.surplusLabel];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.left.mas_equalTo(self.mas_left).offset(9);
        make.right.mas_equalTo (self.mas_right).offset(-9);
        make.height.mas_equalTo(150);
        
    }];
    [self.mallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView.mas_top).offset(0);
        make.left.mas_equalTo(self.backView.mas_left).offset(0);
        make.bottom.mas_equalTo(self.backView.mas_bottom).offset(0);
        make.width.mas_equalTo(100);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView.mas_top).offset(15);
        make.left.mas_equalTo(self.mallImageView.mas_right).offset(20);
        make.right.mas_equalTo (self.backView.mas_right).offset(0);
        make.height.mas_equalTo(14);
        
    }];
    [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.mallImageView.mas_right).offset(20);
        make.right.mas_equalTo (self.backView.mas_right).offset(0);
        make.height.mas_equalTo(14);
        
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.integralLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.mallImageView.mas_right).offset(20);
        make.right.mas_equalTo (self.backView.mas_right).offset(0);
        make.height.mas_equalTo(10);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.mallImageView.mas_right).offset(0);
        make.right.mas_equalTo (self.backView.mas_right).offset(0);
        make.height.mas_equalTo(0.7);
        
    }];
    [self.peopleNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.mallImageView.mas_right).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(14);
        
    }];
    [self.surplusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(20);
        make.right.mas_equalTo (self.backView.mas_right).offset(-9);
        make.width.mas_equalTo(100);
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
        _nameLabel.textColor = [UIColor colorWithHexString:@"212121"];
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
        _addressLabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _addressLabel.font = [UIFont systemFontOfSize:10];
    }
    return _addressLabel;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"bdbddb"];
        _lineView.alpha = 0.7;
        
    }
    return _lineView;
}
- (UILabel *)peopleNumberLabel{
    if (_peopleNumberLabel == nil) {
        _peopleNumberLabel = [[UILabel alloc] init];
        _peopleNumberLabel.text = @"已有18人兑换";
        _peopleNumberLabel.textColor = YBNavigationBarBgColor;
        _peopleNumberLabel.font = [UIFont systemFontOfSize:14];
    }
    return _peopleNumberLabel;
}
- (UILabel *)surplusLabel{
    if (_surplusLabel == nil) {
        _surplusLabel = [[UILabel alloc] init];
        _surplusLabel.text = @"剩余3份";
        _surplusLabel.textAlignment  = NSTextAlignmentRight;
        _surplusLabel.textColor = YBNavigationBarBgColor;
        _surplusLabel.font = [UIFont systemFontOfSize:14];
    }
    return _surplusLabel;
}
- (void)setIntegralMallModel:(YBIntegralMallModel *)integralMallModel{
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
    [self.mallImageView sd_setImageWithURL:[NSURL URLWithString:integralMallModel.productimg] placeholderImage:nil];
    self.nameLabel.text = integralMallModel.productname;
    self.integralLabel.text = [NSString stringWithFormat:@"兑换积分:%d",integralMallModel.productprice];
    self.addressLabel.text = [NSString stringWithFormat:@"地址:%@",integralMallModel.addressStr];
    self.peopleNumberLabel.text = [NSString stringWithFormat:@"已有%d人兑换",integralMallModel.buycount];
    self.surplusLabel.text = [NSString stringWithFormat:@"剩余%d份",integralMallModel.productcount];
    
    
}
@end
