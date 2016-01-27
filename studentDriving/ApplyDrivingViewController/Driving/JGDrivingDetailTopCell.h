//
//  JGDrivingDetailTopCell.h
//  BlackCat
//
//  Created by 董博 on 15/9/9.
//  Copyright (c) 2015年 lord. All rights reserved.
//  顶部个人信息

#import <UIKit/UIKit.h>
@class CoachDMData;

@interface JGDrivingDetailTopCell : UITableViewCell

- (void)refreshData:(CoachDMData *)coachModel;

@end
