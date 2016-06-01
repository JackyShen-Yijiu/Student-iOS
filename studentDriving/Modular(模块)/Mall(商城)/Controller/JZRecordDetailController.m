//
//  JZRecordDetailController.m
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZRecordDetailController.h"
#import "JZExchangeRecordCell.h"
#import "JZRecordFooterView.h"
@interface JZRecordDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation JZRecordDetailController
- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.title = @"兑换详情";
    JZRecordFooterView *footerView = [[JZRecordFooterView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 274) recordOrderModel:self.recordModel];
        self.tableView.tableFooterView = footerView;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 122;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDexchange = @"ecchangeID";
    JZExchangeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:IDexchange];
    if (!cell) {
        cell = [[JZExchangeRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDexchange];
        cell.stateLabel.hidden = YES;
    }
    cell.recordModel = self.recordModel;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }

#pragma mark --- Lazy加载
- (UITableView *)tableView
{
    if (_tableView == nil ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , kSystemHeight - 64) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        
    }
    return _tableView;
}

@end
