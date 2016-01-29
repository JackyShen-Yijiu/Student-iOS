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
static NSString *const kuserapplyUrl = @"/userinfo/userapplyschool";
static NSString *const kExamClassType = @"driveschool/schoolclasstype/%@";
static NSString *const kVerifyFcode = @"verifyfcodecorrect";

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

@property (nonatomic, strong) NSArray *strArray;
@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) UILabel *realPayLabel;
@property (nonatomic, strong) UILabel *moneyPayLabel;
@end

@implementation SignUpFirmOrderController


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
        [_referButton setTitle:@"提交" forState:UIControlStateNormal];
        [_referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_referButton addTarget:self action:@selector(dealRefer:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _referButton;
}
- (UILabel *)realPayLabel{
    if (_realPayLabel == nil) {
        _realPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 40)];
        _realPayLabel.text = @"实际支付";
        _realPayLabel.textColor = [UIColor colorWithHexString:@"333333"];
        
    }
    return _realPayLabel;
}
- (UILabel *)moneyPayLabel{
    if (_moneyPayLabel == nil) {
        _moneyPayLabel = [[UILabel alloc] init];
        _moneyPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSystemWide - 115, 20, 100, 40)];
        _moneyPayLabel.text = @"32288元";
        _moneyPayLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _moneyPayLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneyPayLabel;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight -64-49)];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        SignUpFirmOrderFooterView *footerView = [[SignUpFirmOrderFooterView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide,300) Discount:@"yib" realMoney:@"应付:" schoolName:@"一步驾校"];
        footerView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = footerView;
    }
    return _tableView;
}

- (void)viewDidLoad{
    [super  viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"确认订单";
    self.strArray = [NSArray arrayWithObjects:@"一步活动折扣券",@"商品名称",@"商品金额",@"折扣(当前账户可使用Y码一张)", nil];
    self.infoArray = [NSArray arrayWithObjects:@"真实姓名",@"联系电话",@"验证Y码", nil];
    [self.view addSubview:self.tableView];
    //    self.tableView.tableFooterView = [self tableFootView];
    [self.view addSubview:self.referButton];
    
    [self.referButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
    
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

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SignUpSchoolInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy_0"];
        if (!cell) {
            cell = [[SignUpSchoolInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"yy_0"];
        }
        cell.rightLabel.text = self.strArray[indexPath.row];
        cell.detailLabel.text = @"一步互联网驾校";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (1 == indexPath.section){
        NSString *cellID = @"payCell";
        SignUpPayCell *payCell  = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!payCell) {
            payCell = [[SignUpPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        payCell.selectionStyle = UITableViewCellSelectionStyleNone;
        payCell.payLineUPLabel.text = @"微信支付";
        payCell.payLineDownLabel.text = @"支付宝支付";
        return payCell;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 1)];
    topLineView.backgroundColor = [UIColor redColor];
    [view addSubview:topLineView];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 9, kSystemWide, 1)];
    bottomLineView.backgroundColor = [UIColor redColor];
    [view addSubview:bottomLineView];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 9, kSystemWide, 1)];
    bottomLineView.backgroundColor = [UIColor redColor];
    [view addSubview:bottomLineView];
    return view;
}

- (void)dealRefer:(UIButton *)sender{
    
    NSDictionary *param = [SignUpInfoManager getSignUpInforamtion];
    if (param == nil) {
        return;
    }
    NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kuserapplyUrl];
    [JENetwoking startDownLoadWithUrl:applyUrlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        DYNSLog(@"param = %@",data[@"msg"]);
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            kShowSuccess(@"报名成功");
//            [self.navigationController pushViewController:[SignUpSuccessViewController new] animated:YES];
            [AcountManager saveUserApplyState:@"1"];
            //使重新报名变为0
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            if ([[ud objectForKey:@"applyAgain"] isEqualToString:@"1"]) {
                [ud setObject:@"0" forKey:@"applyAgain"];
                [ud synchronize];
            }
        }else {
            kShowFail(param[@"msg"]);
        }
    }];
}



- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

@end
