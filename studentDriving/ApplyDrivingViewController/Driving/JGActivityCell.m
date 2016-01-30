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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"JGActivityCell" owner:self options:nil];
        JGActivityCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
    }
    return self;
}

- (void)setActivityModel:(JGActivityModel *)activityModel
{
    
    _activityModel = activityModel;
    
    self.activityLabel.text = @"进行中";
    
    [self.activityImgView sd_setImageWithURL:[NSURL URLWithString:_activityModel.contenturl] placeholderImage:[UIImage imageNamed:@"baomingBtnNomal.png"]];
    
    NSLog(@"_activityModel.enddate:%@",_activityModel.enddate);
    
    self.activityTimeLabel.text = _activityModel.enddate;

}

@end
