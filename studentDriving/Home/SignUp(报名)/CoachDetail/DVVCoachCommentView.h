//
//  DVVCoachCommentView.h
//  studentDriving
//
//  Created by 大威 on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVCoachCommentView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,readonly, copy) NSString *coachID;
@property (nonatomic, strong) UIButton *bottomButton;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, assign) CGFloat totalHeight;

- (CGFloat)dynamicHeight:(NSArray *)dataArray;
- (void)refreshData:(NSArray *)dataArray;

@end
