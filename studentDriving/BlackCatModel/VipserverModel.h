//
//  VipserverModel.h
//  studentDriving
//
//  Created by bestseller on 15/11/8.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
@interface VipserverModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic, readonly) NSString *infoId;
@property (strong, nonatomic, readonly) NSNumber *msgId;
@property (copy, nonatomic, readonly) NSString *color;
@property (copy, nonatomic, readonly) NSString *name;
@end
