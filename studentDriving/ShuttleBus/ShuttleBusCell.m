//
//  ShuttleBusCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ShuttleBusCell.h"

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
    }
    return self;
}

- (void)refreshData:(DrivingDetailDMSchoolbusroute *)dmBus {
    
    _titleLabel.text = dmBus.routename;
    _contentLabel.text = dmBus.routecontent;
}

+ (CGFloat)dynamicHeight:(NSString *)string {
    
    return [self autoHeightWithString:string width:[UIScreen mainScreen].bounds.size.width - 8 * 2 font:[UIFont systemFontOfSize:14]] + 18 + 8;
}

+ (CGFloat)autoHeightWithString:(NSString *)string width:(CGFloat)width font:(UIFont *)font {
    
    CGSize boundRectSize = CGSizeMake(width, MAXFLOAT);
    NSDictionary *fontDict = @{ NSFontAttributeName: font };
    CGFloat newFloat = [string boundingRectWithSize:boundRectSize
                                            options: NSStringDrawingUsesLineFragmentOrigin
                        | NSStringDrawingUsesFontLeading
                                         attributes:fontDict context:nil].size.height;
    return newFloat;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
