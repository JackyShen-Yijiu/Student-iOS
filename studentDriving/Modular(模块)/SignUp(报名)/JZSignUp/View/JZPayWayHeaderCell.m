//
//  JZPayWayHeaderCell.m
//  studentDriving
//
//  Created by ytzhang on 16/3/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZPayWayHeaderCell.h"

@implementation JZPayWayHeaderCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"JZPayWayHeaderCell" owner:self options:nil];
        JZPayWayHeaderCell *cell = xibArray.firstObject;
        self = cell;
        [self setRestorationIdentifier:reuseIdentifier];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)setDmdata:(ClassTypeDMData *)dmdata{
    
    self.driveIconImageView.image = [UIImage imageNamed:@"background_mine"];
    self.driveName.text = dmdata.schoolinfo.name;
    
    NSString *addressStr = nil;
    if (dmdata.schoolinfo.address == nil || [dmdata.schoolinfo.address isEqualToString:@""]) {
        addressStr = @"暂无";
    }else {
        addressStr = dmdata.schoolinfo.address;
    }

    self.address.text = [NSString stringWithFormat:@"地址:%@",addressStr];

    NSString *coachStr = nil;
    if (dmdata.coachName == nil || [dmdata.coachName isEqualToString:@""]) {
        coachStr = @"暂无";
    }else {
        coachStr = dmdata.coachName;
    }
    self.coachName.text = [NSString stringWithFormat:@"报考教练:%@",coachStr];
}
@end
