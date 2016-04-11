//
//  JZComplaintHeaderView.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZComplaintHeaderView.h"
#define kLKSize [UIScreen mainScreen].bounds.size
@implementation JZComplaintHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];

    }
    
    return self;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.headerLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(@(kLKSize.width * 0.5));
        make.height.equalTo(@42);
        
    }];
    
    [self.headerRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.headerLeftBtn.mas_right);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@42);
        
    }];
    
    [self.herderLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headerLeftBtn.mas_bottom);
        make.height.equalTo(@2);
        make.left.equalTo(self.headerLeftBtn.mas_left);
        make.width.equalTo(@(kLKSize.width * 0.5));
        
    }];
    
    
}
-(void)setUI {
    
    self.herderLineView.backgroundColor = YBNavigationBarBgColor;
    
}

#pragma mark - 懒加载
-(UIButton *)headerLeftBtn {
    
    if (!_headerLeftBtn) {
        
        UIButton *headerLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [headerLeftBtn setTitle:@"投诉教练" forState:UIControlStateNormal];
        
        [headerLeftBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [headerLeftBtn setTitleColor:YBNavigationBarBgColor forState:UIControlStateNormal];
        self.headerLeftBtn = headerLeftBtn;
        [self addSubview:headerLeftBtn];
    }
    
    return _headerLeftBtn;
    
}
-(UIButton *)headerRightBtn {
    
    if (!_headerRightBtn) {
        
        UIButton *headerRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [headerRightBtn setTitle:@"投诉驾校" forState:UIControlStateNormal];
        [headerRightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [headerRightBtn setTitleColor:TEXTGRAYCOLOR forState:UIControlStateNormal];
        [self addSubview:headerRightBtn];
        _headerRightBtn = headerRightBtn;
        
    }
    
    return _headerRightBtn;
    
}
-(UIView *)herderLineView {
    
    if (!_herderLineView) {
        
        UIView *herderLineView = [[UIView alloc]init];
        
        _herderLineView = herderLineView;
        
        [self addSubview:herderLineView];
        
    }
    
    return _herderLineView;
    
}



@end
