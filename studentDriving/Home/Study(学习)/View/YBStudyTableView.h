//
//  YBStudyTableView.h
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBStudyTool.h"

@interface YBStudyTableView : UIView

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,assign) YBStudyProgress studyProgress;

- (void)reloadData;

@property (nonatomic,weak) UIViewController *parentViewController;

@end
