//
//  JZMyComplaintListController.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyComplaintListController.h"
#import "JZMyComplaintListView.h"
#define kLKSize [UIScreen mainScreen].bounds.size
@interface JZMyComplaintListController ()
@property (nonatomic, weak) JZMyComplaintListView *listView;
@end

@implementation JZMyComplaintListController


-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"我的投诉";
    self.view.backgroundColor = RGBColor(232, 232, 237);

    
    
    
    JZMyComplaintListView *listView = [[JZMyComplaintListView alloc]initWithFrame:CGRectMake(0, 0, kLKSize.width, kLKSize.height-64)];
    
    self.listView = listView;
    
    [self.view addSubview:listView];
    
    
    
    
}




@end
