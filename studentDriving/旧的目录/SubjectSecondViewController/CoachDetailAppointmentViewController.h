//
//  CoachDetailAppointmentViewController.h
//  BlackCat
//
//  Created by bestseller on 15/10/25.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "BLBaseViewController.h"
#import "CoachModel.h"
@interface CoachDetailAppointmentViewController : BLBaseViewController
@property (copy, nonatomic) NSString *coachUserId;
@property (strong, nonatomic) CoachModel *rememberModel;
@end
