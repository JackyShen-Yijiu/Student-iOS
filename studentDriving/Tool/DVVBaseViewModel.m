//
//  DVVBaseViewModel.m
//  LuckyKing
//
//  Created by 大威 on 16/1/3.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import "DVVBaseViewModel.h"

@interface DVVBaseViewModel()

@property (nonatomic, copy) DVVBaseViewModelUpdataBlock refreshSuccessBlock;
@property (nonatomic, copy) DVVBaseViewModelUpdataBlock refreshErrorBlock;
@property (nonatomic, copy) DVVBaseViewModelUpdataBlock loadMoreSuccessBlock;
@property (nonatomic, copy) DVVBaseViewModelUpdataBlock loadMoreErrorBlock;

@end

@implementation DVVBaseViewModel

- (void)dvvNetworkRequestRefresh {
    // 重写此方法刷新数据（需自己调用刷新回调）
}
- (void)dvvNetworkRequestLoadMore {
    // 重写此方法加载数据（需自己调用加载回调）
}

#pragma mark - call back
- (void)dvvRefreshSuccess {
    if (_refreshSuccessBlock) {
        _refreshSuccessBlock();
    }
}
- (void)dvvRefreshError {
    if (_refreshErrorBlock) {
        _refreshErrorBlock();
    }
}
- (void)dvvLoadMoreSuccess {
    if (_loadMoreSuccessBlock) {
        _loadMoreSuccessBlock();
    }
}
- (void)dvvLoadMoreError {
    if (_loadMoreErrorBlock) {
        _loadMoreErrorBlock();
    }
}

#pragma mark - set block
- (void)setDVVRefreshSuccessBlock:(DVVBaseViewModelUpdataBlock)refreshSuccessBlock {
    _refreshSuccessBlock = refreshSuccessBlock;
}
- (void)setDVVRefreshErrorBlock:(DVVBaseViewModelUpdataBlock)refreshErrorBlock {
    _refreshErrorBlock = refreshErrorBlock;
}
- (void)setDVVLoadMoreSuccessBlock:(DVVBaseViewModelUpdataBlock)loadMoreSuccessBlock {
    _loadMoreSuccessBlock = loadMoreSuccessBlock;
}
- (void)setDVVLoadMoreErrorBlock:(DVVBaseViewModelUpdataBlock)loadMoreErrorBlock {
    _loadMoreErrorBlock = loadMoreErrorBlock;
}

@end
