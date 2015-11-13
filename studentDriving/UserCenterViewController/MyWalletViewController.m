//
//  MyWalletViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "MyWalletViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "UIView+CalculateUIView.h"
#import <Chameleon.h>

static NSString *const kMyWalletUrl = @"userinfo/getmywallet?userid=%@&usertype=1&seqindex=%@&count=10";

@interface MyWalletViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UILabel *myWalletTitle;
@property (strong, nonatomic) UILabel *moneyDisplay;
@property (strong, nonatomic) UIButton *inviteButton;
@property (strong, nonatomic) UIButton *exchangeButton;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UILabel *inviteNum;
@end

@implementation MyWalletViewController
- (UILabel *)inviteNum {
    if (_inviteNum == nil) {
        _inviteNum = [[UILabel alloc] init];
        _inviteNum.font = [UIFont systemFontOfSize:14];
        _inviteNum.text = [NSString stringWithFormat:@"我的邀请码:%@",[AcountManager manager].userInvitationcode];
    }
    return _inviteNum;
}
- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.borderColor = BACKGROUNDCOLOR.CGColor;
        _bottomView.layer.borderWidth = 1;
    }
    return _bottomView;
}
- (UILabel *)moneyDisplay {
    if (_moneyDisplay == nil) {
        _moneyDisplay = [WMUITool initWithTextColor:[UIColor whiteColor] withFont:[UIFont systemFontOfSize:65]];
        _moneyDisplay.text = @"56.66";
    }
    return _moneyDisplay;
}
- (UIButton *)inviteButton {
    if (_inviteButton == nil) {
        _inviteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_inviteButton setTitle:@"邀请好友" forState:UIControlStateNormal];
        [_inviteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _inviteButton.backgroundColor = MAINCOLOR;
        _inviteButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _inviteButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _inviteButton.layer.borderWidth = 1;
        _inviteButton.layer.cornerRadius = 2;
    }
    return _inviteButton;
}
- (UIButton *)exchangeButton {
    if (_exchangeButton == nil) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeButton setTitle:@"兑换商品" forState:UIControlStateNormal];
        [_exchangeButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
     
        _exchangeButton.backgroundColor = [UIColor whiteColor];
        _exchangeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _exchangeButton.layer.borderColor = MAINCOLOR.CGColor;
        _exchangeButton.layer.borderWidth = 1;
        _exchangeButton.layer.cornerRadius = 2;
    }
    return _exchangeButton;
}
- (UILabel *)myWalletTitle {
    if (_myWalletTitle == nil) {
        _myWalletTitle = [WMUITool initWithTextColor:[UIColor whiteColor] withFont:[UIFont systemFontOfSize:15]];
        _myWalletTitle.text = @"我的零钱";
    }
    return _myWalletTitle;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight-80-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的钱包";
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = [self tableViewHead];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.inviteNum];
    [self.bottomView addSubview:self.inviteButton];
    [self.bottomView addSubview:self.exchangeButton];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(@80);
    }];
    [self.inviteNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView.mas_left).offset(15);
        make.top.mas_equalTo(self.bottomView.mas_top).offset(10);
    }];
    [self.inviteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView.mas_left).offset(15);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(-10);
        make.height.mas_equalTo(@40);
        NSNumber *wide = [NSNumber numberWithFloat:(kSystemWide/2)-20];
        make.width.mas_equalTo(wide);
    }];
    [self.exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomView.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(-10);
        make.height.mas_equalTo(@40);
        NSNumber *wide = [NSNumber numberWithFloat:(kSystemWide/2)-20];
        make.width.mas_equalTo(wide);
    }];
    
    [self startDownLoad];
    
}
- (void)startDownLoad {
    NSString *url = [NSString stringWithFormat:kMyWalletUrl,[AcountManager manager].userid,@"0"];
    NSString *urlString = [NSString stringWithFormat:BASEURL,url];
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
    }];
}
- (UIView *)tableViewHead {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.calculateFrameWithWide, 230)];
    view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:CGRectMake(0, 0, kSystemWide, 230) andColors:@[RGBColor(240, 71, 26),RGBColor(255, 102, 51)]];
    
    [view addSubview:self.myWalletTitle];
    [self.myWalletTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_top).offset(53);
        make.centerX.mas_equalTo(view.mas_centerX);
    }];
    [view addSubview:self.moneyDisplay];
    [self.moneyDisplay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.myWalletTitle.mas_bottom).offset(0);
        make.centerX.mas_equalTo(view.mas_centerX);

    }];
  
   
    
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 29)];
    sectionTitle.text = @"      交易详情";
    sectionTitle.backgroundColor = RGBColor(247, 249, 251);
    sectionTitle.font = [UIFont systemFontOfSize:12];
    sectionTitle.textColor = [UIColor blackColor];
    return sectionTitle;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 29;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @"分享收益";
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.text = @"07/12";
    cell.detailTextLabel.textColor = TEXTGRAYCOLOR;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    UILabel *moneyDisplay = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    moneyDisplay.textColor = MAINCOLOR;
    moneyDisplay.font = [UIFont systemFontOfSize:22];
    moneyDisplay.text = @"+11.55";
    cell.accessoryView = moneyDisplay;
    return cell;
}


@end
