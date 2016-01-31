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
#define PartnerID @"2088121519930520"
//收款支付宝账号
#define SellerID  @"ybpay@ybxch.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"4d52gmvg1v9a5kt9ldi4ja6dchw7hmth"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICXAIBAAKBgQDNb6OYvMg1/V8W1Ye4wQU+WuvAdyA0r/Up+wQf3lJjJ/7Gqq50pWZyU3Z1KK/WFLiMGVjWh21RXyM6KhT/Tc/ksZ7yq2cdNfisBpCZEFoMA9fWTA2e1vj5dqf3aUpjrF2uWlUPOP46GqY8wlNuucI6GXjYBft05bvOarnFKjbUQQIDAQABAoGAI0o8Ni6nze56eTexGuG9ftqriOJt298mJFIEgVz1lib2szX6xfrrwFPqE3Ir0oC4uwhXpHKbKtFHAeTcuoapYXbAEA2BlBrtx3TuPiOx0/JGVazaR9mddEVBXkdZQj4OPMyK7QYnULPq21H3x8+1pVty0ThpPS9WXNhWS6Xf/ukCQQD4QWRs3JR5Ecs/0bB60UCBmuIm9YuI1hm/itvRn9Sd1Qar713YY4u4G0BiuAoDh5KcHcKJH/jIBFlnx7SR6v2vAkEA09hI2n8Jbmh718L6L5JaiYIgxy5vW0ugHq1U4R/+inPaDdFlfoWDm1sdML0kx8AzfnF9YPfrEjiFjMQKZ+o5DwJAb6AXo8tbB0U0+rEyhUbpll0qKxJld1Wtpi6twIf5di5/HXg33kCEZnf6b2kJN6USCxhmjHnPx0ANY1isnJ/pCQJBAL0yxmY13RN5R1m8rjr8Z9W1nVam1xdfZGLhhRQGwgufSlja8d1cmtyONHTKCGZJ9vNvon2PDafZSRUeJPkHy+sCQBkFkHAazTzBy28JLsK5pRxsOm7ANBomZ/8uKX8PNp0KNkPsY2/sNRH1AweO3qEM0SRwUqEQ2MZS28EEY69xDp4="

//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB"


#pragma mark ------------------ 微信 ------------------

#define weixinApp_ID @"wxc8c5f0de7e6f52a64"
#define weixinApp_Secret @"9557eca4e02713adee0bd73634a147864"
#define weixinApp_URL @"http://a.app.qq.com/o/simple.jsp?pkgname=com.kongfuzi.student&g_f=991653"
#define APP_SECRET      @"1c29d52efd9f74625413c97a06136870"

//商户号，填写商户对应参数
#define MCH_ID          @"1237752602"
//商户API密钥，填写相应参数
#define PARTNER_ID      @"546B81028427A64421F7B0691D0AB32D"
//支付结果回调页面
#define NOTIFY_URL      @"http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php"
//获取服务器端支付数据地址（商户自定义）
#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"


#pragma mark ------------------ 支付相关保存的信息
// 是否支付失败
#define isPayErrorKey @"payError"
// 订单信息
#define payErrorWithDictKey @"payErrorWithDict"
// 支付方式
#define payErrorWithPayType @"payErrorWithPayType"


#endif
