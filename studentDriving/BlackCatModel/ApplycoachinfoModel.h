//
//  ApplycoachinfoModel.h
//  studentDriving
//
//  Created by bestseller on 15/10/27.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
@interface ApplycoachinfoModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic, readonly) NSString *infoId;
@property (copy, nonatomic, readonly) NSString *name;
@end
