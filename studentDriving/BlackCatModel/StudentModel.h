//
//  StudentModel.h
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import "UserIdModel.h"
#import <MTLJSONAdapter.h>
@interface StudentModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic, readonly) NSString *infoId;
@property (strong, nonatomic, readonly) UserIdModel *userid;
@end
