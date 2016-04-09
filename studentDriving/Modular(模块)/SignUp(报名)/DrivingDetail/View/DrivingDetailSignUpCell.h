//
//  DrivingDetailSignUpCell.h
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTypeView.h"
#import "CoachListView.h"

@interface DrivingDetailSignUpCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, copy) NSString *schoolID;

@property (nonatomic, assign) BOOL showType;

@property (nonatomic, strong) ClassTypeView *classTypeView;
@property (nonatomic, strong) CoachListView *coachListView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *followLineImageView;

@property (nonatomic, strong) UITableView *tableView;


- (void)courseButtonAction;
- (void)coachButtonAction;

- (CGFloat)dynamicHeight;

@end
