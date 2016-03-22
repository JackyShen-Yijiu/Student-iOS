//
//  CoachListView.h
//  studentDriving
//
//  Created by 大威 on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachListDMData.h"
#import "DVVNoDataPromptView.h"

typedef void(^CoachListViewCellBlock)(CoachListDMData *dmData);

@interface CoachListView : UITableView

@property (nonatomic,readonly, copy) NSString *schoolID;
@property (nonatomic, strong) UIButton *bottomButton;

@property (nonatomic, strong) DVVNoDataPromptView *noDataPromptView;

- (void)beginNetworkRequest:(NSString *)schoolID;

- (void)setCoachListViewCellDidSelectBlock:(CoachListViewCellBlock)handel;

@end
