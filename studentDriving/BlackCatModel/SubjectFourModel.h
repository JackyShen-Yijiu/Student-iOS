//
//  SubjectFourModel.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SubjectFourModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic, readonly) NSNumber *finishcourse;
@property (copy, nonatomic, readonly) NSString *progress;
@property (strong, nonatomic, readonly) NSNumber *reservation;
@property (strong, nonatomic, readonly) NSNumber *totalcourse;
@property (nonatomic,strong,readonly) NSNumber *missingcourse;
@property (strong, nonatomic, readonly) NSNumber *officialhours;
@end
