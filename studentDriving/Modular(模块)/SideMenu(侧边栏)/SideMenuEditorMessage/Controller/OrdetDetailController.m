//
//  OrdetDetailController.m
//  studentDriving
//
//  Created by zyt on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "OrdetDetailController.h"
#import "JGPayTool.h"

//static NSString *kCellIdentifier = @"userinfo/getmypayorder?userid=%@&orderstate=3";
static NSString *kCellIdentifier = @"userinfo/getmypayorder";

@interface OrdetDetailController ()
@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, strong) NSString *discountStr;
@end

@implementation OrdetDetailController
- (void)viewWillAppear:(BOOL)animated{
    
    self.payStaysLabel.text = @"支付失败";
    self.shcoolNameLabel.text = self.schoolStr;
    self.carMoelLabel.text = self.carModelStr;
    self.orderTimeLabel.text = self.signUpStr;
    self.orderMoneyLabel.text = [NSString stringWithFormat:@"¥%@",self.realMoneyStr];
    
    self.realMoneyLabel.text = [NSString stringWithFormat:@"¥%lu",[self.realMoneyStr integerValue] - [self.discountStr integerValue]];
    self.bottonRealMoneyLabel.text =  [NSString stringWithFormat:@"¥%lu",[self.realMoneyStr integerValue] - [self.discountStr integerValue]];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *param = @{@"userid":[AcountManager manager].userid,
                            @"orderstate":@"-1"};
//    NSString *appleStr = [NSString stringWithFormat:@"%@",kCellIdentifier,[AcountManager manager].userid];
    NSString *urlString = [NSString stringWithFormat:BASEURL,kCellIdentifier];
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *param = data;
        
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        
        if ([type isEqualToString:@"1"]){
            /*
             {
             data =     (
             {
             "_id" = 56d8fa833947daad595e5a53;
             activitycoupon = "";
             applyclasstypeinfo =             {
             id = 56aecf9b70667d997fda6247;
             name = "\U6d4b\U8bd5\U73ed\U578b \U8df3\U697c\U4ef7";
             onsaleprice = 1;
             price = 1;
             };
             applyschoolinfo =             {
             id = 562dcc3ccb90f25c3bde40da;
             name = "\U4e00\U6b65\U4e92\U8054\U7f51\U9a7e\U6821";
             };
             couponcode = "";
             creattime = "2016-03-04T03:01:23.453Z";
             discountmoney = 0;
             paychannel = 0;
             payendtime = "2016-03-07T03:01:23.453Z";
             paymoney = 1;
             userpaystate = 0;
             }
             );
             msg = "";
             type = 1;
             }
             */
            
            // 获取订单编号
            if ([param[@"data"] count]) {
                self.orderNumberLabel.text = [NSString stringWithFormat:@"订单号 %@",[param[@"data"] firstObject][@"_id"]];
                self.discountMoneyLabel.text = [NSString stringWithFormat:@"¥%@",[param[@"data"] firstObject][@"paychannel"]];
            }
        }
        
    } withFailure:^(id data) {
        
    }];

    /*
     
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
     
     
     @property (nonatomic, strong) NSString *schoolStr; // 驾校姓名
     @property (nonatomic, strong) NSString *carModelStr; // 班型
     @property (nonatomic, strong) NSString *signUpStr; // 报名时间
     @property (nonatomic, strong) NSString *realMoneyStr; // 实付款
     @property (nonatomic, strong) NSString *payStausStr; // 支付状态
     @property (nonatomic, strong) NSString *classType;

     */
//    self.orderNumberLabel.text = 
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)didClickAlipay:(id)sender {
    payType paytype;
    // 支付宝支付
    paytype = AlixPay;
    
    // 描述
    NSString *desStr = [NSString stringWithFormat:@"%@ %@",self.carModelStr,self.schoolStr];
    NSString *orderID = self.orderID;
    
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


@end
