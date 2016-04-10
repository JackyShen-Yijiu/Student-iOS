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
#import "JZComplaintLeftView.h"
#import "JZComplaintDetailCell.h"
#define kLKSize [UIScreen mainScreen].bounds.size
@interface JZComplaintController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, weak)  JZComplaintHeaderView *headerView;

//@property (nonatomic, weak) JZComplaintLeftView *leftView;

@property (nonatomic, strong) UITableView *leftTableView;






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
    
    UITableView *leftTableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kLKSize.width, 44)];

    
    leftTableView.backgroundColor = [UIColor orangeColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    leftTableView.bounces = NO;
    leftTableView.showsVerticalScrollIndicator = NO;
    leftTableView.showsHorizontalScrollIndicator = NO;
    
    leftTableView.dataSource = self;
    leftTableView.delegate = self;
    
    leftTableView.rowHeight = 44;
    self.leftTableView = leftTableView;
    [self.view addSubview:leftTableView];
    
    
//    JZComplaintLeftView *leftView = [[JZComplaintLeftView alloc]initWithFrame:CGRectMake(0, 100, kLKSize.width, 133)];
//
//    
//    self.leftView = leftView;
//    
//    [self.view addSubview:leftView];


}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JZComplaintDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lkcell" ];
    
//    self.oneCell = cell;
    
    if (cell == nil) {
        
        cell = [[JZComplaintDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lkcell"];
        
        cell.coachLabel.text = @"教练名字";
        cell.coachNameLabel.text = @"教练";
        cell.detailImg.image = [UIImage imageNamed:@"箭头"];
        
        
    }

    return cell;
}



#pragma mark - Bar右侧--我的投诉
- (void)rightBarDidClick
{
    YBMyComplaintListController *vc = [[YBMyComplaintListController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 懒加载




@end
