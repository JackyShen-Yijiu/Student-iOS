//
//  SubjectFirstViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/15.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "SubjectSecondViewController.h"
#import "UserCenterViewController.h"
#import <Masonry/Masonry.h>
#import "AppointmentViewController.h"
#import "DrivingViewController.h"
#import "MyWalletViewController.h"
#import "ToolHeader.h"
#import "AppointmentDrivingViewController.h"
#import "CoachViewController.h"
#import "LoginViewController.h"
#import "BLAVPlayerViewController.h"
#import <SDCycleScrollView.h>
#import "ChatListViewController.h"
@interface SubjectSecondViewController ()

@property (strong, nonatomic)UIButton *coachButton;
@property (strong, nonatomic) UIImageView *coachImageView;
@property (strong, nonatomic) UILabel *coachLabel;

@property (strong, nonatomic)UIButton *signUpButton;
@property (strong, nonatomic) UIImageView *signUpImageView;
@property (strong, nonatomic) UILabel *signUpLabel;

@property (strong, nonatomic)UIButton *cardButton;
@property (strong, nonatomic) UIImageView *cardImageView;
@property (strong, nonatomic) UILabel *cardLabel;


@property (strong, nonatomic)UIButton *purseButton;
@property (strong, nonatomic) UIImageView *purseImageView;
@property (strong, nonatomic) UILabel *purseLabel;

@property (strong, nonatomic)UIButton *massageButton;
@property (strong, nonatomic) UIImageView *massageImageView;
@property (strong, nonatomic) UILabel *massageLabel;

@property (strong, nonatomic)UIButton *myselfButton;
@property (strong, nonatomic) UIImageView *myselfImageView;
@property (strong, nonatomic) UILabel *myselfLabel;
@property (strong, nonatomic) UIScrollView *backGroundScrollview;
@property (strong, nonatomic) UIView *backGroundView;

@property (strong, nonatomic) SDCycleScrollView *loopview ;

@end

@implementation SubjectSecondViewController

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _backGroundView;
}

- (UIScrollView *)backGroundScrollview {
    if (_backGroundScrollview == nil) {
        _backGroundScrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _backGroundScrollview.showsHorizontalScrollIndicator = NO;
    }
    return _backGroundScrollview;
}
#pragma mark - 我的预约

- (UIButton *)coachButton{
    if (_coachButton ==nil) {
        _coachButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _coachButton.backgroundColor = RGBColor(255, 153, 0);
        [_coachButton addTarget:self action:@selector(dealCoach:) forControlEvents:UIControlEventTouchUpInside];
        _coachButton.layer.cornerRadius = 2;
        [_coachButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _coachButton;
}

- (UIImageView *)coachImageView {
    if (_coachImageView == nil) {
        _coachImageView = [[UIImageView alloc] init];
        _coachImageView.image = [UIImage imageNamed:@"首页_我的预约"];
    }
    return _coachImageView;
}

- (UILabel *)coachLabel {
    if (_coachLabel == nil) {
        _coachLabel = [[UILabel alloc] init];
        _coachLabel.font = [UIFont systemFontOfSize:11];
        _coachLabel.textColor = [UIColor whiteColor];
        _coachLabel.text = @"科二预约列表";
        _coachLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _coachLabel;
}
#pragma mark - 预约学车

- (UIButton *)signUpButton{
    if (_signUpButton == nil) {
        _signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _signUpButton.backgroundColor = RGBColor(189, 31, 74);
        _signUpButton.layer.cornerRadius = 2;
        
        [_signUpButton addTarget:self action:@selector(dealSignUp:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _signUpButton;
}
- (UIImageView *)signUpImageView {
    if (_signUpImageView == nil) {
        _signUpImageView = [[UIImageView alloc] init];
        _signUpImageView.image = [UIImage imageNamed:@"首页_预约学车"];
    }
    return _signUpImageView;
}

- (UILabel *)signUpLabel {
    if (_signUpLabel == nil) {
        _signUpLabel = [[UILabel alloc] init];
        _signUpLabel.font = [UIFont systemFontOfSize:11];
        _signUpLabel.textColor = [UIColor whiteColor];
        _signUpLabel.text = @"我要预约";
        _signUpLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _signUpLabel;
}
#pragma mark - 课件
- (UIButton *)cardButton{
    if (_cardButton == nil) {
        _cardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cardButton.layer.cornerRadius = 2;
        
        _cardButton.backgroundColor = RGBColor(255, 102, 51);
        [_cardButton addTarget:self action:@selector(dealCard:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cardButton;
}
- (UIImageView *)cardImageView {
    if (_cardImageView == nil) {
        _cardImageView = [[UIImageView alloc] init];
        _cardImageView.image = [UIImage imageNamed:@"首页_课件"];
    }
    return _cardImageView;
}

- (UILabel *)cardLabel {
    if (_cardLabel == nil) {
        _cardLabel = [[UILabel alloc] init];
        _cardLabel.font = [UIFont systemFontOfSize:11];
        _cardLabel.textColor = [UIColor whiteColor];
        _cardLabel.text = @"科二课件";
        _cardLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _cardLabel;
}
#pragma mark - 钱包


- (UIButton *)purseButton{
    if (_purseButton == nil) {
        _purseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _purseButton.layer.cornerRadius = 2;
        _purseButton.backgroundColor = RGBColor(1, 160,0);
        [_purseButton addTarget:self action:@selector(dealPurse:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _purseButton;
}
- (UIImageView *)purseImageView {
    if (_purseImageView == nil) {
        _purseImageView = [[UIImageView alloc] init];
        _purseImageView.image = [UIImage imageNamed:@"首页_钱包"];
    }
    return _purseImageView;
}

- (UILabel *)purseLabel {
    if (_purseLabel == nil) {
        _purseLabel = [[UILabel alloc] init];
        _purseLabel.font = [UIFont systemFontOfSize:11];
        _purseLabel.textColor = [UIColor whiteColor];
        _purseLabel.text = @"钱包";
        _purseLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _purseLabel;
}
#pragma mark - 消息
- (UIButton *)massageButton{
    if (_massageButton == nil) {
        _massageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _massageButton.layer.cornerRadius = 2;
        
        _massageButton.backgroundColor = RGBColor(0, 148, 166);
        [_massageButton addTarget:self action:@selector(dealMassage:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _massageButton;
}

- (UIImageView *)massageImageView {
    if (_massageImageView == nil) {
        _massageImageView = [[UIImageView alloc] init];
        _massageImageView.image = [UIImage imageNamed:@"首页_消息"];
    }
    return _massageImageView;
}

- (UILabel *)massageLabel {
    if (_massageLabel == nil) {
        _massageLabel = [[UILabel alloc] init];
        _massageLabel.font = [UIFont systemFontOfSize:11];
        _massageLabel.textColor = [UIColor whiteColor];
        _massageLabel.text = @"消息";
        _massageLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _massageLabel;
}

#pragma mark - 我的
- (UIButton *)myselfButton{
    if (_myselfButton == nil) {
        _myselfButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _myselfButton.layer.cornerRadius = 2;
        
        _myselfButton.backgroundColor = RGBColor(45, 138, 239);
        [_myselfButton addTarget:self action:@selector(dealMyself:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _myselfButton;
}
- (UIImageView *)myselfImageView {
    if (_myselfImageView == nil) {
        _myselfImageView = [[UIImageView alloc] init];
        _myselfImageView.image = [UIImage imageNamed:@"首页_我的"];
    }
    return _myselfImageView;
}

- (UILabel *)myselfLabel {
    if (_myselfLabel == nil) {
        _myselfLabel = [[UILabel alloc] init];
        _myselfLabel.font = [UIFont systemFontOfSize:11];
        _myselfLabel.textColor = [UIColor whiteColor];
        _myselfLabel.text = @"我的";
        _myselfLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _myselfLabel;
}
#define kSystemWide [UIScreen mainScreen].bounds.size.width

#define kSystemHeight [UIScreen mainScreen].bounds.size.height
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (kSystemHeight == 480) {
        self.backGroundView.frame = CGRectMake(0, 0, 320, 568);
        self.backGroundScrollview.contentSize = CGSizeMake(320, 568);
    }
    
    _loopview = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemWide*0.6)];
    _loopview.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bannerChange) name:@"kBannerChange" object:nil];
    
    
    
    
    [self.view addSubview:self.backGroundScrollview];
    [self.backGroundScrollview addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:_loopview];
    
    [self.backGroundView addSubview:self.coachButton];
    
    [self.backGroundView addSubview:self.signUpButton];
    
    [self.backGroundView addSubview:self.cardButton];
    
    [self.backGroundView addSubview:self.myselfButton];
    
    [self.backGroundView addSubview:self.massageButton];
    
    [self.backGroundView addSubview:self.purseButton];
    
    
    
    [self.coachButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loopview.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(5);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.64];
        make.width.mas_equalTo(wide);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.672];
        make.height.mas_equalTo(height);
        
    }];
    
    [self.coachButton addSubview:self.coachImageView];
    [self.coachButton addSubview:self.coachLabel];
    [self.coachImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.coachButton.mas_centerX);
        make.centerY.mas_equalTo(self.coachButton.mas_centerY);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.184];
        make.width.mas_equalTo(wide);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.20];
        make.height.mas_equalTo(height);
    }];
    [self.coachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coachButton.mas_left).with.offset(8);
        make.bottom.mas_equalTo(self.coachButton.mas_bottom).with.offset(-8);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.31];
        make.width.mas_equalTo(wide);
    }];
    
    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coachButton.mas_top).offset(0);
        make.left.mas_equalTo(self.coachButton.mas_right).with.offset(5);
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(-5);
        //        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.3125];
        //        make.height.mas_equalTo(wide);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.3281];
        make.height.mas_equalTo(height);
    }];
    [self.signUpButton addSubview:self.signUpImageView];
    [self.signUpButton addSubview:self.signUpLabel];
    
    
    [self.signUpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.signUpButton.mas_centerX);
        make.centerY.mas_equalTo(self.signUpButton.mas_centerY);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.1];
        make.width.mas_equalTo(wide);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.098];
        make.height.mas_equalTo(height);
    }];
    [self.signUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.signUpButton.mas_left).with.offset(8);
        make.bottom.mas_equalTo(self.signUpButton.mas_bottom).with.offset(-8);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.195];
        make.width.mas_equalTo(wide);
    }];
    
    [self.cardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.signUpButton.mas_bottom).with.offset(5);
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(-5);
        make.left.mas_equalTo(self.coachButton.mas_right).offset(5);
        //        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.3125];
        //        make.height.mas_equalTo(wide);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.3281];
        make.height.mas_equalTo(height);
        
    }];
    [self.cardButton addSubview:self.cardImageView];
    [self.cardButton addSubview:self.cardLabel];
    
    [self.cardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.cardButton.mas_centerX);
        make.centerY.mas_equalTo(self.cardButton.mas_centerY);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.1328];
        make.width.mas_equalTo(wide);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.08125];
        make.height.mas_equalTo(height);
    }];
    [self.cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cardButton.mas_left).with.offset(8);
        make.bottom.mas_equalTo(self.cardButton.mas_bottom).with.offset(-8);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.195];
        make.width.mas_equalTo(wide);
    }];
    
    
    [self.purseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coachButton.mas_bottom).offset(5);
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(5);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.3125];
        make.width.mas_equalTo(wide);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.3281];
        make.height.mas_equalTo(height);
    }];
    
    [self.purseButton addSubview:self.purseImageView];
    [self.purseButton addSubview:self.purseLabel];
    
    [self.purseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.purseButton.mas_centerX);
        make.centerY.mas_equalTo(self.purseButton.mas_centerY);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.10];
        make.width.mas_equalTo(wide);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.08];
        make.height.mas_equalTo(height);
    }];
    [self.purseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.purseButton.mas_left).with.offset(8);
        make.bottom.mas_equalTo(self.purseButton.mas_bottom).with.offset(-8);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.195];
        make.width.mas_equalTo(wide);
    }];
    
    
    [self.massageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerY.mas_equalTo(self.purseButton.mas_centerY);
        make.left.mas_equalTo(self.purseButton.mas_right).with.offset(5);
        make.top.mas_equalTo(self.coachButton.mas_bottom).with.offset(5);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.3125];
        make.width.mas_equalTo(wide);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.3281];
        make.height.mas_equalTo(height);
    }];
    
    [self.massageButton addSubview:self.massageImageView];
    [self.massageButton addSubview:self.massageLabel];
    
    [self.massageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.massageButton.mas_centerX);
        make.centerY.mas_equalTo(self.massageButton.mas_centerY);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.095];
        make.width.mas_equalTo(wide);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.092];
        make.height.mas_equalTo(height);
    }];
    [self.massageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.massageButton.mas_left).with.offset(8);
        make.bottom.mas_equalTo(self.massageButton.mas_bottom).with.offset(-8);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.195];
        make.width.mas_equalTo(wide);
    }];
    
    
    [self.myselfButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerY.mas_equalTo(self.purseButton.mas_centerY);
        
        make.left.mas_equalTo(self.massageButton.mas_right).with.offset(5);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-5);
        make.top.mas_equalTo(self.coachButton.mas_bottom).with.offset(5);
        
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.328];
        make.height.mas_equalTo(height);
    }];
    
    [self.myselfButton addSubview:self.myselfImageView];
    [self.myselfButton addSubview:self.myselfLabel];
    
    [self.myselfImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.myselfButton.mas_centerX);
        make.centerY.mas_equalTo(self.myselfButton.mas_centerY);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.09];
        make.width.mas_equalTo(wide);
        NSNumber *height = [NSNumber numberWithFloat:kSystemWide*0.10];
        make.height.mas_equalTo(height);
    }];
    [self.myselfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.myselfButton.mas_left).with.offset(8);
        make.bottom.mas_equalTo(self.myselfButton.mas_bottom).with.offset(-8);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide*0.195];
        make.width.mas_equalTo(wide);
    }];
}

- (void)bannerChange {
    NSMutableArray *bannerUrl = [[NSMutableArray alloc] init];
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    for (BannerModel *banner in [AcountManager getBannerUrlArray]) {
        [bannerUrl addObject:banner.headportrait.originalpic];
        [titleArray addObject:banner.newsname];
    }
    
    _loopview.imageURLStringsGroup = bannerUrl;
    _loopview.titlesGroup = titleArray;
}
- (void)dealSignUp:(UIButton *)sender {
    
    AppointmentDrivingViewController *appointment = [[AppointmentDrivingViewController alloc] init];
//    appointment.markNum = 2;

    [self.navigationController pushViewController:appointment animated:YES];

}

- (void)dealMassage:(UIButton *)sender {
    ChatListViewController *list = [[ChatListViewController alloc] init];
    list.title = @"消息";

    [self.navigationController pushViewController:list animated:YES];
}

- (void)dealPurse:(UIButton *)sender {
    MyWalletViewController *myWallet = [[MyWalletViewController alloc] init];
    [self.navigationController pushViewController:myWallet animated:YES];
}
- (void)dealCoach:(UIButton *)sender{
    DYNSLog(@"我的预约");
    AppointmentViewController *appointment = [[AppointmentViewController alloc] init];
    appointment.title = @"科二预约列表";
    appointment.markNum = [NSNumber numberWithInteger:2];
    [self.navigationController pushViewController:appointment animated:YES];
}

- (void)dealCard:(UIButton *)sender{
    BLAVPlayerViewController *player = [[BLAVPlayerViewController alloc] init];
    player.title = @"科二课件";
    player.markNum = [NSNumber numberWithInteger:2];
    [self.navigationController pushViewController:player animated:YES];
}

- (void)dealMyself:(UIButton *)sender {
    if (![AcountManager isLogin]) {
        [DVVUserManager userNeedLogin];
        return;
    }
    UserCenterViewController *userCenter = [[UserCenterViewController alloc] init];
    [self.navigationController pushViewController:userCenter animated:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSMutableArray *bannerUrl = [[NSMutableArray alloc] init];
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    for (BannerModel *banner in [AcountManager getBannerUrlArray]) {
        [bannerUrl addObject:banner.headportrait.originalpic];
        [titleArray addObject:banner.newsname];
    }
    
    _loopview.imageURLStringsGroup = bannerUrl;
    _loopview.titlesGroup = titleArray;
}
@end
