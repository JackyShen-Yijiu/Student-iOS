//
//  DVVCoachCommentViewModel.m
//  studentDriving
//
//  Created by 大威 on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachCommentViewModel.h"
#import "DVVCoachCommentCell.h"

@implementation DVVCoachCommentViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [NSMutableArray array];
        _heightArray = [NSMutableArray array];
        _index = 1;
    }
    return self;
}

- (void)dvv_networkRequestRefresh {
    _index = 1;
    [self dvv_networkRequestWithIndex:_index isRefresh:YES];
}
- (void)dvv_networkRequestLoadMore {
    [self dvv_networkRequestWithIndex:++_index isRefresh:NO];
}
- (void)dvv_networkRequestWithIndex:(NSUInteger)index isRefresh:(BOOL)isRefresh {
    
    NSString *string = [NSString stringWithFormat:BASEURL, @"courseinfo/getusercomment/2"];
    NSString *url = [NSString stringWithFormat:@"%@/%@/%lu", string, _coachID, _index];
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        [self dvv_networkCallBack];
        
        NSLog(@"DVVCoachCommentDMRootClass: %@", data);
        DVVCoachCommentDMRootClass *dmRoot = [DVVCoachCommentDMRootClass yy_modelWithJSON:data];
        if (!dmRoot.type || !dmRoot.data.count) {
            [self dvv_nilResponseObject];
            return ;
        }
        
        if (isRefresh) {
            [_dataArray removeAllObjects];
        }
        
        for (NSDictionary *dict in dmRoot.data) {
            DVVCoachCommentDMData *dmData = [DVVCoachCommentDMData yy_modelWithDictionary:dict];
            [_dataArray addObject:dmData];
        }
        // 存储高度
        for (DVVCoachCommentDMData *dmData in _dataArray) {
            CGFloat height = [DVVCoachCommentCell dynamicHeight:dmData];
            [_heightArray addObject:@(height)];
        }
        
        if (isRefresh) {
            [self dvv_refreshSuccess];
        }else {
            [self dvv_loadMoreSuccess];
        }
        
    } withFailure:^(id data) {
        [self dvv_networkCallBack];
        [self dvv_networkError];
    }];
}

@end
