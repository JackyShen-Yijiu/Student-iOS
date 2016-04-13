//
//  JZConfirmOrderSuccessController.m
//  studentDriving
//
//  Created by ytzhang on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZConfirmOrderSuccessController.h"
#import "JZExchangeRecordCell.h"
#import "JZRecordFooterView.h"
#import "JZRecordHeaderView.h"

@interface JZConfirmOrderSuccessController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation JZConfirmOrderSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.title = @"兑换成功";
    JZRecordFooterView *footerView = [[JZRecordFooterView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 274) integralMallModel:_integralMallModel formMall:YES codeStr:_orderscanaduiturl];
    self.tableView.tableFooterView = footerView;
    
    JZRecordHeaderView *headerView = [[JZRecordHeaderView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 172)];
    self.tableView.tableHeaderView = headerView;
    
    
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
    cell.integrtalMallModel = self.integralMallModel;
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
