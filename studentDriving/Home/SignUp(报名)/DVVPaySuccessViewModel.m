//
//  DVVPaySuccessViewModel.m
//  studentDriving
//
//  Created by 大威 on 16/3/2.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVPaySuccessViewModel.h"

@implementation DVVPaySuccessViewModel

- (void)dvv_networkRequestRefresh {
    
    NSString *interface = [NSString stringWithFormat:BASEURL, @"userinfo/getapplyschoolinfo"];
    
    NSString *userID = [AcountManager manager].userid;
    NSDictionary *parmasDict = @{ @"userid": userID };
    
    [JENetwoking startDownLoadWithUrl:interface postParam:parmasDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        DYNSLog(@"%@", data);
        
        [self dvv_networkCallBack];
        
        DVVPaySuccessDMRootClass *dmRoot = [DVVPaySuccessDMRootClass yy_modelWithJSON:data];
        
        if (!dmRoot || !dmRoot.data) {
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
