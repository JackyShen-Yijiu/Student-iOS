//
//  YBOrderListViewController.h
//  studentDriving
//
//  Created by JiangangYang on 16/3/1.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBBaseViewController.h"

@interface YBOrderListViewController : YBBaseViewController


@property (nonatomic, assign) BOOL isFormallOrder;

@property (nonatomic, strong) UIViewController *pareVC;

@property (nonatomic,assign) BOOL isPaySuccess;

@property (strong, nonatomic) UITableView *tableView;

- (void)startDownLoad ;

@end
