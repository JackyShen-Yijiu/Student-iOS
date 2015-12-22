//
//  DrivingModel.h
//  BlackCat
//
//  Created by bestseller on 15/10/9.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
#import "Logoimg.h"
@interface DrivingModel : MTLModel<MTLJSONSerializing>
@property (copy,readonly ,nonatomic) NSString *address;
@property (copy,readonly , nonatomic) NSNumber *distance;
@property (copy,readonly , nonatomic) NSNumber *latitude;
@property (strong,readonly , nonatomic) Logoimg *logoimg;
@property (copy,readonly , nonatomic) NSNumber *longitude;
@property (copy,readonly , nonatomic) NSNumber *maxprice;
@property (copy,readonly , nonatomic) NSNumber *minprice;
@property (copy,readonly , nonatomic) NSString *name;
@property (strong,readonly, nonatomic) NSNumber *passingrate;
@property (copy,readonly , nonatomic) NSString *schoolid;
@property (assign,readonly, nonatomic) NSInteger coachcount;
@end
