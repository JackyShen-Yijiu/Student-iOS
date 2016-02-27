//
//  DVVCoachCommentView.m
//  studentDriving
//
//  Created by 大威 on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachCommentView.h"
#import "DVVCoachCommentCell.h"

static NSString *kCellIdentifier = @"kCellIdentifier";

@implementation DVVCoachCommentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.bounces = NO;
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = self.bottomButton;
        
        [self registerClass:[DVVCoachCommentCell class] forCellReuseIdentifier:kCellIdentifier];
        
        [self configViewModel];
    }
    return self;
}

- (void)setCoachID:(NSString *)coachID {
    _coachID = coachID;
    _viewModel.coachID = _coachID;
    [_viewModel dvv_networkRequestRefresh];
}

- (void)configViewModel {
    
    _viewModel = [DVVCoachCommentViewModel new];
    
    __weak typeof(self) ws = self;
    [_viewModel dvv_setRefreshSuccessBlock:^{
        ws.bottomButton.hidden = NO;
        [ws.noDataPromptView remove];
        [ws reloadData];
    }];
    [_viewModel dvv_setNilResponseObjectBlock:^{
        ws.bottomButton.hidden = YES;
        [ws addSubview:ws.noDataPromptView];
    }];
    [_viewModel dvv_setNetworkErrorBlock:^{
        ws.bottomButton.hidden = YES;
        [ws addSubview:ws.noDataPromptView];
    }];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel.dataArray.count > 2) {
        return 2;
    }
    return _viewModel.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_viewModel.heightArray[indexPath.row] floatValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DVVCoachCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    [cell refreshData:_viewModel.dataArray[indexPath.row]];
    
    //    if (indexPath.row == 1) {
    //        cell.bottomLineView.hidden = YES;
    //    }else {
    //        cell.bottomLineView.hidden = NO;
    //    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    CoachListDMData *dmData = _viewModel.dataArray[indexPath.row];
//    if (_cellDidSelectBlock) {
//        _cellDidSelectBlock(dmData);
//    }
}

- (UIButton *)bottomButton {
    if (!_bottomButton) {
        _bottomButton = [UIButton new];
        _bottomButton.frame = CGRectMake(0, 0, 0, 40);
        _bottomButton.backgroundColor = [UIColor whiteColor];
        [_bottomButton setTitle:@"查看全部学员评价" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _bottomButton;
}

- (DVVNoDataPromptView *)noDataPromptView {
    if (!_noDataPromptView) {
        _noDataPromptView = [[DVVNoDataPromptView alloc] initWithTitle:@"暂无评论信息" image:[UIImage imageNamed:@"app_error_robot"]];
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
