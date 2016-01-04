//
//  MyAppointmentCoachModel.h
//  BlackCat
//
//  Created by bestseller on 15/10/25.
//  Copyright © 2015年 lord. All rights reserved.
//
/*
 "_id" = 5616352721ec29041a9af889;
 driveschoolinfo =                 {
 id = 56163c376816a9741248b7f9;
 name = "\U5317\U4eac\U6d77\U6dc0\U9a7e\U6821";
 };
 headportrait =                 {
 height = "";
 originalpic = "";
 thumbnailpic = "";
 width = "";
 };
 name = "\U674e\U4e9a\U98de\U6559\U7ec3";

 */
#import "MTLModel.h"
#import "DriveSchoolinfo.h"
#import "Logoimg.h"
#import <MTLJSONAdapter.h>
@interface MyAppointmentCoachModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic, readonly) NSString *infoId;
@property (strong, nonatomic, readonly) DriveSchoolinfo *driveschoolinfo;
@property (strong, nonatomic, readonly) Logoimg *headportrait;
@property (copy, nonatomic, readonly) NSString *name;
@end
