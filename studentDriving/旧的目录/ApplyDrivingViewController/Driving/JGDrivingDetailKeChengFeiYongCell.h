//
//  JGDrivingDetailKeChengFeiYongCell.h
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//  课程费用

#import <UIKit/UIKit.h>

@class serverclasslistModel;
@class JGDrivingDetailKeChengFeiYongCell;

@protocol JGDrivingDetailKeChengFeiYongCellDelegate <NSObject>

- (void)JGDrivingDetailKeChengFeiYongCellWithBaomingDidClick:(JGDrivingDetailKeChengFeiYongCell *)cell;

@end

@interface JGDrivingDetailKeChengFeiYongCell : UITableViewCell

@property (nonatomic,strong) serverclasslistModel *detailModel;

+ (CGFloat)heightWithModel:(serverclasslistModel *)model indexPath:(NSIndexPath *)indexPath;

@property (nonatomic,weak) UIViewController *parentViewController;

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,weak) id<JGDrivingDetailKeChengFeiYongCellDelegate>delegate;

@end
