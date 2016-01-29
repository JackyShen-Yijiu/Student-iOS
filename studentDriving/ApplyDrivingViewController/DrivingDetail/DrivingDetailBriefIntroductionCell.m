//
//  DrivingDetailBriefIntroductionCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailBriefIntroductionCell.h"
#import "NSString+Helper.h"

@implementation DrivingDetailBriefIntroductionCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)dynamicHeight:(NSString *)string isShowMore:(BOOL)isShowMore {
    
    if (isShowMore) {
        return [NSString autoHeightWithString:string width:[UIScreen mainScreen].bounds.size.width - 8 * 2 font:[UIFont systemFontOfSize:14]] + 8 + 21 + 8;
    }else {
        return 95.f;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
