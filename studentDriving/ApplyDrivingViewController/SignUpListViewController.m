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
//245 247 250

static NSString *const kuserapplyUrl = @"/userinfo/userapplyschool";
static NSString *const kExamClassType = @"driveschool/schoolclasstype/%@";
static NSString *const kVerifyFcode = @"verifyfcodecorrect";

#define h_width [UIScreen mainScreen].bounds.size.width/320

@interface SignUpListViewController ()<UITableViewDataSource, UITableViewDelegate>{
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

@end

@implementation SignUpListViewController

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

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setTitle:@"C1小车手动挡" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setTitle:@"C2小车自动挡" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (void)clickGoback:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIButton *)callButton{
    if (_callButton == nil) {
        _callButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_callButton setBackgroundImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
        [_callButton addTarget:self action:@selector(callBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callButton;
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
    _whichBtnClick = 1000;//仅仅为了第一次进来时报考班型按钮不为红色
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.goBackButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.callButton];
    
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

#pragma mark -   Action

- (void)leftBtnClick {
    [self.leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSDictionary *param = @{@"modelsid":@(1),@"name":@"小型汽车手动挡",@"code":@"C1"};
    [SignUpInfoManager  signUpInfoSaveRealCarmodel:param];
}

- (void)rightBtnClick {
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    NSDictionary *param = @{@"modelsid":@(2),@"name":@"小型自动挡汽车",@"code":@"C2"};
    [SignUpInfoManager  signUpInfoSaveRealCarmodel:param];
}

#pragma mark -   tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
       return 10;
}

- (void)callBtnClick {

    [BLPFAlertView showAlertWithTitle:@"电话号码" message:@"010-53658566" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
        DYNSLog(@"index = %lu",selectedOtherButtonIndex+1);
        NSUInteger indexAlert = selectedOtherButtonIndex + 1;
        if (indexAlert == 1) {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"01053658566"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else {
            return ;
        }
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.secondArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_cellIsShow) {
            return 5;
        }else {
            return 4;
        }
    }else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row ==3) {
        if (_cellIsShow) {
            return 420;
        }else {
            return 44;
        }
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        if (_numberOfClass == 0) {
            return 44;
        }
        if (_numberOfClass%2) {
            return 44 + 34*(_numberOfClass/2);
        }else {
            return 44 + 34*(_numberOfClass/2-1);
        }
    }else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy_0"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"yy_0"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        self.nameLabel.frame = CGRectMake(16*h_width, 15, 80, 14);
        self.nameLabel.text = [self.secondArray[0] objectAtIndex:0];
        [cell.contentView addSubview:self.nameLabel];
        self.leftBtn.frame = CGRectMake(100, 10, 100, 24);
        [cell.contentView addSubview:self.leftBtn];
        self.rightBtn.frame = CGRectMake(220, 10, 100, 24);
        [cell.contentView addSubview:self.rightBtn];
         return cell;
    }else if ((indexPath.row == 1 &&indexPath.section == 0)||(indexPath.row == 3 && indexPath.section == 0 && !_cellIsShow)||(indexPath.row == 4 && indexPath.section == 0 && _cellIsShow)) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy_1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"yy_1"];
        }
        cell.textLabel.text = [self.secondArray[0] objectAtIndex:indexPath.row];;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSLog(@"%zd",indexPath.row);
        cell.detailTextLabel.text = [signUpArray[0] objectAtIndex:indexPath.row];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }else if (indexPath.row == 2 && indexPath.section == 0) {
        ApplyClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy_2"];
//        for (UIView *view in cell.contentView.subviews) {
//            [view removeFromSuperview];
//        }
        if (!cell) {
            cell = [[ApplyClassCell alloc] initWithStyle:0 reuseIdentifier:@"yy_2"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if ([[_secondArray[0] objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
            self.applyClassName.frame = CGRectMake(16*h_width, 16, 80, 14);
            self.applyClassName.text = @"报考班型";
            [cell.contentView addSubview:self.applyClassName];
        }else {
            cell.btnTag = _whichBtnClick;
            [cell refreshUIWithArray:[_secondArray[0] objectAtIndex:indexPath.row]];
            cell.refresh = ^(NSInteger tag){
                ExamClassModel *model = _classDetailDataArray[tag];
                NSDictionary *classtypeParam = @{kRealClasstypeid:model.classid,@"name":model.classname};
                [SignUpInfoManager signUpInfoSaveRealClasstype:classtypeParam];
                _whichBtnClick = tag;
                _cellIsShow = YES;
                _secondArray = @[@[@"驾照类型:",@"报考驾校",_classNameDataArray,_classDetailDataArray,@"报考教练"],@[@"真实姓名",@"联系电话",@"验证Y码"]];
                signUpArray = @[@[[SignUpInfoManager getSignUpCarmodelName],[SignUpInfoManager getSignUpSchoolName],[SignUpInfoManager getSignUpClasstypeName],@"",[SignUpInfoManager getSignUpCoachName]],@[[SignUpInfoManager getSignUpRealName],[SignUpInfoManager getSignUpRealTelephone],@""]];
                [tableView reloadData];
            };
        }
        return cell;
    }else if (indexPath.row == 3 && indexPath.section == 0 && _cellIsShow) {
        
        static NSString *cellId = @"cell";
        ExamDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

        if (cell == nil) {
            cell = [[ExamDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        ExamClassModel *model = [[_secondArray[0] objectAtIndex:indexPath.row] objectAtIndex:_whichBtnClick];
        cell.schoolClassLabel.text = [NSString stringWithFormat:@"适用驾照类型:%@",model.carmodel.code];
        cell.timeLabel.text = [NSString stringWithFormat:@"活动日期:%@-%@",[NSString getLitteLocalDateFormateUTCDate:model.begindate],[NSString getLitteLocalDateFormateUTCDate:model.enddate]];
        cell.studyLabel.text = [NSString stringWithFormat:@"授课日程:%@",model.classchedule];
        cell.carType.text = [NSString stringWithFormat:@"训练车品牌:%@",model.cartype];
        cell.price.text = [NSString stringWithFormat:@"价格:%@元",model.price];
        cell.personCount.text = [NSString stringWithFormat:@"已经报名人数:%@",model.applycount];
        cell.schoolDetailIntroduction.text = [NSString stringWithFormat:@"%@",model.classdesc];
        [cell receiveVipList:model.vipserverlist];
        return cell;
    }else if (indexPath.section == 1 ) {
        SignUpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy_4"];
        if (cell == nil) {
            cell = [[SignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"yy_4"];
        }
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
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    if (indexPath.row == 1 && indexPath.section == 0){
        SignUpDrivingViewController *drivingVC = [[SignUpDrivingViewController alloc] init];   //选择驾校
        [self.navigationController pushViewController:drivingVC animated:YES];
    }else if ((indexPath.row == 4 && indexPath.section == 0 && _cellIsShow)||(indexPath.row == 3 && indexPath.section == 0 && !_cellIsShow)) {
        SignUpCoachViewController *coachVc = [[SignUpCoachViewController alloc] init];
        coachVc.markNum = 1;
        [self.navigationController pushViewController:coachVc animated:YES];
    }
    
    if(_cellIsShow) {
        [self removeCellWhenClick];
    }
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

- (void)removeCellWhenClick {
    _secondArray = @[@[@"驾照类型:",@"报考驾校",_classNameDataArray,@"报考教练"],@[@"真实姓名",@"联系电话",@"验证Y码"]];
    signUpArray = @[@[[SignUpInfoManager getSignUpCarmodelName],[SignUpInfoManager getSignUpSchoolName],[SignUpInfoManager getSignUpClasstypeName],[SignUpInfoManager getSignUpCoachName]],@[[SignUpInfoManager getSignUpRealName],[SignUpInfoManager getSignUpRealTelephone],@""]];
    _cellIsShow = NO;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_cellIsShow) {
        signUpArray = @[@[[SignUpInfoManager getSignUpCarmodelName],[SignUpInfoManager getSignUpSchoolName],[SignUpInfoManager getSignUpClasstypeName],@"",[SignUpInfoManager getSignUpCoachName]],@[[SignUpInfoManager getSignUpRealName],[SignUpInfoManager getSignUpRealTelephone],@""]];
    }else {
        signUpArray = @[@[[SignUpInfoManager getSignUpCarmodelName],[SignUpInfoManager getSignUpSchoolName],[SignUpInfoManager getSignUpClasstypeName],[SignUpInfoManager getSignUpCoachName]],@[[SignUpInfoManager getSignUpRealName],[SignUpInfoManager getSignUpRealTelephone],@""]];
        _secondArray = @[@[@"驾照类型:",@"报考驾校",@"",@"报考教练"],@[@"真实姓名",@"联系电话",@"验证Y码"]];
    }
    [self.tableView reloadData];
    
    if ([SignUpInfoManager getSignUpSchoolid]) {
        NSString *classString = [NSString stringWithFormat:kExamClassType,[SignUpInfoManager getSignUpSchoolid]];
        
        NSString *urlString = [NSString stringWithFormat:BASEURL,classString];
        
        [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
            DYNSLog(@"res = %@",data);
            
            NSArray *param = data[@"data"];
            
            NSError *error = nil;
            
            NSMutableArray *applyclassArray = [[NSMutableArray alloc] init];
            [applyclassArray addObjectsFromArray:[MTLJSONAdapter modelsOfClass:ExamClassModel.class fromJSONArray:param error:&error]];
            NSMutableArray *applyclassNameArray = [[NSMutableArray alloc] init];
            for (ExamClassModel *model in applyclassArray) {
                [applyclassNameArray addObject:model.classname];
            }
            _classDetailDataArray = [applyclassArray copy];
            _classNameDataArray = [applyclassNameArray copy];
            _numberOfClass = applyclassNameArray.count;
            if (!_cellIsShow) {
                _secondArray = @[@[@"驾照类型:",@"报考驾校",_classNameDataArray,@"报考教练"],@[@"真实姓名",@"联系电话",@"验证Y码"]];
            }else {
            _secondArray = @[@[@"驾照类型:",@"报考驾校",_classNameDataArray,_classDetailDataArray,@"报考教练"],@[@"真实姓名",@"联系电话",@"验证Y码"]];
            }

            
            [self.tableView reloadData];
        }];
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

@end