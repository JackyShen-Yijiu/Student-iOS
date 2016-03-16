//
//  SubjectTwoModel.h
//  studentDriving
//
//  Created by bestseller on 15/10/29.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>

@interface SubjectTwoModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic, readonly) NSNumber *finishcourse;
@property (copy, nonatomic, readonly) NSString *progress;
@property (strong, nonatomic, readonly) NSNumber *reservation;
@property (strong, nonatomic, readonly) NSNumber *totalcourse;//
@property (nonatomic,strong,readonly) NSNumber *missingcourse;
@property (strong, nonatomic, readonly) NSNumber *officialhours;
@property (nonatomic,strong,readonly) NSNumber *buycoursecount;
@property (nonatomic,assign,readonly) NSInteger officialfinishhours;
@end


/*
 规定  officialhours
 完成 officialfinishhours（这是新加的字段）
 购买  totalcourse
 已学  finishcourse
 还需几学时  （officialhours-officialfinishhours）
 */
