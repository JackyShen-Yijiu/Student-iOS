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
        

    }
    
    return self;
}

-(void)setJiFenBtn:(UIButton *)jiFenBtn {
    
    _jiFenBtn = jiFenBtn;
    
    _jiFenBtn.titleLabel.textColor = _jiFenBtn.titleLabel.textColor;
}
-(void)setDuiHuanJuanBtn:(UIButton *)duiHuanJuanBtn {
    _duiHuanJuanBtn = duiHuanJuanBtn;
    _duiHuanJuanBtn.titleLabel.textColor = _duiHuanJuanBtn.titleLabel.textColor;
}

-(void)setXianJinBtn:(UIButton *)xianJinBtn {
    _xianJinBtn = xianJinBtn;
    
    _xianJinBtn.titleLabel.textColor = _xianJinBtn.titleLabel.textColor;

}


@end
