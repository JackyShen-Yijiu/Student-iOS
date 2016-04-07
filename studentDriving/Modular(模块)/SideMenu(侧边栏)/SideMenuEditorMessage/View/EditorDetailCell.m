//
//  EditorDetailCell.m
//  studentDriving
//
//  Created by zyt on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "EditorDetailCell.h"

@interface EditorDetailCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *lineBottom;
@property (nonatomic, assign) NSInteger indexTag;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end
@implementation EditorDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tag:(NSInteger)tag{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.indexTag = tag;
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.toplabel];
    [self addSubview:self.descriTextField];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.showWarningMessageView];
    [self addSubview:self.lineBottom];
//    self.descriTextField.delegate = self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
// 开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (300 == self.showWarningMessageView.tag) {
        self.showWarningMessageView.hidden = YES;
    }
    if (301 == self.showWarningMessageView.tag) {
        self.showWarningMessageView.hidden = YES;
    }
    if (303 == self.showWarningMessageView.tag) {
        self.showWarningMessageView.hidden = YES;
    }
    
}
// 编辑结束
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%lu",textField.tag);
    if (textField.tag == 300) {
        // 姓名编辑
        if (textField.text.length > 6 || textField.text.length <= 0) {
            if (300 == self.showWarningMessageView.tag ) {
                self.showWarningMessageView.hidden = NO;
                return;
            }
        }
    }else if (textField.tag == 301){
        // 昵称编辑
            if ([textField.text length] > 20) {
                if (301 == self.showWarningMessageView.tag) {
                    self.showWarningMessageView.hidden = NO;
                }
                return;
            }
            
        
        
    }else if (textField.tag == 302){
        // 绑定手机号编辑
    }else if (textField.tag == 303){
        // 我的地址编辑
        if ([textField.text length] > 20) {
            if (303 == self.showWarningMessageView.tag) {
                self.showWarningMessageView.hidden = NO;
            }
            return;
        }

    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.toplabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@10);
    }];
    [self.descriTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.toplabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@18);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.width.mas_equalTo(@24);
        make.height.mas_equalTo(24);
    }];
    [self.showWarningMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.width.mas_equalTo(@105);
        make.height.mas_equalTo(@20);
    }];

    [self.lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descriTextField.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@0.5);
    }];

}
- (UILabel *)toplabel{
    if (_toplabel == nil) {
        _toplabel = [[UILabel alloc] init];
        _toplabel.font = [UIFont systemFontOfSize:10];
        _toplabel.text = @"姓名";
        _toplabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        
    }
    return _toplabel;
}
- (UITextField *)descriTextField{
    if (_descriTextField == nil) {
        _descriTextField = [[UITextField alloc] init];
        _descriTextField.font = [UIFont systemFontOfSize:14];
        _descriTextField.textColor = [UIColor colorWithHexString:@"212121"];
        _descriTextField.tag = self.indexTag;
        _descriTextField.delegate = self;
        
    }
    return _descriTextField;
}

- (UIView *)lineBottom{
    if (_lineBottom == nil) {
        _lineBottom = [[UIView alloc] init];
        _lineBottom.backgroundColor = HM_LINE_COLOR;
    }
    return _lineBottom;
}
- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.backgroundColor  = [UIColor clearColor];
        _arrowImageView.image = [UIImage imageNamed:@"箭头"];
        _arrowImageView.hidden = YES;
        if (self.indexTag == 302) {
            NSLog(@"%lu",self.indexTag);
            _arrowImageView.hidden = NO;
        }
    }
    return _arrowImageView;
    
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
