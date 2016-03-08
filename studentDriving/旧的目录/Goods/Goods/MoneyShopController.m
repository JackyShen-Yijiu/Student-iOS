//
//  MoneyShopController.m
//  studentDriving
//
//  Created by ytzhang on 16/1/3.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "MoneyShopController.h"
#import "UIDevice+JEsystemVersion.h"
#import "UIView+CalculateUIView.h"
#import <Chameleon.h>
#import "ToolHeader.h"
#import "MagicMainTableViewController.h"
#import "MyWallet.h"
#import <MJRefresh.h>
#import "UIColor+Hex.h"
#import "DVVSideMenu.h"
#import "DiscountWalletModel.h"
#import "DiscountShopController.h"
#import "DiscountWalletCell.h"

@interface MoneyShopController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UILabel *myWalletTitle;
@property (strong, nonatomic) UILabel *moneyDisplay;
@property (strong, nonatomic) UILabel *YBLabel;
@property (strong, nonatomic) UIButton *inviteButton;
@property (strong, nonatomic) UIButton *exchangeButton;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UILabel *inviteNum;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) UIView *groundView ;
@end

@implementation MoneyShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"现金列表";
    self.automaticallyAdjustsScrollViewInsets = YES;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:self.tableView];
    
    
    self.tableView.tableHeaderView = [self tableViewHead];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(startDownLoad)];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreLoad)];
    
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
    [self.exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomView.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(-5);
        make.height.mas_equalTo(@40);
        NSNumber *wide = [NSNumber numberWithFloat:(kSystemWide)-30];
        make.width.mas_equalTo(wide);
    }];
    
    if ([AcountManager manager].userCoinCertificate == 0) {
        self.exchangeButton.userInteractionEnabled = NO;
        self.exchangeButton.backgroundColor = [UIColor grayColor];
        _exchangeButton.layer.borderColor = [UIColor grayColor].CGColor;
        
    }

    
}

- (void)startDownLoad {
    NSString *url = @"";
    NSString *urlString = [NSString stringWithFormat:BASEURL,url];
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data)  {
        DYNSLog(@"data = %@",data);
        [self.tableView.mj_header endRefreshing];
        
        if (![[data objectForKey:@"type"] integerValue] || data == nil) {
            return ;
        }
        NSArray *param = [data objectForKey:@"data"];
        for (NSDictionary *dic in param) {
            DiscountWalletModel *discountModel = [[DiscountWalletModel alloc] init];
            [discountModel setValuesForKeysWithDictionary:dic];
            self.dataArray = nil;
            [self.dataArray addObject:discountModel];
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
    [view addSubview:self.YBLabel];
    [self.YBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moneyDisplay.mas_right).offset(1);
        make.top.mas_equalTo(self.myWalletTitle.mas_bottom).offset(40);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@40);
    }];
    
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    if (indexPath.section == 1) {
    static NSString *cellId = @"cell";
    DiscountWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[DiscountWalletCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.discountWalletModel = self.dataArray[indexPath.row];
    }
    if (self.dataArray) {
        cell.discountWalletModel = self.dataArray[indexPath.row];
    };
    
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
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
        //        _inviteNum.text = [NSString stringWithFormat:@"我的Y码:%@",[AcountManager manager].userInvitationcode];
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
- (UILabel *)YBLabel
{
    if (_YBLabel == nil) {
        _YBLabel = [WMUITool initWithTextColor:[UIColor whiteColor] withFont:[UIFont systemFontOfSize:16]];
        //        _YBLabel.backgroundColor = [UIColor greenColor];
        _YBLabel.text = @"元";
    }
    return _YBLabel;
}
- (UIButton *)exchangeButton {
    if (_exchangeButton == nil) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeButton setTitle:@"取现" forState:UIControlStateNormal];
        [_exchangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _exchangeButton.userInteractionEnabled = NO;
        _exchangeButton.backgroundColor = [UIColor grayColor];
        _exchangeButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        _exchangeButton.layer.borderColor = MAINCOLOR.CGColor;
//        _exchangeButton.layer.borderWidth = 1;
        _exchangeButton.layer.cornerRadius = 2;
        
    }
    return _exchangeButton;
}
- (UILabel *)myWalletTitle {
    if (_myWalletTitle == nil) {
        _myWalletTitle = [WMUITool initWithTextColor:[UIColor whiteColor] withFont:[UIFont systemFontOfSize:15]];
        //        _myWalletTitle.text = @"我的零钱";
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


@end
