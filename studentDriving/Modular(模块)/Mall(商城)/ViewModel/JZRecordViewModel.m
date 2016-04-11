//
//  JZRecordViewModel.m
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZRecordViewModel.h"
#import "JZRecordListRootClass.h"
#import "JZRecordOrdrelist.h"
#import <YYModel.h>

@implementation JZRecordViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _dataArray = [NSMutableArray array];
        _index = 1;
        _count = 10;
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
    
    
    NSString *url = [NSString stringWithFormat:BASEURL, @"userinfo/getmyorderlist"];
    
    NSDictionary *paramsDict = @{ @"userid": [AcountManager manager].userid,
                                  @"index":  [NSString stringWithFormat:@"%lu", index],
                                  @"count":  [NSString stringWithFormat:@"%lu", _count] };
    
    NSLog(@"coach paramsDict: %@", paramsDict);
    
    [JENetwoking startDownLoadWithUrl:url postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"data ==========  ==========  = =========== ========== = ==%@", data);
        
        [self dvv_networkCallBack];
        
        JZRecordListRootClass *dmRoot = [JZRecordListRootClass yy_modelWithJSON:data];
        
        if (0 == dmRoot.type) {
            if (isRefresh) {
                [self dvv_refreshError];
            }else {
                [self dvv_loadMoreError];
            }
            return ;
        }
        if (!dmRoot.data.ordrelist) {
            [self dvv_nilResponseObject];
            return ;
        }
        
        if (isRefresh) {
            [_dataArray removeAllObjects];
        }
        
        for (NSDictionary *dict in dmRoot.data.ordrelist) {
            JZRecordOrdrelist *dmData = [JZRecordOrdrelist yy_modelWithDictionary:dict];
            [_dataArray addObject:dmData];
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
