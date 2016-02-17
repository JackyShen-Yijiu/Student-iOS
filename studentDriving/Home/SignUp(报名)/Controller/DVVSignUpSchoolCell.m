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
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
    }
    return self;
}

- (void)refreshData:(DVVSignUpSchoolDMData *)dmData {
    [_iconImageView dvv_downloadImage:dmData.logoimg.originalpic
                     placeholderImage:[UIImage imageNamed:@"120"]];
    if (dmData.name) {
        _nameLabel.text = dmData.name;
    }
    if (dmData.address) {
        _addressLabel.text = dmData.address;
    }
    if (dmData.minprice && dmData.maxprice) {
        _priceLabel.text = [NSString stringWithFormat:@"¥%i-¥%i",dmData.minprice,dmData.maxprice];
    }
    if (dmData.distance) {
        _distanceLabel.text = [NSString stringWithFormat:@"距离%.2fkm",dmData.distance / 1000.f];
    }
    if (dmData.schoollevel) {
        [_starBar displayRating:[dmData.schoollevel integerValue]];
    }
}

- (RatingBar *)starBar {
    if (!_starBar) {
        _starBar = [RatingBar new];
        [_starBar setImageDeselected:@"starUnSelected.png" halfSelected:nil fullSelected:@"starSelected.png" andDelegate:nil];
        [_starBar displayRating:3];
    }
    return _starBar;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
