//
//  DiscountWalletCell.m
//  
//
//  Created by ytzhang on 15/12/31.
//
//

#import "DiscountWalletCell.h"
#import "WMUITool.h"
#import <Masonry.h>
@interface DiscountWalletCell()
@property (nonatomic,strong) UILabel *discountNameLabel;

@property (nonatomic,strong) UILabel *timeLable;

@property (nonatomic,strong) UILabel *discountNumbetlable;

@property (nonatomic,strong) UILabel *numberLabel;

@end

@implementation DiscountWalletCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCellUI];
    }
    return self;
}
- (void)createCellUI
{
    [self addSubview:self.discountNameLabel];
    [self addSubview:self.timeLable];
    [self addSubview:self.discountNumbetlable];
    [self addSubview:self.numberLabel];
    
    [self.discountNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@200);
    }];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.discountNameLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@100);
    }];
    [self.discountNumbetlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@100);
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.discountNumbetlable.mas_bottom).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@100);
    }];
}
- (UILabel *)discountNameLabel{
    if (_discountNameLabel == nil){
    _discountNameLabel = [WMUITool initWithTextColor:[UIColor colorWithHexString:@"333333"] withFont:[UIFont systemFontOfSize:12]];
    _discountNameLabel.text = @"获得北京一步互联网驾校";
//    _discountNameLabel.backgroundColor = [UIColor greenColor];
    }
    return _discountNameLabel;
}
- (UILabel *)timeLable
{
    if (_timeLable == nil) {
        _timeLable = [WMUITool initWithTextColor:[UIColor colorWithHexString:@"999999"] withFont:[UIFont systemFontOfSize:12]];
    _timeLable.text = @"2015-12-12";
    }
    return _timeLable;
}
- (UILabel *)discountNumbetlable{
    if (_discountNumbetlable == nil) {
        _discountNumbetlable = [WMUITool initWithTextColor:[UIColor colorWithHexString:@"ff6633"] withFont:[UIFont systemFontOfSize:12]];
        _discountNumbetlable.text = @"兑换劵单号";
        _discountNumbetlable.textAlignment = NSTextAlignmentRight;
        
    }
    return _discountNumbetlable;
}
- (UILabel *)numberLabel{
    if (_numberLabel == nil) {
        _numberLabel = [WMUITool initWithTextColor:[UIColor colorWithHexString:@"ff6633"] withFont:[UIFont systemFontOfSize:12]];
        _numberLabel.text = @"1234556";
        _numberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _numberLabel;
}
@end
