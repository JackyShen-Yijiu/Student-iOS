//
//  DriveSchoolinfo.h
//  BlackCat
//
//  Created by 董博 on 15/10/17.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>

@interface DriveSchoolinfo : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic) NSString *driveSchoolId;
@property (copy, nonatomic) NSString *name;
@end
