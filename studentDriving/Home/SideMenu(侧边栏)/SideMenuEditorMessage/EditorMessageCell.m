//
//  EditorMessageCell.m
//  studentDriving
//
//  Created by zyt on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "EditorMessageCell.h"

@interface EditorMessageCell ()
@property (nonatomic, strong) UIView *lineBottom;
@end

@implementation EditorMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.describeLabel];
    [self addSubview:self.lineBottom];
}
- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@10);
    }];
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@14);
    }];
    [self.lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.describeLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@1);
    }];
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.text = @"报考驾校";
        
        _titleLabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        
    }
    return _titleLabel;
}
- (UILabel *)describeLabel{
    if (_describeLabel == nil) {
        _describeLabel = [[UILabel alloc] init];
//        _describeLabel.backgroundColor = [UIColor cyanColor];
        _describeLabel.text = @"一步互联网驾校";
        _describeLabel.font = [UIFont systemFontOfSize:14];
        _describeLabel.textColor = [UIColor colorWithHexString:@"212121"];
        
    }
    return _describeLabel;
}
- (UIView *)lineBottom{
    if (_lineBottom == nil) {
        _lineBottom = [[UIView alloc] init];
        _lineBottom.backgroundColor = [UIColor colorWithHexString:@"bdbdbd"];
    }
    return _lineBottom;
}

@end
