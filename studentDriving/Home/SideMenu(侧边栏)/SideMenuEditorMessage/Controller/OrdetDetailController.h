//
//  OrdetDetailController.h
//  studentDriving
//
//  Created by zyt on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdetDetailController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *payStaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *shcoolNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *carMoelLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *realMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottonRealMoneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *payButton;


@property (nonatomic, strong) NSString *schoolStr; // 驾校姓名
@property (nonatomic, strong) NSString *carModelStr; // 班型
@property (nonatomic, strong) NSString *signUpStr; // 报名时间
@property (nonatomic, strong) NSString *realMoneyStr; // 实付款
@property (nonatomic, strong) NSString *payStausStr; // 支付状态
@property (nonatomic, strong) NSString *classType;

@end
