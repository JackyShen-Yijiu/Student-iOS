//
//  ShuttleBusCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ShuttleBusCell.h"
#import "NSString+Helper.h"

@implementation ShuttleBusCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"ShuttleBusCell" owner:self options:nil];
        ShuttleBusCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
        _titleLabel.textColor = MAINCOLOR;
//        self.contentView.backgroundColor = [UIColor colorWithRed:247 green:249 blue:251 alpha:1];
    }
    return self;
}

- (void)refreshData:(DrivingDetailDMSchoolbusroute *)dmBus {
    
    _titleLabel.text = dmBus.routename;
    _contentLabel.text = dmBus.routecontent;
}

+ (CGFloat)dynamicHeight:(NSString *)string {
    
    return 8 + 8 + 21 + 8 + [NSString autoHeightWithString:string width:[UIScreen mainScreen].bounds.size.width - 8 * 2 font:[UIFont systemFontOfSize:14]] + 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
