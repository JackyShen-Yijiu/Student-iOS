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
    }
    return self;
}

- (void)refreshData:(DrivingDetailDMData *)dmData {
    
    _passRateLabel.text = [NSString stringWithFormat:@"通  过  率：%zi%%", dmData.passingrate];
    _learnTimeLabel.text = [NSString stringWithFormat:@"营业时间：%@", dmData.hours];
}

+ (CGFloat)defaultHeight {
    return 95.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
