//
//  DVVCoachDetailCourseCell.h
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVCoachDetailClassTypeView.h"

@interface DVVCoachDetailCourseCell : UITableViewCell

@property (nonatomic, strong) DVVCoachDetailClassTypeView *classTypeView;

@property (nonatomic, copy) NSString *coachID;

@property (nonatomic, assign) BOOL showType;
- (CGFloat)dynamicHeight:(NSArray *)dataArray;

@end
