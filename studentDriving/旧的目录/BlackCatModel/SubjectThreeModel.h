//
//  SubjectThreeModel.h
//  studentDriving
//
//  Created by bestseller on 15/11/7.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>

@interface SubjectThreeModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic, readonly) NSNumber *finishcourse;
@property (copy, nonatomic, readonly) NSString *progress;
@property (strong, nonatomic, readonly) NSNumber *reservation;
@property (strong, nonatomic, readonly) NSNumber *totalcourse;
@property (strong, nonatomic, readonly) NSNumber *missingcourse;
@property (strong, nonatomic, readonly) NSNumber *officialhours;
@property (nonatomic,strong,readonly) NSNumber *buycoursecount;
@end
