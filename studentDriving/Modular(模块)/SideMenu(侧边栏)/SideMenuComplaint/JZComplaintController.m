//
//  JZComplaintController.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZComplaintController.h"
#import "YBMyComplaintListController.h"
#import "JZComplaintHeaderView.h"
#define kLKSize [UIScreen mainScreen].bounds.size
@interface JZComplaintController ()


@property (nonatomic, strong)  JZComplaintHeaderView *headerView;


@end

@implementation JZComplaintController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"投诉";
    
    self.view.backgroundColor = BACKGROUNDCOLOR;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的投诉" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarDidClick)];
    [self.navigationItem.rightBarButtonItem
     setTitleTextAttributes:[NSDictionary
                             dictionaryWithObjectsAndKeys:[UIFont
                                                           boldSystemFontOfSize:14], NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    
    JZComplaintHeaderView *headerView = [[JZComplaintHeaderView alloc]initWithFrame:CGRectMake(0, 0, kLKSize.width, 44)];

    
    self.headerView = headerView;
    
    [self.view addSubview:headerView];

}


#pragma mark - Bar右侧--我的投诉
- (void)rightBarDidClick
{
    YBMyComplaintListController *vc = [[YBMyComplaintListController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 懒加载




@end
