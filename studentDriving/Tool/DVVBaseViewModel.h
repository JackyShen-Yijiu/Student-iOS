//
//  DVVBaseViewModel.h
//  LuckyKing
//
//  Created by 大威 on 16/1/3.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DVVBaseViewModelUpdataBlock)();

@interface DVVBaseViewModel : NSObject

// 处理完网络数据后，调用刷新成功、失败的回调
- (void)dvvRefreshSuccess;
- (void)dvvRefreshError;
// 处理完网络数据后，调用加载成功、失败的回调
- (void)dvvLoadMoreSuccess;
- (void)dvvLoadMoreError;

// 设置刷新成功、失败时的回调Block
- (void)setDVVRefreshSuccessBlock:(DVVBaseViewModelUpdataBlock)refreshSuccessBlock;
- (void)setDVVRefreshErrorBlock:(DVVBaseViewModelUpdataBlock)refreshErrorBlock;

// 设置加载成功、失败时的回调Block
- (void)setDVVLoadMoreSuccessBlock:(DVVBaseViewModelUpdataBlock)loadMoreSuccessBlock;
- (void)setDVVLoadMoreErrorBlock:(DVVBaseViewModelUpdataBlock)loadMoreErrorBlock;

// 1、刷新时的网络请求
- (void)dvvNetworkRequestRefresh;
// 2、加载时的网络请求
- (void)dvvNetworkRequestLoadMore;

@end
