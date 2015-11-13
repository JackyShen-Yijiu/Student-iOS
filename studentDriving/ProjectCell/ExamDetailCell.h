//
//  ExamDetailCell.h
//  studentDriving
//
//  Created by bestseller on 15/11/3.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamDetailCell : UITableViewCell
@property (strong, nonatomic) UILabel *schoolLabel;
@property (strong, nonatomic) UILabel *schoolClassLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *studyLabel;
@property (strong, nonatomic) UILabel *featuredTutorials;
@property (strong, nonatomic) UILabel *carType;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *personCount;
- (void)receiveVipList:(NSArray *)list;
@end
