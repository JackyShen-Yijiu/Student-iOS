//
//  CoachInformationCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "CoachInformationCell.h"
#import "ToolHeader.h"
@interface CoachInformationCell ()
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UILabel *coachTitle;
@property (strong, nonatomic) UILabel *rainingGround;

@property (strong, nonatomic) UILabel *studentNum;


@property (strong, nonatomic) UILabel *sendMeet;


@property (strong, nonatomic) UILabel *workTime;

@property (strong, nonatomic) UILabel *teachSubjcet;





@end
@implementation CoachInformationCell

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , 177)];
    }
    return _backGroundView;
}
- (UILabel *)coachTitle {

    if (_coachTitle == nil) {
        _coachTitle = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont boldSystemFontOfSize:14]];
        _coachTitle.text = @"教练信息";
    }
    return _coachTitle;
}
- (UILabel *)rainingGround {
    
    if (_rainingGround == nil) {
        _rainingGround = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _rainingGround.text = @"训练场地:";
    }
    return _rainingGround;
}
- (UILabel *)rainingGroundDetail {
    
    if (_rainingGroundDetail == nil) {
        _rainingGroundDetail = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
//        _rainingGroundDetail.text = @"北京海淀区沙河训练基地";
    }
    return _rainingGroundDetail;
}
- (UILabel *)studentNum {
    
    if (_studentNum == nil) {
        _studentNum = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _studentNum.text = @"学院26位:";
    }
    return _studentNum;
}
- (UILabel *)studentNumDetail {
    
    if (_studentNumDetail == nil) {
        _studentNumDetail = [WMUITool initWithTextColor:MAINCOLOR withFont:    [UIFont systemFontOfSize:14]];
//        _studentNumDetail.text = @"通过率89%";
    }
    return _studentNumDetail;
}
- (UILabel *)sendMeet {
    
    if (_sendMeet == nil) {
        _sendMeet = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _sendMeet.text = @"接       送:";
    }
    return _sendMeet;
}
- (UILabel *)sendMeetDetail {
    
    if (_sendMeetDetail == nil) {
        _sendMeetDetail = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
//        _sendMeetDetail.text = @"5km内可以接送";
    }
    return _sendMeetDetail;
}

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
//        _workTimeDetail.text = @"周一至周五(全天)";
    }
    return _workTimeDetail;
}
- (UILabel *)teachSubjcet {
    
    if (_teachSubjcet == nil) {
        _teachSubjcet = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _teachSubjcet.text = @"授权科目:";
    }
    return _teachSubjcet;
}
- (UILabel *)teachSubjcetDetail {
    
    if (_teachSubjcetDetail == nil) {
        _teachSubjcetDetail = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _teachSubjcetDetail.text = @"全科";
    }
    return _teachSubjcetDetail;
}

- (UILabel *)dringAgeLabel {
    if (_dringAgeLabel == nil) {
        _dringAgeLabel = [[UILabel alloc] init];
        _dringAgeLabel.font = [UIFont systemFontOfSize:14];
        _dringAgeLabel.textColor = [UIColor blackColor];
        _dringAgeLabel.text = @"驾龄:5年";
        
    }
    return _dringAgeLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    
    [self.contentView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.coachTitle];
    
    [self.backGroundView addSubview:self.rainingGround];
    
    
    [self.backGroundView addSubview:self.dringAgeLabel];
    
    [self.backGroundView addSubview:self.studentNum];
    
    [self.backGroundView addSubview:self.sendMeet];
    
    [self.backGroundView addSubview:self.workTime];
    
    [self.backGroundView addSubview:self.teachSubjcet];

    [self.backGroundView addSubview:self.rainingGroundDetail];

    [self.backGroundView addSubview:self.studentNumDetail];

    [self.backGroundView addSubview:self.sendMeetDetail];
    
    [self.backGroundView addSubview:self.workTimeDetail];
    
    [self.backGroundView addSubview:self.teachSubjcetDetail];
    
    [self.coachTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(18);
    }];
    [self.rainingGround mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.coachTitle.mas_bottom).offset(8);
    }];
    
    [self.dringAgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.rainingGround.mas_bottom).offset(8);
    }];
    [self.studentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.dringAgeLabel.mas_bottom).offset(8);
    }];
    [self.sendMeet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.studentNum.mas_bottom).offset(8);
    }];
    [self.workTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.sendMeet.mas_bottom).offset(8);
    }];
    [self.teachSubjcet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.workTime.mas_bottom).offset(8);
    }];
    
    [self.rainingGroundDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rainingGround.mas_right).offset(10);
        make.top.mas_equalTo(self.rainingGround.mas_top).offset(0);
    }];
    
    [self.studentNumDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.studentNum.mas_right).offset(10);
        make.top.mas_equalTo(self.studentNum.mas_top).offset(0);
    }];
    
    [self.sendMeetDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sendMeet.mas_right).offset(10);
        make.top.mas_equalTo(self.sendMeet.mas_top).offset(0);
    }];
    
    [self.workTimeDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.workTime.mas_right).offset(10);
        make.top.mas_equalTo(self.workTime.mas_top).offset(0);
    }];
    
    [self.teachSubjcetDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.teachSubjcet.mas_right).offset(10);
        make.top.mas_equalTo(self.teachSubjcet.mas_top).offset(0);
    }];
    
}
@end
