//
//  CityListCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "CityListCell.h"

@implementation CityListCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.bottomLineImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    _nameLabel.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    _bottomLineImageView.frame = CGRectMake(8, rect.size.height - 1, rect.size.width - 8*2, 0.5);
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}
- (UIImageView *)bottomLineImageView{
    if (!_bottomLineImageView) {
        _bottomLineImageView = [UIImageView new];
        _bottomLineImageView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    }
    return _bottomLineImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
