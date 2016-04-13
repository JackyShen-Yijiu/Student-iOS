//
//  JZAppointTestSuccessController.m
//  studentDriving
//
//  Created by ytzhang on 16/4/13.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZAppointTestSuccessController.h"

#define kMargin 25

@interface JZAppointTestSuccessController ()
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *appleLabel;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *bottomLabel;



@end

@implementation JZAppointTestSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交成功";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.appleLabel];
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.bottomLabel];
    
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
        _appleLabel.text = @"约考成功";
        _appleLabel.textAlignment  = NSTextAlignmentCenter;
        _appleLabel.textColor = JZ_BlueColor;
        _appleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _appleLabel;
}
- (UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.appleLabel.frame) + kMargin, kSystemWide, 14)];
        _topLabel.text = @"考试时间 2016/03/28";
        _topLabel.textAlignment  = NSTextAlignmentCenter;
        _topLabel.textColor = JZ_FONTCOLOR_DRAK;
        _topLabel.font = [UIFont systemFontOfSize:14];
    }
    return _topLabel;
}
- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topLabel.frame) + 5, kSystemWide, 14)];
        _bottomLabel.text = @"考试地点 北京致远驾校第一考试场";
        _bottomLabel.textAlignment  = NSTextAlignmentCenter;
        _bottomLabel.textColor = JZ_FONTCOLOR_DRAK;
        _bottomLabel.font = [UIFont systemFontOfSize:14];
    }
    return _bottomLabel;
}


@end
