//
//  DVVConfirmOrderController.m
//  studentDriving
//
//  Created by 大威 on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVConfirmOrderController.h"
#import "DVVSignUpDetailPayView.h"
#import "DVVBaseDoubleRowCell.h"
#import "DVVConfirmOrderFooterView.h"
#import "JGPayTool.h"

static NSString *kCellIdentifier = @"kCellIdentifier";

@interface DVVConfirmOrderController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *detailArray;
@property (nonatomic, strong) DVVConfirmOrderFooterView *footerView;
@property (nonatomic, strong) DVVSignUpDetailPayView *payView;

// 折扣码是否正确
@property (nonatomic, assign) BOOL discountCodeFlage;
// 保存折扣码
@property (nonatomic, copy) NSString *discountCodeString;
// 折扣金额
@property (nonatomic, assign) NSUInteger discountAmount;

// 支付方式
@property (nonatomic, assign) BOOL payType;

@end

@implementation DVVConfirmOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"确认订单";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.payView];
    
    
    _discountCodeFlage = YES;
    _discountCodeString = @"";
    // 折扣金额默认0
    _discountAmount = 0;
    
    _titleArray = @[ @"折扣券", @"商品名称", @"商品金额", @"折扣金额" ];
    _detailArray = @[ @"", _extraDict[@"name"], [NSString stringWithFormat:@"%@", _extraDict[@"paymoney"]], @"-0" ].mutableCopy;
    
    _payView.label.text = [NSString stringWithFormat:@"实际支付：￥%lu元", (long)[_extraDict[@"paymoney"] integerValue]];
}

#pragma mark - action

- (void)immediatePayment:(UIButton *)button {
    
    if (!_discountCodeFlage) {
        [self obj_showTotasViewWithMes:@"请检查优惠码信息"];
        return ;
    }
    
    payType paytype;
    if (0 == _payType) {
        // 支付宝支付
        paytype = AlixPay;
    }else {
        // 微信支付
        paytype = WeChatPay;
    }
    
    // 描述
    NSString *desStr = [NSString stringWithFormat:@"%@ %@",_extraDict[@"applyclasstypeinfo"][@"name"],_extraDict[@"applyschoolinfo"][@"name"]];
    
    [JGPayTool payWithPaye:paytype tradeNO:_extraDict[@"_id"] parentView:self price:[NSString stringWithFormat:@"%lu", (long)_discountAmount] title:_extraDict[@"applyclasstypeinfo"][@"name"] description:desStr success:^(NSString *str) {
        
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
#pragma mark - 支付宝支付
- (void)firstButtonAction {
    _payType = 0;
}
#pragma mark - 微信支付
- (void)secondButtonAction {
    _payType = 1;
}

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField cell:(DVVBaseDoubleRowCell *)cell {
    
    [cell hidePrompt];
}

- (void)textFieldDidEndEditing:(UITextField *)textField cell:(DVVBaseDoubleRowCell *)cell {
    
    _discountCodeString = textField.text;
    // 折扣码不是必选项，如果没有填写折扣码，不提示错误
    if (!textField.text || !textField.text.length) {
        [cell hidePrompt];
        _discountCodeFlage = YES;
        return ;
    }
    
    // 验证活动折扣码是否正确
    NSString *urlString = [NSString stringWithFormat:BASEURL,@"system/verifyactivitycoupon"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"mobile"] = _mobileString;
    dict[@"couponcode"] = _discountCodeString;
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:dict WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"param: %@",data);
        
        NSDictionary *param = data;
        
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        
        if ([type isEqualToString:@"0"]) {
            // 显示错误信息
            _discountCodeFlage = NO;
            [self obj_showTotasViewWithMes:param[@"msg"]];
            [cell showPrompt];
            // 折扣价格置为0
            _discountAmount = 0;
            _payView.label.text = [NSString stringWithFormat:@"实际支付：￥%lu元", [_extraDict[@"paymoney"] integerValue]];
            return ;
        }
        
        [self obj_showTotasViewWithMes:@"验证成功"];
        
        // 价格
        _discountAmount = [param[@"couponmoney"] integerValue];
        NSInteger newPrice = [_extraDict[@"paymoney"] integerValue] - _discountAmount;
        [_detailArray replaceObjectAtIndex:0 withObject:_discountCodeString];
        [_detailArray replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%lu", _discountAmount]];
        _payView.label.text = [NSString stringWithFormat:@"实际支付：￥%i元", newPrice];
        [self.tableView reloadData];
        
    } withFailure:^(id data) {
        [self obj_showTotasViewWithMes:data[@"msg"]];
    }];
    
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
    
    // 如果是折扣券cell，则内容可编辑
    if (0 == indexPath.row) {
        cell.detailTextField.enabled = YES;
        cell.detailTextField.placeholder = @"请输入折扣码";
        [cell dvvBaseDoubleRowCell_setTextFieldDidBeginEditingBlock:^(UITextField *textField, DVVBaseDoubleRowCell *cell) {
            [self textFieldDidBeginEditing:textField cell:cell];
        }];
        [cell dvvBaseDoubleRowCell_setTextFieldDidEndEditingBlock:^(UITextField *textField, DVVBaseDoubleRowCell *cell) {
            [self textFieldDidEndEditing:textField cell:cell];
        }];
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

- (DVVConfirmOrderFooterView *)footerView {
    if (!_footerView) {
        _footerView = [DVVConfirmOrderFooterView new];
        __weak typeof(self) ws = self;
        [_footerView setFirstButtonActionBlock:^{
            [ws firstButtonAction];
        }];
        [_footerView setSecondButtonActionBlock:^{
            [ws secondButtonAction];
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
        [_payView.button setTitle:@"立即支付" forState:UIControlStateNormal];
        [_payView.button addTarget:self action:@selector(immediatePayment:) forControlEvents:UIControlEventTouchUpInside];
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
