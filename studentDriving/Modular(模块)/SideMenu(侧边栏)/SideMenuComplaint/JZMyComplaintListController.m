//
//  JZMyComplaintListController.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyComplaintListController.h"
#import "JZMyComplaintListView.h"

@interface JZMyComplaintListController ()
@property (nonatomic, weak) JZMyComplaintListView *listView;
@end

@implementation JZMyComplaintListController


-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"我的投诉";
    self.view.backgroundColor = RGBColor(232, 232, 237);

    // 告诉tableView所有cell的真实高度是自动计算（根据设置的约束来计算）
    self.listView.rowHeight = UITableViewAutomaticDimension;
    // 告诉tableView所有cell的估算高度
    self.listView.estimatedRowHeight = 100;
    
    JZMyComplaintListView *listView = [[JZMyComplaintListView alloc]initWithFrame:self.view.bounds];
    
    self.listView = listView;
    
    [self.view addSubview:listView];
    
    
    
}




@end
