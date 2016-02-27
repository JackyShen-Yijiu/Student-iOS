//
//  DVVSignUpCoachViewModel.m
//  studentDriving
//
//  Created by 大威 on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVSignUpCoachViewModel.h"
#import "JENetwoking.h"
#import "DVVSignUpCoachDMRootClass.h"

@implementation DVVSignUpCoachViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [NSMutableArray array];
        _orderType = 2;
        _latitude = 40.096263;
        _longitude = 116.1270;
        
        _radius = 10000;
        _cityName = @"";
        _searchName = @"";
        
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
    
//    if (isRefresh) {
//        [_dataArray removeAllObjects];
//    }
    
    NSString *url = [NSString stringWithFormat:BASEURL, @"searchcoach"];
    
    NSDictionary *paramsDict = @{ @"latitude": [NSString stringWithFormat:@"%f", _latitude],
                                  @"longitude":  [NSString stringWithFormat:@"%f", _longitude],
                                  @"radius":  [NSString stringWithFormat:@"%lu", _radius],
                                  @"cityname": _cityName,
                                  @"licensetype": @"",
                                  @"coachname": _searchName,
                                  @"ordertype":  [NSString stringWithFormat:@"%lu", _orderType],
                                  @"index":  [NSString stringWithFormat:@"%lu", index],
                                  @"count":  [NSString stringWithFormat:@"%lu", _count] };
    
    NSLog(@"coach paramsDict: %@", paramsDict);
    
    [JENetwoking startDownLoadWithUrl:url postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"%@", data);
        
        [self dvv_networkCallBack];
        
        DVVSignUpCoachDMRootClass *dmRoot = [DVVSignUpCoachDMRootClass yy_modelWithJSON:data];
        
        if (0 == dmRoot.type) {
            if (isRefresh) {
                [self dvv_refreshError];
            }else {
                [self dvv_loadMoreError];
            }
            return ;
        }
        if (!dmRoot.data.count) {
            if (_isSearch) {
                [_dataArray removeAllObjects];
                [self dvv_refreshSuccess];
                return ;
            }
            [self dvv_nilResponseObject];
            return ;
        }
        
        if (isRefresh) {
            [_dataArray removeAllObjects];
        }
        
        for (NSDictionary *dict in dmRoot.data) {
            DVVSignUpCoachDMData *dmData = [DVVSignUpCoachDMData yy_modelWithDictionary:dict];
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
