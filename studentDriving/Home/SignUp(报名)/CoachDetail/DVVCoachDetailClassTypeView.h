//
//  DVVCoachDetailClassTypeView.h
//  studentDriving
//
//  Created by 大威 on 16/2/22.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVCoachDetailClassTypeView : UITableView

- (CGFloat)dynamicHeight:(NSArray *)dataArray;
- (void)refreshData:(NSArray *)dataArray;

@end
