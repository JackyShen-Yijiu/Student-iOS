//
//  DrivingSelectedCoachCollectionCell.h
//  BlackCat
//
//  Created by bestseller on 15/9/30.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CoachModel;
@interface DrivingSelectedCoachCollectionCell : UICollectionViewCell
- (void)receiveCoachMessage:(CoachModel *)coachModel;
@end
