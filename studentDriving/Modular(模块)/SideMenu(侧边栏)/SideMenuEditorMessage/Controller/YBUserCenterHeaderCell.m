//
//  YBUserCenterHeaderCell.m
//  studentDriving
//
//  Created by 大威 on 16/3/1.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBUserCenterHeaderCell.h"
#import "UIImageView+DVVWebImage.h"

@implementation YBUserCenterHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBUserCenterHeaderCell" owner:self options:nil];
        self = xibArray.firstObject;
        [self setRestorationIdentifier:reuseIdentifier];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [_iconImageView.layer setMasksToBounds:YES];
        [_iconImageView.layer setCornerRadius:54/2.f];
        _subTitleLabel.textColor = [UIColor lightGrayColor];
        
        [self.iconImageView dvv_downloadImage:[AcountManager manager].userHeadImageUrl placeholderImage:[UIImage imageNamed:@"coach_man_default_icon"]];
        self.subTitleLabel.text = @"更换头像";
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
