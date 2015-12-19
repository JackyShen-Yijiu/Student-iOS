//
//  MenuController.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/7.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "MenuController.h"
#import "SideMenuItem.h"
#import "UserCenterViewController.h"
#import "ChatListViewController.h"
#import "LoginViewController.h"
#import "AcountManager.h"
#import "YBBaseNavigationController.h"

@interface MenuController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView                    *headView;
@property (nonatomic, copy) NSArray                     *LeftItemArray;
@property (nonatomic, copy) NSArray                     *LeftIconArray;

@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"side_menu_bg"];
    self.view.layer.contents = (id)image.CGImage;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    
    SideMenuItem * item1 = [[SideMenuItem alloc] init];
    item1.title = @"首页";
    item1.target = @"";
    
    SideMenuItem * item2 = [[SideMenuItem alloc] init];
    item2.title = @"查找驾校";
    item2.target = @"DrivingViewController";
    
    SideMenuItem * item3 = [[SideMenuItem alloc] init];
    item3.title = @"消息";
    item3.target = @"ChatListViewController";
    
//    SideMenuItem * item4 = [[SideMenuItem alloc] init];
//    item4.title = @"签到";
//    item4.target = @"SweepCodeSignInController";
    
    SideMenuItem * item5 = [[SideMenuItem alloc] init];
    item5.title = @"钱包";
    item5.target = @"MyWalletViewController";
    
    SideMenuItem * item6 = [[SideMenuItem alloc] init];
    item6.title = @"我";
    item6.target = @"UserCenterViewController";
    
    self.LeftItemArray = @[item1,item2,item3,item5,item6];
    
    self.LeftIconArray = @[ @"首页",@"查找教练",@"消息", @"钱包", @"我" ];
    self.tableView.tableHeaderView = self.headView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [UIView new];
        _headView.backgroundColor = [UIColor clearColor];
        
        UIImageView * imgView = [UIImageView new];
        imgView.layer.masksToBounds = YES;
        if ([UIScreen mainScreen].bounds.size.width > 320) {
            _headView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
            imgView.frame = CGRectMake(97, 82, 78, 78);
            imgView.layer.cornerRadius = 39;
        }else {
            _headView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 170);
            imgView.frame = CGRectMake(70, 80, 70, 70);
            imgView.layer.cornerRadius = 35;
        }
        [imgView sd_setImageWithURL:(NSURL *)[AcountManager manager].userHeadImageUrl];
        
        imgView.userInteractionEnabled = YES;
        imgView.image = [UIImage imageNamed:@"头像11"];
        [_headView addSubview:imgView];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconViewIsClick)];
        [imgView addGestureRecognizer:tapGR];
    }
    return _headView;
}

- (void)iconViewIsClick {
    
    
    if (![AcountManager isLogin]) {
        [self showLoginView];
        return;
    }
    UserCenterViewController *ucc = [[UserCenterViewController alloc] init];
    YBBaseNavigationController *nav = [[YBBaseNavigationController alloc] initWithRootViewController:ucc];
    [self presentViewController:nav animated:YES completion:^{
        [ucc setPresentBackBotton];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _LeftIconArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([UIScreen mainScreen].bounds.size.width > 320) {
        return 60;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        UIImageView *cellIconView = [[UIImageView alloc] initWithFrame:CGRectMake(37, 9, 28, 28)];
        cellIconView.tag = 10 +indexPath.row;
        [cell.contentView addSubview:cellIconView];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(67, 15, 100, 16)];
        lb.textColor  = RGBACOLOR(0xfc, 0xfc, 0xfc, 1);
        lb.tag = 100 +indexPath.row;
        lb.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:lb];
    }
    UIImageView *cellIconView = (id)[cell.contentView viewWithTag:10 +indexPath.row];
    cellIconView.image = [UIImage imageNamed:[self.LeftIconArray objectAtIndex:indexPath.row]];
    SideMenuItem *item = [self.LeftItemArray objectAtIndex:indexPath.row];
    UILabel *lb = (id)[cell.contentView viewWithTag:100 +indexPath.row];
    lb.text = [NSString stringWithFormat:@"%@",item.title];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.sideMenuViewController hideMenuViewController];
        return;
    }
    
    SideMenuItem * item = self.LeftItemArray[indexPath.row];
    UIViewController *vc = [[NSClassFromString(item.target) alloc]init];
    if (indexPath.row == 2) {
        vc.title = @"消息";
    }
    YBBaseNavigationController *nav = [[YBBaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{
        [vc setPresentBackBotton];
    }];
}

@end
