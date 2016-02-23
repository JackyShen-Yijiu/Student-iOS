//
//  DVVCoachDetailViewModel.h
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DVVBaseViewModel.h"
#import "DVVCoachDetailDMRootClass.h"

@interface DVVCoachDetailViewModel : NSObject

@property (nonatomic, copy) NSString *coachID;

@property (nonatomic, strong) DVVCoachDetailDMData *dmData;

@end
