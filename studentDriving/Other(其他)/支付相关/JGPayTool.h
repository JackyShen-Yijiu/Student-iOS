//
//  JGPayTool.h
//  studentDriving
//
//  Created by JiangangYang on 16/1/31.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,payType){
    
    AlixPay,// 支付宝支付
    WeChatPay,// 微信支付
    
};

typedef void (^paySuccess)(NSString *str);
typedef void (^payError)(NSString *str);

@interface JGPayTool : NSObject

/*
 * payType:支付方式选择 必选
 * tradeNO:订单号 必选
 * vc:父控制器 必选
 * ID:商品ID 可选
 * price:商品价格 可选
 * title:商品标题 可选
 * description:商品描述 可选
 */
+ (void)payWithPaye:(payType)payType tradeNO:(NSString *)tradeNO parentView:(UIViewController *)vc price:(NSString *)price title:(NSString *)title description:(NSString *)description success:(paySuccess)success error:(payError)error;

@end
