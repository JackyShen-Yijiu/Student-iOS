//
//  CheckProgressCell.m
//  studentDriving
//
//  Created by ytzhang on 16/1/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "CheckProgressCell.h"

@interface CheckProgressCell ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic,strong) UITextField *textFiled;
@end

@implementation CheckProgressCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.label];
    [self addSubview:self.textFiled];
}
#pragma mark Layout
- (void)updateConstraints
{
    [super updateConstraints];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(15);
        make.top.mas_equalTo(self).with.offset(10);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@100);
    }];
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).with.offset(15);
        make.left.mas_equalTo(self.label.mas_left).with.offset(10);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@200);
    }];

}

- (UILabel *)label{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}
- (UITextField *)textFiled{
    if (_textFiled == nil) {
        _textFiled = [[UITextField alloc] init];
        
    }
    return _textFiled;
}
@end
