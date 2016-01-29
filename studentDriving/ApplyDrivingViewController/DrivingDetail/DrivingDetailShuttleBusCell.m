//
//  DrivingDetailShuttleBusCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailShuttleBusCell.h"
#import "NSString+Helper.h"

@implementation DrivingDetailShuttleBusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)refreshData:(DrivingDetailDMData *)dmData {
    
    NSMutableArray *array = [NSMutableArray array];
    for (DrivingDetailDMSchoolbusroute *item in dmData.schoolbusroute) {
        [array addObject:item.routename];
    }
    NSString *string = [array componentsJoinedByString:@"--"];
    _shuttleBusLabel.text = string;
}

+ (CGFloat)dynamicHeight:(NSString *)string {
    
    return [NSString autoHeightWithString:string width:[UIScreen mainScreen].bounds.size.width - 8 * 2 font:[UIFont systemFontOfSize:14]] + 8 + 21 + 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
