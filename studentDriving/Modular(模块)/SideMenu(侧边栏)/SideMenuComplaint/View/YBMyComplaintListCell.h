//
//  YBMyComplaintListCell.h
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//  授课信息

#import <UIKit/UIKit.h>

@class CoachDetail;

@interface YBMyComplaintListCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *detailModel;

+ (CGFloat)heightWithModel:(NSDictionary *)model;

@end
