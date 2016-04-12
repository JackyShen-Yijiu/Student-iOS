//
//  JZConfirmOrderController.m
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZConfirmOrderController.h"
#import "JZExchangeRecordCell.h"
#import "JZOrderMallNumberCell.h"
#import "JZOrderMallAdderssCell.h"

#define footerViewH 40
@interface JZConfirmOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) UIView *bgView;
///  YB的Label
@property (nonatomic, strong) UILabel *moneyLabel;
///  立即兑换的按钮
@property (nonatomic, strong) UIButton *exchangeButton;


@end

@implementation JZConfirmOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.moneyLabel];
    [self.bgView addSubview:self.exchangeButton];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 10)];
    view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 1;
    }
    if (1 == section) {
        return 2;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return 122;
    }
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        static NSString *IDexchange = @"ecchangeID";
        JZExchangeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:IDexchange];
        if (!cell) {
            cell = [[JZExchangeRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDexchange];
        }
        cell.integrtalMallModel = self.integraMallModel;
        cell.stateLabel.hidden = YES;
        return cell;

    }
    if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            static NSString *IDnumber = @"numberID";
            JZOrderMallNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:IDnumber];
            if (!cell) {
                cell = [[JZOrderMallNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDnumber];
            }
            return cell;

        }
        if (1 == indexPath.row) {
            static NSString *IDaddress = @"addressID";
            JZOrderMallAdderssCell *cell = [tableView dequeueReusableCellWithIdentifier:IDaddress];
            if (!cell) {
                cell = [[JZOrderMallAdderssCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDaddress];
            }
            cell.integrtalMallModel = self.integraMallModel;
            return cell;

        }
    }
    
    return nil;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark ---- Action
- (void)didExchange:(UIButton *)btn{
    
}
#pragma mark --- Lazy加载
- (UITableView *)tableView
{
    if (_tableView == nil ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , kSystemHeight - 64 - footerViewH) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kSystemHeight - 64 - footerViewH, kSystemWide, footerViewH)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSystemWide / 2, footerViewH)];
        if (0 == _mallWay) {
            // 积分商城
            
            _moneyLabel.text = [NSString stringWithFormat:@"需支付:%luYB",_integraMallModel.productprice];
        }else if (1 == _mallWay){
            // 兑换劵商城
            _moneyLabel.text = @"需要消费一张兑换劵";
        }
        _moneyLabel.font = [UIFont systemFontOfSize:14];
        _moneyLabel.textColor = [UIColor colorWithHexString:@"212121"];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;
}
- (UIButton *)exchangeButton{
    if (_exchangeButton == nil) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _exchangeButton.frame = CGRectMake(self.bgView.frame.size.width / 2, 0, kSystemWide / 2, footerViewH);
        _exchangeButton.backgroundColor = YBNavigationBarBgColor;
        [_exchangeButton setTitle:@"确认兑换" forState:UIControlStateNormal];
        [_exchangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_exchangeButton addTarget:self action:@selector(didExchange:) forControlEvents:UIControlEventTouchUpInside];
        _exchangeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _exchangeButton;
}

@end
