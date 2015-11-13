//
//  DrivingInformationCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/30.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "DrivingInformationCell.h"
#import "ToolHeader.h"
@interface DrivingInformationCell ()
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UILabel *drivingTitle;
@property (strong, nonatomic) UILabel *successRateLabel;


@property (strong, nonatomic) UILabel *workTime;


@end
@implementation DrivingInformationCell

- (UILabel *)workTime {
    
    if (_workTime == nil) {
        _workTime = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _workTime.text = @"工作时间:";
    }
    return _workTime;
}

- (UILabel *)workTimeDetail {
    
    if (_workTimeDetail == nil) {
        _workTimeDetail = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
//        _workTimeDetail.text = @"早8:00-晚6:00";
    }
    return _workTimeDetail;
}
- (UILabel *)successRateDetailLabel {
    if (_successRateDetailLabel == nil) {
        _successRateDetailLabel = [[UILabel alloc] init];
        _successRateDetailLabel.font = [UIFont systemFontOfSize:14];
        _successRateDetailLabel.textColor = MAINCOLOR;
//        _successRateDetailLabel.text = @"通过95%";
    }
    return _successRateDetailLabel;
}
- (UILabel *)successRateLabel {
    if (_successRateLabel == nil) {
        _successRateLabel = [[UILabel alloc] init];
        _successRateLabel.font = [UIFont systemFontOfSize:14];
        _successRateLabel.textColor = [UIColor blackColor];
        _successRateLabel.text = @"通过率:";
    }
    return _successRateLabel;
}
- (UILabel *)drivingTitle {
    
    if (_drivingTitle == nil) {
        _drivingTitle = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont boldSystemFontOfSize:14]];
        _drivingTitle.text = @"驾校信息";
    }
    return _drivingTitle;
}
- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , 105)];
    }
    return _backGroundView;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    [self.contentView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.drivingTitle];
    
    
    [self.backGroundView addSubview:self.successRateLabel];
    
    [self.backGroundView addSubview:self.successRateDetailLabel];
    
    [self.backGroundView addSubview:self.workTime];

    [self.backGroundView addSubview:self.workTimeDetail];

    [self.drivingTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(18);
    }];
    
    [self.successRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.drivingTitle.mas_bottom).offset(12);

    }];
    
    [self.successRateDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.successRateLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.successRateLabel.mas_top).offset(0);
    }];
    
    [self.workTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.successRateLabel.mas_bottom).offset(8);
    }];
    
    [self.workTimeDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.workTime.mas_right).offset(15);
        make.top.mas_equalTo(self.successRateLabel.mas_bottom).offset(8);
    }];
}

@end
