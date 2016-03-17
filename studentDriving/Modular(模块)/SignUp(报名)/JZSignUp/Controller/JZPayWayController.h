//
//  JZPayWayController.h
//  studentDriving
//
//  Created by ytzhang on 16/3/15.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTypeDMData.h"

@interface JZPayWayController : UIViewController
@property (nonatomic, assign) BOOL isHaveYCode;
@property (nonatomic, strong) ClassTypeDMData *dmData;
@property (nonatomic, strong) NSString *yCodeStr;
@property (nonatomic, strong) NSString *coachName;


// 订单返回到信息
@property (nonatomic, strong) NSDictionary *extraDict;
// 手机号
@property (nonatomic, copy) NSString *mobileString;

@end
