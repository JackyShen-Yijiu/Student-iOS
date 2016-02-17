//
//  YBStudyTableView.m
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBStudyTableView.h"
#import "YBStudyViewCell.h"
#import "DVVToast.h"
#import "WMOtherViewController.h"

#define kCellIdentifier @"YBStudyViewCell"

@interface YBStudyTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *dataTabelView;

@end

@implementation YBStudyTableView

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
    
    YBStudyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[YBStudyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
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
        _dataTabelView.rowHeight = 75;
        _dataTabelView.tableFooterView = [UIView new];
    }
    return _dataTabelView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"self.studyProgress:%ld",(long)self.studyProgress);
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dict = _dataArray[indexPath.row];

    WMOtherViewController *other = [[WMOtherViewController alloc] init];
    other.navTitle = [NSString stringWithFormat:@"%@",dict[@"title"]];
    other.hidesBottomBarWhenPushed = YES;
    [self.parentViewController.navigationController pushViewController:other animated:YES];
    
    switch (self.studyProgress) {
        case YBStudyProgress1:
            
            if (indexPath.row==0) {
    
            }else if (indexPath.row==1){
                
            }else if (indexPath.row==2){
                
            }else if (indexPath.row==3){
                
            }else if (indexPath.row==4){
                
            }
            
            break;
        
        case YBStudyProgress2:
            
            if (indexPath.row==0) {
                
            }else if (indexPath.row==1){
                
            }else if (indexPath.row==2){
                
            }else if (indexPath.row==3){
                
            }
            
            break;
            
        case YBStudyProgress3:
            
            if (indexPath.row==0) {
                
            }else if (indexPath.row==1){
                
            }else if (indexPath.row==2){
                
            }else if (indexPath.row==3){
                
            }
            
            break;
            
        case YBStudyProgress4:
            
            if (indexPath.row==0) {
                
            }else if (indexPath.row==1){
                
            }else if (indexPath.row==2){
                
            }else if (indexPath.row==3){
                
            }else if (indexPath.row==4){
                
            }
            
            break;
            
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
