//
//  SignInDataModel.h
//  studentDriving
//
//  Created by 大威 on 16/1/8.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignInCoachDataModel.h"

@interface SignInDataModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *beginTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *courseProcessDesc;

@property (nonatomic, strong) SignInCoachDataModel *coachDataModel;

// 签到的状态
@property (nonatomic, assign) BOOL signInStatus;

@end
