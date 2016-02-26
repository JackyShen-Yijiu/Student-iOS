//
//  YBIntegrationMessageController.m
//  studentDriving
//
//  Created by zyt on 16/2/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBIntegrationMessageController.h"
#import "YBIntegrationMessageCell.h"

@interface YBIntegrationMessageController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIButton *exchangeButton;
@end

@implementation YBIntegrationMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"bdbdbd"];
    [self.view addSubview:self.tabelView];
    [self initData];
    
}
- (void)initData{
    self.titleArray = @[@"商品名称",@"兑换积分",@"配送方式",@"邮寄地址",@"收货人姓名",@"联系电话"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (_mallType == kIntegralMall) {
//        return self.shopMainListArray.count;
//    }else if (_mallType == kDiscountMall){
//        return self.discountArray.count;
//    }
//    return 0;
    return self.titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 79.7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID =@"IntegralMallID";
     YBIntegrationMessageCell *mallCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!mallCell) {
        mallCell = [[YBIntegrationMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (0 == indexPath.row || 1 == indexPath.row || 2 == indexPath.row || 3 == indexPath.row ) {
        mallCell.describleTextField.userInteractionEnabled = NO;
    }
    mallCell.titleLabel.text = self.titleArray[indexPath.row];
    return mallCell;
    
//    if (_mallType == kIntegralMall) {
//        // 加载积分商城
//        NSString *cellID =@"MallCellID";
//        YBIntegralMallCell *mallCell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        if (!mallCell) {
//            mallCell = [[YBIntegralMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//            mallCell.backgroundColor = [UIColor clearColor];
//        }
//        mallCell.integralMallModel = self.shopMainListArray[indexPath.row];
//        return mallCell;
//    }else if (_mallType == kDiscountMall){
//        // 加载兑换券商城
//        NSString *cellID =@"DiscountCellID";
//        YBDiscountCell *mallCell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        if (!mallCell) {
//            mallCell = [[YBDiscountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//            mallCell.backgroundColor = [UIColor clearColor];
//        }
//        mallCell.discountModel = self.discountArray[indexPath.row];
//        return mallCell;
//    }
    
}

#pragma mark ---- Lazy 加载
- (UITableView *)tabelView{
    if (_tabelView == nil) {
        _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 50) style:UITableViewStylePlain];
        _tabelView.backgroundColor = [UIColor clearColor];
        _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tabelView.delegate = self;
        self.tabelView.dataSource  = self;
    }
    return _tabelView;
    
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(15, kSystemHeight - 114, kSystemWide - 30, 50)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 18, 150, 14)];
        if (0 == _mallWay) {
            // 积分商城
//            _moneyLabel.text = [NSString stringWithFormat:@"需要消费积分:%d",_integralModel.productprice];
        }else if (1 == _mallWay){
            // 兑换劵商城
            _moneyLabel.text = @"需要消费一张兑换劵";
        }
        _moneyLabel.font = [UIFont systemFontOfSize:14];
        _moneyLabel.textColor = YBNavigationBarBgColor;
    }
    return _moneyLabel;
}
- (UIButton *)exchangeButton{
    if (_exchangeButton == nil) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _exchangeButton.frame = CGRectMake(self.bgView.frame.size.width - 100, 7.5, 100, 35);
        _exchangeButton.backgroundColor = YBNavigationBarBgColor;
        [_exchangeButton setTitle:@"立即兑换" forState:UIControlStateNormal];
        [_exchangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_exchangeButton addTarget:self action:@selector(didExchange:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeButton;
}

@end
