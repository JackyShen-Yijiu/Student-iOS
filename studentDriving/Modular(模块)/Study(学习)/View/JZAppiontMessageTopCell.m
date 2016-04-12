//
//  JZAppiontMessageTopCell.m
//  studentDriving
//
//  Created by ytzhang on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZAppiontMessageTopCell.h"


@interface JZAppiontMessageTopCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *desLabel;

@property (nonatomic, strong) UIView *lineView;
@end
@implementation JZAppiontMessageTopCell

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
    [self.contentView addSubview:self.desLabel];
    [self.contentView addSubview:self.lineView];
    
}
- (void)layoutSubviews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@14);
        
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(0);
        make.height.mas_equalTo(@14);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
        make.height.mas_equalTo(@0.5);
        
    }];

    
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"姓名";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = JZ_FONTCOLOR_DRAK;
    }
    return _titleLabel;
}
- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.text = @"刘杰";
        _desLabel.font = [UIFont systemFontOfSize:14];
        _desLabel.textColor = JZ_FONTCOLOR_DRAK;
        _desLabel.textAlignment = NSTextAlignmentRight;
    }
    return _desLabel;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
