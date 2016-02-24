//
//  UserCenterViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserCenterHeadView.h"
#import "UIView+CalculateUIView.h"
#import "EditorUserViewController.h"
#import "MyLoveCoachViewController.h"
#import "SetupViewController.h"
#import "MyWalletViewController.h"
#import "UserCenterCell.h"
#import "MyExamCarViewController.h"
#import "MySaveViewController.h"
#import "DrivingViewController.h"
#import "LoginViewController.h"
#import "SignUpSuccessViewController.h"
#import "SignUpListViewController.h"
#import "DVVSideMenu.h"
#import "DVVUserManager.h"
#import "DVVOpenControllerFromSideMenu.h"
#import "VerifyPhoneController.h"
#import <JPush/APService.h>
#import "SignUpInfoManager.h"
#import "DrivingViewController.h"

@interface UserCenterViewController ()<UITableViewDataSource,UITableViewDelegate,UserCenterHeadViewDelegte>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *tableHeadView;
@property (strong, nonatomic) UserCenterHeadView *userCenterView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSArray *imageArray;

@property (strong, nonatomic) NSArray *signArray;
@end

@implementation UserCenterViewController

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@[@"报考驾校",@"报考车型"],@[@"我的喜欢",@"我的教练",@"钱包"],@[@"设置",@"报名详情",@"验证报名信息"]];
    }
    return _dataArray;
}

- (NSArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = @[@[@"驾校",@"车型"],@[@"喜欢",@"我的教练",@"user_center_qianbao"],@[@"设置",@"xq",@"认证"]];
    }
    return _imageArray;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource  = self;
        _tableView.backgroundColor = RGBColor(245, 247, 250);

    }
    return _tableView;
}

- (UserCenterHeadView *)userCenterView {
    if (_userCenterView == nil) {
        _userCenterView = [[UserCenterHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.calculateFrameWithWide, 80) withUserPortrait:[AcountManager manager].userHeadImageUrl withUserPhoneNum:[AcountManager manager].userDisplaymobile withUserIdNum:[NSString stringWithFormat:@"ID:%@",[AcountManager manager].userDisplayuserid]];
        _userCenterView.delegate = self;
    }
    return _userCenterView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self addSideMenuButton];
    
    self.title = @"个人中心";
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [self tableFootView];
    self.tableView.tableHeaderView = self.userCenterView;
    
}

- (UIButton *)tableFootView {
    UIButton *quit = [UIButton buttonWithType:UIButtonTypeCustom];
    quit.backgroundColor = [UIColor whiteColor];
    [quit setTitle:@"退出" forState:UIControlStateNormal];
    quit.titleLabel.font = [UIFont systemFontOfSize:14];
    [quit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    quit.frame = CGRectMake(0, 0, kSystemWide, 44);
    [quit addTarget:self action:@selector(clickQuit:) forControlEvents:UIControlEventTouchUpInside];
    return quit;
    
}
- (void)clickQuit:(UIButton *)sender {
    
    [AcountManager removeAllData];
    [[EaseMob sharedInstance].chatManager logoffWithUnbindDeviceToken:YES error:nil];
    
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
    
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        DYNSLog(@"asyncLogoffWithUnbindDeviceToken%@",error);
    } onQueue:nil];
    
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        DYNSLog(@"退出成功 = %@ %@",info,error);
        if (!error && info) {
        }
    } onQueue:nil];

//    [self dismissViewControllerAnimated:NO completion:nil];
//    [APService setAlias:@"" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    NSSet *set = [NSSet setWithObjects:@"", nil];
    [APService setTags:set alias:@"" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
//    [self.navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kQuitSuccess" object:nil];
    [AcountManager removeAllData];
    [DVVUserManager userLogout];
    [SignUpInfoManager removeSignData];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:1 forKey:@"isCarReset"];
    [ud synchronize];
}
//取消别名标示
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
     tags, alias];
    
    DYNSLog(@"TagsAlias回调:%@", callbackString);
}

- (void)userCenterClick {
    EditorUserViewController *editor = [[EditorUserViewController alloc] init];
    [self.navigationController pushViewController:editor animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBColor(245, 247, 250);
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 3;
    }else if (section == 2) {
        return 3;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UserCenterCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.contentLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.leftImageView.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
    if (indexPath.section == 0) {
        
        cell.detailTextLabel.text =self.signArray[indexPath.row];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        if ([[AcountManager manager].userApplystate isEqualToString:@"0"]) {
            DrivingViewController *drivingVc = [[DrivingViewController alloc] init];
            [self.navigationController pushViewController:drivingVc animated:YES];
        }
        
    }else if (indexPath.row == 0 && indexPath.section == 1) {
        MySaveViewController *save = [[MySaveViewController alloc] init];
        [self.navigationController pushViewController:save animated:YES];

    }
    else if (indexPath.row == 1 && indexPath.section == 0) {
        
        if ([[AcountManager manager].userApplystate isEqualToString:@"0"]) {
            MyExamCarViewController *examCar = [[MyExamCarViewController alloc] init];
            [self.navigationController pushViewController:examCar animated:YES];
        }
       
    }
    else if (indexPath.row == 1 && indexPath.section == 1) {
        
        MyLoveCoachViewController *mylove = [[MyLoveCoachViewController alloc] init];
        [self.navigationController pushViewController:mylove animated:YES];
        
        
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            SetupViewController *setup = [[SetupViewController alloc] init];
            [self.navigationController pushViewController:setup animated:YES];
        } else if (indexPath.row == 1) {
            if ([[[AcountManager manager] userApplystate] isEqualToString:@"1"]) {
                [self.navigationController pushViewController:[SignUpSuccessViewController new] animated:YES];
            }else if ([[[AcountManager manager] userApplystate] isEqualToString:@"0"])
            {
                DrivingViewController *signUPVC = [DrivingViewController new];
                [self.navigationController pushViewController:signUPVC animated:YES];
            }else if ([[[AcountManager manager] userApplystate] isEqualToString:@"3"]) {
                [self showTotasViewWithMes:@"验证报名中"];
            }else {
                [self showTotasViewWithMes:@"您去支付完成的订单!"];

            }
           
        }else {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CheckProgress"] isEqualToString:@"答错了"]) {
                [self obj_showTotasViewWithMes:@"您还没有报名!"];
                return;
            }
            
            if ([[[AcountManager manager] userApplystate] isEqualToString:@"0"]) {
                [self.navigationController pushViewController:[VerifyPhoneController new] animated:YES];
            }else if ([[[AcountManager manager] userApplystate] isEqualToString:@"1"]){
                [self showTotasViewWithMes:@"报名正在申请中!"];

            }else{
                [self showTotasViewWithMes:@"您已经报过名!"];
            }
            
        }
    }else if (indexPath.section == 1 && indexPath.row == 2 ) {
        if (![AcountManager isLogin]) {
            [self showTotasViewWithMes:@"你还没有登录!"];
            return;
        }
        MyWalletViewController *myWallet = [[MyWalletViewController alloc] init];
        [self.navigationController pushViewController:myWallet animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
#pragma mark - 更新头像
    DYNSLog(@"url = %@",[AcountManager manager].userHeadImageUrl);
    [self.userCenterView.userPortrait sd_setImageWithURL:[NSURL URLWithString:[AcountManager manager].userHeadImageUrl] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    DYNSLog(@"acount = %@ %@",[AcountManager manager].applyschool.name,[AcountManager manager].userCarmodels.name);
    NSString *schoolName = [AcountManager manager].applyschool.name;
    NSString *carModelName = [AcountManager manager].userCarmodels.name;
    if (schoolName == nil) {
        schoolName = @"";
    }
    if (carModelName == nil) {
        carModelName = @"";
    }
    _signArray = @[schoolName,carModelName];
    
    
    //
    if ([AcountManager manager].userName) {
        self.userCenterView.userPhoneNum.text = [AcountManager manager].userName;
    }
    [self.tableView reloadData];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
