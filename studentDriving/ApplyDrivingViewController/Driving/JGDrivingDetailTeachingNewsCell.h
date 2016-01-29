//
//  JGDrivingDetailTeachingNewsCell.h
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//  授课信息

#import <UIKit/UIKit.h>

@class CoachDetail;

@interface JGDrivingDetailTeachingNewsCell : UITableViewCell

@property (nonatomic,strong) CoachDetail *detailModel;

+ (CGFloat)heightWithModel:(CoachDetail *)model;

@property (nonatomic,weak) UIViewController *parentViewController;

@end
