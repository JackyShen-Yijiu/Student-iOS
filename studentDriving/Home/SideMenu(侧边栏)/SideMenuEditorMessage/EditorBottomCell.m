//
//  EditorBottomCell.m
//  studentDriving
//
//  Created by zyt on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "EditorBottomCell.h"

@interface EditorBottomCell ()

@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *lineBottom;
@end
@implementation EditorBottomCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.lineBottom];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(28);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@10);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.width.mas_equalTo(@24);
        make.height.mas_equalTo(24);
    }];
    [self.lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(28);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@0.5);
    }];
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = @"我的喜欢";        
        _titleLabel.textColor = [UIColor colorWithHexString:@"757575"];
        
    }
    return _titleLabel;
}

- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.backgroundColor  = [UIColor clearColor];
        _arrowImageView.image = [UIImage imageNamed:@"箭头"];
    }
    return _arrowImageView;
    
}
- (UIView *)lineBottom{
    if (_lineBottom == nil) {
        _lineBottom = [[UIView alloc] init];
        _lineBottom.backgroundColor = HM_LINE_COLOR;
    }
    return _lineBottom;
}

@end
