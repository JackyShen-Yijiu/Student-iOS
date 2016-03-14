//
//  JZYListController.m
//  studentDriving
//
//  Created by ytzhang on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZYListController.h"
#import "JZYListCell.h"

@interface JZYListController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation JZYListController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Y码券";
    self.view.backgroundColor = RGBColor(226, 226, 233);
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120 + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *YListCellID = @"listCellID";
    JZYListCell *listCell = [tableView dequeueReusableCellWithIdentifier:YListCellID];
    if (!listCell) {
        listCell = [[JZYListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YListCellID];
    }
    return listCell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
#pragma mark ---- Lazy 加载

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource  = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
