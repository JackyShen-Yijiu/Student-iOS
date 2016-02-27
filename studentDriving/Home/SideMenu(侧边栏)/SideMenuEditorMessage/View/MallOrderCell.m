//
//  MallOrderCell.m
//  studentDriving
//
//  Created by zyt on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "MallOrderCell.h"

@interface MallOrderCell ()
@property (strong, nonatomic) UIImageView *mallImageView;
@property (strong, nonatomic) UILabel *mallName; // 商品名称
@property (strong, nonatomic) UILabel *exchangeMoney; // 兑换金额
@property (strong, nonatomic) UILabel *ordertime;     // 下单时间
@property (nonatomic, strong) UILabel *numberMoneyLabel; // 实付款
@property (nonatomic, strong) UILabel *numberMoney;
@property (nonatomic, strong) UILabel *payStaus; // 兑换状态
@property (strong, nonatomic) UIView *lineBottomView;

@property (nonatomic, strong) UIButton *offlineButton; // 线下重新报名



@end
@implementation MallOrderCell

- (UIImageView *)mallImageView {
    if (_mallImageView == nil) {
        _mallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
        _mallImageView.backgroundColor = MAINCOLOR;
        [_mallImageView.layer setMasksToBounds:YES];
        [_mallImageView.layer setCornerRadius:20];
    }
    return _mallImageView;
}

// 驾校姓名
- (UILabel *)mallName{
    if (_mallName == nil) {
        _mallName = [[UILabel alloc]init];
        _mallName.text = @"蓝牙耳机";
        _mallName.font = [UIFont systemFontOfSize:14];
        _mallName.textColor = [UIColor colorWithHexString:@"212121"];
    }
    return _mallName;
}
// 报考班型
- (UILabel *)exchangeMoney{
    if (_exchangeMoney == nil) {
        _exchangeMoney = [[UILabel alloc]init];
        _exchangeMoney.text = @"C1手动挡VIP专项班";
        _exchangeMoney.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _exchangeMoney.font = [UIFont systemFontOfSize:14];
    }
    return _exchangeMoney;
}
// 报名时间
- (UILabel *)ordertime{
    if (_ordertime == nil) {
        _ordertime = [[UILabel alloc]init];
        _ordertime.text = @"报名时间:2016-12-20";
        _ordertime.font = [UIFont systemFontOfSize:10];
        _ordertime.textColor = [UIColor colorWithHexString:@"bdbdbd"];
    }
    return _ordertime;
}

- (UILabel *)numberMoneyLabel {
    if (_numberMoneyLabel == nil) {
        _numberMoneyLabel = [[UILabel alloc] init];
        _numberMoneyLabel.font = [UIFont systemFontOfSize:10];
        _numberMoneyLabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _numberMoneyLabel.text = @"实付款:";
    }
    return _numberMoneyLabel;
}
- (UILabel *)numberMoney{
    if (_numberMoney == nil) {
        _numberMoney = [[UILabel alloc] init];
        _numberMoney.text = @"#3980";
        _numberMoney.font = [UIFont systemFontOfSize:10];
        _numberMoney.textColor = YBNavigationBarBgColor;
    }
    return _numberMoney;
}
- (UILabel *)payStaus{
    if (_payStaus == nil) {
        _payStaus = [[UILabel alloc] init];
        _payStaus.text = @"未支付";
        _payStaus.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _payStaus.font = [UIFont systemFontOfSize:10];
        _payStaus.textAlignment = NSTextAlignmentRight;
    }
    return _payStaus;
}

- (UIView *)lineBottomView{
    
    if (_lineBottomView == nil) {
        _lineBottomView = [[UIView alloc] init];
        _lineBottomView.backgroundColor = HM_LINE_COLOR;
        
    }
    return _lineBottomView;
}
// 线下
- (UIButton *)offlineButton{
    if (_offlineButton == nil) {
        _offlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _offlineButton.backgroundColor = [UIColor clearColor];
        [_offlineButton setTitle:@"再次兑换" forState:UIControlStateNormal];
        [_offlineButton setTitleColor:YBNavigationBarBgColor forState:UIControlStateSelected];
        [_offlineButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
        _offlineButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _offlineButton.selected = YES;
        if (_offlineButton.selected) {
            _offlineButton.layer.borderWidth = 1;
            _offlineButton.layer.borderColor = YBNavigationBarBgColor.CGColor;
        }
        if (!_offlineButton.selected) {
            _offlineButton.layer.borderWidth = 1;
            _offlineButton.layer.borderColor = [UIColor colorWithHexString:@"bdbdbd"].CGColor;
        }
        [_offlineButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        _offlineButton.tag = 400;
        
    }
    return _offlineButton;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCellUI];
    }
    return self;
}
- (void)createCellUI {
    [self addSubview:self.mallImageView];
    [self addSubview:self.mallName];
    [self addSubview:self.exchangeMoney];
    [self addSubview:self.ordertime];
    [self addSubview:self.numberMoneyLabel];
    [self addSubview:self.numberMoney];
    [self addSubview:self.payStaus];
    [self addSubview:self.lineBottomView];
    [self addSubview:self.offlineButton];
    
}
#pragma mark -----ActionTarget
- (void)didClick:(UIButton *)btn{
    if (_didclickBlock) {
        _didclickBlock(btn.tag);
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.mallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@40);
        
    }];
    [self.mallName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mallImageView.mas_right).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.height.mas_equalTo(@14);
    }];
    
    [self.exchangeMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mallImageView.mas_right).offset(20);
        make.top.mas_equalTo(self.mallName.mas_bottom).offset(15);
        make.height.mas_equalTo(@10);
    }];
    [self.ordertime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mallImageView.mas_right).offset(20);
        make.top.mas_equalTo(self.exchangeMoney.mas_bottom).offset(15);
        make.height.mas_equalTo(@10);
    }];
    [self.numberMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.mas_top).offset(40);
        make.height.mas_equalTo(@14);
    }];
    
    [self.numberMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.numberMoney.mas_left).offset(-3);
        make.top.mas_equalTo(self.mas_top).offset(42);
        make.height.mas_equalTo(@10);
    }];
    [self.payStaus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.ordertime.mas_top).offset(0);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@50);
    }];
    [self.lineBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mallName.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.top.mas_equalTo(self.ordertime.mas_bottom).offset(15);
        make.height.mas_equalTo(@0.5);
        
    }];
    [self.offlineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.top.mas_equalTo(self.lineBottomView.mas_bottom).offset(10);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@80);
        
    }];
    
    
}
- (void)setListModel:(MallOrderListModel *)listModel{
    
    [self.mallImageView sd_setImageWithURL:[NSURL URLWithString:listModel.productimg] placeholderImage:nil];
    self.mallName.text = listModel.productname;
    self.exchangeMoney.text = [NSString stringWithFormat:@"兑换金额:%luYB",listModel.productprice];
    self.ordertime.text = listModel.createtime;
    self.numberMoney.text = [NSString stringWithFormat:@"%luYB",listModel.productprice];
    
    /*
     exports.MallOrderState={
     // 已申请
     applying:1,
     // 已确定 接受
     applyconfirm:2,
     //拒绝或者取消）
     applyrefuse:3,
     //  已发送
     sended:4,
     // 已完成
     finished:5
     
     }
     */
    
    if (1 == listModel.orderstate) {
        self.payStaus.text = @"已申请";
        
    }
    if (2 == listModel.orderstate) {
        self.payStaus.text = @"已确认";
        
    }
    if (3 == listModel.orderstate) {
        self.payStaus.text = @"已发送";
        
    }
    if (4 == listModel.orderstate) {
        self.payStaus.text = @"已拒绝";
        
    }
    if (5 == listModel.orderstate) {
        self.payStaus.text = @"已完成";
        
    }
    
    
    
    
    /*
     self.dict = @{@"headerUrl":self.headerImageURl,
     @"schoolStr":self.schoolStr,
     @"carModelStr":self.carModelStr,
     @"signUpStr":self.signUpStr,
     @"realMoneyStr":self.realMoneyStr,
     @"payStausStr":self.payStausStr,
     @"payWaystr":self.payWaystr,
     @"applySatus":self.applySatus};
     */
//    _dict = dict;
//    NSLog(@"_%@",_dict);
//    self.mallName.text = [dict objectForKey:@"schoolStr"];
//    [self.mallImageView sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"headerUrl"]] placeholderImage:nil];
//    self.carNameLabel.text = [dict objectForKey:@"carModelStr"];
//    self.signUptime.text = [dict objectForKey:@"signUpStr"];
//    self.numberMoney.text = [NSString stringWithFormat:@"¥%@",[dict objectForKey:@"realMoneyStr"]];
//    self.payWay.text = [NSString stringWithFormat:@"(%@)",[dict objectForKey:@"payWaystr"]];
//    
//    // 线上支付状态
//    self.payStaus.text = [dict objectForKey:@"payStausStr"];
//    if ([[dict objectForKey:@"payWaystr"] isEqualToString:@"线上支付"]) {
//        if ([[dict objectForKey:@"payStausStr"] isEqualToString:@"未支付"]) {
//            _onlineButton.hidden = NO;
//            _payButton.hidden = NO;
//        }
//        if ([[dict objectForKey:@"payStausStr"] isEqualToString:@"支付失败"]) {
//            _onlineButton.hidden = NO;
//            _payButton.hidden = NO;
//            
//        }
//    }
//    
//    
//    // 线下支付状态
//    if ([[dict objectForKey:@"payWaystr"] isEqualToString:@"线下支付"]) {
//        if ([[dict objectForKey:@"applySatus"] isEqualToString:@"申请中"]) {
//            self.payStaus.text = @"未验证";
//            _offlineButton.hidden = NO;
//        }
//        if ([[dict objectForKey:@"applySatus"] isEqualToString:@"申请成功"]) {
//            self.payStaus.text = @"报名成功";
//        }
//    }
}

@end
