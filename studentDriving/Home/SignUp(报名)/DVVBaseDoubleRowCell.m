//
//  DVVBaseDoubleRowCell.m
//  studentDriving
//
//  Created by 大威 on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVBaseDoubleRowCell.h"

@interface DVVBaseDoubleRowCell ()

@property (nonatomic, copy) DVVBaseDoubleRowCell_TextFieldBlock didBeginEditingBlock;
@property (nonatomic, copy) DVVBaseDoubleRowCell_TextFieldBlock didEndEditingBlock;

@end

@implementation DVVBaseDoubleRowCell

#pragma mark - init

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.promptImageView];
        [self.contentView addSubview:self.promptLabel];
        [self.contentView addSubview:self.detailTextField];
        [self.contentView addSubview:self.separatorImageView];
    }
    return self;
}

#pragma mark - config UI

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    // 标题的高度
    CGFloat titleHeight = size.height / 2.0f;
    // 左右边距
    CGFloat leftMargin = 16;
    CGFloat rightMargin = 16;
    
    _titleLabel.frame = CGRectMake(leftMargin, 0, size.width/2.f - leftMargin, titleHeight);
    _detailTextField.frame = CGRectMake(leftMargin, titleHeight, size.width - leftMargin - rightMargin, size.height - titleHeight);
    
    _separatorImageView.frame = CGRectMake(leftMargin, size.height - 0.5, size.width - leftMargin - rightMargin, 0.5);
    
    // 提示图片的宽度
    CGFloat promptImageWidth = 24;
    _promptLabel.frame = CGRectMake(size.width/2.f, 0, size.width/2.f - rightMargin - promptImageWidth, titleHeight);
    _promptImageView.frame = CGRectMake(CGRectGetMaxX(_promptLabel.frame), 0, promptImageWidth, titleHeight);
    
    [self hidePrompt];
}

#pragma mark - public

- (void)showPrompt {
    _promptLabel.hidden = NO;
    _promptImageView.hidden = NO;
}

- (void)hidePrompt {
    _promptLabel.hidden = YES;
    _promptImageView.hidden = YES;
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


#pragma mark - lazy load

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return _titleLabel;
}

- (UITextField *)detailTextField {
    if (!_detailTextField) {
        _detailTextField = [UITextField new];
        _detailTextField.font = [UIFont systemFontOfSize:14];
        _detailTextField.tintColor = [UIColor lightGrayColor];
        _detailTextField.delegate = self;
    }
    return _detailTextField;
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [UILabel new];
        _promptLabel.textAlignment = NSTextAlignmentRight;
        _promptLabel.text = @"您填写的信息有误";
        _promptLabel.font = [UIFont systemFontOfSize:10];
        _promptLabel.textColor = YBNavigationBarBgColor;
    }
    return _promptLabel;
}

- (UIImageView *)promptImageView {
    if (!_promptImageView) {
        _promptImageView = [UIImageView new];
        _promptImageView.contentMode = UIViewContentModeCenter;
        _promptImageView.image = [UIImage imageNamed:@"warning_Message"];
    }
    return _promptImageView;
}

- (UIImageView *)separatorImageView {
    if (!_separatorImageView) {
        _separatorImageView = [UIImageView new];
        _separatorImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }
    return _separatorImageView;
}

#pragma mark - set block

- (void)dvvBaseDoubleRowCell_setTextFieldDidBeginEditingBlock:(DVVBaseDoubleRowCell_TextFieldBlock)didBeginEditingBlock {
    _didBeginEditingBlock = didBeginEditingBlock;
}

- (void)dvvBaseDoubleRowCell_setTextFieldDidEndEditingBlock:(DVVBaseDoubleRowCell_TextFieldBlock)didEndEditingBlock {
    _didEndEditingBlock = didEndEditingBlock;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
