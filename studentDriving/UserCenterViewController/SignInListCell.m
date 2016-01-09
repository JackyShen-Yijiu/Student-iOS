//
//  SignInListCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/8.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SignInListCell.h"

@implementation SignInListCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.coachNameLabel];
        [self.contentView addSubview:self.beginTimeLabel];
        [self.contentView addSubview:self.markLabel];
        [self.contentView addSubview:self.signInStatusLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    
    _coachNameLabel.frame = CGRectMake(15, 0, viewWidth - 15 - 100, 44);
    _beginTimeLabel.frame = CGRectMake(viewWidth - 100, 0, 85, 44);
    _markLabel.frame = CGRectMake(15, 25, viewWidth - 30, 44);
    _signInStatusLabel.frame = CGRectMake(viewWidth- 80 - 15, 25, 80, 44);
}

- (UILabel *)coachNameLabel {
    if (!_coachNameLabel) {
        _coachNameLabel = [UILabel new];
        _coachNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _coachNameLabel;
}
- (UILabel *)beginTimeLabel {
    if (!_beginTimeLabel) {
        _beginTimeLabel = [UILabel new];
        _beginTimeLabel.font = [UIFont systemFontOfSize:14];
        _beginTimeLabel.textAlignment = 2;
    }
    return _beginTimeLabel;
}
- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [UILabel new];
        _markLabel.font = [UIFont systemFontOfSize:14];
    }
    return _markLabel;
}
- (UILabel *)signInStatusLabel {
    if (!_signInStatusLabel) {
        _signInStatusLabel = [UILabel new];
        _signInStatusLabel.font = [UIFont systemFontOfSize:14];
        _signInStatusLabel.textAlignment = 2;
    }
    return _signInStatusLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
