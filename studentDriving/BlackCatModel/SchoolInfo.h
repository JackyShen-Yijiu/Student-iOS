//
//  SchoolInfo.h
//  studentDriving
//
//  Created by bestseller on 15/11/3.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
@interface SchoolInfo : MTLModel<MTLJSONSerializing>
@property (copy,readonly,nonatomic) NSString *address;
@property (strong,readonly,nonatomic) NSNumber *latitude;
@property (strong,readonly,nonatomic) NSNumber *longitude;
@property (copy,readonly,nonatomic) NSString *name;
@property (copy,readonly,nonatomic) NSString *schoolid;

@end
