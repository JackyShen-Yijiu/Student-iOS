//
//  SignInViewController.m
//  studentDriving
//
//  Created by yyx on 15/12/31.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "SignInViewController.h"
#import "ToolHeader.h"
#import "UIBarButtonItem+JGBarButtonItem.h"
#import "SignInHelpViewController.h"
#import "DVVCreateQRCode.h"
#import "Masonry.h"

@interface SignInViewController ()

@property (nonatomic, strong) UIImageView *qrCodeImageView;
@property (nonatomic, strong) UIButton *completeButton;
@property (nonatomic, strong) UILabel *markLabel;

@property (nonatomic, strong) UILabel *explainTitleLabel;
@property (nonatomic, strong) UILabel *explainLabel;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"签到";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"使用帮助" highTitle:@"使用帮助" target:self action:@selector(helpDidClick) isRightItem:YES];
    
    [self.view addSubview:self.qrCodeImageView];
    [self.view addSubview:self.completeButton];
    [self.view addSubview:self.markLabel];
    [self.view addSubview:self.explainTitleLabel];
    [self.view addSubview:self.explainLabel];
    
    [self configUI];
    
    // 用户id
    NSString *userId = [AcountManager manager].userid;
    // 用户名
    NSString *userName = [AcountManager manager].userName;
    // 详细地址
    NSString *locationAddress = [AcountManager manager].locationAddress;
    // 当前的时间
    NSString *formatString = @"yyyy-MM-dd HH:mm:ss";
    NSString *currentTime = [self dateFromLocalWithFormatString:formatString];
    
    NSLog(@"%@", userId);
    NSLog(@"%@", userName);
    NSLog(@"locationAddress === %@", locationAddress);
    NSLog(@"%@",self.dataModel.ID);
    NSLog(@"%@",self.dataModel.coachDataModel.name);
    NSLog(@"%@",self.dataModel.courseProcessDesc);
    NSString *orderId = self.dataModel.ID;
    NSString *coachName = self.dataModel.coachDataModel.name;
    NSString *courseProcessDesc = self.dataModel.courseProcessDesc;
    
    NSDictionary *dict = @{ @"userId": userId,
                            @"userName": userName,
                            @"orderId": orderId,
                            @"currentTime": currentTime,
                            @"locationAddress": locationAddress,
                            @"coachName": coachName,
                            @"courseProcessDesc": courseProcessDesc };
    
    NSString *string = [NSString stringWithFormat:@"%@", dict];
    
    // 显示二维码
    [self showQRCodeImageWithContent:string];
}

- (NSString *)dateFromLocalWithFormatString:(NSString *)formatString {
    
    NSDate *localDate = [NSDate new];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter stringFromDate:localDate];
}

#pragma mark - action
- (void)completeButtonAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 根据内容加载二维码
- (void)showQRCodeImageWithContent:(NSString *)content {
    
    CGFloat size = 160;
    self.qrCodeImageView.image = [DVVCreateQRCode createQRCodeWithContent:content size:size];
}

#pragma mark - config UI
- (void)configUI {
    
    [_completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.left.and.bottom.with.right.equalTo(@0);
    }];
    
    [_qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@94);
        make.width.and.height.equalTo(@160);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    [_markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.qrCodeImageView.mas_bottom).offset(15);
    }];
    [_explainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64 + 15);
        make.height.equalTo(@20);
        make.left.with.right.mas_equalTo(15);
    }];
    [_explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.explainTitleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
}

#pragma mark - lazy load
- (UIImageView *)qrCodeImageView {
    if (!_qrCodeImageView) {
        _qrCodeImageView = [UIImageView new];
    }
    return _qrCodeImageView;
}
- (UIButton *)completeButton {
    if (!_completeButton) {
        _completeButton = [UIButton new];
        _completeButton.backgroundColor = MAINCOLOR;
        [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
        [_completeButton addTarget:self action:@selector(completeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeButton;
}

- (void)helpDidClick {
    NSLog(@"%s",__func__);
    
    SignInHelpViewController *vc = [[SignInHelpViewController alloc] init];
    vc.url = @"";
    [self.navigationController pushViewController:vc animated:YES];
}
- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [UILabel new];
        _markLabel.font = [UIFont systemFontOfSize:14];
        _markLabel.textAlignment = 1;
        _markLabel.text = @"扫一扫上面的二维码图案,立即签到";
    }
    return _markLabel;
}
- (UILabel *)explainTitleLabel {
    if (!_explainTitleLabel) {
        _explainTitleLabel = [UILabel new];
        _explainTitleLabel.font = [UIFont systemFontOfSize:13];
        _explainTitleLabel.text = @"签到须知:";
        _explainTitleLabel.textColor = [UIColor redColor];
    }
    return _explainTitleLabel;
}
- (UILabel *)explainLabel {
    if (!_explainLabel) {
        _explainLabel = [UILabel new];
        _explainLabel.numberOfLines = 0;
        _explainLabel.font = [UIFont systemFontOfSize:12];
        _explainLabel.text = @"        签到开放的时间为,预定学车开始前的15分钟至学车结束后15分钟，请您及时签到。如不签到，可能会影响您的学时记录以及教练的工时记录。\n如有疑问，请拨打400-626-9255";
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:8];//调整行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_explainLabel.text];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_explainLabel.text length])];
        _explainLabel.attributedText = attributedString;
    }
    return _explainLabel;
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

- (IBAction)completeBtnDidClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
