//
//  JZMainSignUpController.h
//  studentDriving
//
//  Created by ytzhang on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTypeDMData.h"
#import "DVVCoachDetailDMData.h"



@interface JZMainSignUpController : UIViewController

@property (nonatomic, strong) ClassTypeDMData *dmData;

@property (nonatomic, assign) BOOL isFormCoach;

@property (nonatomic, strong) DVVCoachDetailDMData *detailDMData;
@end
