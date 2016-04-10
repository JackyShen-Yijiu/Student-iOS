//
//  YBAppointMentDetailsDataModel.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentDetailsDataModel.h"
#import "YBAppointMentDetailsDataRootClass.h"
#import "YYModel.h"

@implementation YBAppointMentDetailsDataModel

- (void)dvv_networkRequestRefresh {
    
    if (!_appointMentID || !_appointMentID.length) {
        return ;
    }
    
    //     NSString *interface = [NSString stringWithFormat:@"userinfo/getuserinfo/2/userid/%@", _coachID];

    NSString *interface = [NSString stringWithFormat:@"courseinfo/userreservationinfo/%@", _appointMentID];
    NSString *url = [NSString stringWithFormat:BASEURL,interface];
    NSLog(@"dvv_networkRequestRefresh url:%@",url);
    
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
       
        [self dvv_networkCallBack];
        
        NSLog(@"YBAppointMentDetailsDataModel.data: %@", data);
        
        YBAppointMentDetailsDataRootClass *dmRoot = [YBAppointMentDetailsDataRootClass yy_modelWithJSON:data];
        
        if (0 == dmRoot.type) {
            [self dvv_refreshError];
            return ;
        }
        
        if (!dmRoot.data) {
            [self dvv_nilResponseObject];
            return ;
        }
        _dmData = dmRoot.data;
        [self dvv_refreshSuccess];
        
    } withFailure:^(id data) {
        [self dvv_networkCallBack];
        [self dvv_networkError];
    }];
}

@end
