//
//  YBBaoMingDuiHuanQuanTableView.m
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBBaoMingDuiHuanQuanTableView.h"
#import "DVVToast.h"
#import "YBBaoMingDuiHuanQuanCell.h"

#define kCellIdentifier @"YBBaoMingDuiHuanQuanCell"

@interface YBBaoMingDuiHuanQuanTableView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation YBBaoMingDuiHuanQuanTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.dataTabelView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _dataTabelView.frame = self.bounds;
}

- (void)reloadData
{
    NSLog(@"reloadData dataArray:%@",_dataArray);
    [self.dataTabelView reloadData];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YBBaoMingDuiHuanQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[YBBaoMingDuiHuanQuanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    cell.dictModel = _dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - lazy load
- (UITableView *)dataTabelView {
    if (!_dataTabelView) {
        _dataTabelView = [UITableView new];
        _dataTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dataTabelView.dataSource = self;
        _dataTabelView.delegate = self;
        // 如果是固定高度的话在这里设置比较好
        _dataTabelView.rowHeight = 63;
        _dataTabelView.tableFooterView = [UIView new];
    }
    return _dataTabelView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
