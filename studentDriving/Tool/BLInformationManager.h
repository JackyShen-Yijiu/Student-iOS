//
//  BLInformationManager.h
//  BlackCat
//
//  Created by bestseller on 15/10/22.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppointmentCoachModel.h"
@interface BLInformationManager : NSObject

@property (copy, nonatomic) NSMutableArray *appointmentData;
@property (strong, nonatomic) AppointmentCoachModel *appointmentCoachModel;
+ (BLInformationManager *)sharedInstance;

@end
