//
//  CourseView.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ClassTypeView.h"
#import "ClassTypeViewModel.h"
#import "ClassTypeCell.h"

#define kCellIdentifier @"kCellIdentifier"

@interface ClassTypeView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ClassTypeViewModel *viewModel;

@property (nonatomic, copy) ClassTypeViewBlock networkSuccessBlock;
@property (nonatomic, copy) ClassTypeViewCellBlock signUpButtonBlock;
@property (nonatomic, copy) ClassTypeViewCellBlock cellDidSelectBlock;

@end

@implementation ClassTypeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.bounces = NO;
        self.dataSource = self;
        self.delegate = self;
        
        [self configViewModel];
    }
    return self;
}

#pragma mark - config view model
- (void)configViewModel {
    
    _viewModel = [ClassTypeViewModel new];
    _viewModel.schoolID = _schoolID;
    
    [_viewModel dvvSetRefreshSuccessBlock:^{
        _totalHeight = _viewModel.totalHeight;
        [self reloadData];
        if (_networkSuccessBlock) {
            _networkSuccessBlock(_viewModel);
        }
    }];
    [_viewModel dvvSetNilResponseObjectBlock:^{
        [self obj_showTotasViewWithMes:@"没有数据"];
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
        [self obj_showTotasViewWithMes:@"加载失败"];
    }];
    [_viewModel dvvSetNetworkErrorBlock:^{
        [self obj_showTotasViewWithMes:@"网络错误"];
    }];
}

- (void)beginNetworkRequest:(NSString *)schoolID {
    _schoolID = schoolID;
    _viewModel.schoolID = schoolID;
    [_viewModel dvvNetworkRequestRefresh];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_viewModel.heightArray[indexPath.row] floatValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[ClassTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        [cell.signUpButton addTarget:self action:@selector(signUpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.signUpButton.tag = indexPath.row;
    [cell refreshData:_viewModel.dataArray[indexPath.row]];
    
    if (_viewModel.dataArray.count == indexPath.row + 1) {
        cell.lineImageView.hidden = YES;
    }else {
        cell.lineImageView.hidden = NO;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassTypeDMData *dmData = _viewModel.dataArray[indexPath.row];
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
        ClassTypeDMData *dmData = _viewModel.dataArray[sender.tag];
        _signUpButtonBlock(dmData);
    }
}

- (void)setClassTypeNetworkSuccessBlock:(ClassTypeViewBlock)handle {
    
    _networkSuccessBlock = handle;
}
- (void)setClassTypeSignUpButtonActionBlock:(ClassTypeViewCellBlock)handle {
    _signUpButtonBlock = handle;
}
- (void)setClassTypeViewCellDidSelectBlock:(ClassTypeViewCellBlock)handel {
    _cellDidSelectBlock = handel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
