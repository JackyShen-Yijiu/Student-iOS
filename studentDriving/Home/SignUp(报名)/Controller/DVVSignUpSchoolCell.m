//
//  DVVSignUpSchoolCell.m
//  studentDriving
//
//  Created by 大威 on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVSignUpSchoolCell.h"

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
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
