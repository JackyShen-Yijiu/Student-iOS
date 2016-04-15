//
//  JZConfirmOrderController.m
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZConfirmOrderController.h"
#import "JZExchangeRecordCell.h"
#import "JZOrderMallNumberCell.h"
#import "JZOrderMallAdderssCell.h"
#import "JZConfirmOrderSuccessController.h"

#define footerViewH 40

static NSString *const kBuyproduct =  @"userinfo/buyproduct";

@interface JZConfirmOrderController ()<UITableViewDelegate,UITableViewDataSource,JZMallNumberDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) UIView *bgView;
///  YB的Label
@property (nonatomic, strong) UILabel *moneyLabel;
///  立即兑换的按钮
@property (nonatomic, strong) UIButton *exchangeButton;

@property (nonatomic, assign) NSUInteger numberMall;


@end

@implementation JZConfirmOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.moneyLabel];
    [self.bgView addSubview:self.exchangeButton];
    _numberMall = 1;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 10)];
    view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 1;
    }
    if (1 == section) {
        return 2;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return 122;
    }
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        static NSString *IDexchange = @"ecchangeID";
        JZExchangeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:IDexchange];
        if (!cell) {
            cell = [[JZExchangeRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDexchange];
        }
        cell.integrtalMallModel = self.integraMallModel;
        cell.stateLabel.hidden = YES;
        return cell;

    }
    if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            static NSString *IDnumber = @"numberID";
            JZOrderMallNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:IDnumber];
            if (!cell) {
                cell = [[JZOrderMallNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDnumber];
            }
            cell.JZMallNumberDelegate = self;
            return cell;

        }
        if (1 == indexPath.row) {
            static NSString *IDaddress = @"addressID";
            JZOrderMallAdderssCell *cell = [tableView dequeueReusableCellWithIdentifier:IDaddress];
            if (!cell) {
                cell = [[JZOrderMallAdderssCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDaddress];
            }
            cell.integrtalMallModel = self.integraMallModel;
            return cell;

        }
    }
    
    return nil;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark -----delegate(商品数量)
- (void)mallNumberWith:(NSInteger)numberMall{
    _numberMall = numberMall;
    
    NSString *result = [NSString stringWithFormat:@"%lu",_integraMallModel.productprice * numberMall];
    NSString *title  = @" 积分";
    NSInteger rang1 = [result length];
    NSInteger rang2 = [title length];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",result,title]];
    
    // 设置
    [attStr addAttribute:NSForegroundColorAttributeName value:YBNavigationBarBgColor range:NSMakeRange(0, rang1)];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, rang1)];
    
    [attStr addAttribute:NSForegroundColorAttributeName value:JZ_FONTCOLOR_LIGHT range:NSMakeRange(rang1, rang2)];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(rang1 , rang2)];
    self.moneyLabel.attributedText = attStr;


    
}
#pragma mark ---- Action 确认购买
- (void)didExchange:(UIButton *)btn{
    if (_numberMall == 0) {
        [self obj_showTotasViewWithMes:@"请选择商品数量"];
        return;
    }
    
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,kBuyproduct];
    NSLog(@"urlString = %@",urlString);
    
    // 当点击购买时向后台传送数据
    NSString *useId = [AcountManager manager].userid;
    NSString *productId =  _integraMallModel.productid;
    /*
     "usertype": 1,
     "userid": "563c8d5976e8a3882d734975",
     "productid": "564052488d799c642be50320",
     "name": "李亚飞",
     "mobile": "15652305650",
     "address": "北京市海淀区",
     "buycount": 1,
     "couponid": "dsfsdfdsfs"
     
     */
    
    
    NSDictionary *dic = @{@"usertype":@"1",
                          @"userid":useId,
                          @"productid":productId,
                          @"couponid": [NSString stringWithFormat:@"%lu",self.numberMall]
//                          @"name":_inameCell.describleTextField.text,
//                          @"mobile":_iphoneCell.describleTextField.text,
//                          @"address":_iaddressCell.describleTextField.text
                          };
//    NSLog(@"========================%@,%@,%@,%@,%@,%@",dic,useId,productId,_inameCell.describleTextField.text,_iphoneCell.describleTextField.text,_iaddressCell.describleTextField.text);
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
//            for (UIViewController *viewCon in self.navigationController.viewControllers) {
//                if ([viewCon isKindOfClass:[YBMallViewController class]]) {
//                    YBMallViewController *mallVC = (YBMallViewController *)viewCon;
//                    [self.navigationController popToViewController:mallVC animated:YES];
//                }
//                
//            }
            JZConfirmOrderSuccessController *orderSuccessVC = [[JZConfirmOrderSuccessController alloc] init];
            orderSuccessVC.integralMallModel = self.integraMallModel;
            orderSuccessVC.orderscanaduiturl = data[@"extra"][@"orderscanaduiturl"];
            [self.navigationController pushViewController:orderSuccessVC animated:YES];
            
        }
        
        
    }  withFailure:^(id data) {
        NSLog(@"errorData = %@",data);
    }];

    
    
    
    
    
    
    
    
    
}
#pragma mark --- Lazy加载
- (UITableView *)tableView
{
    if (_tableView == nil ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , kSystemHeight - 64 - footerViewH) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kSystemHeight - 64 - footerViewH, kSystemWide, footerViewH)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSystemWide / 2, footerViewH)];
            NSString *result = [NSString stringWithFormat:@"%lu",_integraMallModel.productprice];
            NSString *title  = @" 积分";
            NSInteger rang1 = [result length];
            NSInteger rang2 = [title length];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",result,title]];
            
            // 设置
            [attStr addAttribute:NSForegroundColorAttributeName value:YBNavigationBarBgColor range:NSMakeRange(0, rang1)];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, rang1)];
            
            [attStr addAttribute:NSForegroundColorAttributeName value:JZ_FONTCOLOR_LIGHT range:NSMakeRange(rang1, rang2)];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(rang1 , rang2)];
            self.moneyLabel.attributedText = attStr;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;
}
- (UIButton *)exchangeButton{
    if (_exchangeButton == nil) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _exchangeButton.frame = CGRectMake(self.bgView.frame.size.width / 2, 0, kSystemWide / 2, footerViewH);
        _exchangeButton.backgroundColor = YBNavigationBarBgColor;
        [_exchangeButton setTitle:@"确认兑换" forState:UIControlStateNormal];
        [_exchangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_exchangeButton addTarget:self action:@selector(didExchange:) forControlEvents:UIControlEventTouchUpInside];
        _exchangeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _exchangeButton;
}

@end
