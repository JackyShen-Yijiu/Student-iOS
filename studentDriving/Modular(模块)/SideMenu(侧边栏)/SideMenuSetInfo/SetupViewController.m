//
//  SetupViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "SetupViewController.h"

#import "UIDevice+JEsystemVersion.h"
#import "FeedBackViewController.h"
#import "AboutUsViewController.h"
#import "AcountManager.h"
#import <JPush/APService.h>
#import "SignUpInfoManager.h"
#import "HelpController.h"
#import "YBLoginController.h"

static NSString *const kSettingUrl = @"userinfo/personalsetting";

@interface SetupViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;

@property (nonatomic, strong) UISwitch *reservationreminderSwitch;
@property (nonatomic, strong) UISwitch *newmessagereminder;
@property (nonatomic, strong) UIButton *quitButton;

@end

@implementation SetupViewController
- (UISwitch *)reservationreminderSwitch {
    if (!_reservationreminderSwitch) {
        _reservationreminderSwitch = [UISwitch new];
        _reservationreminderSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 45, 20)];
        _reservationreminderSwitch.onTintColor = YBNavigationBarBgColor;
//        _reservationreminderSwitch.tintColor=[UIColor cyanColor];
    }
    return _reservationreminderSwitch;
}
- (UISwitch *)newmessagereminder {
    if (!_newmessagereminder) {
        _newmessagereminder = [UISwitch new];
        _newmessagereminder = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 45, 20)];
        _newmessagereminder.onTintColor = YBNavigationBarBgColor;
    }
    return _newmessagereminder;
}
- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@[@"预约提醒",@"新消息通知"],@[@"使用帮助",@"关于我们",@"去评分",@"反馈"]];
    }
    return _dataArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBColor(249, 249, 249);
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.quitButton];
    
    [self checkSet];
}

- (void)checkSet {
    
    NSLog(@"res === %i",[AcountManager manager].reservationreminder);
    NSLog(@"new === %i",[AcountManager manager].newmessagereminder);
    
    self.reservationreminderSwitch.on = [AcountManager manager].reservationreminder;
    self.newmessagereminder.on = [AcountManager manager].newmessagereminder;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBColor(249, 249, 249);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 4;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            self.reservationreminderSwitch.tag = 100 + indexPath.row;
            cell.accessoryView = self.reservationreminderSwitch;
            [_reservationreminderSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];

        }else if (indexPath.row == 1) {
            self.newmessagereminder.tag = 100 + indexPath.row;
            cell.accessoryView = self.newmessagereminder;
            [_newmessagereminder addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        }
    }
    return cell;
}
- (void)switchAction:(UISwitch *)sender {
    NSMutableDictionary *mubdic = [[NSMutableDictionary alloc] initWithDictionary:@{@"userid":[AcountManager manager].userid,@"usertype":@"1"}];
    NSString *url = [NSString stringWithFormat:BASEURL,kSettingUrl];
    if (sender.tag - 100 == 0) {
        if (sender.on == YES) {
            DYNSLog(@"sender.on = %d",sender.on);
            [mubdic setObject:@"1" forKey:@"reservationreminder"];
        }else if (sender.on == NO) {
            [mubdic setObject:@"0" forKey:@"reservationreminder"];
        }
        [mubdic setObject:@([AcountManager manager].newmessagereminder) forKey:@"newmessagereminder"];
        
        [JENetwoking startDownLoadWithUrl:url postParam:mubdic WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            NSDictionary *dataParam = data;
            NSNumber *messege = dataParam[@"type"];
            if (messege.intValue == 1) {
                [AcountManager manager].reservationreminder = sender.on;
                [self showTotasViewWithMes:@"修改成功"];
            }else {
                [self showTotasViewWithMes:@"修改失败"];
                self.reservationreminderSwitch.on = !sender.on;
            }
        }];
    }else if (sender.tag - 100 == 1) {
        if (sender.on == YES) {
            DYNSLog(@"sender.on = %d",sender.on);
            [mubdic setObject:@"1" forKey:@"newmessagereminder"];
        }else if (sender.on == NO) {
            [mubdic setObject:@"0" forKey:@"newmessagereminder"];
        }
        [mubdic setObject:@([AcountManager manager].reservationreminder) forKey:@"reservationreminder"];
        
        [JENetwoking startDownLoadWithUrl:url postParam:mubdic WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            NSDictionary *dataParam = data;
            NSNumber *messege = dataParam[@"type"];
            if (messege.intValue == 1) {
                [AcountManager manager].newmessagereminder = sender.on;
                [self showTotasViewWithMes:@"修改成功"];
            }else {
                [self showTotasViewWithMes:@"修改失败"];
                self.newmessagereminder.on = !sender.on;
            }
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        // 使用帮助
        HelpController *helpVC  = [[HelpController alloc] init];
        [self.navigationController pushViewController:helpVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        // 关于我们
        AboutUsViewController *about = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 2) {
        // 去评分
        [self gotoAppStorePageRaisal:@"1060105429"];
    }else if (indexPath.section == 1 && indexPath.row == 3) {
        // 反馈
        FeedBackViewController *feedBack = [[FeedBackViewController alloc] init];
        [self.navigationController pushViewController:feedBack animated:YES];
    }
    
}

- (void)gotoAppStorePageRaisal:(NSString *)AppId {
    
    // 评分
    NSString *str;
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
        
    {
        str = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",AppId];
    }else
    {
        str = [NSString stringWithFormat:
               @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",AppId];
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}
// 退出App
- (UIButton *)quitButton{
    if (_quitButton == nil) {
        _quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _quitButton.backgroundColor = YBNavigationBarBgColor;
        [_quitButton setTitle:@"退出" forState:UIControlStateNormal];
        _quitButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_quitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _quitButton.frame = CGRectMake(0,kSystemHeight - 108, kSystemWide, 44);
        [_quitButton addTarget:self action:@selector(clickQuit:) forControlEvents:UIControlEventTouchUpInside];
        return _quitButton;
    }
    return _quitButton;
}
- (void)clickQuit:(UIButton *)sender {
    
    [AcountManager removeAllData];
    
    [[EaseMob sharedInstance].chatManager logoffWithUnbindDeviceToken:YES error:nil];
    
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
    
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        DYNSLog(@"asyncLogoffWithUnbindDeviceToken%@",error);
    } onQueue:nil];
    
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        
        //    [self dismissViewControllerAnimated:NO completion:nil];
        //    [APService setAlias:@"" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        NSSet *set = [NSSet setWithObjects:@"", nil];
        [APService setTags:set alias:@"" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        //    [self.navigationController popToRootViewControllerAnimated:NO];

        [AcountManager removeAllData];
        
        // 检测是否打开登录页
        //    [self.navigationController pushViewController:[DVVUserManager loginController] animated:NO];
        //    [self.navigationController presentViewController:[DVVUserManager loginController] animated:YES completion:nil];
        
        [SignUpInfoManager removeSignData];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setInteger:1 forKey:@"isCarReset"];
        [ud synchronize];

        [UIApplication sharedApplication].keyWindow.rootViewController = [[YBLoginController alloc] init];

    } onQueue:nil];
    
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

@end
