//
//  DVVCoachDetailCourseCell.m
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachDetailCourseCell.h"

@implementation DVVCoachDetailCourseCell

- (void)awakeFromNib {
    // Initialization code
}

- (CGFloat)dynamicHeight:(NSArray *)dataArray {
    CGFloat height = [UIScreen mainScreen].bounds.size.height - (64 + 44);
    CGFloat tempHeight = 0;
    if (0 == _showType) {
        tempHeight = [_classTypeView dynamicHeight:dataArray];
    }else {
//        tempHeight = 
    }
    
    if (tempHeight < height) {
        return height;
    }else {
        return tempHeight;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
