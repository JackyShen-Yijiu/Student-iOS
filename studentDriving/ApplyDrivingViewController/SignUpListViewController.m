//
//  SignUpOneViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "SignUpListViewController.h"
#import "SignUpCell.h"
#import "ExamClassViewController.h"
#import "ExamCarViewController.h"
#import <SVProgressHUD.h>
#import "SignUpInfoManager.h"
#import "DrivingViewController.h"
#import "SignUpCoachViewController.h"
#import "SignUpDrivingViewController.h"
#import "ChooseBtnView.h"
#import "KindlyReminderView.h"
#import "SignUpViewController.h"
#import "SignUpSuccessViewController.h"
#import "NSUserStoreTool.h"
#import "UIColor+Hex.h"
//245 247 250

static NSString *const kuserapplyUrl = @"/userinfo/userapplyschool";

@interface SignUpListViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *signUpArray;
}

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UIButton *referButton;
@property (strong, nonatomic) NSArray *secondArray;
@property (strong, nonatomic) UIView *chooseBtnView;
@property (strong, nonatomic) UIButton *goBackButton;
@property (strong, nonatomic) UIButton *callButton;

@end

@implementation SignUpListViewController

- (void)clickGoback:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIButton *)goBackButton{
    if (_goBackButton == nil) {
        _goBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回_click"] forState:UIControlStateNormal];
        [_goBackButton addTarget:self action:@selector(dealGoBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBackButton;
}

- (UIButton *)callButton{
    if (_callButton == nil) {
        _callButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_callButton setBackgroundImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
        [_callButton addTarget:self action:@selector(callBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callButton;
}

- (UIView *)chooseBtnView {
    if (!_chooseBtnView) {
        _chooseBtnView = [[UIView alloc] init];
        _chooseBtnView.userInteractionEnabled = YES;
        _chooseBtnView.hidden = YES;
        
        UIButton *upBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 145, 40)];
        [upBtn setTitle:@"系统分配" forState:UIControlStateNormal];
        [upBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [upBtn addTarget:self action:@selector(upBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_chooseBtnView addSubview:upBtn];
        
        UIButton *downBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, 145, 40)];
        [downBtn setTitle:@"自行添加" forState:UIControlStateNormal];
        [downBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [downBtn addTarget:self action:@selector(downBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_chooseBtnView addSubview:downBtn];
        _chooseBtnView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"下拉框"]];
    }
    return _chooseBtnView;
}

- (NSArray *)secondArray {
    if (_secondArray == nil) {
        _secondArray = @[@"驾照类型",@"报考驾校",@"报考班型",@"报考教练"];
    }
    return _secondArray;
}
- (UIButton *)referButton{
    if (_referButton == nil) {
        _referButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _referButton.backgroundColor = [UIColor colorWithHexString:@"ff5d35"];
        _referButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_referButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_referButton addTarget:self action:@selector(dealRefer:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _referButton;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight -64-49) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBColor(245, 247, 250);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return _tableView;
}
- (UIView *)tableHeadView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 87)];
    ChooseBtnView *chooseBtnView = [[ChooseBtnView alloc] initWithSelectedBtn:0 leftTitle:@"选择驾校" midTitle:@"填写信息" rightTitle:@"报名验证" frame:CGRectMake(0, 10, kSystemWide, 67)];
    chooseBtnView.backgroundColor = [UIColor whiteColor];
    [view addSubview:chooseBtnView];
    return view;
}

- (void)viewDidLoad{
    [super  viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"报名信息表";
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.goBackButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.callButton];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [self tableHeadView];
//    self.tableView.tableFooterView = [self tableFootView];
    [self.view addSubview:self.referButton];
    
    [self.referButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 100;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 200)];
    KindlyReminderView *kindlyReminderView = [[KindlyReminderView alloc] initWithContentStr:@"请认真填写以上信息，您填写的信息将作为报名信息录入车考驾照系统内，如果信息错误，将影响您的报名流程。" frame:CGRectMake(0, 0, kSystemWide, 100)];
    kindlyReminderView.backgroundColor = RGBColor(245, 247, 250);
    [view addSubview:kindlyReminderView];
    
    self.chooseBtnView.frame = CGRectMake(kSystemWide-145, 0, 145, 80);
    
    
    [view addSubview:self.chooseBtnView];
    return view;
}

- (void)dealGoBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)callBtnClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://01053658566"]];
}


- (void)upBtnClick {
    self.chooseBtnView.hidden = YES;
    NSDictionary *param = @{@"coachid":@"-1",@"name":@"系统分配"};
    [SignUpInfoManager signUpInfoSaveRealCoach:param];
    signUpArray = @[[SignUpInfoManager getSignUpCarmodelName],[SignUpInfoManager getSignUpSchoolName],[SignUpInfoManager getSignUpClasstypeName],[SignUpInfoManager getSignUpCoachName]];
    [_tableView reloadData];
}

- (void)downBtnClick {
    self.chooseBtnView.hidden = YES;
    SignUpCoachViewController *coachVc = [[SignUpCoachViewController alloc] init];
    coachVc.markNum = 1;
    [self.navigationController pushViewController:coachVc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.secondArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    DYNSLog(@"result = %@",signUpArray[indexPath.row]);
    cell.detailTextLabel.text = signUpArray[indexPath.row];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _chooseBtnView.hidden = YES;
    if (indexPath.row == 0) {
        if ([SignUpInfoManager getSignUpSchoolid] == nil || [SignUpInfoManager getSignUpSchoolid].length == 0) {
        }
        ExamCarViewController *carType = [[ExamCarViewController alloc] init];// 选择车型
        [self.navigationController pushViewController:carType animated:YES];
    }else if (indexPath.row == 1 ){
        SignUpDrivingViewController *drivingVC = [[SignUpDrivingViewController alloc] init];   //选择驾校
        [self.navigationController pushViewController:drivingVC animated:YES];
            }
    else if (indexPath.row == 2) {
        if ([SignUpInfoManager getSignUpSchoolName] == nil || [SignUpInfoManager getSignUpSchoolName].length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请选择驾校"];
            return;
        }
        ExamClassViewController *classType = [[ExamClassViewController alloc] init];//报考班型
        [self.navigationController pushViewController:classType animated:YES];
    }else if (indexPath.row == 3) {
        _chooseBtnView.hidden = NO;
    }
}



- (void)dealRefer:(UIButton *)sender{
    self.chooseBtnView.hidden = YES;

    if (![signUpArray[0] isEqualToString:@""]&&![signUpArray[1] isEqualToString:@""]&&![signUpArray[2] isEqualToString:@""]&&![signUpArray[3] isEqualToString:@""]) {
       [self.navigationController pushViewController:[SignUpViewController new] animated:YES];
    }else {
        [SVProgressHUD showInfoWithStatus:@"信息未填写完整"];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    signUpArray = @[[SignUpInfoManager getSignUpCarmodelName],[SignUpInfoManager getSignUpSchoolName],[SignUpInfoManager getSignUpClasstypeName],[SignUpInfoManager getSignUpCoachName]];
    [self.tableView reloadData];
    
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    kShowDismiss
}

@end