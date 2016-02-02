//
//  SignUpFirmOrderController.m
//  studentDriving
//
//  Created by ytzhang on 16/1/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SignUpFirmOrderController.h"
#import "SignUpCell.h"
#import "KindlyReminderView.h"
#import "SignUpInfoManager.h"
#import "NSUserStoreTool.h"
#import "UIColor+Hex.h"
#import "BLPFAlertView.h"
#include "CoachViewController.h"
#import "YBBaseTableCell.h"
//245 247 250
#import "SignUpSchoolInfoCell.h"
#import "SignUpPayCell.h"
#import "SignUpInfoCell.h"
#import "SignUpFirmOrderFooterView.h"
#import "HomeCheckProgressView.h"
#import "JGPayTool.h"
#import "SignUpSucceedViewController.h"

static NSString *const kExamClassType = @"driveschool/schoolclasstype/%@";
static NSString *const kVerifyFcode = @"verifyfcodecorrect";


static NSString *const applyUrl = @"system/verifyactivitycoupon";

#define h_width [UIScreen mainScreen].bounds.size.width/320

@interface SignUpFirmOrderController ()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *signUpArray;
}

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UIButton *referButton;
@property (strong, nonatomic) NSArray *secondArray;
@property (strong, nonatomic) UIButton *callButton;

@property (strong, nonatomic) UILabel  *nameLabel;
@property (strong, nonatomic) UILabel  *applyClassName;
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) UIView   *YcodeFootView;

@property (nonatomic, strong) NSMutableArray *strArray;
@property (nonatomic, strong) NSMutableArray *infoArray;
@property (nonatomic, strong) UILabel *realPayLabel;
@property (nonatomic, strong) UILabel *moneyPayLabel;
@property (nonatomic, strong) HomeCheckProgressView *YView;
@property (nonatomic, strong) SignUpPayCell *payCell;
@property (nonatomic, assign) NSInteger tag; // 支付方式
@property (nonatomic, strong) NSString *discountPrice; // 实际支付金额
@property (nonatomic, assign) NSInteger couponmoney; // 活动券优化金额
@property (nonatomic, strong) SignUpFirmOrderFooterView *footerView;


@property (nonatomic,copy) NSString *YDiscountStr;

@end

@implementation SignUpFirmOrderController

- (NSMutableArray *)strArray
{
    if (_strArray==nil) {
        _strArray = [NSMutableArray array];
    }
    return _strArray;
}
- (NSMutableArray *)infoArray
{
    if (_infoArray==nil) {
        _infoArray = [NSMutableArray array];
    }
    return _infoArray;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}

- (UILabel *)applyClassName {
    if (!_applyClassName) {
        _applyClassName = [[UILabel alloc] init];
        _applyClassName.font = [UIFont systemFontOfSize:14];
    }
    return _applyClassName;
}


- (void)clickGoback:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIButton *)referButton{
    if (_referButton == nil) {
        _referButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _referButton.backgroundColor = [UIColor colorWithHexString:@"ff5d35"];
        _referButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_referButton setTitle:@"立即支付" forState:UIControlStateNormal];
        [_referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_referButton addTarget:self action:@selector(dealRefer:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _referButton;
}
//- (UILabel *)realPayLabel{
//    if (_realPayLabel == nil) {
//        _realPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 40)];
//        _realPayLabel.text = @"实际支付";
//        _realPayLabel.textColor = [UIColor colorWithHexString:@"333333"];
//        
//    }
//    return _realPayLabel;
//}
//- (UILabel *)moneyPayLabel{
//    if (_moneyPayLabel == nil) {
//        _moneyPayLabel = [[UILabel alloc] init];
//        _moneyPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSystemWide - 115, 20, 100, 40)];
//        _moneyPayLabel.text = @"32288元";
//        _moneyPayLabel.textColor = [UIColor colorWithHexString:@"333333"];
//        _moneyPayLabel.textAlignment = NSTextAlignmentRight;
//    }
//    return _moneyPayLabel;
//}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight -64-49)];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _footerView = [[SignUpFirmOrderFooterView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide,300) Discount:_extraDict[@"applyclasstypeinfo"][@"price"] realMoney:_extraDict[@"applyclasstypeinfo"][@"price"] schoolName:_extraDict[@"applyclasstypeinfo"][@"name"]];
        _footerView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = _footerView;
    }
    return _tableView;
}

- (void)viewDidLoad{
    [super  viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"确认订单";
    /*
     { "type": 1, "msg": "", "data": "success", "extra": { "__v": 0, "paymoney": 4700, // 支付金额 "payendtime": "2016-02-03T12:29:49.423Z", "creattime": "2016-01-31T12:29:49.423Z", "userid": "564e1242aa5c58b901e4961a", "_id": "56adfe3d323ed17278e71914", 订单id "discountmoney": 0, "applyclasstypeinfo": { "onsaleprice": 4700, "price": 4700, "name": "一步互联网驾校快班", "id": "562dd1fd1cdf5c60873625f3" }, "applyschoolinfo": { "name": "一步互联网驾校", "id": "562dcc3ccb90f25c3bde40da" }, "paychannel": 0, //支付方式 "userpaystate": 0 订单状态 // 0 订单生成 1 开始支付 2 支付成功 3 支付失败 4 订单取消 } }
     */
//    self.strArray = [NSArray arrayWithObjects:@"一步活动折扣券",@"商品名称",@"商品金额",@"折扣(当前账户可使用Y码一张)", nil];
    
    [self.strArray addObject:@"一步活动折扣券"];
    [self.strArray addObject:@"商品名称"];
    [self.strArray addObject:@"商品金额"];
    [self.strArray addObject:@"折扣金额"];

    NSDictionary *applyclasstypeinfo = _extraDict[@"applyclasstypeinfo"];
   
    NSString *dicMoney = nil;
    if (_couponmoney == 0) {
        dicMoney = @"Y-0";
    }else{
         dicMoney = [NSString stringWithFormat:@"Y-%lu",_couponmoney];
    }
    
    if (applyclasstypeinfo && [applyclasstypeinfo count]!=0) {
        [self.infoArray addObject:@""];
        [self.infoArray addObject:[NSString stringWithFormat:@"%@",applyclasstypeinfo[@"name"]]];
        [self.infoArray addObject:[NSString stringWithFormat:@"%@元",applyclasstypeinfo[@"price"]]];
        [self.infoArray addObject:[NSString stringWithFormat:@"%@元",dicMoney]];
    }
    
    [self.view addSubview:self.tableView];
    //    self.tableView.tableFooterView = [self tableFootView];
    [self.view addSubview:self.referButton];
    
    [self.referButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
    
    _footerView.discountLabel.text = [NSString stringWithFormat:@"一步现金可折扣:%@元",@"0"];
    _footerView.realPayLabel.text = [NSString stringWithFormat:@"应付: %lu元 (%@)",[_extraDict[@"paymoney"] integerValue],_extraDict[@"applyclasstypeinfo"][@"name"]];
    _footerView.discountPayLabel.text = [NSString stringWithFormat:@"实付: %lu元",[_extraDict[@"paymoney"] integerValue]];
    _discountPrice = [NSString stringWithFormat:@"%ld",[_extraDict[@"paymoney"] integerValue]];
    
}

#pragma mark -   tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return 10;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 ) {
        return 4;
    }else if(section == 1){
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        
        return 44;
    }
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (0 == indexPath.row) {
            
            // 一步活动折扣验证
            NSString *infoCellID = @"infoCellID";
            SignUpInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
            if (!infoCell) {
                infoCell = [[SignUpInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoCellID];
            }
            infoCell.signUpTextField.placeholder = @"一步活动折扣券";
            
            infoCell.signUpCompletion = ^(NSString *YDiscountStr){
                
               // 验证活动折扣券是否正确
                NSString *applyUrlString = [NSString stringWithFormat:BASEURL,applyUrl];
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                dict[@"mobile"] = _mobile;
                dict[@"couponcode"] = self.YDiscountStr;

                [JENetwoking startDownLoadWithUrl:applyUrlString postParam:dict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
                    DYNSLog(@"param = %@",data[@"msg"]);
                    NSDictionary *param = data;
                    NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
                    if ([type isEqualToString:@"1"]) {
                        kShowSuccess(@"验证成功");
                        // 价格
                        NSInteger couponmoney = [param[@"couponmoney"] integerValue];
                        NSInteger newPrice = [_extraDict[@"paymoney"] integerValue] - couponmoney;
                        _discountPrice = [NSString stringWithFormat:@"%ld",(long)newPrice];
                        _footerView.discountLabel.text = [NSString stringWithFormat:@"一步现金可折扣%lu元",couponmoney];
                        _footerView.realPayLabel.text = [NSString stringWithFormat:@"应付: %lu (%@)",[_extraDict[@"paymoney"] integerValue],_extraDict[@"applyclasstypeinfo"][@"name"]];
                        _footerView.discountPayLabel.text = [NSString stringWithFormat:@"实付: %lu",newPrice];
                        [self.tableView reloadData];
                        
                    }else {
                        kShowFail(param[@"msg"]);
                        // 弹出提示信息
                        _YView = [[HomeCheckProgressView alloc]initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight)];
                        _YView.imgView.image = [UIImage imageNamed:@"错"];
                        _YView.topLabel.text = @"一步活动折扣券不正确,请重新填写";
                        _YView.bottomLabel.text = @"";
                        _YView.topLabel.font = [UIFont systemFontOfSize:16];
                        _YView.bottomLabel.font = [UIFont systemFontOfSize:12];
                        _YView.bottomLabel.textColor = [UIColor colorWithHexString:@"e6e6e6"];
                        [_YView.rightButtton setTitle:@"下一步" forState:UIControlStateNormal];
                        [_YView.wrongButton setTitle:@"重新填写" forState:UIControlStateNormal];
                        [[UIApplication sharedApplication].keyWindow addSubview:_YView];
                        __weak typeof(self) ws = self;
                        _YView.didClickBlock = ^(NSInteger tag){
                            // 点击下一步或者重新填写时的回调
                            [ws.YView removeFromSuperview];
                        };

                    }
                }];
            };
            return infoCell;
            
        }else{
            
            SignUpSchoolInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy_0"];
            if (!cell) {
                cell = [[SignUpSchoolInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"yy_0"];
            }
            if (3 == indexPath.row) {
                cell.detailLabel.textColor = MAINCOLOR;
            }
            if(self.strArray && [self.strArray count]!=0){
                cell.rightLabel.text = self.strArray[indexPath.row];
            }
            if (self.infoArray && [self.infoArray count]!=0) {
                cell.detailLabel.text = self.infoArray[indexPath.row];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;

        }
        
    }else if (1 == indexPath.section){
        
        NSString *cellID = @"payCell";
        _payCell  = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!_payCell) {
            _payCell = [[SignUpPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        _payCell.selectionStyle = UITableViewCellSelectionStyleNone;
        //_payCell.payLineUPLabel.text = @"微信支付";
        _payCell.payLineUPButton.hidden = YES;
        _payCell.payLineUPLabel.hidden = YES;
        _payCell.payLineDownLabel.text = @"支付宝支付";
        _payCell.clickPayWayBlock = ^(NSInteger tag){
            _tag = tag;
        };

        return _payCell;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"F5F9F9"];
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 1)];
    topLineView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    [view addSubview:topLineView];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 9, kSystemWide, 1)];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    [view addSubview:bottomLineView];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"F5F9F9"];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 9, kSystemWide, 1)];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    [view addSubview:bottomLineView];
    return view;
}

- (void)dealRefer:(UIButton *)sender{
    
    
    payType type;
    
    if (200 == _tag) {
        // 微信支付
//        type = WeChatPay;
    }else if (201 == _tag){
        // 支付宝支付
        type = AlixPay;
    }
//    
//    [JGPayTool payWithPaye:AlixPay tradeNO:@"11111111111" parentView:self price:@"0.1" title:@"标题亚飞没给" description:@"描述亚飞没给我" success:^(NSString *str) {
//        
//        NSLog(@"成功操作,跳转二维码界面");
//        [self obj_showTotasViewWithMes:@"支付成功"];
//        
//    } error:^(NSString *str) {
//        
//        NSLog(@"支付失败");
//        [self obj_showTotasViewWithMes:@"支付失败"];
//      
//    }];
    
    /*
     
     报名时验证活动验证码 { "type": 1, "msg": "", "data": { "_id": "56ac5284ba6357fc4cc18b14", "couponmoney": 800, // 减少的金额 "couponcode": "123456",
     "mobile": "15652305650",
     "__v": 0, "state": 1, // 状态1未消费 2过期 3作废 4 已消费 "endtime": "2016-08-17T06:04:52.005Z", "createtime": "2016-01-30T06:07:58.385Z" } }
     
     */
    
//    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,applyUrl];
//
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"mobile"] = _mobile;
//    dict[@"couponcode"] = self.YDiscountStr;
//
//    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:dict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
//        
//        NSDictionary *newDataDict = data[@"data"];
//
//        // 价格
//        NSInteger couponmoney = [newDataDict[@"couponmoney"] integerValue];
//        NSInteger newPrice = [_extraDict[@"paymoney"] integerValue] - couponmoney;
//        NSString *price = [NSString stringWithFormat:@"%ld",(long)newPrice];
        
        // 描述
        NSString *desStr = [NSString stringWithFormat:@"%@ %@",_extraDict[@"applyclasstypeinfo"][@"name"],_extraDict[@"applyschoolinfo"][@"name"]];

        [JGPayTool payWithPaye:type tradeNO:_extraDict[@"_id"] parentView:self price:_discountPrice title:_extraDict[@"applyclasstypeinfo"][@"name"] description:desStr success:^(NSString *str) {
            
            NSLog(@"成功操作,跳转二维码界面");
            [self obj_showTotasViewWithMes:@"支付成功"];
            
            [AcountManager saveUserApplyState:@"1"];

            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setBool:NO forKey:isPayErrorKey];
            [user setObject:nil forKey:payErrorWithDictKey];
            [user synchronize];
            
            //SignUpSucceedViewController *vc = [[SignUpSucceedViewController alloc] init];
            //[self.navigationController pushViewController:vc animated:YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } error:^(NSString *str) {
            
            NSLog(@"支付失败");
            [self obj_showTotasViewWithMes:@"支付失败"];
            
        }];
//        
//    } withFailure:^(id data) {
//        
//        [self obj_showTotasViewWithMes:@"网络请求失败,请稍后再试"];
//        
//    }];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

@end
