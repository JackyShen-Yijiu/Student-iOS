//
//  DuideDetailCell.m
//  studentDriving
//
//  Created by ytzhang on 16/2/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DuideDetailCell.h"




@interface DuideDetailCell ()

@end

@implementation DuideDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.deTextView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(20);
        make.height.mas_equalTo(@14);
    }];
    [self.deTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];

    
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.text = @"1、注册成功";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithHexString:@"212121"];
        
    }
    return _titleLabel;
}
- (UITextView *)deTextView{
    if (_deTextView == nil) {
        _deTextView = [[UITextView alloc] init];
        _deTextView.backgroundColor = [UIColor clearColor];
        _deTextView.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _deTextView.font = [UIFont systemFontOfSize:10];
        _deTextView.userInteractionEnabled = NO;
        _deTextView.text = @"  APP下载安装完成后，按照流程填写验证手机号进行\n注册，注册完成后点击“报名”，在页面中通过筛选驾校和教练选择自己满意的驾校并进行报名.";
    }
    return _deTextView;
}
@end
