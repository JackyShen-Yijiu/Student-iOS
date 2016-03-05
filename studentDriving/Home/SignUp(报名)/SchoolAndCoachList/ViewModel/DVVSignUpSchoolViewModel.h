//
//  DVVSignUpSchoolViewModel.h
//  studentDriving
//
//  Created by 大威 on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DVVBaseViewModel.h"

#define ArchiverName_SchoolDataArray @"schoolDataArray.archiver"

@interface DVVSignUpSchoolViewModel : NSObject

@property (nonatomic, assign) BOOL isSearch;

@property (nonatomic, strong) NSMutableArray *dataArray;

// 搜索参数
// 车型选择(服务器返回类型)
@property (nonatomic, assign) NSInteger licenseType;
// 0 默认 1距离 2评分 3价格
@property (nonatomic, assign) NSInteger orderType;

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger count;

// 可选
@property (nonatomic, assign) NSInteger radius;
// 城市名称
@property (nonatomic, copy) NSString *cityName;
// 搜索名字（coachname schoolname）
@property (nonatomic, copy) NSString *searchName;

@end
