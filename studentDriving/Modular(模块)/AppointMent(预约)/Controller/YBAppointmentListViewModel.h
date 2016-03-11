//
//  YBAppointmentListViewModel.h
//  studentDriving
//
//  Created by 大威 on 16/3/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DVVBaseViewModel.h"
//#import "YBAppointmentListDMRootClass.h"
#import "BaseModelMethod.h"
#import "HMCourseModel.h"
#import "YBObjectTool.h"

@interface YBAppointmentListViewModel : NSObject

/** 今天的预约 */
@property (nonatomic, strong) NSMutableArray *todayArray;
/** 未来的预约 */
@property (nonatomic, strong) NSMutableArray *nextArray;
/** 已完成的预约 */
@property (nonatomic, strong) NSMutableArray *completedArray;

@end
