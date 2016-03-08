//
//  CoinCertificateController.m
//  studentDriving
//
//  Created by 大威 on 15/12/31.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "CoinCertificateController.h"
#import "JENetwoking.h"

@interface CoinCertificateController ()

@property (weak, nonatomic) IBOutlet UIButton *exchangeCouponButton;
@property (weak, nonatomic) IBOutlet UIButton *deductibleAmountButton;
// 是否正在网络处理中
@property (nonatomic, assign) BOOL beingProcessed;

// 存储查询到的未领取的优惠券的ID
@property (nonatomic, strong) NSMutableArray *couponIDArray;

@end

@implementation CoinCertificateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"兑换";
}

- (IBAction)exchangeCouponButtonAction:(UIButton *)sender {
    // 兑换优惠券
    [self checkCouponWithReceiveType:@"0"];
}
- (IBAction)deductibleAmountButtonAction:(UIButton *)sender {
    // 领取钱
    [self checkCouponWithReceiveType:@"1"];
}

#pragma mark 兑换优惠券
- (void)exchangeWithReceiveType:(NSString *)receiveType
                        cuponID:(NSString *)cuponID {
    
    if (_beingProcessed) {
        [self showTotasViewWithMes:@"正在处理中"];
        return ;
    }
    _beingProcessed = YES;
    NSString *urlString = [NSString stringWithFormat:BASEURL, @"userinfo/receivemycupon"];
    NSDictionary *paramsDict = @{ @"userid": [AcountManager manager].userid,
                                  @"receivetype": receiveType,
                                  @"cuponidid": cuponID };
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *dict = data;
        NSLog(@"%@ type === %zi",dict, [[dict objectForKey:@"type"] integerValue]);
        if (![[dict objectForKey:@"type"] integerValue]) {
            [self showTotasViewWithMes:@"兑换失败"];
            return ;
        }
        
        [self showTotasViewWithMes:@"兑换成功"];
        // 兑换成功后重新保存兑换券个数
        [AcountManager manager].userCoinCertificate -= 1;
        _beingProcessed = NO;
    } withFailure:^(id data) {
        
        _beingProcessed = NO;
        [self showTotasViewWithMes:@"兑换失败"];
    }];
}
#pragma mark 查询优惠券
- (void)checkCouponWithReceiveType:(NSString *)receiveType {
    
    NSString *interface = @"userinfo/getmycupon";
    NSString *path = [NSString stringWithFormat:BASEURL, interface];
    NSDictionary *paramsDict = @{ @"userid": [AcountManager manager].userid };
    [JENetwoking startDownLoadWithUrl:path postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *paramsDict = data;
        if (![[paramsDict objectForKey:@"type"] integerValue]) {
            [self showTotasViewWithMes:@"暂无优惠券"];
            return ;
        }
        if (![[paramsDict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            [self showTotasViewWithMes:@"暂无优惠券"];
            return ;
        }
        NSArray *dataArray = [paramsDict objectForKey:@"data"];
        if (!dataArray.count) {
            [self showTotasViewWithMes:@"暂无优惠券"];
            return ;
        }
        
        //            {
        //                "_id": "56812f877b340f4e48423164",
        //                "userid": "562cb02e93d4ca260b40e544",
        //                "state": 0,
        //                "is_forcash": true,
        //                "couponcomefrom": 1,
        //                "createtime": "2015-12-28T12:48:07.805Z"
        //            }
        _couponIDArray = [NSMutableArray array];
        for (NSDictionary *itemDict in dataArray) {
            if (0 == [[itemDict objectForKey:@"state"] integerValue]) {
                [_couponIDArray addObject:[itemDict objectForKey:@"_id"]];
            }
        }
        if (!_couponIDArray.count) {
            [self showTotasViewWithMes:@"暂无优惠券"];
        }else {
            // 兑换优惠券或者领取钱
            [self exchangeWithReceiveType:receiveType cuponID:_couponIDArray.firstObject];
        }
        
    } withFailure:^(id data) {
        [self showTotasViewWithMes:@"兑换失败"];
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
