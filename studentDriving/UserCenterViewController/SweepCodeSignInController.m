//
//  SweepCodeSignInController.m
//  studentDriving
//
//  Created by 大威 on 15/12/19.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "SweepCodeSignInController.h"

@interface SweepCodeSignInController ()

@property (nonatomic, strong) UIImageView *qrCodeImageView;
@property (nonatomic, strong) UIButton *markButton;
@property (nonatomic, strong) UIButton *doneButton;

@end

@implementation SweepCodeSignInController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"签到";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.qrCodeImageView];
    [self.view addSubview:self.markButton];
    [self.view addSubview:self.doneButton];
}

#pragma mark - action
- (void)doneButtonAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy load
- (UIImageView *)qrCodeImageView {
    if (!_qrCodeImageView) {
        _qrCodeImageView = [UIImageView new];
        _qrCodeImageView.backgroundColor = [UIColor orangeColor];
        CGFloat width = self.view.bounds.size.width / 2.f;
        CGFloat height = self.view.bounds.size.height / 2.f;
        _qrCodeImageView.frame = CGRectMake(0, 0, width, width);
        _qrCodeImageView.center = CGPointMake(width, height);
    }
    return _qrCodeImageView;
}
- (UIButton *)markButton {
    if (!_markButton) {
        _markButton = [UIButton new];
        [_markButton setTitle:@"每次签到自动更新" forState:UIControlStateNormal];
        CGFloat width = self.view.bounds.size.width / 2.f;
        _markButton.frame = CGRectMake(0, 0, width, 20);
        CGFloat height = self.view.bounds.size.height / 2.f;
        _markButton.center = CGPointMake(width, height + (width + 20) / 2.f);
        _markButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_markButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _markButton;
}
- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [UIButton new];
        _doneButton.backgroundColor = [UIColor orangeColor];
        CGFloat width = self.view.bounds.size.width;
        CGFloat height = self.view.bounds.size.height;
        _doneButton.frame = CGRectMake(0, height - 50, width, 50);
        [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _doneButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_doneButton addTarget:self action:@selector(doneButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
