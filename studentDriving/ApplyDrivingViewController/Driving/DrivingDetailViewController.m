//
//  SelectViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/13.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "DrivingDetailViewController.h"
#import "DrivingDetailCell.h"
#import "MapViewController.h"
#import "BLPFAlertView.h"
#import "DrivingInformationCell.h"
#import "DrivingIntroductionCell.h"
#import "SignUpListViewController.h"
#import "DrivingSelectedCoachCell.h"
#import "DrvingDetailModel.h"
#import "SignUpInfoManager.h"
#import "CoachModel.h"
#import "CoachDetailViewController.h"
#import "LoginViewController.h"
#import "UIColor+Hex.h"
#import "DVVUserManager.h"


static NSString *const kDrivingDetailUrl = @"driveschool/getschoolinfo/%@";

static NSString *const kGetDrivingCoachUrl = @"getschoolcoach/%@/%@";

static NSString *const kCheckMyLoveDriving = @"userinfo/favoriteschool";
static NSString *const kAddLoveDriving = @"userinfo/favoriteschool/%@";
static NSString *const kDeleteLoveDriving = @"userinfo/favoriteschool/%@";

@interface DrivingDetailViewController () <UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,DrivingSelectedCoachCellDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *phoneButton;
@property (strong, nonatomic) UIImageView *tableHeadImageView;
@property (nonatomic, strong) UIImageView *heartImageView;

@property (strong, nonatomic)UIButton *signUpButton;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSArray *coachArray;
@end
@implementation DrivingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configBarItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"kLoginSuccess" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"驾校详情";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.signUpButton];
    self.tableView.tableHeaderView = [self tableHeadImageView];
    
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(@49);
    }];
    
    [self startDownLoad];
    
    [self startDownLoadCoach];
    
    // 检查是否已经收藏
    [self checkCollection];
}


- (void)loginSuccess {
    DYNSLog(@"login");
    if ([[AcountManager manager].userApplystate isEqualToString:@"1"]) {
        [self.signUpButton setTitle:@"报名申请中" forState:UIControlStateNormal];
        self.signUpButton.userInteractionEnabled = NO;
        
    }else if ([[AcountManager manager].userApplystate isEqualToString:@"2"]) {
        [self.signUpButton setTitle:@"报名成功" forState:UIControlStateNormal];
        self.signUpButton.userInteractionEnabled = NO;
        
    }else {
        [self.signUpButton setTitle:@"报名" forState:UIControlStateNormal];
    }
}
- (void)startDownLoadCoach {
    
    NSString *urlString = [NSString stringWithFormat:kGetDrivingCoachUrl,self.schoolId,[NSNumber numberWithInt:1]];
    NSString *getCoachUrlString = [NSString stringWithFormat:BASEURL,urlString];
    [JENetwoking startDownLoadWithUrl:getCoachUrlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"coachData = %@",data);
        NSDictionary *param = data;
        NSError *error = nil;
        
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        if (type.integerValue == 1) {
            self.coachArray = [MTLJSONAdapter modelsOfClass:CoachModel.class fromJSONArray:param[@"data"] error:&error];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }else {
            kShowFail(msg)
        }
    }];
}
- (void)startDownLoad {
    
    NSString *urlString = [NSString stringWithFormat:kDrivingDetailUrl,self.schoolId];
    NSString *url = [NSString stringWithFormat:BASEURL,urlString];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"result = %@",data);
        
        NSDictionary *param = data;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        if (type.integerValue == 1) {
            NSDictionary *dic = data[@"data"];
            NSError *error = nil;
            DrvingDetailModel *drvingDetailModel = [MTLJSONAdapter modelOfClass:DrvingDetailModel.class fromJSONDictionary:dic error:&error];
            DYNSLog(@"error = %@",error);
            [self.dataArray addObject:drvingDetailModel];
            [self.tableView reloadData];
            [self.tableHeadImageView sd_setImageWithURL:[NSURL URLWithString:drvingDetailModel.logoimg.originalpic]placeholderImage:[UIImage imageNamed:@"bigImage.png"]];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else {
            [MBProgressHUD hideHUDForView:self.view animated:NO];
            kShowFail(msg)
        }
        
        
    }];
}
- (UIImageView *)tableHeadImageView {
    if (_tableHeadImageView == nil) {
        _tableHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 240)];
        _tableHeadImageView.userInteractionEnabled = YES;
        UIImageView *maskView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 240-129, kSystemWide, 129)];
        maskView.image = [UIImage imageNamed:@"渐变"];
        //        _tableHeadImageView.image = [UIImage imageNamed:@"av.jpg"];
        [_tableHeadImageView addSubview:maskView];
        
        UIView *heart = [[UIView alloc] initWithFrame:CGRectMake(kSystemWide-15-50, 240-50, 50, 50)];
        heart.backgroundColor = [UIColor whiteColor];
        heart.layer.masksToBounds = YES;
        heart.userInteractionEnabled = YES;
        heart.layer.cornerRadius = heart.frame.size.width *0.5;
        [_tableHeadImageView addSubview:heart];
        
        UIView *mainColorView =  [[UIView alloc] initWithFrame:CGRectMake(2, 2, 46, 46)];
        mainColorView.backgroundColor = MAINCOLOR;
        mainColorView.layer.cornerRadius = mainColorView.frame.size.width *0.5;
        mainColorView.userInteractionEnabled = YES;
        [heart addSubview:mainColorView];
        
        _heartImageView = [[UIImageView alloc] initWithFrame:CGRectMake(46/2-21/2, 46/2-21/2, 21, 21)];
        _heartImageView.image = [UIImage imageNamed:@"心Inner.png"];
        //        _heartImageView.backgroundColor = [UIColor blackColor];
        _heartImageView.userInteractionEnabled = YES;
        [mainColorView addSubview:_heartImageView];
        //        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealLike:)];
        //        [mainColorView addGestureRecognizer:tapGesture];
        
        UIButton *heartButton = [UIButton new];
        heartButton.frame = heart.frame;
        [heartButton.layer setMasksToBounds:YES];
        [heartButton.layer setCornerRadius:heart.frame.size.width *0.5];
        [heartButton addTarget:self action:@selector(dealLike:) forControlEvents:UIControlEventTouchDown];
        [_tableHeadImageView addSubview:heartButton];
        heartButton.backgroundColor = [UIColor clearColor];
        
    }
    return _tableHeadImageView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 86;
    }else if (indexPath.row == 1) {
        return 105;
    }else if (indexPath.row == 2) {
        DrvingDetailModel *model = self.dataArray.firstObject;
        NSString *contentStr = model.introduction;
        CGSize size = [contentStr boundingRectWithSize:CGSizeMake(self.view.frame.size.width -30 , CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName] context:nil].size;
        return size.height + 44 + 18 +5;
    }else if (indexPath.row == 3) {
        return 150;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DrvingDetailModel *model = self.dataArray.firstObject;
    DYNSLog(@"model = %@",model.name);
    if (indexPath.row == 0) {
        static NSString *cellId = @"Addresscell";
        DrivingDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[DrivingDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.drivingNameLabel.text = model.name;
        cell.locationLabel.text = [NSString stringWithFormat:@"地址:%@",model.address];
        return cell;
    }else if (indexPath.row == 1) {
        static NSString *cellId = @"InformationCell";
        DrivingInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[DrivingInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.workTimeDetail.text = model.hours;
        cell.successRateDetailLabel.text = [NSString stringWithFormat:@"通过率%@%@",model.passingrate,@"%"];
        return cell;
    }else if (indexPath.row == 2) {
        static NSString *cellId = @"Introduction";
        DrivingIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[DrivingIntroductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.drivingIntroductionDetail.text = model.introduction;
        return cell;
    }else if (indexPath.row == 3) {
        static NSString *cellId = @"DrivingSelected";
        DrivingSelectedCoachCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[DrivingSelectedCoachCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell receiveGetCoachMessage:self.coachArray];
        return cell;
    }
    
    return nil;
}
#pragma mark - tableView selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DrvingDetailModel *model = self.dataArray.firstObject;
    
    if (indexPath.row == 0) {
        MapViewController *mapview = [[MapViewController alloc] init];
        mapview.latitudeNum = model.latitude;
        mapview.longitudeNum = model.longitude;
        [self.navigationController pushViewController:mapview animated:YES];
    }
}

#pragma mark - buttonAciton
- (void)dealSignUp:(UIButton *)sender{
    
    DrvingDetailModel *model = self.dataArray.firstObject;
    
    if (![AcountManager isLogin]) {
//        DYNSLog(@"islogin = %d",[AcountManager isLogin]);
//        LoginViewController *login = [[LoginViewController alloc] init];
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
//        return;
        [DVVUserManager userNeedLogin];
        return ;
    }
    
    DYNSLog(@"countId = %@",[AcountManager manager].applycoach.infoId);
    
    if (![AcountManager manager].applyschool.infoId) {
        
        if (model.schoolid && model.name) {
            DYNSLog(@"schoolinfo");
            NSDictionary *schoolParam = @{kRealSchoolid:model.schoolid,@"name":model.name};
            [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
        }
        SignUpListViewController *signUp = [[SignUpListViewController alloc] init];
        [self.navigationController pushViewController:signUp animated:YES];
        return;
    }
    
    
    if ([[AcountManager manager].applyschool.infoId isEqualToString:model.schoolid]) {
        SignUpListViewController *signUp = [[SignUpListViewController alloc] init];
        [self.navigationController pushViewController:signUp animated:YES];
        return;
    }
    
    [BLPFAlertView showAlertWithTitle:@"提示" message:@"您已经选择了教练和班型更换驾校后您可能重新做出选择" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
        DYNSLog(@"index = %ld",selectedOtherButtonIndex);
        NSUInteger index = selectedOtherButtonIndex + 1;
        if (index == 0) {
            return ;
        }else {
            
            if (model.schoolid && model.name) {
                DYNSLog(@"schoolinfo");
                NSDictionary *schoolParam = @{kRealSchoolid:model.schoolid,@"name":model.name};
                [SignUpInfoManager signUpInfoSaveRealSchool:schoolParam];
            }
            SignUpListViewController *signUp = [[SignUpListViewController alloc] init];
            [self.navigationController pushViewController:signUp animated:YES];
        }
    }];
    
    
    
}
#pragma mark - delegateCoach

- (void)senderCoachModel:(CoachModel *)model {
    NSString *coachId = model.coachid;
    
    CoachDetailViewController *coachDetail = [[CoachDetailViewController alloc] init];
    coachDetail.coachUserId = coachId;
    [self.navigationController pushViewController:coachDetail animated:YES];
    
}

- (void)dealPhone:(UIButton *)sender {
    DrvingDetailModel *model = self.dataArray.firstObject;
    if (!model.phone || [model.phone isEqualToString:@""]) {
        [self showTotasViewWithMes:@"此驾校暂无预留电话"];
        return ;
    }
    
    [BLPFAlertView showAlertWithTitle:@"联系驾校" message:model.phone cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
        NSLog(@"index = %ld",selectedOtherButtonIndex);
        if (selectedOtherButtonIndex == 0) {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else {
            return ;
        }
    }];
}

#pragma mark 检测是否收藏
- (void)checkCollection {
    
//    if (![AcountManager isLogin]) {
//        DYNSLog(@"islogin = %d",[AcountManager isLogin]);
//        LoginViewController *login = [[LoginViewController alloc] init];
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
//        return;
//    }
    
    NSString *kSaveUrl = [NSString stringWithFormat:kCheckMyLoveDriving];
    NSString *urlString = [NSString stringWithFormat:BASEURL,kSaveUrl];
    DYNSLog(@"urlstring = %@",urlString);
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            
            if ([[data objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                NSArray *array = [data objectForKey:@"data"];
                for (int i = 0; i < array.count; i++) {
                    NSString *schoolId = [array[i] objectForKey:@"schoolid"];
                    if ([schoolId isEqualToString:self.schoolId]) {
                        _heartImageView.image = [UIImage imageNamed:@"心"];
                        _heartImageView.tag = 1;
                        return ;
                    }
                }
            }
        }
    }];
}

- (void)dealLike:(UITapGestureRecognizer *)tap {
    
    if (![AcountManager isLogin]) {
//        DYNSLog(@"islogin = %d",[AcountManager isLogin]);
//        LoginViewController *login = [[LoginViewController alloc] init];
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
//        return;
        
        [self showTotasViewWithMes:@"您还没有登录哟"];
        return ;
    }
    
    if (_heartImageView.tag) {
        [self deleteLoveSchool];
    }else {
        [self addLoveSchool];
    }
}

#pragma mark 添加喜欢的驾校
- (void)addLoveSchool {
    
    NSString *kSaveUrl = [NSString stringWithFormat:kAddLoveDriving,self.schoolId];
    NSString *urlString = [NSString stringWithFormat:BASEURL,kSaveUrl];
    DYNSLog(@"urlstring = %@",urlString);
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodPut withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            _heartImageView.image = [UIImage imageNamed:@"心"];
            [self showTotasViewWithMes:@"收藏成功"];
            _heartImageView.tag = 1;
        }else {
            [self showTotasViewWithMes:@"收藏失败"];
        }
    }];
    
}

#pragma mark 删除喜欢的驾校
- (void)deleteLoveSchool {
    
    NSString *kSaveUrl = [NSString stringWithFormat:kDeleteLoveDriving,self.schoolId];
    NSString *urlString = [NSString stringWithFormat:BASEURL,kSaveUrl];
    DYNSLog(@"urlstring = %@",urlString);
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodDelete withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = data;
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        if ([type isEqualToString:@"1"]) {
            _heartImageView.image = [UIImage imageNamed:@"心Inner"];
            [self showTotasViewWithMes:@"已取消收藏"];
            _heartImageView.tag = 0;
        }else {
            [self showTotasViewWithMes:@"取消收藏失败"];
        }
    }];
}

#pragma mark - lazy load
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (UIButton *)signUpButton{
    if (_signUpButton == nil) {
        _signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _signUpButton.backgroundColor = MAINCOLOR;
        _signUpButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_signUpButton addTarget:self action:@selector(dealSignUp:) forControlEvents:UIControlEventTouchUpInside];
        if ([[AcountManager manager].userApplystate isEqualToString:@"1"]) {
            [_signUpButton setTitle:@"报名申请中" forState:UIControlStateNormal];
            _signUpButton.userInteractionEnabled = NO;
            
        }else if ([[AcountManager manager].userApplystate isEqualToString:@"2"]) {
            [_signUpButton setTitle:@"报名成功" forState:UIControlStateNormal];
            _signUpButton.userInteractionEnabled = NO;
            
        }else {
            [_signUpButton setTitle:@"报名" forState:UIControlStateNormal];
        }
        
        [_signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    return _signUpButton;
}
- (UIButton *)phoneButton {
    if (_phoneButton == nil) {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneButton.frame = CGRectMake(0, 0, 20, 20);
        
        [_phoneButton setBackgroundImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
        [_phoneButton addTarget:self action:@selector(dealPhone:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneButton;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight-64-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)configBarItem {
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.phoneButton];
    self.navigationItem.rightBarButtonItems = @[rightItem];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
