//
//  OrdetDetailController.m
//  studentDriving
//
//  Created by zyt on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "OrdetDetailController.h"
#import "JGPayTool.h"

static NSString *kCellIdentifier = @"userinfo/getmypayorder?userid=%@&orderstate=3";

@interface OrdetDetailController ()

@end

@implementation OrdetDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    payType paytype;
    // 微信支付
    paytype = WeChatPay;

    NSString *appleStr = [NSString stringWithFormat:@"%@%@",kCellIdentifier,[AcountManager manager].userid];
    NSString *urlString = [NSString stringWithFormat:BASEURL,appleStr];
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *param = data;
        
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        
        if ([type isEqualToString:@"1"]){
            /*
             {
             "type": 1,
             "msg": "",
             "data": [
             {
             "_id": "56aef40c618a3948d82279c0",
             "userpaystate": 0,
             "creattime": "2016-02-01T05:58:36.454Z",
             "payendtime": "2016-02-04T05:58:36.454Z",
             "paychannel": 0,
             "applyschoolinfo": {
             "id": "562dcc3ccb90f25c3bde40da",
             "name": "一步互联网驾校"
             },
             */
            // 描述
            NSString *desStr = [NSString stringWithFormat:@"%@ %@",self.carModelStr,self.schoolStr];
            NSString *orderID = param[@"data"][@"_id"];
            [JGPayTool payWithPaye:paytype tradeNO:orderID parentView:self price:self.realMoneyStr title:self.classType description:desStr success:^(NSString *str) {
                
                // 报名成功时清除
                NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
                [defauts setObject:@"" forKey:@"SignUp"];
                
                
                [self obj_showTotasViewWithMes:@"支付成功"];
                [AcountManager saveUserApplyState:@"2"];
                
                
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setBool:NO forKey:isPayErrorKey];
                [user setObject:nil forKey:payErrorWithDictKey];
                [user synchronize];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            } error:^(NSString *str) {
                
                NSLog(@"支付失败");
                [self obj_showTotasViewWithMes:@"支付失败"];
                
            }];

        }

    } withFailure:^(id data) {
        
       }];

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
