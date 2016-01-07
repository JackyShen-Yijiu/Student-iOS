//
//  SearchCoachViewModel.h
//  studentDriving
//
//  Created by 大威 on 16/1/6.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVBaseViewModel.h"

@interface SearchCoachViewModel : DVVBaseViewModel

// 数据列表
@property (nonatomic, strong) NSMutableArray *dataArray;

// 搜索条件
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) NSInteger radius;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, assign) NSInteger licenseType;
@property (nonatomic, assign) NSInteger orderType;
@property (nonatomic, copy) NSString *searchName;

@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) NSUInteger count;

@end
