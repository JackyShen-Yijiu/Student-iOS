//
//  SignUpFirmOrderController.h
//  studentDriving
//
//  Created by ytzhang on 16/1/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpFirmOrderController : UIViewController

// 订单返回到信息
@property (nonatomic, strong) NSDictionary *extraDict;
// 手机号
@property (nonatomic, copy) NSString *mobile;

@end
