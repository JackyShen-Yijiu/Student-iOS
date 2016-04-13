//
//  JZJiFenHeaderView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletHeaderView.h"
#define kLKSize [UIScreen mainScreen].bounds.size

@implementation JZMyWalletHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"JZMyWalletHeaderView" owner:self options:nil].lastObject;
        
        self.frame = CGRectMake(0, 0, kLKSize.width,238);
        
        
        _goToOthersBtn.layer.masksToBounds = YES;
        _goToOthersBtn.layer.cornerRadius = 15;
        _goToOthersBtn.layer.borderWidth = 2;
        _goToOthersBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        
        
        [self.jiFenBtn addTarget:self action:@selector(clickJiFenBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.duiHuanJuanBtn addTarget:self action:@selector(clickDuiHuanJuanBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.xianJinBtn addTarget:self action:@selector(clickXianJinBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

#pragma mark - 点击积分
-(void)clickJiFenBtn {
    
    [self.jiFenBtn setTitleColor:RGBColor(219, 68, 55) forState:UIControlStateNormal];
    self.duiHuanJuanBtn.titleLabel.textColor = RGBColor(110, 110, 110);
    self.xianJinBtn.titleLabel.textColor = RGBColor(110, 110, 110);
    self.howDoBtn.hidden = NO;

    [self.headerImg setImage:[UIImage imageNamed:@"wallet_integral"]];
    [self.goToOthersBtn setTitle:@"积分商城" forState:UIControlStateNormal];
    _goToOthersBtn.layer.borderWidth = 2;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.rollLineView.transform = CGAffineTransformMakeTranslation(0,0);
        
    }];
}
#pragma mark - 点击兑换券
-(void)clickDuiHuanJuanBtn {
    [self.duiHuanJuanBtn setTitleColor:RGBColor(219, 68, 55) forState:UIControlStateNormal];
    self.jiFenBtn.titleLabel.textColor = RGBColor(110, 110, 110);
    self.xianJinBtn.titleLabel.textColor = RGBColor(110, 110, 110);
    
    [self.headerImg setImage:[UIImage imageNamed:@"wallet_ticket"]];
    [self.goToOthersBtn setTitle:@"" forState:UIControlStateNormal];
    self.howDoBtn.hidden = YES;

_goToOthersBtn.layer.borderWidth = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.rollLineView.transform = CGAffineTransformMakeTranslation(kLKSize.width/3,0);
        
        
    }];}
#pragma mark - 点击现金
-(void)clickXianJinBtn {
    [self.xianJinBtn setTitleColor:RGBColor(219, 68, 55) forState:UIControlStateNormal];
    self.jiFenBtn.titleLabel.textColor = RGBColor(110, 110, 110);
    self.duiHuanJuanBtn.titleLabel.textColor = RGBColor(110, 110, 110);
     [self.headerImg setImage:[UIImage imageNamed:@"wallet_cash"]];
    [self.goToOthersBtn setTitle:@"立即提现" forState:UIControlStateNormal];

    _goToOthersBtn.layer.borderWidth = 2;

    self.howDoBtn.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.rollLineView.transform = CGAffineTransformMakeTranslation(kLKSize.width/3*2,0);
        
        
    }];
}


@end
