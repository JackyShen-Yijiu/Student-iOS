//
//  YBCheatslistViewCell.m
//  studentDriving
//
//  Created by JiangangYang on 16/3/1.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBCheatslistViewCell.h"

@implementation YBCheatslistViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBCheatslistViewCell" owner:self options:nil];
        YBCheatslistViewCell *cell = xibArray.firstObject;
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
