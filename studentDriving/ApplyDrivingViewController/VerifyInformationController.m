//
//  VerifyInformationController.m
//  studentDriving
//
//  Created by 胡东苑 on 15/12/15.
//  Copyright © 2015年 jatd. All rights reserved.
//


#import "VerifyInformationController.h"
#import "SignUpCell.h"
#import "ExamClassViewController.h"
#import "ExamCarViewController.h"
#import "SignUpInfoManager.h"
#import "DrivingViewController.h"
#import "SignUpCoachViewController.h"
#import "SignUpDrivingViewController.h"
#import "ChooseBtnView.h"
#import "KindlyReminderView.h"
#import "SignUpViewController.h"
#import "SubmitVerificationController.h"
#import "WhichStateViewController.h"
#import "SignUpInfoManager.h"
#import "ToolHeader.h"
#import "AcountManager.h"
#import "DrivingViewController.h"
#import "SignUpCoachDetailViewController.h"



//245 247 250

static NSString *const kuserapplyUrl = @"userinfo/enrollverificationv2";

@interface VerifyInformationController ()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *signUpArray;
}

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UIButton *referButton;
@property (strong, nonatomic) NSArray *secondArray;

@end

@implementation VerifyInformationController

- (void)clickGoback:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray *)secondArray {
    if (_secondArray == nil) {
        _secondArray = @[@"驾照类型",@"报考驾校",@"报考班型",@"报考教练",@"科目进度"];
    }
    return _secondArray;
}
- (UIButton *)referButton{
    
    if (_referButton == nil) {
        _referButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _referButton.backgroundColor = MAINCOLOR;
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
    ChooseBtnView *chooseBtnView = [[ChooseBtnView alloc] initWithSelectedBtn:1 leftTitle:@"验证手机号" midTitle:@"验证信息" rightTitle:@"提交验证" frame:CGRectMake(0, 10, kSystemWide, 67)];
    chooseBtnView.backgroundColor = [UIColor whiteColor];
    [view addSubview:chooseBtnView];
    return view;
}

- (void)viewDidLoad{
    [super  viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"验证报考驾校信息";
    
    
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [self tableHeadView];
    //    self.tableView.tableFooterView = [self tableFootView];
    [self.view addSubview:self.referButton];
    
    [self.referButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.width.equalTo(self.view);
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

    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
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
    if (indexPath.row == 0) {
        if ([SignUpInfoManager getSignUpSchoolid] == nil || [SignUpInfoManager getSignUpSchoolid].length == 0) {
        }
        ExamCarViewController *carType = [[ExamCarViewController alloc] init];// 选择车型
        [self.navigationController pushViewController:carType animated:YES];
    }else if (indexPath.row == 1 ){
        DrivingViewController *controller = [DrivingViewController new];
        controller.isHideItem = YES;
        [self.navigationController pushViewController:controller animated:YES];

//        SignUpDrivingViewController *drivingVC = [[SignUpDrivingViewController alloc] init];   //选择驾校
//        drivingVC.isVerify = YES;
//        [self.navigationController pushViewController:drivingVC animated:YES];
    }
    else if (indexPath.row == 2) {
        if ([SignUpInfoManager getSignUpSchoolid] == nil || [SignUpInfoManager getSignUpSchoolid].length == 0) {
            [self showTotasViewWithMes:@"请选择驾校"];
            return;
        }
        ExamClassViewController *classType = [[ExamClassViewController alloc] init];//报考班型
        [self.navigationController pushViewController:classType animated:YES];
    }
    else if (indexPath.row == 3) {
        SignUpCoachViewController *coachVc = [[SignUpCoachViewController alloc] init];
        coachVc.isVerify = YES;
        coachVc.markNum = 1;
        [self.navigationController pushViewController:coachVc animated:YES];
    }else if (indexPath.row == 4) {
        [self.navigationController pushViewController:[WhichStateViewController new] animated:YES];
    }
}



- (void)dealRefer:(UIButton *)sender{
    NSLog(@"__%@",signUpArray);

    if ([signUpArray[0] isEqualToString:@""]) {
        [self showTotasViewWithMes:@"驾照类型为空"];
        return;
    }
    if ([signUpArray[1] isEqualToString:@""]) {
        [self showTotasViewWithMes:@"驾校为空"];
        return;
    }
    if ([signUpArray[2] isEqualToString:@""]) {
        [self showTotasViewWithMes:@"班型为空"];
        return;
    }
    if ([signUpArray[3] isEqualToString:@""]) {
        [self showTotasViewWithMes:@"教练为空"];
        return;
    }
    if ([signUpArray[4] isEqualToString:@""]) {
        [self showTotasViewWithMes:@"科目进度为空"];
        return;
    }
    
    
        NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kuserapplyUrl];
        NSDictionary *upData = [SignUpInfoManager getSignUpPassInformation];
        [JENetwoking startDownLoadWithUrl:applyUrlString postParam:upData WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            NSDictionary *param = data;
            NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
            if ([type isEqualToString:@"1"]) {
               [self.navigationController pushViewController:[SubmitVerificationController new] animated:YES];
                [AcountManager saveUserApplyState:@"3"];
            }else {
                kShowFail(param[@"msg"]);
            }
        }];

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    signUpArray = @[[SignUpInfoManager getSignUpCarmodelName],[SignUpInfoManager getSignUpSchoolName],[SignUpInfoManager getSignUpClasstypeName],[SignUpInfoManager getSignUpVerifyCoachName],[SignUpInfoManager getSignUpSubjectId]];
    [self.tableView reloadData];
}

@end
