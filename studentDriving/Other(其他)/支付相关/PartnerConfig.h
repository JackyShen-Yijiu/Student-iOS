//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用你的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h


#pragma mark ------------------  支付宝 ------------------
//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088221033158753"
//收款支付宝账号
#define SellerID  @"jizhipay@joyincorp.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"xjz579z3wds1kd9244pfeu9r8ha913ta"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICXQIBAAKBgQDHAoGG/CCMvSVVebXZjbWcawAfZPU/yZMzNyrar4MyEyxAyHHqB1SbMiPC0Nq/JGR3nw+eyzJHp76OsbTQwhfwWZ+DSsq0F/Jjr33iqbMKei8J6PaEvKBEvqdG1yZZZeJR0Yv0wQipl/rfUXPDtckVMUHx4fwaRsc9eSe5kUa8bwIDAQABAoGAW6aVzHq06tv5I6JH04dlykGk7tBp+hR1TDLt84S9IQSfbr5hZ+w0VL0EpyXUeA7kjgqdAP6Hi2R/Z+wDX9jjeKdSczdNFdJo4cpPg1+a4Bwprh6mWsp1qY+R2VzVP8Res+GRcMV6AQMq3MAHElVsBzlsGTActX7oo57S0uZh2wECQQDr/vtcrWIYRyLTaQATaA13LyCW2GdmU2hDNHW0+ZKxgXPKNu2qm6j1JP4CtT2tPBslvxjNaOhV7q7s0rDEuwQvAkEA1+DwEp4zjZTtZ6X2OLxXsO5Ins6GgWa7Fkx0N5ylpT4j7xjAqczgoeulMo1PBAkG9YPPSl4vyiaEi0sp75p7wQJBAJZ9w00WQ7e3pT2rd6Doea3HH8ERvt5B0fsJOQZvIFyRcIVDAcwJ93RcYp7XdL1D1wv7EJXskDw8ONBMiuzpVYECQBf/LBCVv1tMo7syypTx8rl7M11bzb3SopdO9lg8NHmS18G7OadmW84D+MAOzyq+qiRee4tjvuI0t+UX/NhijsECQQDgWMOFgs4ingbXALr9ZyGtvWOwMI9WkX2lJIeh9fO1Q4rVoj1Xkd0DrVsv/SFOMBY5CIETatYjABRGWhBmS8Tb"

//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDHAoGG/CCMvSVVebXZjbWcawAfZPU/yZMzNyrar4MyEyxAyHHqB1SbMiPC0Nq/JGR3nw+eyzJHp76OsbTQwhfwWZ+DSsq0F/Jjr33iqbMKei8J6PaEvKBEvqdG1yZZZeJR0Yv0wQipl/rfUXPDtckVMUHx4fwaRsc9eSe5kUa8bwIDAQAB"


#pragma mark ------------------ 微信 ------------------

#define weixinApp_ID @"wxb815a53dcb2faf06"//
#define weixinApp_Secret @"2637931343bdd1d1991fcef1b28a187a"//
//#define weixinApp_URL @"http://a.app.qq.com/o/simple.jsp?pkgname=com.kongfuzi.student&g_f=991653"
//#define APP_SECRET      @"1c29d52efd9f74625413c97a06136870"

//商户号，填写商户对应参数
#define MCH_ID          @"1317721101"//
//商户API密钥，填写相应参数
#define PARTNER_ID      @"JIZHIjiafu20150810andyibukejiinn"//
//支付结果回调页面
#define NOTIFY_URL      @"http://jzapi.yibuxueche.com/paynotice/weixin"//
//获取服务器端支付数据地址（商户自定义）
#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"


#pragma mark ------------------ 支付相关保存的信息
// 是否支付失败
#define isPayErrorKey @"payError"
// 订单信息
#define payErrorWithDictKey @"payErrorWithDict"
// 支付方式
#define payErrorWithPayType @"payErrorWithPayType"
// 手机号码
#define payErrorWithPhone @"payErrorWithPhone"

// 微信支付成功的通知
#define weixinpaySuccessNotification @"weixinPaySuccessNotification"
// 微信支付失败的通知
#define weixinpayErrorNotification @"weixinPayErrorNotification"

#endif
