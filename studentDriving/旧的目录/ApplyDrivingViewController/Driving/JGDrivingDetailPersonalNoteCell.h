//
//  JGDrivingDetailPersonalNoteCell.h
//  BlackCat
//
//  Created by bestseller on 15/9/29.
//  Copyright © 2015年 lord. All rights reserved.
//  个人说明

#import <UIKit/UIKit.h>

@class CoachDetail;
@class JGDrivingDetailPersonalNoteCell;

@protocol JGDrivingDetailPersonalNoteCellDelegate <NSObject>

- (void)JGDrivingDetailPersonalNoteCellWithMoreBtnDidClick:(JGDrivingDetailPersonalNoteCell *)cell;

@end

@interface JGDrivingDetailPersonalNoteCell : UITableViewCell

@property (nonatomic,strong) CoachDetail *detailModel;

+ (CGFloat)heightWithModel:(CoachDetail *)model indexPath:(NSIndexPath *)indexPath;

@property (nonatomic,weak)id<JGDrivingDetailPersonalNoteCellDelegate>delegate;

@end
