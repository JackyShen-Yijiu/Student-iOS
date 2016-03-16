//
//  SignUpDetailCell.m
//  studentDriving
//
//  Created by zyt on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SignUpDetailCell.h"

#import <Masonry.h>
#import "CoachDMData.h"
#import "CoachModel.h"
#import "RatingBar.h"

@interface SignUpDetailCell ()

@property  (strong, nonatomic) UIView *bgView; // 顶部视图
@property (nonatomic, strong) UILabel *titleLabel; // 视图title (显示订单未支付或者不显示)
@property (nonatomic, strong) UIView *bgLineView; // 底部分割线

@property (nonatomic, strong) UIView *mightBGView;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *schoolName; // 驾校姓名
//@property (strong, nonatomic) UILabel *payWay; // 支付方式
@property (strong, nonatomic) UILabel *carNameLabel; // 报考车型
@property (strong, nonatomic) UILabel *signUptime;     // 报名时间
@property (nonatomic, strong) UILabel *numberMoneyLabel; // 实付款
@property (nonatomic, strong) UILabel *numberMoney;
@property (nonatomic, strong) UILabel *payStaus; // 支付状态
@property (strong, nonatomic) UIView *lineBottomView;

//@property (nonatomic, strong) UIButton *offlineButton; // 继续支付

@property (nonatomic, strong) UIView *bottomBG;
@property (nonatomic, strong) UIButton *cancelButton; // 取消订单
@property (nonatomic, strong) UIButton *payButton; // 继续支付



@end
@implementation SignUpDetailCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCellUI];
    }
    return self;
}
- (void)createCellUI {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.bgLineView];
    
    
    [self addSubview:self.mightBGView];
    [self.mightBGView addSubview:self.headImageView];
    [self.mightBGView addSubview:self.schoolName];
    [self.mightBGView addSubview:self.carNameLabel];
    [self.mightBGView addSubview:self.signUptime];
    [self.mightBGView addSubview:self.numberMoneyLabel];
    [self.mightBGView addSubview:self.numberMoney];
    [self.mightBGView addSubview:self.payStaus];
    [self.mightBGView addSubview:self.lineBottomView];
    
    

    [self addSubview:self.bottomBG];
    [self.bottomBG addSubview:self.cancelButton];
    [self.bottomBG addSubview:self.payButton];
}
#pragma mark -----ActionTarget
- (void)didClick:(UIButton *)btn{
    NSLog(@"%lu",btn.tag);
    if (_didclickBlock) {
        _didclickBlock(btn.tag);
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@50);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(18);
        make.centerX.mas_equalTo(self.bgView);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@70);
    }];
    [self.bgLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.height.mas_equalTo(@0.5);
    }];
    
    
    [self.mightBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.height.mas_equalTo(@98);
         make.right.mas_equalTo(self.mas_right).offset(0);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mightBGView.mas_top).offset(15);
        make.left.mas_equalTo(self.mightBGView.mas_left).offset(20);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@40);
        
    }];
    [self.schoolName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(20);
        make.top.mas_equalTo(self.headImageView.mas_top);
        make.height.mas_equalTo(@14);
    }];
//    [self.payWay mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.schoolName.mas_right).offset(5);
//        make.top.mas_equalTo(self.headImageView.mas_top).offset(17);
//        make.height.mas_equalTo(@10);
//    }];

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
        make.right.mas_equalTo(self.mightBGView.mas_right).offset(-20);
        make.top.mas_equalTo(self.schoolName.mas_top);
        make.height.mas_equalTo(@14);
    }];

    [self.numberMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.numberMoney.mas_left).offset(-3);
        make.top.mas_equalTo(self.numberMoney.mas_top);
        make.height.mas_equalTo(@10);
    }];
    [self.payStaus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mightBGView.mas_right).offset(-20);
        make.top.mas_equalTo(self.signUptime.mas_top).offset(0);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@50);
    }];
    [self.lineBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mightBGView.mas_left).offset(0);
        make.right.mas_equalTo(self.mightBGView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.mightBGView.mas_bottom).offset(0);
        make.height.mas_equalTo(@0.5);
        
    }];
//    [self.offlineButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.mas_right).offset(-15);
//        make.top.mas_equalTo(self.lineBottomView.mas_bottom).offset(10);
//        make.height.mas_equalTo(@30);
//        make.width.mas_equalTo(@100);
//        
//    }];
    
    [self.bottomBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.top.mas_equalTo(self.lineBottomView.mas_bottom).offset(0);
        make.height.mas_equalTo(@50);
       make.left.mas_equalTo(self.mas_left).offset(0);
    }];
    
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomBG.mas_right).offset(-15);
        make.top.mas_equalTo(self.bottomBG.mas_top).offset(10);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@80);
        
    }];

    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.payButton.mas_left).offset(-15);
        make.top.mas_equalTo(self.payButton.mas_top);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@80);
        
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
//    self.payWay.text = [NSString stringWithFormat:@"(%@)",[dict objectForKey:@"payWaystr"]];
    
    // 线上支付状态
    self.payStaus.text = [dict objectForKey:@"payStausStr"];
//    if ([[dict objectForKey:@"payWaystr"] isEqualToString:@"线上支付"]) {
        if ([[dict objectForKey:@"payStausStr"] isEqualToString:@"未支付"]) {
            _bottomBG.hidden = NO;
        }
        if ([[dict objectForKey:@"payStausStr"] isEqualToString:@"支付失败"]) {
            _bottomBG.hidden = NO;

        }
    if ([[dict objectForKey:@"payStausStr"] isEqualToString:@"支付成功"]) {
        _bottomBG.hidden = YES;
        _bgView.hidden = YES;
        [self.mightBGView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mas_top).offset(0);
                make.left.mas_equalTo(self.mas_left).offset(0);
                make.height.mas_equalTo(@98);
                make.right.mas_equalTo(self.mas_right).offset(0);
           
        }];
        
    }
//    }

    
    // 线下支付状态
        if ([[dict objectForKey:@"payWaystr"] isEqualToString:@"线下支付"]) {
        if ([[dict objectForKey:@"applySatus"] isEqualToString:@"申请中"]) {
            self.payStaus.text = @"未验证";
//            _offlineButton.hidden = NO;
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
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"订单未支付";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = YBNavigationBarBgColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIView *)bgLineView{
    if (_bgLineView == nil) {
        _bgLineView = [[UIView alloc] init];
        _bgLineView.backgroundColor = HM_LINE_COLOR;
    }
    return _bgLineView;
}




- (UIView *)mightBGView{
    if (_mightBGView == nil) {
        _mightBGView = [[UIView alloc] init];
        _mightBGView.backgroundColor = [UIColor whiteColor];
    }
    return _mightBGView;
}

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
//// 支付方式
//- (UILabel *)payWay{
//    if (_payWay == nil) {
//        _payWay = [[UILabel alloc]init];
//        _payWay.text = @"(线上)";
//        _payWay.font = [UIFont systemFontOfSize:10];
//        _payWay.textColor = [UIColor colorWithHexString:@"bdbdbd"];
//    }
//    return _payWay;
//}
// 报考班型
- (UILabel *)carNameLabel{
    if (_carNameLabel == nil) {
        _carNameLabel = [[UILabel alloc]init];
        _carNameLabel.text = @"C1手动挡VIP专项班";
        _carNameLabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
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
//// 线下
//- (UIButton *)offlineButton{
//    if (_offlineButton == nil) {
//        _offlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _offlineButton.backgroundColor = [UIColor clearColor];
//        [_offlineButton setTitle:@"重新报名" forState:UIControlStateNormal];
//        [_offlineButton setTitleColor:YBNavigationBarBgColor forState:UIControlStateSelected];
//        [_offlineButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
//        _offlineButton.selected = YES;
//        if (_offlineButton.selected) {
//            _offlineButton.layer.borderWidth = 1;
//            _offlineButton.layer.borderColor = YBNavigationBarBgColor.CGColor;
//        }
//        if (!_offlineButton.selected) {
//            _offlineButton.layer.borderWidth = 1;
//            _offlineButton.layer.borderColor = [UIColor colorWithHexString:@"bdbdbd"].CGColor;
//        }
//    [_offlineButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
//        _offlineButton.hidden = YES;
//        _offlineButton.tag = 400;
//
//    }
//    return _offlineButton;
//}
// 线上
- (UIView *)bottomBG{
    if (_bottomBG == nil) {
        _bottomBG = [[UIView alloc] init];
        _bottomBG.backgroundColor = [UIColor whiteColor];
        _bottomBG.hidden = YES;
    }
    return _bottomBG;
}
- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = [UIColor clearColor];
        [_cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:YBNavigationBarBgColor forState:UIControlStateSelected];
        [_cancelButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
        _cancelButton.selected = YES;
        if (_cancelButton.selected) {
            _cancelButton.layer.borderWidth = 1;
            _cancelButton.layer.borderColor = YBNavigationBarBgColor.CGColor;
        }
        if (!_cancelButton.selected) {
            _cancelButton.layer.borderWidth = 1;
            _cancelButton.layer.borderColor = [UIColor colorWithHexString:@"bdbdbd"].CGColor;
        }
        [_cancelButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.tag = 401;
        
    }
    return _cancelButton;
}
- (UIButton *)payButton{
    if (_payButton == nil) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.backgroundColor = [UIColor clearColor];
        [_payButton setTitle:@"继续支付" forState:UIControlStateNormal];
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
        _payButton.tag = 402;
        
    }
    return _payButton;
}

@end
