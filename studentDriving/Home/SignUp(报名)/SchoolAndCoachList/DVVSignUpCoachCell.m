//
//  DVVSignUpCoachCell.m
//  studentDriving
//
//  Created by 大威 on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVSignUpCoachCell.h"
#import "UIImageView+DVVWebImage.h"

@implementation DVVSignUpCoachCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DVVSignUpCoachCell" owner:self options:nil];
        DVVSignUpCoachCell *cell = xibArray.firstObject;
        self = cell;
        [self setRestorationIdentifier:reuseIdentifier];
        
        [self.contentView addSubview:self.starView];
        [self.contentView addSubview:self.lineImageView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [_iconImageView.layer setMasksToBounds:YES];
        [_iconImageView.layer setCornerRadius:20];
        
        _nameLabel.textColor = [UIColor colorWithHexString:@"#212121"];
        _schoolNameLabel.textColor = [UIColor colorWithHexString:@"757575"];
        _distanceLabel.textColor = [UIColor colorWithHexString:@"757575"];
        _priceLabel.textColor = [UIColor colorWithHexString:@"DB4437"];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    _starView.frame = CGRectMake(size.width - 94 - 16, 16, 94, 14);
    CGFloat minX = CGRectGetMinX(_nameLabel.frame);
    _lineImageView.frame = CGRectMake(minX, size.height - 0.5, size.width - minX - 16, 0.5);
}

- (void)refreshData:(DVVSignUpCoachDMData *)dmData {
    
    if (dmData.headportrait.originalpic && dmData.headportrait.originalpic.length) {
        [_iconImageView dvv_downloadImage:dmData.headportrait.originalpic];
    }else {
        NSString *imageName = @"coach_man_default_icon";
        if (dmData.gender && dmData.gender.length) {
            if ([dmData.gender isEqualToString:@"女"]) {
                imageName = @"coach_woman_default_icon";
            }
        }
        _iconImageView.image = [UIImage imageNamed:imageName];
    }
    
    if (dmData.name) {
        _nameLabel.text = dmData.name;
    }else {
        _nameLabel.text = @"未填写教练名";
    }
    if (dmData.driveschoolinfo.name) {
        _schoolNameLabel.text = dmData.driveschoolinfo.name;
    }else {
        _schoolNameLabel.text = @"未填写所属驾校";
    }
    if (dmData.minprice) {
        _priceLabel.text = [NSString stringWithFormat:@"%li元起",dmData.minprice];
    }else {
        _priceLabel.text = @"未填写价格";
    }
    if (dmData.distance) {
        _distanceLabel.text = [NSString stringWithFormat:@"距您%.2fkm",dmData.distance / 1000.f];
    }else {
        _distanceLabel.text = @"暂无距离信息";
    }
    if (dmData.starlevel) {
        [_starView dvv_setStar:dmData.starlevel];
    }else {
        [_starView dvv_setStar:0];
    }
}

- (DVVStarView *)starView {
    if (!_starView) {
        _starView = [DVVStarView new];
        [_starView dvv_setBackgroundImage:@"star_all_default_icon" foregroundImage:@"star_all_icon" width:94 height:14];
    }
    return _starView;
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
