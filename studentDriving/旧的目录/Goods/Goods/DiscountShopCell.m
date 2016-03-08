//
//  DiscountShopCell.m
//  studentDriving
//
//  Created by ytzhang on 15/12/31.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DiscountShopCell.h"
#import "WMUITool.h"
#import <Masonry.h>
#import "UIImageView+EMWebCache.h"

@interface DiscountShopCell()
@property (nonatomic,strong) UIView *backView;

@property (nonatomic, strong) UIImageView *shopImageView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *shopNumLabel;

@property (nonatomic, strong) UILabel *shopAddressLabel;

@property (nonatomic, strong) UILabel *shopPriceLabel;

@property (nonatomic, strong) UILabel *shopAreaLabel;

@property (nonatomic, strong) UILabel *shopDidtanceLable;

@property (nonatomic, strong) UILabel *shopPeoleLabel;

@property (nonatomic, strong) UIImageView *lineImageView;

@property (nonatomic, strong) UILabel *shopLeftLabel;
@end

@implementation DiscountShopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCellUI];
    }
    return self;
}
- (void)createCellUI
{
       
    [self.contentView addSubview:self.shopImageView];
    [self.shopImageView addSubview:self.bgView];
    [self.bgView addSubview:self.shopNumLabel];
    [self.bgView addSubview:self.shopAddressLabel];
    [self.bgView addSubview:self.shopPriceLabel];
    [self.bgView addSubview:self.shopAreaLabel];
    [self.bgView addSubview:self.shopDidtanceLable];
    [self.bgView addSubview:self.shopPeoleLabel];
    [self.bgView addSubview:self.lineImageView];
    [self.bgView addSubview:self.shopLeftLabel];

    
    [self.shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.height.mas_equalTo(@64);
        
    }];
    [self.shopNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
        make.left.mas_equalTo(self.bgView.mas_left).offset(20);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@40);
    }];
    [self.shopAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shopNumLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.bgView.mas_left).offset(20);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@200);
    }];
    [self.shopPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shopAddressLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.bgView.mas_left).offset(20);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@150);
    }];
    [self.shopAreaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-20);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@40);
    }];
    [self.shopDidtanceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shopAreaLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-20);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@40);
    }];
    [self.shopLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shopDidtanceLable.mas_bottom).offset(10);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-20);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@50);
    }];
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-5);
        make.right.mas_equalTo(self.shopLeftLabel.mas_left).offset(-5);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@1);
    }];
    [self.shopPeoleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shopDidtanceLable.mas_bottom).offset(10);
        make.right.mas_equalTo(self.lineImageView.mas_left).offset(-5);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@50);
    }];


}
- (UIView *)backView
{
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 120)];
        _shopImageView.backgroundColor = [UIColor greenColor];
    }
    return _backView;
    
}
- (UIImageView *)shopImageView
{
    if (_shopImageView == nil) {
        _shopImageView = [[UIImageView alloc] init];
        _shopImageView.backgroundColor = [UIColor grayColor];
        
    }
    return _shopImageView;
}
- (UIView *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.alpha = 0.2;
        
        
    }
    return _bgView;
}
- (UILabel *)shopNumLabel
{
    if (_shopNumLabel == nil) {
        _shopNumLabel = [WMUITool initWithTextColor:[UIColor colorWithHexString:@"333333"] withFont:[UIFont systemFontOfSize:12]];
        _shopNumLabel.text = @"007网吧";
        
    }
    return _shopNumLabel;
}
- (UILabel *)shopAddressLabel
{
    if (_shopAddressLabel == nil) {

         _shopAddressLabel = [WMUITool initWithTextColor:[UIColor colorWithHexString:@"333333"] withFont:[UIFont systemFontOfSize:12]];
        _shopAddressLabel.text = _discountModel.address;
    }
    return _shopAddressLabel;
}
- (UILabel *)shopPriceLabel{
    if (_shopPriceLabel == nil) {

         _shopPriceLabel = [WMUITool initWithTextColor:[UIColor colorWithHexString:@"cf151a"] withFont:[UIFont systemFontOfSize:12]];
        _shopPriceLabel.text = @"价值600元的美容套餐";
    }
    return _shopPriceLabel;
}
- (UILabel *)shopAreaLabel{
    if (_shopAreaLabel == nil) {

         _shopAreaLabel = [WMUITool initWithTextColor:[UIColor colorWithHexString:@"333333"] withFont:[UIFont systemFontOfSize:12]];
        _shopAreaLabel.text = _discountModel.county;
    }
    return _shopAreaLabel;
}
- (UILabel *)shopDidtanceLable
{
    if (_shopDidtanceLable == nil) {

         _shopDidtanceLable = [WMUITool initWithTextColor:[UIColor colorWithHexString:@"333333"] withFont:[UIFont systemFontOfSize:12]];
        _shopDidtanceLable.text = @"12Km";
    }
    return _shopDidtanceLable;
}
- (UILabel *)shopPeoleLabel{
    if (_shopPeoleLabel == nil  ) {

         _shopPeoleLabel = [WMUITool initWithTextColor:[UIColor colorWithHexString:@"333333"] withFont:[UIFont systemFontOfSize:12]];
        
        _shopPeoleLabel.text = @"18人已兑换";
    }
    return _shopPeoleLabel;
}
- (UIImageView *)lineImageView
{
    if (_lineImageView == nil) {
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.image = [UIImage imageNamed:@"shopLine"];
    }
    return _lineImageView;
}
- (UILabel *)shopLeftLabel
{
    if (_shopLeftLabel == nil) {

         _shopLeftLabel = [WMUITool initWithTextColor:[UIColor colorWithHexString:@"333333"] withFont:[UIFont systemFontOfSize:12]];
        _shopLeftLabel.text = @"剩余80份";
    }
    return _shopLeftLabel;
}
- (void)setDiscountModel:(DiscountShopModel *)discountModel
{
    self.shopAddressLabel.text = discountModel.address;
    self.shopAreaLabel.text = discountModel.county;
    NSURL *url = [NSURL URLWithString:discountModel.detailsimg];
    [self.shopImageView sd_setImageWithURL:url placeholderImage:nil];
}
@end
