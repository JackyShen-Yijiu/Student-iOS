//
//  SearchCoachViewModel.m
//  studentDriving
//
//  Created by 大威 on 16/1/6.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SearchCoachViewModel.h"
#import "JENetwoking.h"

#import "CoachDMData.h"
#import "YYModel.h"

@implementation SearchCoachViewModel

- (void)dvvNetworkRequestRefresh {
    
    NSString *interface = @"searchcoach";
    NSString *url = [NSString stringWithFormat:BASEURL, interface];

    [JENetwoking startDownLoadWithUrl:url postParam:[self paramtersDict] WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        [self.dataArray removeAllObjects];

        // 检测是否有数据
        if ([self checkErrorWithData:data]) {
            [self dvvRefreshSuccess];
            return ;
        }
        
        NSArray *array = data[@"data"];
        
        for (NSDictionary *dict in array) {
            
            CoachDMData *dmData = [CoachDMData yy_modelWithDictionary:dict];
            
            [self.dataArray addObject:dmData];
            
        }
        
        [self dvvRefreshSuccess];
        
    } withFailure:^(id data) {
        
    }];
}
- (void)dvvNetworkRequestLoadMore {
    
    // 判断加载时当前的请求的页面
    NSInteger dataCount = 0;
    if (self.dataArray.count) {
        if (self.dataArray.count <= 10) {
            dataCount = 10;
        }else {
            NSInteger temp = self.dataArray.count % 10;
            if (temp) {
                temp += 10 - temp;
            }
            dataCount = self.dataArray.count + temp;
        }
    }
    NSInteger index = dataCount / 10 + 1;
    // 设置当前请求的页面
    _index = index;
    
    NSString *interface = @"searchcoach";
    NSString *url = [NSString stringWithFormat:BASEURL, interface];

    [JENetwoking startDownLoadWithUrl:url postParam:[self paramtersDict] WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        // 检测是否有数据
        if ([self checkErrorWithData:data]) {
            NSString *msg = @"没有找到数据";
            if (self.dataArray.count) {
                msg = @"已经加载完成全部数据";
            }
            [self showMsg:msg];
            [self dvvLoadMoreSuccess];
            return ;
        }
        
        NSArray *array = data[@"data"];
        for (NSDictionary *dict in array) {
            CoachDMData *dmData = [CoachDMData yy_modelWithDictionary:dict];
            [self.dataArray addObject:dmData];
        }
        [self dvvRefreshSuccess];
        
    } withFailure:^(id data) {
        
    }];
}

- (NSDictionary *)paramtersDict {
    
    NSString *latitude = [NSString stringWithFormat:@"%f", self.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", self.longitude];
    NSString *radius = [NSString stringWithFormat:@"%li", self.radius];
    NSString *cityName = [NSString stringWithFormat:@"%@", self.cityName];
    NSString *licenseType = [NSString stringWithFormat:@"%li", self.licenseType];
    NSString *searchName = [NSString stringWithFormat:@"%@", self.searchName];
    NSString *orderType = [NSString stringWithFormat:@"%li", self.orderType];
    NSString *index = [NSString stringWithFormat:@"%li", self.index];
    NSString *count = [NSString stringWithFormat:@"%li", self.count];
    
    NSDictionary *params = @{ @"latitude": latitude,
                              @"longitude": longitude,
                              @"radius": radius,
                              @"cityname": cityName,
                              @"licensetype": licenseType,
                              @"coachname": searchName,
                              @"ordertype": orderType,
                              @"index": index,
                              @"count": count };
    return params;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _latitude = 40.096263;
        _longitude = 116.1270;
        _dataArray = [NSMutableArray array];
        _radius = 10000;
        _cityName = @"";
        
        _licenseType = 0;
        _orderType = 0;
        _searchName = @"";
        
        _index = 1;
        _count = 10;
    }
    return self;
}

- (void)showMsg:(NSString *)message {
    
    ToastAlertView *toast = [[ToastAlertView alloc] initWithTitle:message];
    [toast show];
}

@end
