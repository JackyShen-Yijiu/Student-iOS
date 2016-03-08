//
//  DVVOpenControllerFromSideMenu.h
//  DVVSideMenu
//
//  Created by 大威 on 15/12/22.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, kOpenControllerType) {
    
    kOpenControllerTypeHomeMainController = 0, //首页
    kOpenControllerTypeDrivingViewController, //查找驾校
    kOpenControllerTypeChatListViewController, //消息
    kOpenControllerTypeMyWalletViewController, //钱包
    kOpenControllerTypeHomeActivityController, //活动
    kOpenControllerTypeComplaintController, //投诉
    kOpenControllerTypeSignInViewController, //签到
    kOpenControllerTypeUserCenterViewController, //我
    kOpenControllerTypeDiscountWalletController, //兑换劵
    kOpenControllerTypeMoneyShopController, //可取现金额
    kOpenControllerTypeShuttleBusController, //班车路线
    kOpenControllerTypeHomeAdvantageController //优势
};

@interface DVVOpenControllerFromSideMenu : NSObject

// 用这个方法打开对应的窗体
+ (void)openControllerWithControllerType:(kOpenControllerType)controllerType;

@end
