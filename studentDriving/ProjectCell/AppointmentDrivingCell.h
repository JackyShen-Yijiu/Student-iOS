//
//  AppointmentDrivingCell.h
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppointmentDrivingCellDelegate <NSObject>

- (void)calendarClick:(NSString *)dateString;

@end
@interface AppointmentDrivingCell : UITableViewCell
- (void)receiveCoachTimeData:(NSArray *)coachTimeData;
@property (weak, nonatomic) id <AppointmentDrivingCellDelegate>delegate;
@property (strong, nonatomic) NSMutableArray *upDateArray;

@property (nonatomic,weak) UIViewController *parentViewController;

@end
