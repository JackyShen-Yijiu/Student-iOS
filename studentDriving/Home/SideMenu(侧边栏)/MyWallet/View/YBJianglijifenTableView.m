//
//  YBJianglijifenTableView.m
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBJianglijifenTableView.h"
#import "DVVToast.h"
#import "YBJiangliJifenCell.h"

#define kCellIdentifier @"YBJiangliJifenCell"

@interface YBJianglijifenTableView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation YBJianglijifenTableView

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
    [self.dataTabelView reloadData];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"self.jianglijifenArrray:%@",self.jianglijifenArrray);
    NSLog(@"self.kequxianjineduArray:%@",self.kequxianjineduArray);

    if (self.isJianglijifen) {
        return self.jianglijifenArrray.count;
    }
    return self.kequxianjineduArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YBJiangliJifenCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[YBJiangliJifenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.isJianglijifen) {
        cell.jianglijifenModel = _jianglijifenArrray[indexPath.row];
    }else{
        cell.kequxianjineduModel = _kequxianjineduArray[indexPath.row];
    }
    
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
