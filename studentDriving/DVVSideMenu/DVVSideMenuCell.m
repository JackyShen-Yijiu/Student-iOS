//
//  DVVSideMenuCell.m
//  DVVSideMenu
//
//  Created by 大威 on 15/12/22.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "DVVSideMenuCell.h"

@implementation DVVSideMenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.backgroundImageView];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.markLabel];
        
//        _iconImageView.backgroundColor = [UIColor redColor];
//        _nameLabel.backgroundColor = [UIColor greenColor];
//        _contentLabel.backgroundColor = [UIColor blackColor];
//        _markLabel.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat selfWidth = self.contentView.bounds.size.width;
    CGFloat selfHeight = self.contentView.bounds.size.height;
    
    self.backgroundImageView.frame = CGRectMake(0, 0, selfWidth, selfHeight);
//    self.iconImageView.frame = CGRectMake(20, 9, 25, 25);
    self.iconImageView.frame = CGRectMake(0, 0, 0, 0);
    CGFloat minX = CGRectGetMaxX(self.iconImageView.frame) + 15;
    CGFloat rightMargin = 15;
    CGFloat labelWidth = selfWidth - minX;
    self.nameLabel.frame = CGRectMake(minX,
                                      CGRectGetMinY(self.iconImageView.frame),
                                      labelWidth - rightMargin,
                                      selfHeight);
    self.markLabel.frame = CGRectMake(selfWidth - 26 - rightMargin, 0, 26, selfHeight);
    self.contentLabel.frame = CGRectMake(0, 0, selfWidth - 26 - rightMargin, selfHeight);
}

#pragma mark - lazy load
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
    }
    return _backgroundImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textColor = [UIColor redColor];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textAlignment = 2;
    }
    return _contentLabel;
}
- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [UILabel new];
        _markLabel.font = [UIFont systemFontOfSize:13];
        _markLabel.textColor = [UIColor whiteColor];
    }
    return _markLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
