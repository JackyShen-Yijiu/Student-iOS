//
//  MyWalletViewCell.m
//  studentDriving
//
//  Created by 胡东苑 on 15/12/30.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MyWalletViewCell.h"
#import "ToolHeader.h"

@interface MyWalletViewCell ()

@property (nonatomic, strong) UILabel *shareLb;
@property (nonatomic, strong) UILabel *dateLb;
@property (nonatomic, strong) UILabel *moneyLb;


@end

@implementation MyWalletViewCell

- (UILabel *)shareLb {
    if (!_shareLb) {
        _shareLb = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 14)];
        _shareLb.font = [UIFont systemFontOfSize:14];
        _shareLb.textColor = [UIColor blackColor];
    }
    return _shareLb;
}

- (UILabel *)dateLb {
    if (!_dateLb) {
        _dateLb = [[UILabel alloc] initWithFrame:CGRectMake(20, 42, 100, 14)];
        _dateLb.font = [UIFont systemFontOfSize:14];
        _dateLb.textColor = TEXTGRAYCOLOR;
    }
    return _dateLb;
}

- (UILabel *)moneyLb {
    if (!_moneyLb) {
        _moneyLb = [[UILabel alloc] initWithFrame:CGRectMake(kSystemWide-100, 13, 100, 44)];
        _moneyLb.font = [UIFont systemFontOfSize:22];
        _moneyLb.textColor = MAINCOLOR;
    }
    return _moneyLb;
}

- (void)awakeFromNib {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    [self.contentView addSubview:self.shareLb];
    [self.contentView addSubview:self.dateLb];
    [self.contentView addSubview:self.moneyLb];
}

- (void)refreshWithModel:(NSDictionary *)model{
    self.shareLb.text = @"分享收益";
    NSRange range = NSMakeRange(0, 10);
    self.dateLb.text = [model[@"createtime"] substringWithRange:range];
    self.moneyLb.text = [NSString stringWithFormat:@"%@",model[@"amount"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
