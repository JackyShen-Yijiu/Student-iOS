//
//  DVVConfirmOrderController.h
//  studentDriving
//
//  Created by 大威 on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVConfirmOrderController : UIViewController

// 订单返回到信息
@property (nonatomic, strong) NSDictionary *extraDict;
// 手机号
@property (nonatomic, copy) NSString *mobileString;

@end
