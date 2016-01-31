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
 * payType:支付方式选择
 * tradeNO:订单号
 * vc:父控制器
 * ID:商品ID
 * price:商品价格
 * title:商品标题
 * description:商品描述
 */
+ (void)payWithPaye:(payType)payType tradeNO:(NSString *)tradeNO parentView:(UIViewController *)vc ID:(NSString *)ID price:(NSString *)price title:(NSString *)title description:(NSString *)description success:(paySuccess)success error:(payError)error;

@end
