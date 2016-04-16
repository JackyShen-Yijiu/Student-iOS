//
//  JZSignUpCell.m
//  studentDriving
//
//  Created by ytzhang on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZSignUpCell.h"

@interface JZSignUpCell ()<UITextFieldDelegate>

@property (nonatomic, copy) SignUpRowCell_TextFieldBlock didBeginEditingBlock;
@property (nonatomic, copy) SignUpRowCell_TextFieldBlock didEndEditingBlock;

@end

@implementation JZSignUpCell
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
    [self.contentView addSubview:self.desTextFiled];
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
    [self.desTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(14);
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@170);
        
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.top.mas_equalTo(self.contentView.mas_top).offset(15);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@8);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        make.height.mas_equalTo(@0.5);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        
    }];

}
#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_didBeginEditingBlock) {
        _didBeginEditingBlock(textField, self);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_didEndEditingBlock) {
        _didEndEditingBlock(textField, self);
    }
}

#pragma mark --- Lazy 加载
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"报考驾校";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithHexString:@"2f2f2f"];
    }
    return _titleLabel;
}
- (UITextField *)desTextFiled{
    if (_desTextFiled == nil) {
        _desTextFiled = [[UITextField alloc] init];
        _desTextFiled.font = [UIFont systemFontOfSize:14];
        _desTextFiled.delegate = self;
        _desTextFiled.textColor = JZ_FONTCOLOR_LIGHT;
        [_desTextFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        [_desTextFiled setValue:JZ_FONTCOLOR_LIGHT forKeyPath:@"placeholderLabel.textColor"];
    }
    return _desTextFiled;
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

- (void)dvvBaseDoubleRowCell_setTextFieldDidBeginEditingBlock:(SignUpRowCell_TextFieldBlock)didBeginEditingBlock {
    _didBeginEditingBlock = didBeginEditingBlock;
}

- (void)dvvBaseDoubleRowCell_setTextFieldDidEndEditingBlock:(SignUpRowCell_TextFieldBlock)didEndEditingBlock {
    _didEndEditingBlock = didEndEditingBlock;
}

@end
