//
//  CourseViewModel.m
//  studentDriving
//
//  Created by 大威 on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "ClassTypeViewModel.h"
#import "JENetwoking.h"
#import "YYModel.h"
#import "ClassTypeDMRootClass.h"
#import "ClassTypeCell.h"

@implementation ClassTypeViewModel

- (void)dvvNetworkRequestRefresh {
    
    NSString *interface = [NSString stringWithFormat:BASEURL, @"driveschool/schoolclasstype/"];
    NSString *url = [NSString stringWithFormat:@"%@%@", interface, _schoolID];
    
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"%@", data);
        
        ClassTypeDMRootClass *dmRoot = [ClassTypeDMRootClass yy_modelWithJSON:data];
        if (0 == dmRoot.type) {
            [self dvvRefreshError];
            return ;
        }
        if (!dmRoot.data || !dmRoot.data.count) {
            [self dvvNilResponseObject];
            return ;
        }
        
        _dataArray = [NSMutableArray array];
        _heightArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dmRoot.data) {
            
            ClassTypeDMData *dmData = [ClassTypeDMData yy_modelWithDictionary:dict];
            [_dataArray addObject:dmData];
        }
        for (ClassTypeDMData *dmData in _dataArray) {
            
            CGFloat height = [ClassTypeCell dynamicHeight:dmData.classdesc];
            _totalHeight += height;
            
            [_heightArray addObject:[NSString stringWithFormat:@"%f",height]];
        }
        
        [self dvvRefreshSuccess];
        
    } withFailure:^(id data) {
        [self dvvNetworkError];
    }];
}

@end
