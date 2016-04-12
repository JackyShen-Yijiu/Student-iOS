//
//  JZAppointTestApplyController.m
//  studentDriving
//
//  Created by ytzhang on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZAppointTestApplyController.h"

#define kMargin 25

@interface JZAppointTestApplyController ()
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *appleLabel;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) UILabel *phoneLabe;


@end

@implementation JZAppointTestApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.appleLabel];
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.bottomLabel];
    [self.view addSubview:self.phoneLabe];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 221)];
        _imgView.image = [UIImage imageNamed:@"appointment_submit"];
    }
    return _imgView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame), kSystemWide, 14)];
        _titleLabel.text = @"恭喜您 预约成功";
        _titleLabel.textAlignment  = NSTextAlignmentCenter;
        _titleLabel.textColor = JZ_FONTCOLOR_DRAK;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}
- (UILabel *)appleLabel{
    if (_appleLabel == nil) {
        _appleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + kMargin, kSystemWide, 16)];
        _appleLabel.text = @"正在预约中...";
        _appleLabel.textAlignment  = NSTextAlignmentCenter;
        _appleLabel.textColor = YBNavigationBarBgColor;
        _appleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _appleLabel;
}
- (UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.appleLabel.frame) + kMargin, kSystemWide, 14)];
        _topLabel.text = @"我们将尽快代您预约考试";
        _topLabel.textAlignment  = NSTextAlignmentCenter;
        _topLabel.textColor = JZ_FONTCOLOR_LIGHT;
        _topLabel.font = [UIFont systemFontOfSize:14];
    }
    return _topLabel;
}
- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topLabel.frame) + 5, kSystemWide, 14)];
        _bottomLabel.text = @"一旦预约成功将会以短信形式通知您";
        _bottomLabel.textAlignment  = NSTextAlignmentCenter;
        _bottomLabel.textColor = JZ_FONTCOLOR_LIGHT;
        _bottomLabel.font = [UIFont systemFontOfSize:14];
    }
    return _bottomLabel;
}
- (UILabel *)phoneLabe{
    if (_phoneLabe == nil) {
        _phoneLabe = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bottomLabel.frame) + kMargin, kSystemWide, 14)];
        _phoneLabe.text = @"如有疑问请拨打客服: 400-2658-3726";
        _phoneLabe.textAlignment  = NSTextAlignmentCenter;
        _phoneLabe.textColor = JZ_FONTCOLOR_LIGHT;
        _phoneLabe.font = [UIFont systemFontOfSize:14];
    }
    return _phoneLabe;
}


@end
