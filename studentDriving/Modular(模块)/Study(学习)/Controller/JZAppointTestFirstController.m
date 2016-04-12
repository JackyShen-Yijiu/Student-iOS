//
//  JZAppointTestFirstController.m
//  studentDriving
//
//  Created by ytzhang on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZAppointTestFirstController.h"
#import "YBAppointTestViewController.h"
#import "JZAppiontTestMessageController.h"

#define kLeftW 28
#define kMarginH 14

@interface JZAppointTestFirstController ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *titleDesLabel;

@property (nonatomic, strong) UILabel *titleWebLabel;

@property (nonatomic, strong) UILabel *titleProcessLabel;

@property (nonatomic, strong) UILabel *appinotDesLabel;

@property (nonatomic, strong) UIButton *appiontButton;

@end

@implementation JZAppointTestFirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要预约";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.titleDesLabel];
    [self.view addSubview:self.titleWebLabel];
    [self.view addSubview:self.titleProcessLabel];
    [self.view addSubview:self.appinotDesLabel];
    [self.view addSubview:self.appiontButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }

#pragma  mark -- Action
- (void)appointSchool:(UIButton *)btn{
    JZAppiontTestMessageController * appiontTestVC  = [[JZAppiontTestMessageController alloc] init];
    [self.navigationController pushViewController:appiontTestVC animated:YES];
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftW, kMarginH +  10, 200, 14)];
        _titleLabel.text = @"自主考试说明";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = YBNavigationBarBgColor;
        
    }
    return _titleLabel;
}
- (UILabel *)titleDesLabel{
    if (_titleDesLabel == nil) {
        _titleDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftW, CGRectGetMaxY(self.titleLabel.frame) + kMarginH, kSystemWide - kLeftW * 2, 124)];
        _titleDesLabel.text = @"根据中华人民共和国公安部令第139号文件，学员可以自主选择考试场地、考试时间、考试场次提出考试预约申请。在停止接受考试预约申请前，学员可以在互联网办理取消预约。在预约结果公布时间当天，该考试计划将在互联网上截止预约。（由于该系统在全国各地的推进进度不同，可能有部分地区暂时不支持自主约考，请选择驾校代约)";
        _titleDesLabel.numberOfLines = 0;
        _titleDesLabel.font = [UIFont systemFontOfSize:14];
        _titleDesLabel.textColor = JZ_FONTCOLOR_LIGHT;
        
    }
    return _titleDesLabel;
}
- (UILabel *)titleWebLabel{
    if (_titleWebLabel == nil) {
        _titleWebLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftW, CGRectGetMaxY(self.titleDesLabel.frame) + kMarginH, kSystemWide - kLeftW * 2, 35)];
        _titleWebLabel.text = @"学员登录122.gov.cn，点击【驾驶证业务】→【考试预约】业务功能办理。";
        _titleWebLabel.font = [UIFont systemFontOfSize:14];
         _titleWebLabel.numberOfLines = 0;
        _titleWebLabel.textColor = JZ_FONTCOLOR_DRAK;
        
    }
    return _titleWebLabel;
}
- (UILabel *)titleProcessLabel{
    if (_titleProcessLabel == nil) {
        _titleProcessLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftW, CGRectGetMaxY(self.titleWebLabel.frame) + kMarginH, kSystemWide - kLeftW * 2, 56)];
        _titleProcessLabel.text = @"业务流程及操作说明\n[业务须知】→ 【确认信息】→ 【考试预约】→[选择日期和场次】→ 【确认提交】→ 【完成提交】";
        _titleProcessLabel.font = [UIFont systemFontOfSize:14];
        _titleProcessLabel.textColor = JZ_BlueColor;
         _titleProcessLabel.numberOfLines = 0;
        
    }
    return _titleProcessLabel;
}
- (UILabel *)appinotDesLabel{
    if (_appinotDesLabel == nil) {
        _appinotDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftW, CGRectGetMaxY(self.titleProcessLabel.frame) + kMarginH, kSystemWide - kLeftW * 2, 94)];
        _appinotDesLabel.text = @"提交成功后，系统生成业务流水号，学员根据该业务流水号可以在网办进度中查询该流水的预约受理状态。系统将在预约结果公示时间当天安排考试，学员可以通过网办进度、驾驶人考试预约结果公布、短信及时获取预约结果。";
        _appinotDesLabel.font = [UIFont systemFontOfSize:14];
         _appinotDesLabel.numberOfLines = 0;
        _appinotDesLabel.textColor = JZ_FONTCOLOR_LIGHT;
        
    }
    return _appinotDesLabel;
}
- (UIButton *)appiontButton{
    if (_appiontButton == nil) {
        _appiontButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat marginW = 16;
        CGFloat H = 44;
        _appiontButton.frame = CGRectMake(marginW, kSystemHeight - marginW - H - 64, kSystemWide - 2 * marginW , H);
        [_appiontButton setTitle:@"驾校代约" forState:UIControlStateNormal];
        _appiontButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_appiontButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _appiontButton.backgroundColor = YBNavigationBarBgColor;
        [_appiontButton addTarget:self action:@selector(appointSchool:) forControlEvents:UIControlEventTouchUpInside];
        _appiontButton.layer.masksToBounds = YES;
        _appiontButton.layer.cornerRadius = 4;
    }
    return _appiontButton;
}
@end
