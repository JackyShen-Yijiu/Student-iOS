//
//  JZShowTitleCell.m
//  studentDriving
//
//  Created by ytzhang on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZShowTitleCell.h"

@implementation JZShowTitleCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.titleLabel];
        
}
- (void)layoutSubviews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        
    }];
    
}
#pragma mark ---- Lazy 加载
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"你的姓名,你的姓名,你的姓名,你的姓名";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
    }
    return _titleLabel;
}

@end
