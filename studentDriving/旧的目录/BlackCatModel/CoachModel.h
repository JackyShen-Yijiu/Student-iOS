//
//  CoachModel.h
//  BlackCat
//
//  Created by 董博 on 15/10/17.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
#import "Logoimg.h"
#import "DriveSchoolinfo.h"
#import "CoachDetail.h"

@interface CoachModel : MTLModel<MTLJSONSerializing>

@property (copy, readonly, nonatomic) NSString *Seniority;
@property (copy, readonly, nonatomic) NSString *coachid;
@property (strong, readonly, nonatomic) NSNumber *distance;
@property (copy, readonly, nonatomic) NSString *name;
@property (strong, readonly, nonatomic) DriveSchoolinfo *driveschoolinfo;
@property (strong, readonly, nonatomic) Logoimg *headportrait;
//是否接送
@property (assign, readonly, nonatomic) BOOL is_shuttle;
@property (strong, readonly, nonatomic) NSNumber *latitude;
@property (strong, readonly, nonatomic) NSNumber *longitude;
@property (strong, readonly, nonatomic) NSNumber *passrate;
@property (strong, readonly, nonatomic) NSNumber *starlevel;

@property (strong, readonly, nonatomic) NSNumber *commentcount;

@property (strong, readonly, nonatomic) NSArray *subject;

@end
