//
//  JZSignUpTopCell.m
//  studentDriving
//
//  Created by ytzhang on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZSignUpTopCell.h"

@interface JZSignUpTopCell ()<UITextFieldDelegate>

@property (nonatomic, copy) signUpRowCell_TextFieldBlock didBeginEditingBlock;
@property (nonatomic, copy) signUpRowCell_TextFieldBlock didEndEditingBlock;

@end

@implementation JZSignUpTopCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.lineView];
    
}
- (void)layoutSubviews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.top.mas_equalTo(self.contentView.mas_top).offset(16);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@56);
        
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.top.mas_equalTo(self.contentView.mas_top).offset(15);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@8);
        
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrowImageView.mas_left).offset(-8);
        make.top.mas_equalTo(self.contentView.mas_top).offset(16);
        make.height.mas_equalTo(@14);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        make.height.mas_equalTo(@0.5);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        
    }];
    
}
#pragma mark --- Lazy 加载
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"你的姓名";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
    }
    return _titleLabel;
}
- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont systemFontOfSize:14];
        _rightLabel.text = @"一步互联网驾校";
        _rightLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
    
    }
    return _rightLabel;
}
- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more_right"]];
    }
    return _arrowImageView;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}
#pragma mark - set block

- (void)dvvBaseDoubleRowCell_setTextFieldDidBeginEditingBlock:(signUpRowCell_TextFieldBlock)didBeginEditingBlock {
    _didBeginEditingBlock = didBeginEditingBlock;
}

- (void)dvvBaseDoubleRowCell_setTextFieldDidEndEditingBlock:(signUpRowCell_TextFieldBlock)didEndEditingBlock {
    _didEndEditingBlock = didEndEditingBlock;
}


@end
