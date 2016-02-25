//
//  DrivingInfoCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailInfoCell.h"

@implementation DrivingDetailInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DrivingDetailInfoCell" owner:self options:nil];
        DrivingDetailInfoCell *cell = xibArray.firstObject;
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
        [self.contentView addSubview:self.lineImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGFloat minX = CGRectGetMinX(_learnTimeLabel.frame);
    _lineImageView.frame = CGRectMake(minX, size.height - 0.5, size.width - minX - 16, 0.5);
}

- (void)refreshData:(DrivingDetailDMData *)dmData {
    
    if (dmData.passingrate) {
        _passRateLabel.text = [NSString stringWithFormat:@"%zi%%", dmData.passingrate];
    }else {
        _passRateLabel.text = @"暂无";
    }
    if (dmData.hours && dmData.hours.length) {
        _learnTimeLabel.text = [NSString stringWithFormat:@"营业时间：%@", dmData.hours];
    }else {
        _learnTimeLabel.text = [NSString stringWithFormat:@"营业时间：未填写"];
    }
}

+ (CGFloat)defaultHeight {
    return 85.f;
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }
    return _lineImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
