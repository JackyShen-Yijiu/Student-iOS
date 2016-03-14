//
//  JGPayTool.m
//  studentDriving
//
//  Created by JiangangYang on 16/1/31.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JGPayTool.h"

#import "payRequsestHandler.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthV2Info.h"
#import "WXApi.h"
#import "WXApiObject.h"

@interface JGPayTool ()

@end

@implementation JGPayTool
+ (void)payWithPaye:(payType)payType tradeNO:(NSString *)tradeNO parentView:(UIViewController *)vc price:(NSString *)price title:(NSString *)title description:(NSString *)description success:(paySuccess)success error:(payError)error
{
    
    if (payType==AlixPay) {// 支付宝支付
       
        
        [self alipayWithtradeNO:[self generateTradeNO] amount:price productName:title productDescription:description success:^(NSString *str) {
            
            success(str);
            
        } error:^(NSString *str) {
            
            error(str);
            
        }];
        
        
    }else if (payType==WeChatPay){// 微信支付
        
        if ([WXApi isWXAppInstalled]==NO) {
            [self obj_showTotasViewWithMes:@"尚未安装微信客户端"];
            return;
        }
        
        [self wxPayWithtradeNO:tradeNO success:^(NSString *str) {
            
            success(str);

        } error:^(NSString *str) {
            
            error(str);

        }];
        
    }
    
}


#pragma mark -------- 支付宝支付
+ (void)alipayWithtradeNO:(NSString *)tradeNO amount:(NSString *)amount productName:(NSString *)productName productDescription:(NSString *)productDescription success:(paySuccess)success error:(payError)error
{
    
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = PartnerID;
    NSString *seller = SellerID;
    NSString *privateKey = PartnerPrivKey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = tradeNO; //订单ID（由商家自行制定）
    order.productName = productName; //商品标题
    order.productDescription = productDescription; //商品描述
    order.amount = amount; //商品价格
    order.notifyURL = @"http://jzapi.yibuxueche.com/paynotice/alipay"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"yibuxuechePay";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"将商品信息拼接成字符串orderSpec = %@",orderSpec);
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"pay reslut = %@",resultDic);
            /*
             
             // 用户取消支付
             {
              memo = "\U7528\U6237\U4e2d\U9014\U53d6\U6d88";
              result = "";
              resultStatus = 6001;
             }
             
             */
            if (resultDic)
            {
                
                NSString *resultStatus = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
                
                // 状态返回9000为成功
                if ([resultStatus isEqualToString:@"9000"])
                {
                    /*
                     *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
                     */
                    NSLog(@"支付宝交易成功");
                    
                    success(resultStatus);
                    
                }
                else
                {
                    //交易失败
                    NSLog(@"支付失败");
                    error(resultStatus);
                }
            }
            else
            {
                //失败
                NSLog(@"支付失败");
                
                error(@"支付失败");

            }
            
        }];
        
    }
    
}

#pragma mark -------- 微信支付
+ (void)wxPayWithtradeNO:(NSString *)tradeNO success:(paySuccess)success error:(payError)error
{
    
    /*
    //{{{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    
    //创建支付签名对象
    payRequsestHandler *req = [[payRequsestHandler alloc] init];
    //初始化支付签名对象
    [req init:weixinApp_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    //}}}
    
//     获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demoWithtradeNO:tradeNO amount:amount productName:productName productDescription:productDescription type:0];
    
    NSLog(@"获取到实际调起微信支付的参数后，在app端调起支付dict:%@",dict);
    */
    
    NSString *url = [NSString stringWithFormat:kgetprepayinfo,[AcountManager manager].userid,tradeNO];
    
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,url];
    
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"获取微信预支付订单信息：%@",data);
        
        NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];

        NSMutableDictionary *dict = data[@"data"];
       
        if ([type isEqualToString:@"1"]) {
            
            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = [dict objectForKey:@"appid"];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            
            [WXApi sendReq:req];
            
        }else {
            
            [self obj_showTotasViewWithMes:[NSString stringWithFormat:@"%@",data[@"msg"]]];
            
        }
        
    } withFailure:^(id data) {
        [self obj_showTotasViewWithMes:@"网络连接失败，请检查网络连接"];
    }];
    
}

- (void)onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
                
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                
                break;
                
            case WXErrCodeUserCancel:
                
                NSLog(@"用户点击取消");
                
                break;
                
            default:
                
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                
                break;
                
        }
    }
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
    //    
}

//客户端提示信息
+ (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}

#pragma mark   ==============产生随机订单号==============
+ (NSString *)generateTradeNO
{
    
    NSString *orderno   = [NSString stringWithFormat:@"%ld",time(0)];
    
    return orderno;
    
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
