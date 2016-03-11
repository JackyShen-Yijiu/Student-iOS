//
//  YBAppointmentListViewModel.m
//  studentDriving
//
//  Created by 大威 on 16/3/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointmentListViewModel.h"
#import "YYModel.h"

@implementation YBAppointmentListViewModel

- (void)dvv_networkRequestRefresh {
    
    [JENetwoking startDownLoadWithUrl:@"" postParam:@{} WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        [self dvv_networkCallBack];
        
        YBAppointmentListDMRootClass *dmRoot = [YBAppointmentListDMRootClass yy_modelWithJSON:data];
        if (!dmRoot.type || !dmRoot.data) {
            [self dvv_nilResponseObject];
            return ;
        }
        
        
    } withFailure:^(id data) {
        ;
    }];
}

@end
