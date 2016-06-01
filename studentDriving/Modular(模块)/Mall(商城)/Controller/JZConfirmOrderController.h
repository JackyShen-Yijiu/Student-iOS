//
//  JZConfirmOrderController.h
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZRecordOrdrelist.h"
#import "YBIntegralMallModel.h"

@interface JZConfirmOrderController : UIViewController

@property (nonatomic,assign) BOOL mallWay; // 0 积分商城 ，1 兑换劵商城

@property (nonatomic, assign) YBIntegralMallModel *integraMallModel;

@property (nonatomic, assign) NSInteger integralNumber;
@end
