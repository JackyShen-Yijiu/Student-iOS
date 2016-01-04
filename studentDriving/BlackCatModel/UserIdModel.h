//
//  UserIdModel.h
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import "Logoimg.h"
#import <MTLJSONAdapter.h>
@interface UserIdModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic, readonly) NSString *userId;
@property (strong, nonatomic, readonly) Logoimg *headportrait;
@property (copy, nonatomic, readonly) NSString *name;
@end
