//
//  SignUpController.m
//  studentDriving
//
//  Created by ytzhang on 16/1/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SignUpController.h"
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
#import "SignUpSuccessViewController.h"
#import "NSUserStoreTool.h"
#import "UIColor+Hex.h"
#import "ExamClassModel.h"
#import "ExamDetailCell.h"
#import "SignUpCell.h"
#import "ApplyClassCell.h"
#import "BLPFAlertView.h"
#include "CoachViewController.h"
#import "YBBaseTableCell.h"
//245 247 250
#import "SignUpSchoolInfoCell.h"
#import "SignUpPayCell.h"
static NSString *const kuserapplyUrl = @"/userinfo/userapplyschool";
static NSString *const kExamClassType = @"driveschool/schoolclasstype/%@";
static NSString *const kVerifyFcode = @"verifyfcodecorrect";

#define h_width [UIScreen mainScreen].bounds.size.width/320

@interface SignUpController ()<UITableViewDataSource, UITableViewDelegate>{
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

@property (assign, nonatomic) BOOL      cellIsShow;            // 用来记录班级详情时候显示
@property (assign, nonatomic) NSInteger numberOfClass;         //班级的个数
@property (strong, nonatomic) NSArray   *classDetailDataArray; //用来保存选择驾校后返回的班级详情信息
@property (strong, nonatomic) NSArray   *classNameDataArray;   //用来保存班级名字
@property (assign, nonatomic) NSInteger whichBtnClick;         //用来记录报考班型中那个cell被点击了

@property (nonatomic, strong) NSArray *strArray;
@property (nonatomic, strong) NSArray *infoArray;
@end

@implementation SignUpController

- (UIView *)YcodeFootView {
    if (!_YcodeFootView) {
        _YcodeFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 60)];
        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 20)];
        labelTitle.text = @"Y码须知:";
        labelTitle.font = [UIFont systemFontOfSize:12];
        labelTitle.textColor = [UIColor redColor];
        [_YcodeFootView addSubview:labelTitle];
        UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, kSystemWide-30, 30)];
        labelContent.text = @"       Y码不影响您的报名流程!填写正确的Y码,即可获得丰厚的奖励。";
        labelContent.font = [UIFont systemFontOfSize:12];
        labelContent.numberOfLines = 2;
        labelContent.textColor = [UIColor blackColor];
        [_YcodeFootView addSubview:labelContent];
    }
    return _YcodeFootView;
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
        [_referButton setTitle:@"提交" forState:UIControlStateNormal];
        [_referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_referButton addTarget:self action:@selector(dealRefer:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _referButton;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, kSystemWide, kSystemHeight -64-49)];
        _tableView.backgroundColor = RGBColor(245, 247, 250);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 160)];
        [view addSubview:self.YcodeFootView];
        KindlyReminderView *kindlyReminderView = [[KindlyReminderView alloc] initWithContentStr:@"请认真填写以上信息，您填写的信息将作为报名信息录入车考驾照系统内，如果信息错误，将影响您的报名流程。" frame:CGRectMake(0, 60, kSystemWide, 100)];
        kindlyReminderView.backgroundColor = RGBColor(245, 247, 250);
        [view addSubview:kindlyReminderView];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}

- (void)viewDidLoad{
    [super  viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"报名信息表";
    self.strArray = [NSArray arrayWithObjects:@"班级类型",@"报考驾校",@"报考教练", nil];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
                   return 3;
            }else if(section == 2){
                return 1;
        }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 ) {
        
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
        return cell;
    }else if (indexPath.section == 1 ) {
        SignUpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy_4"];
        if (cell == nil) {
            cell = [[SignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"yy_4"];
        }
        cell.signUpTextField.placeholder = _infoArray[indexPath.row];
        //        [cell receiveTextContent:];
        NSString *titleString = [self.secondArray[1] objectAtIndex:indexPath.row];
        [cell receiveTitile:titleString andSignUpBlock:^(NSString *completionString) {
            if (indexPath.row == 0) {
                if (completionString == nil || completionString.length == 0) {
                    [self showTotasViewWithMes:@"请输入真实姓名"];
                    return ;
                }
                if(completionString.length>6) {
                    cell.signUpTextField.text = @"";
                    [self showTotasViewWithMes:@"最大输入6个中文字符"];
                    return;
                }
                [SignUpInfoManager signUpInfoSaveRealName:completionString];
                DYNSLog(@"真实名字");
            }else if (indexPath.row == 1) {
                if (completionString == nil || completionString.length == 0) {
                    [self showTotasViewWithMes:@"请输入手机号"];
                    return;
                }
                if (![AcountManager isValidateMobile:completionString]) {
                    [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
                    return;
                }
                [SignUpInfoManager signUpInfoSaveRealTelephone:completionString];
                DYNSLog(@"联系方式");
            }else if (indexPath.row == 2) {
                NSDictionary *param = @{@"userid":[AcountManager manager].userid,
                                        @"fcode":completionString};
                NSString *verifyFcode = [NSString stringWithFormat:BASEURL,kVerifyFcode];
                
                [JENetwoking startDownLoadWithUrl:verifyFcode postParam:param WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
                    DYNSLog(@"param = %@",data[@"msg"]);
                    NSDictionary *param = data;
                    NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
                    if ([type isEqualToString:@"1"]) {
                        kShowSuccess(@"Y码验证成功");
                        [SignUpInfoManager signUpInfoSaveRealFcode:completionString];
                    }else {
                        kShowFail(@"未查询到此Y码");
                    }
                } withFailure:^(id data) {
                    [self showTotasViewWithMes:@"网络连接失败，请检查网络连接"];
                }];
            }
        }];
        
        return cell;
        
    }else if (2 == indexPath.section){
        NSString *cellID = @"payCell";
        SignUpPayCell *payCell  = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!payCell) {
            payCell = [[SignUpPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return payCell;
    }
    return nil;
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
            [self.navigationController pushViewController:[SignUpSuccessViewController new] animated:YES];
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