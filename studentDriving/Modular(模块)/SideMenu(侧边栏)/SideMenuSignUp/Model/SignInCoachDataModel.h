//
//  SignInCoachDataModel.h
//  studentDriving
//
//  Created by 大威 on 16/1/8.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignInCoachIconModel.h"

@interface SignInCoachDataModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *gender;

@property (nonatomic, strong) SignInCoachIconModel *coachIconModel;
@end
