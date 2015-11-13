//
//  DrivingSelectedCoachCell.h
//  BlackCat
//
//  Created by bestseller on 15/9/30.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoachModel;
@protocol DrivingSelectedCoachCellDelegate <NSObject>

- (void)senderCoachModel:(CoachModel *)model;

@end
@interface DrivingSelectedCoachCell : UITableViewCell
- (void)receiveGetCoachMessage:(NSArray *)coachArray;
@property (weak,nonatomic) id<DrivingSelectedCoachCellDelegate>delegate;
@end
