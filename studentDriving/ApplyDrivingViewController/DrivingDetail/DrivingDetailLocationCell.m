//
//  DrivingDetailLocationCell.m
//  studentDriving
//
//  Created by 大威 on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailLocationCell.h"

@implementation DrivingDetailLocationCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DrivingDetailLocationCell" owner:self options:nil];
        DrivingDetailLocationCell *cell = xibArray.firstObject;
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.lineImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGFloat minX = CGRectGetMinX(_priceLabel.frame);
    _lineImageView.frame = CGRectMake(minX, size.height - 0.5, size.width - minX - 16, 0.5);
}

- (void)refreshData:(DrivingDetailDMData *)dmData {
    
    if (dmData.minprice || dmData.maxprice) {
        _priceLabel.text = [NSString stringWithFormat:@"%zi-%zi", dmData.minprice, dmData.maxprice];
    }else {
        _priceLabel.text = @"未填写价格";
    }
    if (dmData.address && dmData.address.length) {
        _locationLabel.text = [NSString stringWithFormat:@"%@", dmData.address];
    }else {
        _locationLabel.text = @"未填写地址信息";
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
