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
@property (strong, nonatomic) UILabel *topLabelOne;
@property (strong, nonatomic) UILabel *topLabelTwo;

@end

@implementation AboutUsViewController
- (UIImageView *)logoImageView {
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"loginLogo"];
    }
    return _logoImageView;
}
- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont boldSystemFontOfSize:14];
        _topLabel.text = @"极致驾服";
    }
    return _topLabel;
}
- (UILabel *)topLabelOne {
    if (_topLabelOne == nil) {
        _topLabelOne = [[UILabel alloc] init];
        _topLabelOne.textAlignment = NSTextAlignmentCenter;
        _topLabelOne.font = [UIFont boldSystemFontOfSize:14];
        _topLabelOne.text = @"极致驾服,专注学车美一步!";
    }
    return _topLabelOne;
}
- (UILabel *)topLabelTwo {
    if (_topLabelTwo == nil) {
        _topLabelTwo = [[UILabel alloc] init];
        _topLabelTwo.textAlignment = NSTextAlignmentCenter;
        _topLabelTwo.font = [UIFont boldSystemFontOfSize:14];
        _topLabelTwo.text = @"V 1.0.0";
    }
    return _topLabelTwo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于我们";
    
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.topLabelOne];
    [self.view addSubview:self.topLabelTwo];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(100);
        make.height.mas_equalTo(@90);
        make.width.mas_equalTo(@90);
    }];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.logoImageView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@44);
    }];
    [self.topLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.topLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@44);
    }];
    [self.topLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.topLabelOne.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@44);
    }];
}



@end
