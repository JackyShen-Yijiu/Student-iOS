//
//  DVVSignUpDetailController.m
//  studentDriving
//
//  Created by 大威 on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVSignUpDetailController.h"
#import "DVVBaseDoubleRowCell.h"
#import "DVVSignUpDetailFooterView.h"
#import "DVVSignUpDetailPayView.h"
#import "SignUpSuccessViewController.h"
#import "SignUpFirmOrderController.h"
#import "DVVToast.h"

static NSString *kCellIdentifier = @"kCellIdentifier";

@interface DVVSignUpDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *detailArray;
@property (nonatomic, strong) DVVSignUpDetailFooterView *footerView;
@property (nonatomic, strong) DVVSignUpDetailPayView *payView;

// 用于区分是否是从教练详情里进入的
@property (nonatomic, assign) BOOL isCoach;
// 用于区分线上或线下支付
@property (nonatomic, assign) BOOL isOnLine;

// 手机号是否填写正确
@property (nonatomic, assign) BOOL mobileFlage;
// 保存手机号
@property (nonatomic, copy) NSString *mobileString;

// Y码是否正确
@property (nonatomic, assign) BOOL yCodeFlage;
// 保存Y码
@property (nonatomic, copy) NSString *yCodeString;

@end

@implementation DVVSignUpDetailController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    self.title = @"报名";
    
    _mobileFlage = YES;
    _yCodeFlage = YES;
    
    // 默认线上支付
    _isOnLine = YES;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.payView];
    
    _titleArray = @[ @"班级类型", @"报考驾校", @"报考教练", @"真实姓名", @"联系电话", @"一步Y码折扣券" ];
    _detailArray = @[ @"", @"", @"", @"", @"", @"" ].mutableCopy;
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [DVVToast hide];
}

- (void)loadData {
    
    if (!_dmData) {
        return ;
    }
    
    // 班型
    NSString *classType = [NSString stringWithFormat:@"%@ ￥%i", _dmData.classname, _dmData.price];
    [_detailArray replaceObjectAtIndex:0 withObject:classType];
    
    // 驾校名
    NSString *schoolName = _dmData.schoolinfo.name;
    [_detailArray replaceObjectAtIndex:1 withObject:schoolName];
    
    // 教练名
    NSString *coachName = @"智能匹配";
    if (_dmData.coachID && _dmData.coachName.length) {
        if (_dmData.coachName && _dmData.coachName.length) {
            coachName = _dmData.coachName;
            _isCoach = YES;
        }
    }
    [_detailArray replaceObjectAtIndex:2 withObject:coachName];
    
    // 用户名
    NSString *userName = [AcountManager manager].userName;
    [_detailArray replaceObjectAtIndex:3 withObject:userName];
    
    // 手机号
    NSString *mobile = [AcountManager manager].userMobile;
    _mobileString = mobile;
    [_detailArray replaceObjectAtIndex:4 withObject:mobile];
    
    
    _payView.label.text = [NSString stringWithFormat:@"需支付：%i元", _dmData.price];
}

#pragma mark - action

#pragma mark 下一步
- (void)nextStep:(UIButton *)sender {
    
    if (!_mobileFlage || !_yCodeFlage) {
        [self obj_showTotasViewWithMes:@"请检查信息是否输入有误"];
        return ;
    }
    
    NSMutableDictionary *carmodelParams = [NSMutableDictionary dictionary];
    carmodelParams[@"modelsid"] = [NSString stringWithFormat:@"%i",_dmData.carmodel.modelsid];
    carmodelParams[@"name"] = _dmData.carmodel.name;
    carmodelParams[@"code"] = _dmData.carmodel.code;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"name"] = [AcountManager manager].userName;
    params[@"idcardnumber"] = @"";
    params[@"telephone"] = _mobileString;
    params[@"address"] = [AcountManager manager].userAddress;
    params[@"userid"] = [AcountManager manager].userid;
    if (_dmData.schoolinfo.schoolid && _dmData.schoolinfo.schoolid.length) {
        params[@"schoolid"] = _dmData.schoolinfo.schoolid;
    }else{
        params[@"schoolid"] = @"";
    }
    // 如果是从教练进入的，则填写教练ID
    if (_isCoach) {
        params[@"coachid"] = _dmData.coachID;
    }else {
        params[@"coachid"] = @"";
    }
    
    params[@"classtypeid"] = _dmData.calssid;
    params[@"carmodel"] = [self dictionaryToJson:carmodelParams];
    
    if (_isOnLine) {
        // 线上支付
        params[@"paytype"] = @2;
        
    }else {
        // 线下支付
        params[@"paytype"] = @1;
    }
    
    NSLog(@"apply params: %@", params);
    
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,@"userinfo/userapplyschool"];
    
    [DVVToast show];
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:params WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        [DVVToast hide];
        
        NSString *type = [NSString stringWithFormat:@"%@",data[@"type"]];
        
        if ([type isEqualToString:@"0"]) {
            [self obj_showTotasViewWithMes:data[@"msg"]];
            return ;
        }
        
        [self obj_showTotasViewWithMes:@"报名成功"];
        
        /*
         
         {
         "type": 1,
         "msg": "",
         "data": "success",
         "extra": {
         "__v": 0,
         "paymoney": 4700,
         //支付金额"payendtime": "2016-02-03T12:29:49.423Z",
         "creattime": "2016-01-31T12:29:49.423Z",
         "userid": "564e1242aa5c58b901e4961a",
         "_id": "56adfe3d323ed17278e71914",
         订单id"discountmoney": 0,
         "applyclasstypeinfo": {
         "onsaleprice": 4700,
         "price": 4700,
         "name": "一步互联网驾校快班",
         "id": "562dd1fd1cdf5c60873625f3"
         },
         "applyschoolinfo": {
         "name": "一步互联网驾校",
         "id": "562dcc3ccb90f25c3bde40da"
         },
         "paychannel": 0,
         userpaystate": 0订单状态//0订单生成1开始支付2支付成功3支付失败4订单取消 //支付方式"
         }
         }
         
         */
        
        NSDictionary *extraDict = data[@"extra"];;
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        // 存储状态
        //是否支付失败
#define isPayErrorKey @"payError"
        [ud setBool:YES forKey:isPayErrorKey];
        
        // 订单信息
        //#define payErrorWithDictKey @"payErrorWithDict"
        [ud setObject:extraDict forKey:payErrorWithDictKey];
        
        // 支付方式
        //#define payErrorWithPayType @"payErrorWithPayType"
        
        // 手机号码
        //#define payErrorWithPhone @"payErrorWithPhone"
        [ud setObject:_mobileString forKey:payErrorWithPhone];
        
        
        //使重新报名变为0
        if ([[ud objectForKey:@"applyAgain"] isEqualToString:@"1"]) {
            [ud setObject:@"0" forKey:@"applyAgain"];
        }
        [ud synchronize];
        
        if (_isOnLine) {
            // 线下报名
            [self.navigationController pushViewController:[SignUpSuccessViewController new] animated:YES];
        }else {
            // 线上报名
            
            SignUpFirmOrderController *vc = [SignUpFirmOrderController new];
            vc.extraDict = extraDict;
            vc.mobile = _mobileString;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } withFailure:^(id data) {
        [DVVToast hide];
        [self obj_showTotasViewWithMes:data[@"msg"]];
    }];
}

#pragma mark 点击线上支付
- (void)onLineButtonAction {
    _isOnLine = YES;
}
#pragma mark 点击线下支付
- (void)offLineButtonAction {
    _isOnLine = NO;
}

#pragma mark - public

#pragma mark 将字典转化为JSON字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dict {
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField cell:(DVVBaseDoubleRowCell *)cell {
    
    [cell hidePrompt];
}

- (void)textFieldDidEndEditing:(UITextField *)textField cell:(DVVBaseDoubleRowCell *)cell {
    if (4 == cell.tag) {
        // 验证手机号
        if (textField.text.length != 11) {
            [cell showPrompt];
            _mobileFlage = NO;
        }else {
            [cell hidePrompt];
            _mobileFlage = YES;
        }
    }
    if (5 == cell.tag) {
        
        _yCodeString = textField.text;
        // Y码不是必选项，如果没有填写Y码，不提示错误
        if (!textField.text || !textField.text.length) {
            [cell hidePrompt];
            _yCodeFlage = YES;
            return ;
        }
        // 验证Y码
        NSDictionary *paramsDict = @{ @"userid":[AcountManager manager].userid,
                                      @"fcode":textField.text };
        
        NSString *verifyFcode = [NSString stringWithFormat:BASEURL, @"verifyfcodecorrect"];
        
        [JENetwoking startDownLoadWithUrl:verifyFcode postParam:paramsDict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            
            DYNSLog(@"param = %@",data[@"msg"]);
            NSDictionary *param = data;
            NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
            if ([type isEqualToString:@"1"]) {
                NSLog(@"Y码验证成功");
                _yCodeFlage = YES;
                [cell hidePrompt];
            }else {
                NSLog(@"未查询到此Y码");
                [cell showPrompt];
                _yCodeFlage = NO;
            }
        } withFailure:^(id data) {
            [self obj_showTotasViewWithMes:@"网络连接失败，请检查网络连接"];
        }];
    }
}

#pragma mark - tableView delegate and data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DVVBaseDoubleRowCell *cell = [[DVVBaseDoubleRowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    cell.tag = indexPath.row;
    
    cell.titleLabel.text = _titleArray[indexPath.row];
    cell.detailTextField.text = _detailArray[indexPath.row];
    // 如果是联系电话cell、Y码cell，则内容可编辑
    if (4 == indexPath.row || 5 == indexPath.row) {
        cell.detailTextField.enabled = YES;
        [cell dvvBaseDoubleRowCell_setTextFieldDidBeginEditingBlock:^(UITextField *textField, DVVBaseDoubleRowCell *cell) {
            [self textFieldDidBeginEditing:textField cell:cell];
        }];
        [cell dvvBaseDoubleRowCell_setTextFieldDidEndEditingBlock:^(UITextField *textField, DVVBaseDoubleRowCell *cell) {
            [self textFieldDidEndEditing:textField cell:cell];
        }];
        if (4 == indexPath.row) {
            cell.detailTextField.placeholder = @"请输入手机号";
        }
        if (5 == indexPath.row) {
            cell.detailTextField.placeholder = @"请输入Y码";
        }
    }else {
        cell.detailTextField.enabled = NO;
    }
    
    return cell;
}

#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        CGSize size = [UIScreen mainScreen].bounds.size;
        _tableView.frame = CGRectMake(0, 0, size.width, size.height - 64 - 48);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 64;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
        
        _tableView.tableFooterView = self.footerView;
    }
    return _tableView;
}

- (DVVSignUpDetailFooterView *)footerView {
    if (!_footerView) {
        _footerView = [DVVSignUpDetailFooterView new];
        __weak typeof(self) ws = self;
        [_footerView setOnLineButtonActionBlock:^{
            [ws onLineButtonAction];
        }];
        [_footerView setOffLineButtonActionBlock:^{
            [ws offLineButtonAction];
        }];
    }
    return _footerView;
}

- (DVVSignUpDetailPayView *)payView {
    if (!_payView) {
        _payView = [DVVSignUpDetailPayView new];
        CGSize size = [UIScreen mainScreen].bounds.size;
        _payView.frame = CGRectMake(0, size.height - 64 - 48, size.width, 48);
        _payView.backgroundColor = [UIColor whiteColor];
        [_payView.button setTitle:@"下一步" forState:UIControlStateNormal];
        [_payView.button addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payView;
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
