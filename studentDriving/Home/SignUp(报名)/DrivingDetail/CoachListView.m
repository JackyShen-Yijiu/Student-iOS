//
//  CoachListView.m
//  studentDriving
//
//  Created by 大威 on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "CoachListView.h"
#import "CoachListCell.h"
#import "CoachListViewModel.h"
#import "CoachListDMData.h"

#define kCellIdentifier @"kCoachListCellID"

@interface CoachListView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CoachListViewModel *viewModel;

@property (nonatomic, copy) CoachListViewCellBlock cellDidSelectBlock;

@end

@implementation CoachListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.bounces = NO;
        self.dataSource = self;
        self.delegate = self;
        // 如果是固定高度的话在这里设置比较好
        self.rowHeight = 88.f;
        self.tableFooterView = self.bottomButton;
        
        [self registerClass:[CoachListCell class] forCellReuseIdentifier:kCellIdentifier];
        
        [self configViewModel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = _bottomButton.frame;
    rect.size.width = self.bounds.size.width;
    _bottomButton.frame = rect;
}

#pragma mark - config view model
- (void)configViewModel {
    
    _viewModel = [CoachListViewModel new];
    _viewModel.schoolID = _schoolID;
    __weak typeof(self) ws = self;
    [_viewModel dvvSetRefreshSuccessBlock:^{
        ws.bottomButton.hidden = NO;
        [ws.noDataPromptView remove];
        [ws reloadData];
    }];
    [_viewModel dvvSetNilResponseObjectBlock:^{
        
        ws.bottomButton.hidden = YES;
        [ws addSubview:ws.noDataPromptView];

//        ws.bottomButton.tag = 1;
//        ws.bottomButton.userInteractionEnabled = NO;
//        [ws.bottomButton setTitle:@"暂未填写教练信息" forState:UIControlStateNormal];
//        ws.bottomButton.bounds = CGRectMake(0, 0, self.bounds.size.width, [UIScreen mainScreen].bounds.size.height - (64 + 44));
//        [self obj_showTotasViewWithMes:@"没有数据"];
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
//        [self obj_showTotasViewWithMes:@"加载失败"];
    }];
    [_viewModel dvvSetNetworkErrorBlock:^{
//        [self obj_showTotasViewWithMes:@"网络错误"];
    }];
}
- (void)beginNetworkRequest:(NSString *)schoolID {
    _schoolID = schoolID;
    _viewModel.schoolID = schoolID;
    [_viewModel dvvNetworkRequestRefresh];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel.dataArray.count > 2) {
        return 2;
    }
    return _viewModel.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CoachListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    [cell refreshData:_viewModel.dataArray[indexPath.row]];
    
//    if (indexPath.row == 1) {
//        cell.bottomLineView.hidden = YES;
//    }else {
//        cell.bottomLineView.hidden = NO;
//    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CoachListDMData *dmData = _viewModel.dataArray[indexPath.row];
    if (_cellDidSelectBlock) {
        _cellDidSelectBlock(dmData);
    }
}

- (UIButton *)bottomButton {
    if (!_bottomButton) {
        _bottomButton = [UIButton new];
        _bottomButton.frame = CGRectMake(0, 0, 0, 40);
        _bottomButton.backgroundColor = [UIColor whiteColor];
        [_bottomButton setTitle:@"查看该校全部教练" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _bottomButton;
}

- (void)setCoachListViewCellDidSelectBlock:(CoachListViewCellBlock)handel {
    _cellDidSelectBlock = handel;
}

- (DVVNoDataPromptView *)noDataPromptView {
    if (!_noDataPromptView) {
        _noDataPromptView = [[DVVNoDataPromptView alloc] initWithTitle:@"暂无教练信息" image:[UIImage imageNamed:@"app_error_robot"]];
        CGSize size = [UIScreen mainScreen].bounds.size;
        _noDataPromptView.frame = CGRectMake(0, 0, size.width, size.height - 64 - 44);
    }
    return _noDataPromptView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
