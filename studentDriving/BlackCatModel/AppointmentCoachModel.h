//
//  AppointmentCoachModel.h
//  BlackCat
//
//  Created by bestseller on 15/10/22.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MTLModel.h"
#import "DriveSchoolinfo.h"
#import "Logoimg.h"
#import <MTLJSONAdapter.h>
@interface AppointmentCoachModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic) NSString *seniority;
@property (copy, nonatomic) NSString *coachid;
@property (strong, nonatomic) DriveSchoolinfo *driveschoolinfo;
@property (strong, nonatomic) Logoimg *headportrait;
@property (assign, nonatomic) BOOL is_shuttle;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *passrate;
@property (strong, nonatomic) NSNumber *starlevel;
@end
