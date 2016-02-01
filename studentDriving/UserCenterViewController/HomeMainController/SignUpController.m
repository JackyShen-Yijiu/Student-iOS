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
#import "SignUpInfoCell.h"
#import "HomeCheckProgressView.h"
#import "SignUpFirmOrderController.h"


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
@property (nonatomic, strong) UILabel *realPayLabel;
@property (nonatomic, strong) UILabel *moneyPayLabel;
@property (nonatomic, strong) HomeCheckProgressView *YView;
@property (nonatomic, strong) SignUpPayCell *payCell;
@property (nonatomic,assign) NSInteger tag ; // tag = 200 线上支付,tag = 201 线下支付
@property (nonatomic, strong) NSArray *cellPathStr;
@property (nonatomic, strong) NSString *phoneStr; // 电话号码
@property (nonatomic, strong) NSString *nameStr; // 姓名

@property (nonatomic,copy) NSString *baomingName;
@property (nonatomic,copy) NSString *baomingTel;


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
        labelContent.textColor = [UIColor colorWithHexString:@"999999"];
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
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 280)];
        view.backgroundColor  = [UIColor whiteColor];
        [view addSubview:self.YcodeFootView];
        KindlyReminderView *kindlyReminderView = [[KindlyReminderView alloc] initWithContentStr:@"请认真填写以上信息，您填写的信息将作为报名信息录入车考驾照系统内，如果信息错误，将影响您的报名流程。" frame:CGRectMake(0, 60, kSystemWide, 100)];
        [view addSubview:kindlyReminderView];
        
        // pay view
        UIView *payView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, kSystemWide, 80)];
        payView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
        [payView addSubview:self.realPayLabel];
        [payView addSubview:self.moneyPayLabel];
        [view addSubview:payView];
        _tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}

- (void)viewDidLoad{
    [super  viewDidLoad];
    NSString *className =  nil;
    NSString *schoolName = nil;
    NSString *coachName = nil;
    if (_signUpFormDetail == SignUpFormCoachDetail) {
        // 教练详情
         coachName = self.coachDetailModel.name;
        className =  self.coachDetailModel.carmodel.name;
        schoolName = self.coachDetailModel.driveschoolinfo.name;
    }else if (_signUpFormDetail == SignUpFormSchoolDetail){
        // 驾校详情
        className = self.classTypeDMDataModel.carmodel.name;
        schoolName = self.classTypeDMDataModel.schoolinfo.name;
        coachName = @"智能匹配";
    }
    self.cellPathStr = [NSArray arrayWithObjects:className,schoolName,coachName, nil];
    self.view.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"报名";
    self.strArray = [NSArray arrayWithObjects:@"班级类型",@"报考驾校",@"报考教练", nil];
    self.infoArray = [NSArray arrayWithObjects:@"真实姓名",@"联系电话",@"验证Y码", nil];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.referButton];

    // 价格
    self.moneyPayLabel.text = [NSString stringWithFormat:@"%ld元",(long)self.serverclasslistModel.price];
    
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
        cell.detailLabel.text = self.cellPathStr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1 ) {
        SignUpInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy_4"];
        if (cell == nil) {
            cell = [[SignUpInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"yy_4"];
        }
        cell.signUpTextField.placeholder = _infoArray[indexPath.row];
        NSString *titleString = [self.secondArray[1] objectAtIndex:indexPath.row];
        [cell receiveTitile:titleString andSignUpBlock:^(NSString *completionString) {
            if (indexPath.row == 0) {
                if (completionString == nil || completionString.length == 0) {
                    [self showTotasViewWithMes:@"请输入真实姓名"];
                    return ;
                }else{
                    
                    self.baomingName = completionString;
                    
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
                }else{
                    
                    self.baomingTel = completionString;
                    
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
                        
                        // 弹出提示信息
                        _YView = [[HomeCheckProgressView alloc]initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight)];
                        _YView.imgView.image = [UIImage imageNamed:@"错"];
                        _YView.topLabel.text = @"您的Y码不正确,请重新填写";
                         _YView.bottomLabel.text = @"亲, Y码不仅能省钱还能挣钱哦亲!";
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
                } withFailure:^(id data) {
                    [self showTotasViewWithMes:@"网络连接失败，请检查网络连接"];
                }];
            }
        }];
        
        return cell;
        
    }else if (2 == indexPath.section){
        NSString *cellID = @"payCell";
        _payCell  = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!_payCell) {
            _payCell = [[SignUpPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        _payCell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 点击支付方式的回调
        _payCell.clickPayWayBlock = ^(NSInteger tag){
            _tag = tag;
        };
        return _payCell;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"f5f9f9"];
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 1)];
    topLineView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    [view addSubview:topLineView];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 9, kSystemWide, 1)];
    bottomLineView.backgroundColor = [UIColor redColor];
    [view addSubview:bottomLineView];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"f5f9f9"];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 9, kSystemWide, 1)];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    [view addSubview:bottomLineView];
    return view;
}

- (void)dealRefer:(UIButton *)sender{
    if (_baomingName == nil || _baomingName.length == 0) {
        [self showTotasViewWithMes:@"请输入手机号"];
        return;
    }
    if (_baomingTel == nil || _baomingTel.length == 0) {
        [self obj_showTotasViewWithMes:@"请输入正确的手机号"];
        return;
    }
    NSLog(@"%lu",_tag);
    NSNumber *number = nil;
    if (201 == _tag) {
        // 线下支付
        number = [[NSNumber alloc] initWithInt:1];
    }else if (200 == _tag){
        // 线上支付
        number = [[NSNumber alloc] initWithInt:2];
    }
    /*
         
         "name": "（姓名）", "idcardnumber": "（身份证号）", "telephone": "（手机号）", "address": "（地址）", "userid": "（用户id）", "schoolid": "（报名的学习id）", "coachid": "（报名的教练id）", "classtypeid": "（报名课程id）", "carmodel": { "modelsid": 1（车型类型id）, "name": "小型汽车手动挡（车型名称）", "code": "C1（车型代码）" } } "paytype": 1, // 支付方式 1 线下支付 2 线上支付
         */

    if (_signUpFormDetail == SignUpFormCoachDetail) {
        
        //从教练详情报名
        NSDictionary *carmodelParm = @{@"modelsid":self.coachDetailModel.carmodel.modelsid,
                                       @"name":self.coachDetailModel.carmodel.name,
                                       @"code":self.coachDetailModel.carmodel.code};
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"name"] = self.baomingName;
        params[@"idcardnumber"] = @"";
        params[@"telephone"] = self.baomingTel;
        params[@"address"] = [AcountManager manager].userAddress;
        params[@"userid"] = [AcountManager manager].userid;
        if (self.coachDetailModel.driveschoolinfo.driveSchoolId && [self.coachDetailModel.driveschoolinfo.driveSchoolId length]!=0) {
            params[@"schoolid"] = self.coachDetailModel.driveschoolinfo.driveSchoolId;
        }else{
            params[@"schoolid"] = @"";
        }
        params[@"coachid"] = self.coachDetailModel.coachid;
        params[@"classtypeid"] = self.serverclasslistModel._id;
        params[@"carmodel"] = carmodelParm;
        params[@"paytype"] = number;

        NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kuserapplyUrl];
        
        [JENetwoking startDownLoadWithUrl:applyUrlString postParam:params WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            
            NSDictionary *param = data;
            
            NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
            
            if ([type isEqualToString:@"1"]) {
                
                kShowSuccess(@"报名成功");
                
                [AcountManager saveUserApplyState:@"1"];
                
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
                     //支付方式"userpaystate": 0订单状态//0订单生成1开始支付2支付成功3支付失败4订单取消
                             }
                 }
                 
                 */
                 
                NSDictionary *extraDict = param[@"extra"];
                
                //使重新报名变为0
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                if ([[ud objectForKey:@"applyAgain"] isEqualToString:@"1"]) {
                    [ud setObject:@"0" forKey:@"applyAgain"];
                    [ud synchronize];
                }
                if (1 == [number integerValue]) {
                    // 线下报名
                    [self.navigationController pushViewController:[SignUpSuccessViewController new] animated:YES];
                }else if (2 == [number integerValue]){
                    // 线上报名
                    
                    SignUpFirmOrderController *vc = [SignUpFirmOrderController new];
                    vc.extraDict = extraDict;
                    vc.mobile = self.baomingTel;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }

            }else {
                kShowFail(param[@"msg"]);
            }
        }];

    }else if (_signUpFormDetail == SignUpFormSchoolDetail){
        
        // 从驾校详情报名
        NSDictionary *carmodelParm = @{@"modelsid":[NSString stringWithFormat:@"%lu",self.classTypeDMDataModel.carmodel.modelsid],
                                       @"name":self.classTypeDMDataModel.carmodel.name,
                                       @"code":self.classTypeDMDataModel.carmodel.code};
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"name"] = self.baomingName;
        params[@"idcardnumber"] = @"";
        params[@"telephone"] = self.baomingTel;
        params[@"address"] = [AcountManager manager].userAddress;
        params[@"userid"] = [AcountManager manager].userid;
        if (self.classTypeDMDataModel.schoolinfo.schoolid && [self.classTypeDMDataModel.schoolinfo.schoolid length]!=0) {
            params[@"schoolid"] = self.classTypeDMDataModel.schoolinfo.schoolid;
        }else{
            params[@"schoolid"] = self.classTypeDMDataModel.schoolinfo.schoolid;
        }
        params[@"coachid"] = @"";
        params[@"classtypeid"] = self.serverclasslistModel._id;
        params[@"carmodel"] = carmodelParm;
        params[@"paytype"] = number;
        
//        
//        NSDictionary *param = @{@"name":[SignUpInfoManager getSignUpRealName],
//                                @"idcardnumber":@"",
//                                @"telephone":[SignUpInfoManager getSignUpRealTelephone],
//                                @"address":[AcountManager manager].userAddress,
//                                @"userid":[AcountManager manager].userid,
//                                @"schoolid":self.classTypeDMDataModel.schoolinfo.schoolid,
//                                @"coachid":@"",
//                                @"classtypeid":self.classTypeDMDataModel.calssid,
//                                @"carmodel":carmodelParm,
//                                @"paytype":number};
        
        NSString *applyUrlString = [NSString stringWithFormat:BASEURL,kuserapplyUrl];
        
        [JENetwoking startDownLoadWithUrl:applyUrlString postParam:params WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            
            DYNSLog(@"param = %@",data[@"msg"]);
            
            NSDictionary *param = data;
            
            NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
            
            NSDictionary *extraDict = param[@"extra"];

            if ([type isEqualToString:@"0"]) {
                
                kShowSuccess(@"报名成功");
                [AcountManager saveUserApplyState:@"1"];
                //使重新报名变为0
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                if ([[ud objectForKey:@"applyAgain"] isEqualToString:@"1"]) {
                    [ud setObject:@"0" forKey:@"applyAgain"];
                    [ud synchronize];
                }
                if (1 == [number integerValue]) {
                    // 线下报名
                    [self.navigationController pushViewController:[SignUpSuccessViewController new] animated:YES];
                }else if (2 == [number integerValue]){
                    // 线上报名
                    
                    SignUpFirmOrderController *vc = [SignUpFirmOrderController new];
                    vc.extraDict = extraDict;
                    vc.mobile = self.baomingTel;
                    [self.navigationController pushViewController:vc animated:YES];

                }
                
            }else {
                kShowFail(param[@"msg"]);
            }
        }];

    }
    
        
    
}



- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

@end