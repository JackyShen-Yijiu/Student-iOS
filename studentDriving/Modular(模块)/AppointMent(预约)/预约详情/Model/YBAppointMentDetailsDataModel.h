//
//  YBAppointMentDetailsDataModel.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DVVBaseViewModel.h"
#import "YBAppointMentDetailsDataData.h"

@interface YBAppointMentDetailsDataModel : NSObject

@property (nonatomic, copy) NSString *appointMentID;

@property (nonatomic, strong) YBAppointMentDetailsDataData *dmData;

@end
