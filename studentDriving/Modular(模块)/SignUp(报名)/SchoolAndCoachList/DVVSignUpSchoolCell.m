//
//  DVVSignUpSchoolCell.m
//  studentDriving
//
//  Created by 大威 on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVSignUpSchoolCell.h"
#import "UIImageView+DVVWebImage.h"

@implementation DVVSignUpSchoolCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DVVSignUpSchoolCell" owner:self options:nil];
        DVVSignUpSchoolCell *cell = xibArray.firstObject;
        self = cell;
        [self setRestorationIdentifier:reuseIdentifier];
        
        [self.contentView addSubview:self.starView];
        [self.contentView addSubview:self.lineImageView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [_iconImageView.layer setMasksToBounds:YES];
        [_iconImageView.layer setCornerRadius:20];
        
        _nameLabel.textColor = [UIColor colorWithHexString:@"#212121"];
        _addressLabel.textColor = [UIColor colorWithHexString:@"757575"];
        _distanceLabel.textColor = [UIColor colorWithHexString:@"757575"];
        _priceLabel.textColor = [UIColor colorWithHexString:@"DB4437"];
        _coachCountLabel.textColor = [UIColor colorWithHexString:@"DB4437"];
        
        if ( ScreenWidthIs_6Plus_OrWider ) {
            _nameLabel.font = [UIFont systemFontOfSize:14*YBRatio];
            _addressLabel.font = [UIFont systemFontOfSize:12*YBRatio];
            _distanceLabel.font = [UIFont systemFontOfSize:12*YBRatio];
            _priceLabel.font = [UIFont systemFontOfSize:14*YBRatio];
            _coachCountLabel.font = [UIFont systemFontOfSize:12*YBRatio];
        }
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

- (void)refreshData:(DVVSignUpSchoolDMData *)dmData {
    
//    DVVSignUpSchoolDMLogoimg *
    
    [_iconImageView dvv_downloadImage:dmData.logoimg.originalpic
                     placeholderImage:[UIImage imageNamed:@"ic_school_header"]];
    NSLog(@"dmData.logoimg.originalpic: %@", dmData.logoimg.originalpic);
    if (dmData.name) {
        _nameLabel.text = dmData.name;
    }else {
        _nameLabel.text = @"未填写驾校名";
    }
    if (dmData.address) {
        _addressLabel.text = dmData.address;
    }else {
        _addressLabel.text = @"未填写地址";
    }
    if (dmData.maxprice) {
        _priceLabel.text = [NSString stringWithFormat:@"¥%lu-¥%lu",dmData.minprice,dmData.maxprice];
    }else {
        _priceLabel.text = @"未填写价格";
    }
    if (dmData.distance) {
        _distanceLabel.text = [NSString stringWithFormat:@"距您%.2fkm",dmData.distance / 1000.f];
    }else {
        _distanceLabel.text = @"暂无距离信息";
    }
    if (dmData.coachcount) {
        _coachCountLabel.text = [NSString stringWithFormat:@"%lu位认证教练", dmData.coachcount];
    }else {
        _coachCountLabel.text = @"暂无认证教练";
    }
    if (dmData.schoollevel) {
        [_starView dvv_setStar:[dmData.schoollevel integerValue]];
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
