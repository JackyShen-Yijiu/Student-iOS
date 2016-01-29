//
//  DrivingDetailSignUpCell.h
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseView.h"

@interface DrivingDetailSignUpCell : UITableViewCell

@property (nonatomic, strong) CourseView *courseView;

@property (weak, nonatomic) IBOutlet UIButton *courseButton;
@property (weak, nonatomic) IBOutlet UIButton *coachButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
