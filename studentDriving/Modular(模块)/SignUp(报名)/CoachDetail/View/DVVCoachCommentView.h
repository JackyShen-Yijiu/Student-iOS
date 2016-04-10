//
//  DVVCoachCommentView.h
//  studentDriving
//
//  Created by 大威 on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVCoachCommentViewModel.h"
#import "DVVNoDataPromptView.h"

@interface DVVCoachCommentView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) DVVCoachCommentViewModel *viewModel;

@property (nonatomic, copy) NSString *coachID;
@property (nonatomic, strong) UIButton *bottomButton;

@property (nonatomic, strong) DVVNoDataPromptView *noDataPromptView;

- (CGFloat)dynamicHeight:(NSArray *)dataArray;
- (void)refreshData:(NSArray *)dataArray;

@end
