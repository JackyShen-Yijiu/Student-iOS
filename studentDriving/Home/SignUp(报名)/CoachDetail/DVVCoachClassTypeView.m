//
//  DVVCoachDetailClassTypeView.m
//  studentDriving
//
//  Created by 大威 on 16/2/22.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachClassTypeView.h"

#define kCellIdentifier @"kCellIdentifier"

@interface DVVCoachClassTypeView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) DVVCoachClassTypeViewCellBlock signUpButtonBlock;
@property (nonatomic, copy) DVVCoachClassTypeViewCellBlock cellDidSelectBlock;

@property (nonatomic, strong) UIButton *markButton;

@end

@implementation DVVCoachClassTypeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [NSMutableArray array];
        _heightArray = [NSMutableArray array];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.bounces = NO;
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (CGFloat)dynamicHeight:(NSArray *)dataArray {
    
    [_dataArray removeAllObjects];
    [_heightArray removeAllObjects];
    _totalHeight = 0;
    for (NSDictionary *dict in dataArray) {
        
        ClassTypeDMData *dmData = [ClassTypeDMData yy_modelWithDictionary:dict];
        [_dataArray addObject:dmData];
    }
    for (ClassTypeDMData *dmData in _dataArray) {
        
        CGFloat height = [ClassTypeCell dynamicHeight:dmData.classdesc];
        _totalHeight += height;
        
        [_heightArray addObject:[NSString stringWithFormat:@"%f",height]];
    }
    [self reloadData];
    return _totalHeight;
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_heightArray[indexPath.row] floatValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[ClassTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        [cell.signUpButton addTarget:self action:@selector(signUpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.signUpButton.tag = indexPath.row;
    [cell refreshData:_dataArray[indexPath.row]];
    
    if (_dataArray.count == indexPath.row + 1) {
        cell.lineImageView.hidden = YES;
    }else {
        cell.lineImageView.hidden = NO;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassTypeDMData *dmData = _dataArray[indexPath.row];
    if (_cellDidSelectBlock) {
        _cellDidSelectBlock(dmData);
    }
}
- (void)signUpButtonAction:(UIButton *)sender {
    
    if (![AcountManager isLogin]) {
        [DVVUserManager userNeedLogin];
        return ;
    }
    if (_signUpButtonBlock) {
        ClassTypeDMData *dmData = _dataArray[sender.tag];
        _signUpButtonBlock(dmData);
    }
}

- (UIImageView *)noDataMarkImageView {
    if (!_noDataMarkImageView) {
        _noDataMarkImageView = [UIImageView new];
    }
    return _noDataMarkImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
