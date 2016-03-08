//
//  DrivingDetailViewModel.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DrivingDetailViewModel.h"
#import "JENetwoking.h"
#import "YYModel.h"

@implementation DrivingDetailViewModel

- (void)dvvNetworkRequestRefresh {
    
    NSString *interface = [NSString stringWithFormat:BASEURL, @"driveschool/getschoolinfo/"];
    NSString *url = [NSString stringWithFormat:@"%@%@", interface, _schoolID];
    
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        [self dvvNetworkCallBack];
        
        NSLog(@"%@   %@", data, [AcountManager manager].applyschool.infoId);

        DrivingDetailDMRootClass *dmRoot = [DrivingDetailDMRootClass yy_modelWithJSON:data];
        if (0 == dmRoot.type) {
            [self dvvRefreshError];
            return ;
        }
        if (!dmRoot.data) {
            [self dvvNilResponseObject];
            return ;
        }
        _dmData = dmRoot.data;
        
        [self dvvRefreshSuccess];
        
    } withFailure:^(id data) {
        [self dvvNetworkCallBack];
        [self dvvNetworkError];
    }];
}

@end
