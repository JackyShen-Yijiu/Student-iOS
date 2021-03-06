//
//  DetailViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "SignUpCoachDetailViewController.h"
#import "SignUpListViewController.h"
#import "DrivingDetailViewController.h"
#import "CoachDetailCell.h"
#import "CoachInformationCell.h"
#import "CoachIntroductionCell.h"
#import "StudentCommentCell.h"
#import "JsonTransformManager.h"
#import "CoachDetail.h"
#import "BLPFAlertView.h"
#import "SignUpInfoManager.h"
#import "StudentCommentModel.h"
#import "VerifyInformationController.h"
static NSString *const kCoachDetailInfo = @"/userinfo/getuserinfo/2/userid/%@";
static NSString *const kGetCommentInfo = @"courseinfo/getusercomment/2/%@/%@";

static NSString *const kSaveMyLoveCoach = @"userinfo/favoritecoach/%@";


@interface SignUpCoachDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)UIButton *phoneBtn;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *tableHeadImageView;

@property (strong, nonatomic) CoachDetail *detailModel;
@property (strong, nonatomic)UIButton *signUpButton;
@property (strong, nonatomic) NSArray *dataArray;


@end

@implementation SignUpCoachDetailViewController

- (UIImageView *)tableHeadImageView {
    if (_tableHeadImageView == nil) {
        _tableHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 240)];
        UIImageView *maskView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 240-129, kSystemWide, 129)];
        maskView.image = [UIImage imageNamed:@"渐变"];
//        _tableHeadImageView.image = [UIImage imageNamed:@"mv.jpg"];
        _tableHeadImageView.userInteractionEnabled = YES;
        [_tableHeadImageView addSubview:maskView];
        
        UIView *heart = [[UIView alloc] initWithFrame:CGRectMake(kSystemWide-15-50, 240-24, 50, 50)];
        heart.backgroundColor = [UIColor whiteColor];
        heart.layer.masksToBounds = YES;
        heart.layer.cornerRadius = heart.frame.size.width *0.5;
        [_tableHeadImageView addSubview:heart];
        
        UIView *mainColorView =  [[UIView alloc] initWithFrame:CGRectMake(2, 2, 46, 46)];
        mainColorView.userInteractionEnabled = YES;
        mainColorView.backgroundColor = [UIColor whiteColor];
        mainColorView.layer.cornerRadius = mainColorView.frame.size.width *0.5;
        [heart addSubview:mainColorView];
        
        UIImageView *heartImageView = [[UIImageView alloc] initWithFrame:CGRectMake(46/2-21/2, 46/2-21/2, 21, 21)];
        heartImageView.image = [UIImage imageNamed:@"xin"];
        heartImageView.userInteractionEnabled = YES;
        [mainColorView addSubview:heartImageView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealLike:)];
        [mainColorView addGestureRecognizer:tapGesture];
        
    }
    return _tableHeadImageView;
    
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, kSystemWide, kSystemHeight-64-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}



- (UIButton *)phoneBtn{
    if (_phoneBtn == nil) {
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneBtn.frame = CGRectMake(0, 0, 20, 20);
        [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
        [_phoneBtn addTarget:self action:@selector(clickPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;
}

- (UIButton *)signUpButton{
    if (_signUpButton == nil) {
        _signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _signUpButton.backgroundColor = MAINCOLOR;
        _signUpButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_signUpButton addTarget:self action:@selector(dealSignUp:) forControlEvents:UIControlEventTouchUpInside];
        if (self.isVerify) {
            [_signUpButton setTitle:@"验证" forState:UIControlStateNormal];
        }else {
            if ([[AcountManager manager].userApplystate isEqualToString:@"0"]) {
                [_signUpButton setTitle:@"报名" forState:UIControlStateNormal];
            }else if ([[AcountManager manager].userApplystate isEqualToString:@"1"]) {
                
                [_signUpButton setTitle:@"报名申请中" forState:UIControlStateNormal];
                _signUpButton.userInteractionEnabled = NO;
                
            }else if ([[AcountManager manager].userApplystate isEqualToString:@"2"]) {
                [_signUpButton setTitle:@"报名成功" forState:UIControlStateNormal];
                _signUpButton.userInteractionEnabled = NO;
                
            }
        }

        
        [_signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    return _signUpButton;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"教练详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configBarItem];
    
    [self createUI];
    
    [self startDownLoad];
    
    [self startDownLoadComment];

    
}

- (void)startDownLoadComment {
    
    NSString *urlString = [NSString stringWithFormat:kGetCommentInfo,self.coachUserId,[NSNumber numberWithInt:1]];
    NSString *urlComment = [NSString stringWithFormat:BASEURL,urlString];
    [JENetwoking startDownLoadWithUrl:urlComment postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        
        NSError *error = nil;
        self.dataArray = [MTLJSONAdapter modelsOfClass:StudentCommentModel.class fromJSONArray:param[@"data"] error:&error];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
}

- (void)startDownLoad {
    
    NSString *infoString = [NSString stringWithFormat:kCoachDetailInfo,self.coachUserId];
    NSString *urlString = [NSString stringWithFormat:BASEURL,infoString];
    DYNSLog(@"urlString = %@",urlString);
    
    __weak SignUpCoachDetailViewController *weakSelf = self;
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        if (messege.intValue == 1) {
            NSError *error = nil;
            CoachDetail *coachDetail = [MTLJSONAdapter modelOfClass:CoachDetail.class fromJSONDictionary:dataParam[@"data"] error:&error];
            DYNSLog(@"error = %@",error);
            weakSelf.detailModel = coachDetail;
            DYNSLog(@"data = %@",weakSelf.detailModel);
            
            [weakSelf.tableView reloadData];
            [self.tableHeadImageView sd_setImageWithURL:[NSURL URLWithString:coachDetail.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"bigImage.png"]];

        }else {
            [self  showTotasViewWithMes:@"网络错误"];
            return;
        }
    }];
    
}


- (void)configBarItem {
    

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.phoneBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark - createUI
- (void)createUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.signUpButton];
    self.tableView.tableHeaderView = [self tableHeadImageView];
    
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(@49);
    }];
    
}
#pragma mark - delegation

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 32;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 18+14)];
        UILabel *studentComment = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont boldSystemFontOfSize:14]];
        studentComment.frame = CGRectMake(15, 18, kSystemWide-15, 14);
        studentComment.text = @"学员评论";
        [backGroundView addSubview:studentComment];
        return backGroundView;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 160;
    }else if (indexPath.row == 1 && indexPath.section == 0) {
        return 195;
    }else if (indexPath.row == 2 && indexPath.section == 0) {
        return 105;
    }
    return 96;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return self.dataArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        static NSString *cellId = @"cellOne";
        CoachDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[CoachDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        DYNSLog(@"name = %@",self.detailModel.name);
        cell.coachNameLabel.text = self.detailModel.name;
        cell.locationLabel.text = [NSString stringWithFormat:@"%@ %@",self.detailModel.address,self.detailModel.platenumber];
        [cell.starBar displayRating:self.detailModel.starlevel.floatValue];
        if (self.detailModel.is_shuttle) {
            cell.coachStateSend.hidden = NO;
        }
        
        if (self.detailModel.subject.count >= 2) {
            cell.coachStateAll.hidden = NO;
        }
        
        return cell;
        
    }else if (indexPath.row == 1 && indexPath.section == 0) {
        static NSString *cellId = @"cellTwo";
        CoachInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[CoachInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.rainingGroundDetail.text = self.detailModel.trainFieldInfo.name;
        cell.studentNumDetail.text = [NSString stringWithFormat:@"通过率%@",self.detailModel.passrate];
        cell.sendMeetDetail.text = self.detailModel.shuttlemsg;
        cell.workTimeDetail.text = self.detailModel.worktimedesc;
        if (self.detailModel.subject.count >= 2) {
            cell.teachSubjcetDetail.text = @"全科";
        }else {
            SubjectModel *subjectInfo = self.detailModel.subject.firstObject;
            cell.teachSubjcetDetail.text = subjectInfo.subjectId.stringValue;
        }
        return cell;
    }else if (indexPath.row == 2 && indexPath.section == 0) {
        static NSString *cellId = @"cellThree";
        CoachIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[CoachIntroductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        return cell;
    }else if ( indexPath.section == 1) {
        static NSString *cellId = @"cellFour";
        StudentCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[StudentCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        StudentCommentModel *model = self.dataArray[indexPath.row];
        [cell receiveCommentMessage:model];
        return cell;
    }
    
    
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    DrivingDetailViewController *drivingDetail = [[DrivingDetailViewController alloc] init];
//    drivingDetail.schoolId = self.detailModel.driveschoolinfo.driveSchoolId;
//    [self.navigationController pushViewController:drivingDetail animated:YES];
}

#pragma  mark - btnAction
- (void)clickPhoneBtn:(UIButton *)sender {
    
    if (self.detailModel.mobile == nil || [self.detailModel.mobile isEqualToString:@""]) {
        [self showTotasViewWithMes:@"该教练未录入电话!"];
        return;
    }
    
    [BLPFAlertView showAlertWithTitle:@"电话号码" message:self.detailModel.mobile cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
        DYNSLog(@"index = %lu",selectedOtherButtonIndex+1);
        NSUInteger indexAlert = selectedOtherButtonIndex + 1;
        if (indexAlert == 1) {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.detailModel.mobile];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else {
            return ;
        }
        
    }];
}

- (void)dealSignUp:(UIButton *)sender{
    
    if (self.detailModel.coachid && self.detailModel.name) {
        if (self.isVerify) {
            NSDictionary *coachParam = @{kVerifyCoachid:self.detailModel.coachid,@"name":self.detailModel.name};
            [SignUpInfoManager signUpInfoSaveVerifyRealCoach:coachParam];
        }else {
            NSDictionary *coachParam = @{kRealCoachid:self.detailModel.coachid,@"name":self.detailModel.name};
            [SignUpInfoManager signUpInfoSaveRealCoach:coachParam];
        }
        NSDictionary *schoolParam = @{kRealSchoolid:self.detailModel.driveschoolinfo[@"id"],@"name":self.detailModel.driveschoolinfo[@"name"]};
        [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
    }
    
  

    for (UIViewController *targetVc in self.navigationController.viewControllers) {
        if ([targetVc isKindOfClass:[SignUpListViewController class]]) {
            [self.navigationController popToViewController:targetVc animated:YES];
        }
        if ([targetVc isKindOfClass:[VerifyInformationController class]]) {
            [self.navigationController popToViewController:targetVc animated:YES];
        }

    }
    
   
}

- (void)dealLike:(UITapGestureRecognizer *)tap{
    DYNSLog(@"like");
    NSString *kSaveUrl = [NSString stringWithFormat:kSaveMyLoveCoach,self.detailModel.coachid];
    NSString *urlString = [NSString stringWithFormat:BASEURL,kSaveUrl];
    DYNSLog(@"urlstring = %@",urlString);
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodPut withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            [self showTotasViewWithMes:@"收藏成功"];
        }else {
            [self showTotasViewWithMes:param[@"msg"]];
            
        }
    }];
}

@end