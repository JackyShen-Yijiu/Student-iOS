//
//  YBIntegrationMessageCell.m
//  studentDriving
//
//  Created by zyt on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBIntegrationMessageCell.h"

@interface YBIntegrationMessageCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *lineView;


@end
@implementation YBIntegrationMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.describleTextField];
    [self addSubview:self.lineView];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@10);
    }];
    [self.describleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@24);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.describleTextField.mas_bottom).offset(15);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@0.7);
    }];
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"商品名称";
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
    }
    return _titleLabel;
}
- (UITextField *)describleTextField{
    if (_describleTextField == nil) {
        _describleTextField = [[UITextField alloc]init];
        _describleTextField.delegate = self;
        _describleTextField.font  = [UIFont systemFontOfSize:14];
        _describleTextField.textColor = [UIColor colorWithHexString:@"212121"];
        _describleTextField.text = @"北京市海淀区";
    }
    return _describleTextField;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"bdbdbd"];
        _lineView.alpha = 0.7;
    }
    return _lineView;
}
@end
