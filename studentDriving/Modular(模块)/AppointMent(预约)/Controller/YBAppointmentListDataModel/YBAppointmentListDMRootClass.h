//
//  YBAppointmentListDMRootClass.h
//  studentDriving
//
//  Created by 大威 on 16/3/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBAppointmentListDMData.h"

@interface YBAppointmentListDMRootClass : NSObject

@property (nonatomic, strong) YBAppointmentListDMData *data;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, assign) NSInteger type;

@end
