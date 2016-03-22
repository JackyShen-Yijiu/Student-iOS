//
//  DVVCoachDetailCourseCell.h
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVCoachClassTypeView.h"
#import "DVVCoachCommentView.h"

@interface DVVCoachDetailCourseCell : UITableViewCell

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) DVVCoachClassTypeView *classTypeView;
@property (nonatomic, strong) DVVCoachCommentView *commentView;

@property (nonatomic, copy) NSString *coachID;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) BOOL showType;
- (CGFloat)dynamicHeight:(NSArray *)dataArray;

- (void)courseButtonAction;
- (void)commentButtonAction;

@end
