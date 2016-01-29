//
//  DrivingDetailTrainingGroundCell.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailTrainingGroundCell.h"

#define imageWidth (([UIScreen mainScreen].bounds.size.width - 10 * 4) / 3.f)
#define imageHeight imageWidth * 0.7

@implementation DrivingDetailTrainingGroundCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)defaultHeight {
    
    return 8 + 21 + 8 + imageWidth + 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
