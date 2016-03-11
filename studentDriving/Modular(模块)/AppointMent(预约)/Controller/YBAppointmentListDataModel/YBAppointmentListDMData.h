//
//  YBAppointmentListDMData.h
//  studentDriving
//
//  Created by 大威 on 16/3/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBAppointmentListDMData : NSObject

/** 今天的预约 */
@property (nonatomic, strong) NSArray *todayArray;
/** 未来的预约 */
@property (nonatomic, strong) NSArray *nextArray;
/** 已完成的预约 */
@property (nonatomic, strong) NSArray *completedArray;

@end
