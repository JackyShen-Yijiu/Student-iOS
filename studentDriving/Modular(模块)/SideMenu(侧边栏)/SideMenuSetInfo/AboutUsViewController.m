//
//  AboutUsViewController.m
//  studentDriving
//
//  Created by bestseller on 15/11/19.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UIImageView *bottomImageView;

@end

@implementation AboutUsViewController
- (UIImageView *)logoImageView {
    if (_logoImageView == nil) {
        
        _logoImageView = [[UIImageView alloc]init];
        
        _logoImageView.image = [UIImage imageNamed:@"icon_about"];
    
    }
    return _logoImageView;
}
- (UILabel *)topLabel {
    if (_topLabel == nil) {
        
        _topLabel = [[UILabel alloc]init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont boldSystemFontOfSize:14];
        _topLabel.text = @"极致驾服学员端 V1.2";
        _topLabel.textColor = RGBColor(219, 68, 55);
       
    }
    return _topLabel;
}

-(UIImageView *)bottomImageView {
    
    if (_bottomImageView == nil) {
        
        _bottomImageView = [[UIImageView alloc]init];
        _bottomImageView.image = [UIImage imageNamed:@"slogan"];
    
    }
    
    return _bottomImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于我们";
    
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.bottomImageView];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(94);
        make.height.mas_equalTo(@73);
        make.width.mas_equalTo(@73);
    }];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.logoImageView.mas_bottom).with.offset(24);
        make.height.mas_equalTo(@14);
    }];
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-24);
    }];

}



@end
