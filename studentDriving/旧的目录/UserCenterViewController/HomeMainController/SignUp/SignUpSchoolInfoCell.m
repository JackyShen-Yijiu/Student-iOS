//
//  SignUpSchoolInfoCell.m
//  studentDriving
//
//  Created by ytzhang on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SignUpSchoolInfoCell.h"

@interface SignUpSchoolInfoCell ()

@end

@implementation SignUpSchoolInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.detailLabel];
}
- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
    _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _rightLabel.font = [UIFont systemFontOfSize:16];

    }
    return _rightLabel;
}
- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _detailLabel.font = [UIFont systemFontOfSize:16];
        _detailLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _detailLabel;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(20);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@10);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(20);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@10);
    }];
}
@end
