//
//  JGActivityCell.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JGActivityCell.h"
#import "JGActivityModel.h"

@implementation JGActivityCell

- (void)setActivityModel:(JGActivityModel *)activityModel
{
    
    _activityModel = activityModel;
    
    self.activityLabel.text = @"进行中";
    
    [self.activityImgView sd_setImageWithURL:[NSURL URLWithString:_activityModel.contenturl] placeholderImage:[UIImage imageNamed:@"baomingBtnNomal.png"]];
    
    self.activityTimeLabel.text = _activityModel.enddate;

}

@end
