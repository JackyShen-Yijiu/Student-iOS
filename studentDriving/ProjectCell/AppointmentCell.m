//
//  AppointmentCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/2.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "AppointmentCell.h"
#import "ToolHeader.h"
@interface AppointmentCell ()
@property (strong, nonatomic) UIView *backGroundView;


@end
@implementation AppointmentCell

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = [WMUITool initWithTitle:@"取消预约" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        [_cancelButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UILabel *)courseProgressLabel {
    if ( _courseProgressLabel== nil) {
        _courseProgressLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
//        _courseProgressLabel.backgroundColor = RGBColor(205, 212, 217);

        _courseProgressLabel.text = @"课程进度:";
    }
    return _courseProgressLabel;
}
- (UILabel *)courseProgress {
    if ( _courseProgress== nil) {
        _courseProgress = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
//        _courseProgress.backgroundColor = RGBColor(205, 212, 217);

        _courseProgress.text = @"";
    }
    return _courseProgress;
}
- (UILabel *)courseLabel {
    if (_courseLabel == nil) {
        _courseLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _courseLabel.text = @"课程信息:";
//        _courseLabel.backgroundColor = RGBColor(205, 212, 217);

    }
    return _courseLabel;
}
- (UILabel *)courseTime {
    if (_courseTime == nil) {
        _courseTime = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _courseTime.text = @"";
//        _courseTime.backgroundColor = RGBColor(205, 212, 217);

    }
    return _courseTime;
}
- (UILabel *)courseLocation {
    if (_courseLocation == nil) {
        _courseLocation = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _courseLocation.text = @"接送地点:";
//        _courseLocation.backgroundColor = RGBColor(205, 212, 217);

    }
    return _courseLocation;
}



- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 200)];
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
    
    [self.backGroundView addSubview:self.courseProgressLabel];
    [self.courseProgressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(16);
    }];
    [self.backGroundView addSubview:self.courseProgress];
    [self.courseProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.courseProgressLabel.mas_bottom).offset(5);
    }];
    
    [self.backGroundView addSubview:self.courseLabel];
    
    [self.courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.courseProgress.mas_bottom).offset(5);
    }];
    
    [self.backGroundView addSubview:self.courseTime];
    
    [self.courseTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.courseLabel.mas_bottom).offset(10);
    }];
    
    [self.backGroundView addSubview:self.courseLocation];
    
    [self.courseLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.courseTime.mas_bottom).offset(10);
    }];
    
    [self.backGroundView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-15);
        make.top.mas_equalTo(self.courseLocation.mas_bottom).offset(10);
        make.height.mas_equalTo(@44);
    }];
    

    
    
}
#pragma mark - btnAction
- (void)clickBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(studentCancelAppointment)]) {
        [_delegate studentCancelAppointment];
    }
}
@end
