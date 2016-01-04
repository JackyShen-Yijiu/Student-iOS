//
//  DrivingCycleShowViewModel.m
//  studentDriving
//
//  Created by 大威 on 15/12/15.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "DrivingCycleShowViewModel.h"
#import "JENetwoking.h"
#import "DrivingCycleShowDMRootClass.h"

#define kCycleShowImagesUrl @"info/headlinenews"

@interface DrivingCycleShowViewModel()<JENetwokingDelegate>

@end

@implementation DrivingCycleShowViewModel

- (void)networkRequestRefresh {
    
    [JENetwoking initWithUrl:[NSString stringWithFormat:BASEURL,kCycleShowImagesUrl] WithMethod:JENetworkingRequestMethodGet WithDelegate:self];
}

- (void)jeNetworkingCallBackData:(id)data {
    
    DrivingCycleShowDMRootClass *rootClass = [[DrivingCycleShowDMRootClass alloc] initWithDictionary:data];
    if (!rootClass.type) {
        return ;
    }
    NSMutableArray *marray = [NSMutableArray array];
    for (DrivingCycleShowDMData *item in rootClass.data) {
        NSString *url = item.headportrait.originalpic;
        [marray addObject:url];
    }
    self.imagesUrlArray = marray;
    
    [self successRefreshBlock];
}

@end
