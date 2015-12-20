//
//  SubmitVerificationController.m
//  studentDriving
//
//  Created by 胡东苑 on 15/12/15.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "SubmitVerificationController.h"
#import "ChooseBtnView.h"

@interface SubmitVerificationController ()

@property (nonatomic, strong) ChooseBtnView *cbv;
@property (nonatomic, strong)       UILabel *contentUpLb;
@property (nonatomic, strong)       UILabel *contentDownLb;
@property (nonatomic, strong)   UIImageView *imageView;
@property (strong, nonatomic)      UIButton *referButton;

@end

@implementation SubmitVerificationController

- (UIButton *)referButton{
    if (_referButton == nil) {
        _referButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _referButton.backgroundColor = MAINCOLOR;
        _referButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_referButton setTitle:@"完成" forState:UIControlStateNormal];
        [_referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_referButton addTarget:self action:@selector(dealRefer:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _referButton;
}

- (ChooseBtnView *)cbv {
    if (!_cbv) {
        _cbv = [[ChooseBtnView alloc] initWithSelectedBtn:2 leftTitle:@"验证手机号" midTitle:@"验证信息" rightTitle:@"提交验证" frame:CGRectMake(0, 74, kSystemWide, 67)];
        _cbv.backgroundColor = [UIColor whiteColor];
    }
    return _cbv;
}

- (UILabel *)contentUpLb {
    if (!_contentUpLb) {
        _contentUpLb = [[UILabel alloc] init];
        _contentUpLb.text = @"恭喜您，验证成功。";
        _contentUpLb.textColor = [UIColor redColor];
        _contentUpLb.font = [UIFont systemFontOfSize:12];
    }
    return _contentUpLb;
}

- (UILabel *)contentDownLb {
    if (!_contentDownLb) {
        _contentDownLb = [[UILabel alloc] init];
        _contentDownLb.text = @"一步学车将为您定制属于您的学车之路。";
        _contentDownLb.textColor = [UIColor redColor];
        _contentDownLb.font = [UIFont systemFontOfSize:12];
    }
    return _contentDownLb;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"iconfont-wancheng"];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBColor(245, 247, 250);
    self.title = @"验证报考驾校信息";
    
    [self.view addSubview:self.cbv];
    [self.view addSubview:self.contentUpLb];
    [self.view addSubview:self.contentDownLb];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.referButton];
}

- (void)viewWillLayoutSubviews {
    __weak typeof(self) weakSelf = self;
    
    [self.contentUpLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.cbv.mas_bottom).with.offset(21);
    }];
    [self.contentUpLb sizeToFit];
    
    [self.contentDownLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.contentUpLb.mas_bottom).with.offset(1);
    }];
    [self.contentDownLb sizeToFit];

    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.contentDownLb.mas_bottom).with.offset(35);
        make.size.mas_equalTo(CGSizeMake(72, 72));
    }];
    [self.referButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
}

- (void)dealRefer:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
