//
//  YBIntegrationMessageController.m
//  studentDriving
//
//  Created by zyt on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBIntegrationMessageController.h"
#import "YBIntegrationMessageCell.h"
#import "MallListSuccessController.h"
#import "YBMallViewController.h"

static NSString *const kBuyproduct =  @"userinfo/buyproduct";
@interface YBIntegrationMessageController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) UIView *bgView;
///  YB的Label
@property (nonatomic, strong) UILabel *moneyLabel;
///  立即兑换的按钮
@property (nonatomic, strong) UIButton *exchangeButton;

@property (nonatomic, strong) NSArray *titleIntegrationArray;
@property (nonatomic, strong) NSArray *titleDiscountArray;
@property (nonatomic, strong) NSArray *describeIntegrationArray;
@property (nonatomic, strong) NSArray *describeDiscountArray;
@property (nonatomic, strong) NSArray *integrationTagArray;
@property (nonatomic, strong) NSArray *discountTagArray;

@property (nonatomic, strong) YBIntegrationMessageCell *iaddressCell;
@property (nonatomic, strong) YBIntegrationMessageCell *inameCell;
@property (nonatomic, strong) YBIntegrationMessageCell *iphoneCell;

@property (nonatomic, strong) YBIntegrationMessageCell *dNameCell;
@property (nonatomic, strong) YBIntegrationMessageCell *dPhoneCell;

@end

@implementation YBIntegrationMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.view.backgroundColor = RGBColor(249, 249, 249);
    [self.view addSubview:self.tabelView];
    [self.bgView addSubview:self.moneyLabel];
    [self.bgView addSubview:self.exchangeButton];
    [self.view addSubview:self.bgView];
    [self initData];
    
}
- (void)initData{
    NSString *addressStr = nil;
    NSString *nameStr = nil;
    NSString *mobileStr = nil;
    // 判断姓名是否为空
    if ([AcountManager manager].userName.length == 0  || [AcountManager manager].userName == nil) {
        nameStr = @"暂无姓名";
    }else{
        nameStr = [AcountManager manager].userName;
    }
    // 判断地址是否为空
    if ([AcountManager manager].userAddress.length == 0  || [AcountManager manager].userAddress == nil) {
        addressStr = @"暂无地址";
    }else{
        addressStr = [AcountManager manager].userAddress;
    }
    // 判断电话是否为空
    if ([AcountManager manager].userMobile == nil) {
        mobileStr = @"暂无电话";
    }else{
        mobileStr = [AcountManager manager].userMobile;
    }

    self.titleIntegrationArray = @[@"商品名称",@"兑换积分",@"配送方式",@"邮寄地址",@"收货人姓名",@"联系电话"];
    self.titleDiscountArray = @[@"商品名称",@"兑换方式",@"配送方式",@"收货人姓名",@"联系电话"];
    self.integrationTagArray = @[@"500",@"501",@"502",@"503",@"504",@"505"];
    self.discountTagArray = @[@"600",@"601",@"602",@"603",@"604"];
    if (0 == _mallWay) {
        self.describeIntegrationArray = @[_integraMallModel.productname,[NSString stringWithFormat:@"%luYB",_integraMallModel.productprice],@"快递免费",addressStr,nameStr,mobileStr];
    }else if (1 == _mallWay){
        self.describeDiscountArray = @[_discountMallModel.productname,@"1张报名兑换劵",@"到店自取",nameStr,mobileStr];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_mallWay == 0) {
        return self.titleIntegrationArray.count;
    }else if (_mallWay == 1){
        return self.titleDiscountArray.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 79.7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID =@"IntegralMallID";
     YBIntegrationMessageCell *mallCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!mallCell) {
        if (0 == _mallWay) {
             mallCell = [[YBIntegrationMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID tag:[self.integrationTagArray[indexPath.row] integerValue]];
            if (3 == indexPath.row) {
                self.iaddressCell = mallCell;
            }
            if (4 == indexPath.row) {
                self.inameCell = mallCell;
            }
            if (5 == indexPath.row) {
                self.iphoneCell = mallCell;
            }
        } else if(1 == _mallWay){
             mallCell = [[YBIntegrationMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID tag:[self.discountTagArray[indexPath.row] integerValue]];
            if (3 == indexPath.row) {
                self.dNameCell = mallCell;
            }
            if (4 == indexPath.row) {
                self.dPhoneCell = mallCell;
            }

        }
       
    }
    if (0 == indexPath.row || 1 == indexPath.row || 2 == indexPath.row  ) {
        mallCell.describleTextField.userInteractionEnabled = NO;
    }
    if (0 == _mallWay) {
        mallCell.titleLabel.text = self.titleIntegrationArray[indexPath.row];
        mallCell.describleTextField.text = self.describeIntegrationArray[indexPath.row];
        if (1 == indexPath.row) {
            mallCell.describleTextField.textColor = YBNavigationBarBgColor;
        }
    }
    else if (1 == _mallWay){
        mallCell.titleLabel.text = self.titleDiscountArray[indexPath.row];
        mallCell.describleTextField.text = self.describeDiscountArray[indexPath.row];
    }
    
    mallCell.backgroundColor = [UIColor clearColor];
    return mallCell;
    
    
}
#pragma mark ---- ActionTarget
- (void)didExchange:(UIButton *)btn{
    if (0 == _mallWay) {
        // 积分商城
        if (!self.iaddressCell.showWarningMessageView.hidden) {
            [self obj_showTotasViewWithMes:@"请填写正确信息"];
            return;
        }
        if (!self.inameCell.showWarningMessageView.hidden) {
            [self obj_showTotasViewWithMes:@"请填写正确信息"];
            return;
        }
        if (!self.iphoneCell.showWarningMessageView.hidden) {
            [self obj_showTotasViewWithMes:@"请填写正确信息"];
            return;
        }
        NSLog(@"%@,%@,%@",self.iaddressCell.describleTextField.text,self.inameCell.describleTextField.text,self.iphoneCell.describleTextField.text);
        NSString *urlString = [NSString stringWithFormat:BASEURL,kBuyproduct];
        NSLog(@"urlString = %@",urlString);
        
        // 当点击购买时向后台传送数据
        NSString *useId = [AcountManager manager].userid;
        NSString *productId =  _integraMallModel.productid;
        
        NSDictionary *dic = @{@"usertype":@"1",
                              @"userid":useId,
                              @"productid":productId,
                              @"name":_inameCell.describleTextField.text,
                              @"mobile":_iphoneCell.describleTextField.text,
                              @"address":_iaddressCell.describleTextField.text};
        NSLog(@"========================%@,%@,%@,%@,%@,%@",dic,useId,productId,_inameCell.describleTextField.text,_iphoneCell.describleTextField.text,_iaddressCell.describleTextField.text);
        [JENetwoking startDownLoadWithUrl:urlString postParam:dic WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            /*
            { data = suncess;
             extra =     {
             finishorderurl = "http://api.yibuxueche.com/validation/getpageorderfinish?orderid=56cfe6c9623c319d25a02384";
             orderid = 56cfe6c9623c319d25a02384;
             orderscanaduiturl = "http://api.yibuxueche.com/validation/ordervalidation?orderid=56cfe6c9623c319d25a02384";
             };
             msg = "";
             type = 1;
             }
             */
            if (1 == [data[@"type"] integerValue]) {
                [self obj_showTotasViewWithMes:@"积分兑换完成"];
                for (UIViewController *viewCon in self.navigationController.viewControllers) {
                    if ([viewCon isKindOfClass:[YBMallViewController class]]) {
                        YBMallViewController *mallVC = (YBMallViewController *)viewCon;
                        [self.navigationController popToViewController:mallVC animated:YES];
                    }
                    
                }

            }
            
            
        }  withFailure:^(id data) {
            NSLog(@"errorData = %@",data);
        }];

        
        
    } else if (1 == _mallWay){
        // 兑换劵商城
        if (!self.dNameCell.showWarningMessageView.hidden) {
            [self obj_showTotasViewWithMes:@"请填写正确信息"];
            return;
        }
        if (!self.dPhoneCell.showWarningMessageView.hidden) {
            [self obj_showTotasViewWithMes:@"请填写正确信息"];
            return;
        }
        NSLog(@"%@,%@,%@",self.iaddressCell.describleTextField.text,self.inameCell.describleTextField.text,self.iphoneCell.describleTextField.text);
        NSString *urlString = [NSString stringWithFormat:BASEURL,kBuyproduct];
        NSLog(@"urlString = %@",urlString);
        
        // 当点击购买时向后台传送数据
        NSString *useId = [AcountManager manager].userid;
        NSString *productId =  _discountMallModel.productid;
        
        NSDictionary *dic = @{@"usertype":@"1",
                              @"userid":useId,
                              @"productid":productId,
                              @"name":_dNameCell.describleTextField.text,
                              @"mobile":_dPhoneCell.describleTextField.text,
                              @"address":@""};
        NSLog(@"========================%@,%@,%@,%@,%@,%@",dic,useId,productId,_inameCell.describleTextField.text,_iphoneCell.describleTextField.text,_iaddressCell.describleTextField.text);
        [JENetwoking startDownLoadWithUrl:urlString postParam:dic WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            /*
             { data = suncess;
             extra =     {
             finishorderurl = "http://api.yibuxueche.com/validation/getpageorderfinish?orderid=56cfe6c9623c319d25a02384";
             orderid = 56cfe6c9623c319d25a02384;
             orderscanaduiturl = "http://api.yibuxueche.com/validation/ordervalidation?orderid=56cfe6c9623c319d25a02384";
             };
             msg = "";
             type = 1;
             }
             */
            NSDictionary *parm = data[@"extra"];
            MallListSuccessController *successVC = [[MallListSuccessController alloc] init];
            successVC.successUrl = parm[@"finishorderurl"];
            [self.navigationController pushViewController:successVC animated:YES];
            
        }  withFailure:^(id data) {
            NSLog(@"errorData = %@",data);
        }];
        

    }
}
#pragma mark ---- Lazy 加载
- (UITableView *)tabelView{
    if (_tabelView == nil) {
        _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 50) style:UITableViewStylePlain];
        _tabelView.backgroundColor = [UIColor clearColor];
        _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tabelView.delegate = self;
        self.tabelView.dataSource  = self;
    }
    return _tabelView;
    
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kSystemHeight - 114, kSystemWide, 50)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}
- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 18, 150, 14)];
        if (0 == _mallWay) {
            // 积分商城
            
            _moneyLabel.text = [NSString stringWithFormat:@"需支付:%luYB",_integraMallModel.productprice];
        }else if (1 == _mallWay){
            // 兑换劵商城
            _moneyLabel.text = @"需要消费一张兑换劵";
        }
        _moneyLabel.font = [UIFont systemFontOfSize:14];
        _moneyLabel.textColor = [UIColor colorWithHexString:@"212121"];
    }
    return _moneyLabel;
}
- (UIButton *)exchangeButton{
    if (_exchangeButton == nil) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _exchangeButton.frame = CGRectMake(self.bgView.frame.size.width - 100 - 25, 7.5, 100, 35);
        _exchangeButton.backgroundColor = YBNavigationBarBgColor;
        [_exchangeButton setTitle:@"立即兑换" forState:UIControlStateNormal];
        [_exchangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_exchangeButton addTarget:self action:@selector(didExchange:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeButton;
}

@end
