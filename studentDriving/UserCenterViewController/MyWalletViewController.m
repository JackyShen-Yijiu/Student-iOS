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
#import "ToolHeader.h"
#import "MagicMainTableViewController.h"
#import "MyWallet.h"
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import "UIColor+Hex.h"
#import "DVVSideMenu.h"

static NSString *const kMyWalletUrl = @"userinfo/getmywallet?userid=%@&usertype=1&seqindex=%@&count=10";

@interface MyWalletViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UILabel *myWalletTitle;
@property (strong, nonatomic) UILabel *moneyDisplay;
@property (strong, nonatomic) UIButton *inviteButton;
@property (strong, nonatomic) UIButton *exchangeButton;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UILabel *inviteNum;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) UIView *groundView ;

@end

@implementation MyWalletViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
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
        _moneyDisplay.text = @"0";
    }
    return _moneyDisplay;
}
- (UIButton *)inviteButton {
    if (_inviteButton == nil) {
        _inviteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_inviteButton setTitle:@"赚积分" forState:UIControlStateNormal];
        [_inviteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _inviteButton.backgroundColor = [UIColor colorWithHexString:@"ff5d35"];
        _inviteButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _inviteButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _inviteButton.layer.borderWidth = 1;
        _inviteButton.layer.cornerRadius = 2;
        [_inviteButton addTarget:self action:@selector(dealInvite:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _inviteButton;
}
- (UIButton *)exchangeButton {
    if (_exchangeButton == nil) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeButton setTitle:@"兑换商品" forState:UIControlStateNormal];
        [_exchangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     
        _exchangeButton.backgroundColor = [UIColor colorWithHexString:@"ff5d35"];
        _exchangeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _exchangeButton.layer.borderColor = MAINCOLOR.CGColor;
        _exchangeButton.layer.borderWidth = 1;
        _exchangeButton.layer.cornerRadius = 2;
        [_exchangeButton addTarget:self action:@selector(clickExchange:) forControlEvents:UIControlEventTouchUpInside];
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
//    [self addSideMenuButton];
    
    self.title = @"我的钱包";
    self.automaticallyAdjustsScrollViewInsets = YES;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:self.tableView];

    
    self.tableView.tableHeaderView = [self tableViewHead];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(startDownLoad)];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreLoad)];
//    self.tableView.mj_footer.automaticallyHidden = NO;
//    DYNSLog(@"footview = %@",self.tableView.mj_footer);
    
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
- (void)dealInvite:(UIButton *)sender {
    
    self.groundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight)];
    self.groundView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];

    
    UIView *backImageView = [[UIView alloc] initWithFrame:CGRectMake(kSystemWide/2-250/2, kSystemHeight/2-250/2, 250, 250)];
    backImageView.backgroundColor = [UIColor whiteColor];
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(-1, -1, 252, 200)];
    backView.image = [UIImage imageNamed:@"红包_background.png"];
    
    UIImageView *redImage = [[UIImageView alloc] initWithFrame:CGRectMake(250/2-75/2, 10, 75, 58)];
    redImage.layer.masksToBounds = YES;
    redImage.image = [UIImage imageNamed:@"红包.png"];
    [backView addSubview:redImage];
    [backImageView addSubview:backView];
    
    UILabel *labelone = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 250, 20)];
    labelone.textAlignment = NSTextAlignmentCenter;
    labelone.text = @"一步学车设计了最先进的用户激励机制";
    labelone.textColor = [UIColor whiteColor];
    labelone.font = [UIFont systemFontOfSize:14];
    UILabel *labeltwo = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 250, 20)];
    labeltwo.font = [UIFont systemFontOfSize:13];
    labeltwo.textColor = [UIColor whiteColor];


    labeltwo.textAlignment = NSTextAlignmentCenter;

    labeltwo.text = @"推荐用户和学员可以长久的获利";
    UILabel *labelthree = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 250, 20)];
    labelthree.font = [UIFont systemFontOfSize:13];
    labelthree.textColor = [UIColor whiteColor];


    labelthree.textAlignment = NSTextAlignmentCenter;

    labelthree.text = @"赶快去邀请小伙伴来用吧";
    UILabel *labelfour = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, 250,20)];
    labelfour.textAlignment = NSTextAlignmentCenter;
    labelfour.font = [UIFont systemFontOfSize:13];
    labelfour.textColor = [UIColor whiteColor];


    labelfour.text = @"记得让他们注册的时候填写你的邀请码哟";
    
    [backView addSubview:labelone];
    [backView addSubview:labeltwo];
    [backView addSubview:labelthree];
    [backView addSubview:labelfour];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = RGBColor(241, 81, 27);
    button.frame = CGRectMake(250/2-200/2, 205, 200, 40);
    [button setTitle:@"我知道了" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickDismiss:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:button];
    
    [self.groundView addSubview:backImageView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.groundView];
    

    
}
- (void)clickDismiss:(UIButton *)sender {
    [self.groundView removeFromSuperview];
}
- (void)clickExchange:(UIButton *)sender {
    MagicMainTableViewController *vc = [[MagicMainTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadMoreLoad {
    DYNSLog(@"loadmore");
    MyWallet *wallet = [self.dataArray lastObject];
    NSString *urlString = [NSString stringWithFormat:kMyWalletUrl,[AcountManager manager].userid,[NSNumber numberWithInt:wallet.seqindex]];
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data)  {
        DYNSLog(@"data = %@",data);
        [self.tableView.mj_footer endRefreshing];
        
        NSDictionary *param = [data objectForKey:@"data"];
        NSArray *list = [param objectForKey:@"list"];
        if (list.count < 10) {
            [SVProgressHUD showInfoWithStatus:@"没有更多信息"];
            return ;
        }
        NSString *walletString = [NSString stringWithFormat:@"%@",param[@"wallet"]];
        DYNSLog(@"wallet = %@",walletString);
        if (walletString && walletString.length != 0) {
            self.moneyDisplay.text =  [NSString stringWithFormat:@"%@",walletString];
            wallet.wallet = [NSString stringWithFormat:@"%@",walletString];
        }
        for (NSDictionary *dic in data) {
            MyWallet *wallet = [[MyWallet alloc] init];
            [wallet setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:wallet];
        }
        [self.tableView reloadData];
        
    } withFailure:^(id data) {
        [self.tableView.mj_footer endRefreshing];
    } ];
    
}

- (void)startDownLoad {
    NSString *url = [NSString stringWithFormat:kMyWalletUrl,[AcountManager manager].userid,@"0"];
    NSString *urlString = [NSString stringWithFormat:BASEURL,url];
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data)  {
        DYNSLog(@"data = %@",data);
        [self.tableView.mj_header endRefreshing];
        
        if (![[data objectForKey:@"type"] integerValue]) {
            return ;
        }
        NSDictionary *param = [data objectForKey:@"data"];
        NSArray *list = [param objectForKey:@"list"];
        
        NSString *walletString = [NSString stringWithFormat:@"%@",param[@"wallet"]];
        NSLog(@"walletStringTest = %@",walletString);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:walletString forKey:@"walletStr"];
    
        
        DYNSLog(@"wallet = %@",walletString);
        if (walletString && walletString.length != 0) {
            self.moneyDisplay.text =  [NSString stringWithFormat:@"%@",walletString];
        }
        for (NSDictionary *dic in list) {
            MyWallet *wallet = [[MyWallet alloc] init];
            [wallet setValuesForKeysWithDictionary:dic];
            self.dataArray = nil;
            [self.dataArray addObject:wallet];
        }
        [self.tableView reloadData];

    } withFailure:^(id data) {
        [self.tableView.mj_header endRefreshing];
    } ];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 1) {
        return  29;
//    }else if (section== 0) {
//        return 0;
//    }
//    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        return 230;
//    }else if (indexPath.section == 1) {
        return 70;
//    }
//    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
//        return 1;
//    }else if (section == 1) {
        return self.dataArray.count;
//    }
//    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 1) {
        static NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MyWallet *wallet = self.dataArray[indexPath.row];
        
        cell.textLabel.text = @"分享收益";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.text = [NSString getLitteLocalDateFormateUTCDate:wallet.createtime];
        cell.detailTextLabel.textColor = TEXTGRAYCOLOR;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        UILabel *moneyDisplay = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        moneyDisplay.textColor = MAINCOLOR;
        moneyDisplay.font = [UIFont systemFontOfSize:22];
        moneyDisplay.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithInt:wallet.amount]] ;
        cell.accessoryView = moneyDisplay;
        return cell;
}
- (void)refreshWalletData
{
    [self startDownLoad];
}

@end
