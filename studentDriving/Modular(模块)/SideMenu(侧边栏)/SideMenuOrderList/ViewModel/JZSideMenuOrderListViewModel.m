//
//  JZSideMenuOrderListViewModel.m
//  studentDriving
//
//  Created by ytzhang on 16/4/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZSideMenuOrderListViewModel.h"
#import <YYModel.h>

@implementation JZSideMenuOrderListViewModel

- (instancetype)init{
    _listDataArray = [NSMutableArray array];
    return self;
}

- (void)dvv_networkRequestRefresh {
    
    NSString *url = [NSString stringWithFormat:BASEURL,@"userinfo/getcuponuselist"];
    NSDictionary *param = @{@"userid":[AcountManager manager].userid};
    
    [JENetwoking startDownLoadWithUrl:url postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        /*
         {
         "type": 1,
         "msg": "",
         "data": [
         {
         "_id": "570cc683ec71a98dbcb0e290",
         "userid": "56e6341394aaa86c3244d9a1",
         "createtime": "2016-04-11T07:26:32.132Z",
         "couponcomefrom": 1,
         "is_forcash": false,
         "state": 4,
         "usetime": "2016-04-15T07:26:32.132Z",
         "productid": {
         "_id": "5652883a35146036001414c5",
         "productname": "64G 闪存盘"
         },
         "orderscanaduiturl": "http://jzapi.yibuxueche.com/validation/applyvalidation?userid=570cc683ec71a98dbcb0e290"
         }
         ]
         }
         
         */
        
        NSDictionary *param = data;
        
        
        
        [self dvv_networkCallBack];
        if (0 == [param[@"type"] integerValue]) {
            [self dvv_refreshError];
            return ;
        }
        if (!param[@"data"]) {
            [self dvv_nilResponseObject];
            return ;
        }
        for (NSDictionary *dic in param[@"data"]) {
            JZSideMenuOrderListData *listDataModel = [JZSideMenuOrderListData yy_modelWithDictionary:dic];
            [_listDataArray addObject:listDataModel];
        }
        [self dvv_refreshSuccess];
        
    } withFailure:^(id data) {
        [self dvv_networkCallBack];
        [self dvv_networkError];
    }];
}

@end
