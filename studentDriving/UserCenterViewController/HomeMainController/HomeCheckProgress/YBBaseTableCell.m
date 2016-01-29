//
//  YBBaseTableCell.m
//  Headmaster
//
//  Created by zyt on 15/12/5.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseTableCell.h"

@interface YBBaseTableCell()

@property (nonatomic, strong) UIImageView *lineImageView;

@end

@implementation YBBaseTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.lineImageView];
    CGRect rect = self.bounds;
    CGFloat margin = 15;
    CGFloat height = 1;
    self.lineImageView.frame = CGRectMake(margin, rect.size.height - height, rect.size.width - margin * 2, height);
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
        _lineImageView.layer.shadowColor = [UIColor whiteColor].CGColor;
        _lineImageView.layer.shadowOffset = CGSizeMake(0, 1);
        _lineImageView.layer.shadowOpacity = 0.3;
        _lineImageView.layer.shadowRadius = 1;
    }
    return _lineImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
