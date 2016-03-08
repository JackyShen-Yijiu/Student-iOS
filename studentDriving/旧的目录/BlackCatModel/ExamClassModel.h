//
//  ExamClassModel.h
//  BlackCat
//
//  Created by bestseller on 15/10/20.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
#import "CarModel.h"
#import "SchoolInfo.h"
#import "VipserverModel.h"
@interface ExamClassModel : MTLModel<MTLJSONSerializing>
@property (strong,readonly,nonatomic) NSNumber *applycount;
@property (copy, readonly, nonatomic) NSString *begindate;
@property (copy, readonly, nonatomic) NSString *classid;
@property (strong, readonly, nonatomic) CarModel *carmodel;
@property (copy, readonly, nonatomic) NSString *cartype;
@property (copy, readonly, nonatomic) NSString *classchedule;
@property (copy, readonly, nonatomic) NSString *classdesc;
@property (copy, readonly, nonatomic) NSString *classname;
@property (copy, readonly, nonatomic) NSString *enddate;
@property (strong, readonly, nonatomic) NSNumber *is_vip;
@property (strong, readonly, nonatomic) NSNumber *price;
@property (strong, readonly, nonatomic) SchoolInfo *schoolinfo;
@property (strong, readonly, nonatomic) NSArray *vipserverlist;
@end
