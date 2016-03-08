//
//  MagicDetailViewController.h
//  TestShop
//
//  Created by ytzhang on 15/12/19.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTBottomView.h"
#import "ShopMainModel.h"
#import "MyWallet.h"
#import "YBIntegralMallModel.h"
#import "YBDiscountModel.h"

@interface MagicDetailViewController : UIViewController
@property (nonatomic,retain)ShopMainModel *mainModel;
@property (nonatomic,retain) LTBottomView *bottomView;
@property (nonatomic,retain)  UIButton *didClickBtn;
@property (nonatomic,assign) int moneyCount;
@property (nonatomic,assign) BOOL mallWay; // 0 积分商城 ，1 兑换劵商城
@property (nonatomic, strong) YBDiscountModel *discountModel;
@property (nonatomic, strong) YBIntegralMallModel *integralModel;

@end
