//
//  SignUpDetailCell.m
//  studentDriving
//
//  Created by zyt on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SignUpDetailCell.h"
#import "ToolHeader.h"
#import <Masonry.h>
#import "CoachDMData.h"
#import "CoachModel.h"
#import "RatingBar.h"

@interface SignUpDetailCell ()
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *schoolName; // 驾校姓名
@property (strong, nonatomic) UILabel *payWay; // 支付方式
@property (strong, nonatomic) UILabel *carNameLabel; // 报考车型
@property (strong, nonatomic) UILabel *signUptime;     // 报名时间
@property (nonatomic, strong) UILabel *numberMoneyLabel; // 实付款
@property (nonatomic, strong) UILabel *numberMoney;
@property (nonatomic, strong) UILabel *payStaus; // 支付状态
@property (strong, nonatomic) UIView *lineBottomView;

@property (nonatomic, strong) UIButton *offlineButton; // 线下重新报名
@property (nonatomic, strong) UIButton *onlineButton; // 线上重新报名
@property (nonatomic, strong) UIButton *payButton; // 支付



@end
@implementation SignUpDetailCell

- (UIImageView *)headImageView {
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
        _headImageView.backgroundColor = MAINCOLOR;
        [_headImageView.layer setMasksToBounds:YES];
        [_headImageView.layer setCornerRadius:20];
    }
    return _headImageView;
}

// 驾校姓名
- (UILabel *)schoolName{
    if (_schoolName == nil) {
        _schoolName = [[UILabel alloc]init];
        _schoolName.font = [UIFont systemFontOfSize:14];
        _schoolName.textColor = [UIColor colorWithHexString:@"212121"];
    }
    return _schoolName;
}
// 支付方式
- (UILabel *)payWay{
    if (_payWay == nil) {
        _payWay = [[UILabel alloc]init];
        _payWay.text = @"(线上)";
        _payWay.font = [UIFont systemFontOfSize:10];
        _payWay.textColor = [UIColor colorWithHexString:@"bdbdbd"];
    }
    return _payWay;
}
// 报考班型
- (UILabel *)carNameLabel{
    if (_carNameLabel == nil) {
        _carNameLabel = [[UILabel alloc]init];
        _carNameLabel.text = @"C1手动挡VIP专项班";
        _carNameLabel.textColor = [UIColor colorWithHexString:@"bdbddb"];
        _carNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _carNameLabel;
}
// 报名时间
- (UILabel *)signUptime{
    if (_signUptime == nil) {
        _signUptime = [[UILabel alloc]init];
        _signUptime.text = @"报名时间:2016-12-20";
        _signUptime.font = [UIFont systemFontOfSize:10];
        _signUptime.textColor = [UIColor colorWithHexString:@"bdbdbd"];
    }
    return _signUptime;
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
        _numberMoney.textColor = [UIColor colorWithHexString:@"bd4437"];
    }
    return _numberMoney;
}
- (UILabel *)payStaus{
    if (_payStaus == nil) {
        _payStaus = [[UILabel alloc] init];
        _payStaus.text = @"未支付";
        _payStaus.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _payStaus.font = [UIFont systemFontOfSize:10];
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
        [_offlineButton setTitle:@"重新报名" forState:UIControlStateNormal];
        [_offlineButton setTitleColor:YBNavigationBarBgColor forState:UIControlStateSelected];
        [_offlineButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
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
        _offlineButton.hidden = YES;
        _offlineButton.tag = 400;
        
    }
    return _offlineButton;
}
// 线上
- (UIButton *)onlineButton{
    if (_onlineButton == nil) {
        _onlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _onlineButton.backgroundColor = [UIColor clearColor];
        [_onlineButton setTitle:@"重新报名" forState:UIControlStateNormal];
        [_onlineButton setTitleColor:YBNavigationBarBgColor forState:UIControlStateSelected];
        [_onlineButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
        _onlineButton.selected = YES;
        if (_onlineButton.selected) {
            _onlineButton.layer.borderWidth = 1;
            _onlineButton.layer.borderColor = YBNavigationBarBgColor.CGColor;
        }
        if (!_onlineButton.selected) {
            _onlineButton.layer.borderWidth = 1;
            _onlineButton.layer.borderColor = [UIColor colorWithHexString:@"bdbdbd"].CGColor;
        }
        [_onlineButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        _onlineButton.hidden = YES;
        _onlineButton.tag = 401;
        
    }
    return _onlineButton;
}
- (UIButton *)payButton{
    if (_payButton == nil) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.backgroundColor = [UIColor clearColor];
        [_payButton setTitle:@"立即支付" forState:UIControlStateNormal];
        [_payButton setTitleColor:YBNavigationBarBgColor forState:UIControlStateSelected];
        [_payButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
        _payButton.selected = NO;
        if (_payButton.selected) {
            _payButton.layer.borderWidth = 1;
            _payButton.layer.borderColor = YBNavigationBarBgColor.CGColor;
        }
        if (!_payButton.selected) {
            _payButton.layer.borderWidth = 1;
            _payButton.layer.borderColor = [UIColor colorWithHexString:@"bdbdbd"].CGColor;
        }
        [_payButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        _payButton.hidden = YES;
        _payButton.tag = 402;
        
    }
    return _payButton;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCellUI];
    }
    return self;
}
- (void)createCellUI {
    [self addSubview:self.headImageView];
    [self addSubview:self.schoolName];
    [self addSubview:self.payWay];
    [self addSubview:self.carNameLabel];
    [self addSubview:self.signUptime];
    [self addSubview:self.numberMoneyLabel];
    [self addSubview:self.numberMoney];
    [self addSubview:self.payStaus];
    [self addSubview:self.lineBottomView];
    [self addSubview:self.offlineButton];
    [self addSubview:self.onlineButton];
    [self addSubview:self.payButton];
}
#pragma mark -----ActionTarget
- (void)didClick:(UIButton *)btn{
    if (_didclickBlock) {
        _didclickBlock(btn.tag);
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@40);
        
    }];
    [self.schoolName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.height.mas_equalTo(@14);
    }];
    [self.payWay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.schoolName.mas_right).offset(5);
        make.top.mas_equalTo(self.mas_top).offset(17);
        make.height.mas_equalTo(@10);
    }];

    [self.carNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(20);
        make.top.mas_equalTo(self.schoolName.mas_bottom).offset(15);
        make.height.mas_equalTo(@10);
    }];
    [self.signUptime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(20);
        make.top.mas_equalTo(self.carNameLabel.mas_bottom).offset(15);
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
        make.top.mas_equalTo(self.signUptime.mas_top).offset(0);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@50);
    }];
    [self.lineBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.schoolName.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.top.mas_equalTo(self.signUptime.mas_bottom).offset(15);
        make.height.mas_equalTo(@0.5);
        
    }];
    [self.offlineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.top.mas_equalTo(self.lineBottomView.mas_bottom).offset(10);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@100);
        
    }];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.top.mas_equalTo(self.lineBottomView.mas_bottom).offset(10);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@100);
        
    }];
    [self.onlineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.payButton.mas_left).offset(-15);
        make.top.mas_equalTo(self.lineBottomView.mas_bottom).offset(10);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@100);
        
    }];

    
}
- (void)setDict:(NSDictionary *)dict{
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
    _dict = dict;
    NSLog(@"_%@",_dict);
    self.schoolName.text = [dict objectForKey:@"schoolStr"];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"headerUrl"]] placeholderImage:nil];
    self.carNameLabel.text = [dict objectForKey:@"carModelStr"];
    self.signUptime.text = [dict objectForKey:@"signUpStr"];
    self.numberMoney.text = [NSString stringWithFormat:@"¥%@",[dict objectForKey:@"realMoneyStr"]];
    self.payWay.text = [NSString stringWithFormat:@"(%@)",[dict objectForKey:@"payWaystr"]];
    
    // 线上支付状态
    self.payStaus.text = [dict objectForKey:@"payStausStr"];
    if ([[dict objectForKey:@"payWaystr"] isEqualToString:@"线上支付"]) {
        if ([[dict objectForKey:@"payStausStr"] isEqualToString:@"未支付"]) {
            _onlineButton.hidden = NO;
            _payButton.hidden = NO;
        }
        if ([[dict objectForKey:@"payStausStr"] isEqualToString:@"支付失败"]) {
            _onlineButton.hidden = NO;
            _payButton.hidden = NO;

        }
    }

    
    // 线下支付状态
        if ([[dict objectForKey:@"payWaystr"] isEqualToString:@"线下支付"]) {
        if ([[dict objectForKey:@"applySatus"] isEqualToString:@"申请中"]) {
            self.payStaus.text = @"未验证";
            _offlineButton.hidden = NO;
        }
        if ([[dict objectForKey:@"applySatus"] isEqualToString:@"申请成功"]) {
            self.payStaus.text = @"报名成功";
        }
    }
}


- (void)receivedCellModelWith:(CoachModel *)coachModel {
    
    
    
}

- (void)refreshData:(CoachDMData *)coachModel {
    
        
    
    
}
@end
