//
//  MyConsultationListCell.h
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//  咨询

#import <UIKit/UIKit.h>

@class CoachDetail;

@interface MyConsultationListCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *detailModel;

+ (CGFloat)heightWithModel:(NSDictionary *)model;

@end
