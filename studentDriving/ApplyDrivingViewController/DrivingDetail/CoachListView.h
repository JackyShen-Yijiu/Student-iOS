//
//  CoachListView.h
//  studentDriving
//
//  Created by 大威 on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoachListView : UITableView

@property (nonatomic,readonly, copy) NSString *schoolID;
@property (nonatomic, strong) UIButton *bottomButton;

- (void)beginNetworkRequest:(NSString *)schoolID;

@end
