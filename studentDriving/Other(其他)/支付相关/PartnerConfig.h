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
#define PartnerPrivKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMcCgYb8IIy9JVV5tdmNtZxrAB9k9T/JkzM3KtqvgzITLEDIceoHVJsyI8LQ2r8kZHefD57LMkenvo6xtNDCF/BZn4NKyrQX8mOvfeKpswp6Lwno9oS8oES+p0bXJlll4lHRi/TBCKmX+t9Rc8O1yRUxQfHh/BpGxz15J7mRRrxvAgMBAAECgYBbppXMerTq2/kjokfTh2XKQaTu0Gn6FHVMMu3zhL0hBJ9uvmFn7DRUvQSnJdR4DuSOCp0A/oeLZH9n7ANf2ON4p1JzN00V0mjhyk+DX5rgHCmuHqZaynWpj5HZXNU/xF6z4ZFwxXoBAyrcwAcSVWwHOWwZMBy1fuijntLS5mHbAQJBAOv++1ytYhhHItNpABNoDXcvIJbYZ2ZTaEM0dbT5krGBc8o27aqbqPUk/gK1Pa08GyW/GM1o6FXuruzSsMS7BC8CQQDX4PASnjONlO1npfY4vFew7kiezoaBZrsWTHQ3nKWlPiPvGMCpzOCh66UyjU8ECQb1g89KXi/KJoSLSynvmnvBAkEAln3DTRZDt7elPat3oOh5rccfwRG+3kHR+wk5Bm8gXJFwhUMBzAn3dFxintd0vUPXC/sQleyQPDw40EyK7OlVgQJAF/8sEJW/W0yjuzLKlPHyuXszXVvNvdKil072WDw0eZLXwbs5p2ZbzgP4wA7PKr6qJF57i2O+4jS35Rf82GKOwQJBAOBYw4WCziKeBtcAuv1nIa29Y7Awj1aRfaUkh6H187VDitWiPVeR3QOtWy/9IU4wFjkIgRNq1iMAFEZaEGZLxNs="

//支付宝公钥
//#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDHAoGG/CCMvSVVebXZjbWcawAfZPU/yZMzNyrar4MyEyxAyHHqB1SbMiPC0Nq/JGR3nw+eyzJHp76OsbTQwhfwWZ+DSsq0F/Jjr33iqbMKei8J6PaEvKBEvqdG1yZZZeJR0Yv0wQipl/rfUXPDtckVMUHx4fwaRsc9eSe5kUa8bwIDAQAB"

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

// 微信支付成功的通知
#define weixinpaySuccessNotification @"weixinPaySuccessNotification"
// 微信支付失败的通知
#define weixinpayErrorNotification @"weixinPayErrorNotification"

#endif
