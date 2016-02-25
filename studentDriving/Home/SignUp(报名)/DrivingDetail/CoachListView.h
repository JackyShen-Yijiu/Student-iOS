//
//  CoachListView.h
//  studentDriving
//
//  Created by 大威 on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachListDataModel/CoachListDMData.h"
#import "DVVPromptNilDataView.h"

typedef void(^CoachListViewCellBlock)(CoachListDMData *dmData);

@interface CoachListView : UITableView

@property (nonatomic,readonly, copy) NSString *schoolID;
@property (nonatomic, strong) UIButton *bottomButton;

@property (nonatomic, strong) DVVPromptNilDataView *promptNilDataView;

- (void)beginNetworkRequest:(NSString *)schoolID;

- (void)setCoachListViewCellDidSelectBlock:(CoachListViewCellBlock)handel;

@end
