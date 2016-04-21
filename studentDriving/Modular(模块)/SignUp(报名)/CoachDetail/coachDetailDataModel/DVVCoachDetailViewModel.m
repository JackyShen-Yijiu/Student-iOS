//
//  DVVCoachDetailViewModel.m
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVCoachDetailViewModel.h"
#import "ClassTypeDMData.h"

@implementation DVVCoachDetailViewModel

- (instancetype)init{
    _classTypeListArray = [NSMutableArray array];
    return self;
}

- (void)dvv_networkRequestRefresh {
    
    //userinfo/getuserinfo/2/userid/%@
    if (!_coachID || !_coachID.length) {
        return ;
    }
    
    NSString *interface = [NSString stringWithFormat:@"userinfo/getuserinfo/2/userid/%@", _coachID];
    NSString *url = [NSString stringWithFormat:BASEURL,interface];
    
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        [self dvv_networkCallBack];
        
        NSLog(@"DVVCoachDetailViewModel_data: %@", data);
        DVVCoachDetailDMRootClass *dmRoot = [DVVCoachDetailDMRootClass yy_modelWithJSON:data];
        if (0 == dmRoot.type) {
            [self dvv_refreshError];
            return ;
        }
        if (!dmRoot.data) {
            [self dvv_nilResponseObject];
            return ;
        }
        
        _dmData = dmRoot.data;
        // 班型数据
        [_classTypeListArray removeAllObjects];
        NSArray *classListArray =  _dmData.serverclasslist;
        for (NSDictionary *dic in classListArray) {
            ClassTypeDMData *classTypeModel = [ClassTypeDMData yy_modelWithDictionary:dic];
            [_classTypeListArray addObject:classTypeModel];
        }
        
        [self dvv_refreshSuccess];
        
    } withFailure:^(id data) {
        [self dvv_networkCallBack];
        [self dvv_networkError];
    }];
}

@end
