//
//  YBUserCenterCell.m
//  studentDriving
//
//  Created by 大威 on 16/3/1.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBUserCenterCell.h"

@implementation YBUserCenterCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBUserCenterCell" owner:self options:nil];
        self = xibArray.firstObject;
        [self setRestorationIdentifier:reuseIdentifier];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.lineImageView];
        _titleLabel.textColor = [UIColor grayColor];
        _subTitleLabel.textColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    CGFloat minX = CGRectGetMinX(_titleLabel.frame);
    _lineImageView.frame = CGRectMake(minX, size.height - 0.5, size.width - minX, 0.5);
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    }
    return _lineImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
