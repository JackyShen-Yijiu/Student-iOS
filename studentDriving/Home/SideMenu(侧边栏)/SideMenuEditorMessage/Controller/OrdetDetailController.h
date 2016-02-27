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

@end
