//
//  MagicDetailViewController.m
//  TestShop
//
//  Created by ytzhang on 15/12/19.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "MagicDetailViewController.h"
#import "DetailIntroduceCell.h"
#import "DetailPriceCell.h"
#import "PrivateMessageController.h"
#import "UIImageView+EMWebCache.h"
#import "UIColor+Hex.h"
#import "MyWalletViewController.h"
#import "VirtualViewController.h"

@interface MagicDetailViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSString *walletstr;
@end

@implementation MagicDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    MyWalletViewController *walletVC = [self.navigationController.viewControllers objectAtIndex:0];
    [walletVC refreshWalletData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self addBottomView];
}
#pragma mark -----加载底部View
- (void)addBottomView
{
    // 加载底部View
    _bottomView = [LTBottomView instanceBottomView];
    // 取出积分的Label
    UILabel *numberLabel = [_bottomView viewWithTag:103];
    NSUserDefaults *defaules = [NSUserDefaults standardUserDefaults];
    _walletstr = [defaules objectForKey:@"walletStr"];
//
    numberLabel.text = _walletstr;
    // 取出立即购买按钮,添加点击事件
    _didClickBtn = [_bottomView viewWithTag:102];
    if ([_mainModel.is_scanconsumption isEqualToString:@"ture"]) {
        [_didClickBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
        //// 判断按钮是否能点击
        _didClickBtn.selected = [_walletstr intValue]  >=  _mainModel.productprice ? 1 : 0;
        if (_didClickBtn.selected) {
            _didClickBtn.tag = 301;
            [_didClickBtn setBackgroundColor:[UIColor colorWithHexString:@"ff5d35"]];
            [_didClickBtn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        }

    }else
    {
       [_didClickBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        //// 判断按钮是否能点击
        _didClickBtn.selected = [_walletstr intValue]  >=  _mainModel.productprice ? 1 : 0;
        if (_didClickBtn.selected) {
            _didClickBtn.tag = 302;
            [_didClickBtn setBackgroundColor:[UIColor colorWithHexString:@"ff5d35"]];
            [_didClickBtn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        }

    }
    
    
    
    CGFloat kWight = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHight = [UIScreen mainScreen].bounds.size.height;
    CGFloat kbottonViewh = 50;
    _bottomView.frame = CGRectMake(0,kHight - 50 , kWight, kbottonViewh);
    [self.view addSubview:_bottomView];
    
    
}
#pragma mark ----- 立即购买按钮的点击事件

- (void)didClick:(UIButton *)btn
{
    if (btn.tag == 301) {
        VirtualViewController *virtualVC = [[VirtualViewController alloc] init];
        virtualVC.shopId = _mainModel.productid;
        [self.navigationController pushViewController:virtualVC animated:YES];

    }else if (btn.tag == 302)
    {
        PrivateMessageController *privateMessageVC = [[PrivateMessageController alloc] init];
        
        privateMessageVC.shopId = _mainModel.productid;
        [self.navigationController pushViewController:privateMessageVC animated:YES];
    }

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *definition = @"myCell";
    BOOL nibsRegistered = NO;
    // 加载第一部分Cell
    if (indexPath.row == 0)
    {
        if (!nibsRegistered)
        {
            
            UINib *nib = [UINib nibWithNibName:@"DetailPriceCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:definition];
            nibsRegistered = YES;
        }
        DetailPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:definition];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *textStr = [NSString stringWithFormat:@" 浏览   %d次",(int)_mainModel.viewcount];
        NSString *buyStr = [NSString stringWithFormat:@" 兑换   %d次",(int)_mainModel.buycount];
        NSString *moneyStr = [NSString stringWithFormat:@"%d",_mainModel.productprice];
        NSString *descStr  = _mainModel.productdesc;
        _moneyCount = _mainModel.productprice;
        cell.scanNumber.text = textStr;
        cell.buyNumber.text = buyStr;
        cell.moneyNumber.text = moneyStr;
        cell.shopDetailName.text = descStr;
        NSString *encoded = [_mainModel.detailsimg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:encoded] placeholderImage:[UIImage imageNamed:@"nav_bg"]];
        return cell;
    }
    // 加载第二部分Cell
    else
    {
        if (!nibsRegistered)
        {
            
            UINib *nib = [UINib nibWithNibName:@"DetailIntroduceCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:definition];
            nibsRegistered = YES;
        }
        DetailIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:definition];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *encoded = [_mainModel.detailsimg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:encoded] placeholderImage:[UIImage imageNamed:@"nav_bg"]];
        return cell;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark ---- Lazy加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 114) style:UITableViewStylePlain];
    }
    return _tableView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 250;
    }
    else
    {
        return  300;
    }
}

@end
