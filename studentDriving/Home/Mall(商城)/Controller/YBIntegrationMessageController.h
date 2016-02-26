//
//  YBIntegrationMessageController.h
//  studentDriving
//
//  Created by zyt on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBIntegralMallModel.h"
#import "YBDiscountModel.h"

@interface YBIntegrationMessageController : UIViewController
@property (nonatomic,assign) BOOL mallWay; // 0 积分商城 ，1 兑换劵商城
@property (nonatomic, assign) YBIntegralMallModel *integraMallModel;
@property (nonatomic, assign) YBDiscountModel *discountMallModel;
@end
