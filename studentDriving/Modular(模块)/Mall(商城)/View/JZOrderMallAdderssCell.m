//
//  JZOrderMallAdderssCell.m
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZOrderMallAdderssCell.h"


@interface JZOrderMallAdderssCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *addressLabel;


@end
@implementation JZOrderMallAdderssCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
     self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.addressLabel];
    
}
- (void)layoutSubviews{
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@14);
        
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(0);
        make.height.mas_equalTo(@14);
        
    }];
    
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"领取地点:";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = JZ_FONTCOLOR_DRAK;
    }
    return _titleLabel;
}
- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"北京致远驾校前厅超市";
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = JZ_FONTCOLOR_DRAK;
        _addressLabel.textAlignment = NSTextAlignmentRight;
    }
    return _addressLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
@end
