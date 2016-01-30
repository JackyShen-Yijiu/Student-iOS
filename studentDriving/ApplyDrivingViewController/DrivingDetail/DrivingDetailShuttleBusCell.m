//
//  DrivingDetailShuttleBusCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailShuttleBusCell.h"
#import "NSString+Helper.h"
#import "YYModel.h"

@implementation DrivingDetailShuttleBusCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DrivingDetailShuttleBusCell" owner:self options:nil];
        DrivingDetailShuttleBusCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
    }
    return self;
}

- (void)refreshData:(DrivingDetailDMData *)dmData {
    
    _shuttleBusLabel.text = [self.class getShuttlebusString:dmData];
}

+ (NSString *)getShuttlebusString:(DrivingDetailDMData *)dmData {
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *itemDict in dmData.schoolbusroute) {
        DrivingDetailDMSchoolbusroute *dmBusRoute = [DrivingDetailDMSchoolbusroute yy_modelWithDictionary:itemDict];
        [array addObject:dmBusRoute.routename];
    }
    NSString *string = [array componentsJoinedByString:@"--"];
    return string;
}

+ (CGFloat)dynamicHeight:(DrivingDetailDMData *)dmData {
    
    return 8 + 21 + 8 + [NSString autoHeightWithString:[self getShuttlebusString:dmData] width:[UIScreen mainScreen].bounds.size.width - 8 * 2 font:[UIFont systemFontOfSize:14]] + 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
