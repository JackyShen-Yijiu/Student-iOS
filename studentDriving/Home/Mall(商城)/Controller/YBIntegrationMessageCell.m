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
@property (nonatomic, assign) NSInteger indexTag;


@end
@implementation YBIntegrationMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tag:(NSInteger)tag{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.indexTag = tag;
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.describleTextField];
    [self addSubview:self.showWarningMessageView];
    [self addSubview:self.lineView];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
     NSLog(@"%lu",textField.tag);
    if (503 == self.showWarningMessageView.tag) {
        self.showWarningMessageView.hidden = YES;
    }
    if (504 == self.showWarningMessageView.tag) {
        self.showWarningMessageView.hidden = YES;
    }
    if (505 == self.showWarningMessageView.tag) {
        self.showWarningMessageView.hidden = YES;
    }
    if (603 == self.showWarningMessageView.tag) {
        self.showWarningMessageView.hidden = YES;
    }
    if (604 == self.showWarningMessageView.tag) {
        self.showWarningMessageView.hidden = YES;
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    // 积分商城
    if (503 == textField.tag) {
        // 地址输入结束
        if (textField.text.length > 30 || textField.text.length <= 0) {
            if (503 == self.showWarningMessageView.tag) {
                self.showWarningMessageView.hidden = NO;
                return;
            }
        }
    }
    if (504 == textField.tag) {
        // 姓名输入结束
        if (textField.text.length > 6 || textField.text.length <= 0) {
            if (504 == self.showWarningMessageView.tag) {
                self.showWarningMessageView.hidden = NO;
                return;
            }
        }

    }
    if (505 == textField.tag) {
        // 联系电话输入结束
        if (textField.text.length > 11 || textField.text.length <= 0) {
            if (505 == self.showWarningMessageView.tag) {
                self.showWarningMessageView.hidden = NO;
                return;
            }
        }

    }
    
    // 兑换劵商城
    if (603 == textField.tag) {
        // 姓名输入结束
        if (textField.text.length > 6 || textField.text.length <= 0) {
            if (603 == self.showWarningMessageView.tag) {
                self.showWarningMessageView.hidden = NO;
                return;
            }
        }
        
    }
    if (604 == textField.tag) {
        // 联系电话输入结束
        if (textField.text.length > 11 || textField.text.length <= 0) {
            if (604 == self.showWarningMessageView.tag) {
                self.showWarningMessageView.hidden = NO;
                return;
            }
        }
        
    }

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
        make.height.mas_equalTo(@0.5);
    }];
    [self.showWarningMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.width.mas_equalTo(@105);
        make.height.mas_equalTo(@20);
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
         _describleTextField.tag = self.indexTag;
    }
    return _describleTextField;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
        
    }
    return _lineView;
}
- (ShowWarningMessageView *)showWarningMessageView{
    if (_showWarningMessageView == nil) {
        _showWarningMessageView = [[ShowWarningMessageView alloc] init];
//        _showWarningMessageView.backgroundColor = [UIColor cyanColor];
        _showWarningMessageView.hidden = YES;
        _showWarningMessageView.tag = self.indexTag;
        
    }
    return _showWarningMessageView;
}
@end
