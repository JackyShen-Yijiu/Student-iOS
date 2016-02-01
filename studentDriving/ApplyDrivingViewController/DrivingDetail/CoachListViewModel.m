//
//  CoachListViewModel.m
//  studentDriving
//
//  Created by 大威 on 16/1/30.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "CoachListViewModel.h"
#import "ToolHeader.h"
#import "JENetwoking.h"
#import "YYModel.h"
#import "CoachListDMRootClass.h"

@implementation CoachListViewModel

- (void)dvvNetworkRequestRefresh {
    
    [self dvvNetworkRequestWithIndex:1 isRefresh:YES];
}

- (void)dvvNetworkRequestLoadMore {
    
    [self dvvNetworkRequestWithIndex:++_index isRefresh:NO];
}

- (void)dvvNetworkRequestWithIndex:(NSUInteger)index
                         isRefresh:(BOOL)isRefresh {
    
    _index = index;
    NSString *interface = [NSString stringWithFormat:BASEURL, @"getschoolcoach/"];
    NSString *url = [NSString stringWithFormat:@"%@%@/%ld",interface, _schoolID, _index];
    
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        [self dvvNetworkCallBack];
        
        CoachListDMRootClass *dmRoot = [CoachListDMRootClass yy_modelWithJSON:data];
        if (0 == dmRoot.type) {
            if (isRefresh) {
                [self dvvRefreshError];
            }else {
                [self dvvLoadMoreError];
            }
            return ;
        }
        if (!dmRoot.data || !dmRoot.data.count) {
            [self dvvNilResponseObject];
            return ;
        }
        if (isRefresh) {
            _dataArray = [NSMutableArray array];
        }
        for (NSDictionary *dict in dmRoot.data) {
            
            CoachListDMData *dmData = [CoachListDMData yy_modelWithDictionary:dict];
            NSLog(@"%@", dmData.headportrait.originalpic);
            [_dataArray addObject:dmData];
        }
        
        if (isRefresh) {
            [self dvvRefreshSuccess];
        }else {
            [self dvvLoadMoreSuccess];
        }
        
        
    } withFailure:^(id data) {
        [self dvvNetworkCallBack];
        [self dvvNetworkError];
    }];
}

@end
