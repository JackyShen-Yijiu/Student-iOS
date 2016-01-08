//
//  Myreservation MyReservationCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/2.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MyReservationCell.h"
#import "ToolHeader.h"
#import "MyAppointmentModel.h"
#import <UIImageView+WebCache.h>


@interface MyReservationCell ()
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UIView *leftLineView;
@property (strong, nonatomic) UIImageView *remindImageView;
@property (strong, nonatomic) UIView *reservationContent;
@property (strong, nonatomic) UIView *leftCorner;

@property (strong, nonatomic) UILabel *contentTitle;
@property (strong, nonatomic) UILabel *contentTime;
@property (strong, nonatomic) UILabel *contentState;
@property (strong, nonatomic) UIView *contentStateView;
@property (strong, nonatomic) UIImageView *contentHeadView;

@property (strong, nonatomic) UILabel *contentStateTitle;

@end
@implementation MyReservationCell

- (UIImageView *)contentHeadView {
    if (_contentHeadView == nil) {
        _contentHeadView = [[UIImageView alloc] init];
        _contentHeadView.backgroundColor = MAINCOLOR;
    }
    return _contentHeadView;
}

- (UIView *)contentStateView {
    if (_contentStateView == nil) {
        _contentStateView = [[UIView alloc] init];
    }
    return _contentStateView;
}
- (UILabel *)contentState {
    if (_contentState == nil) {
        _contentState = [[UILabel alloc] init];
    }
    return _contentState;
}
- (UILabel *)contentTime {
    if (_contentTime == nil) {
        _contentTime = [WMUITool initWithTextColor:TEXTGRAYCOLOR withFont:[UIFont systemFontOfSize:12]];
        _contentTime.text = @"2015年7月21日  13:00-18:00";
    }
    return _contentTime;
}
- (UILabel *)contentTitle {
    if (_contentTitle == nil) {
        _contentTitle = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _contentTitle.text = @"科目二";
    }
    return _contentTitle;
}

- (UIView *)leftCorner {
    if (_leftCorner == nil) {
        _leftCorner = [[UIView alloc] initWithFrame:CGRectMake(-10, (81-8)/2-15/2, 15, 15)];
        _leftCorner.layer.cornerRadius = _leftCorner.frame.size.width*0.5;
        _leftCorner.backgroundColor = BACKGROUNDCOLOR;
        _leftCorner.layer.masksToBounds = YES;
    }
    return _leftCorner;
}
- (UIView *)reservationContent {
    if (_reservationContent == nil) {
        _reservationContent = [[UIView alloc] initWithFrame:CGRectMake(24, 4, kSystemWide-24-15, 81-8)];
        _reservationContent.backgroundColor = [UIColor whiteColor];
    }
    return _reservationContent;
}
- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 105)];
    }
    return _backGroundView;
}
- (UIView *)leftLineView {
    if (_leftLineView == nil) {
        _leftLineView = [[UIView alloc] init];
        _leftLineView.backgroundColor = MAINCOLOR;
    }
    return _leftLineView;
}
- (UIImageView *)remindImageView {
    if (_remindImageView == nil) {
        _remindImageView = [[UIImageView alloc] init];
        _remindImageView.backgroundColor = [UIColor whiteColor];
    }
    return _remindImageView;
}

- (UILabel *)contentStateTitle {
    if (_contentStateTitle == nil) {
        _contentStateTitle = [[UILabel alloc] init];
        _contentStateTitle.font = [UIFont systemFontOfSize:11];
    }
    return _contentStateTitle;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = BACKGROUNDCOLOR;
        [self setUp];
    }
    return self;
}
- (void)setUp {
    
    [self.contentView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.reservationContent];
    
    [self.reservationContent addSubview:self.leftCorner];
    [self.backGroundView addSubview:self.leftLineView];
    
    [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(0);
        make.bottom.mas_equalTo(self.backGroundView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(20);
        make.width.mas_equalTo(@1);
    }];
    
    [self.leftLineView addSubview:self.remindImageView];
    
    [self.remindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.leftLineView.mas_centerX);
        make.centerY.mas_equalTo(self.reservationContent.mas_centerY);
        make.width.mas_equalTo(@10);
        make.height.mas_equalTo(@10);
    }];
    
    [self.reservationContent addSubview:self.contentHeadView];
    
    [self.contentHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.reservationContent.mas_left).offset(10);
        make.top.mas_equalTo(self.reservationContent.mas_top).offset(8);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@60);
    }];
    
    
    [self.reservationContent addSubview:self.contentTitle];
    
    [self.contentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.reservationContent.mas_left).offset(15+10+60);
        make.top.mas_equalTo(self.reservationContent.mas_top).offset(14);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-70);
    }];
    
    [self.reservationContent addSubview:self.contentTime];
    [self.contentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.reservationContent.mas_left).offset(15+10+60);
        make.top.mas_equalTo(self.contentTitle.mas_bottom).offset(15);
    }];
    
    [self.reservationContent addSubview:self.contentState];
    [self.contentState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.reservationContent.mas_right).offset(-14);
        make.top.mas_equalTo(self.reservationContent.mas_top).offset(14);
    }];
    
    [self.reservationContent addSubview:self.contentStateView];
    [self.contentStateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.reservationContent.mas_top).offset(0);
        make.bottom.mas_equalTo(self.reservationContent.mas_bottom).offset(0);
        make.right.mas_equalTo(self.reservationContent.mas_right).offset(0);
        make.width.mas_equalTo(@2);
    }];
    
    [self.reservationContent addSubview:self.contentStateTitle];
    [self.contentStateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.reservationContent.mas_top).offset(14);
        make.right.mas_equalTo(self.reservationContent.mas_right).offset(-14);
    }];
}
- (void)receiveDataModel:(MyAppointmentModel *)myModel {
    self.remindImageView.image = nil;
    //    self.contentTitle.text = nil;
    self.contentStateView.backgroundColor = [UIColor clearColor];
    self.contentStateTitle.text = nil;
    self.contentStateTitle.textColor = [UIColor blackColor];
    
    self.contentTitle.text = myModel.courseprocessdesc;
    self.contentTime.text = myModel.classdatetimedesc;
    [self.contentHeadView sd_setImageWithURL:[NSURL URLWithString:myModel.coachid.headportrait.originalpic]placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    DYNSLog(@"state = %@",myModel.reservationstate);
    if (myModel.reservationstate.integerValue == 1) {
        //课程申请待确认中
        self.remindImageView.image = [UIImage imageNamed:@"预约corner.png"];
        self.contentStateView.backgroundColor = MAINCOLOR;
        self.contentStateTitle.text = @"申请中";
        
    }else if (myModel.reservationstate.integerValue == 2) {
        //取消预约(自己取消)
        self.remindImageView.image = [UIImage imageNamed:@"完成corner.png"];
        self.contentStateView.backgroundColor = RGBColor(17, 216, 136);
        self.contentStateTitle.text = @"您已取消";
        self.contentStateTitle.textColor =  RGBColor(17, 216, 136);
        
    }else if (myModel.reservationstate.integerValue == 3) {
        //已经确认
        self.remindImageView.image = [UIImage imageNamed:@"待评价corner.png"];
        self.contentStateView.backgroundColor = RGBColor(255, 150, 24);
        self.contentStateTitle.text = @"已提交";
        self.contentStateTitle.textColor = RGBColor(255, 150, 24);
        
    }else if (myModel.reservationstate.integerValue == 4) {
        //已取消(教练取消)
        self.remindImageView.image = [UIImage imageNamed:@"完成corner.png"];
        self.contentStateView.backgroundColor =  RGBColor(17, 216, 136);
        self.contentStateTitle.text = @"教练取消";
        self.contentStateTitle.textColor =  RGBColor(17, 216, 136);
        
    }else if (myModel.reservationstate.integerValue == 5) {
        //待确认
        self.remindImageView.image = [UIImage imageNamed:@"预约corner.png"];
        self.contentStateView.backgroundColor = MAINCOLOR;
        self.contentStateTitle.text = @"待确认";
        self.contentStateTitle.textColor = MAINCOLOR;
        
    }else if (myModel.reservationstate.integerValue == 6) {
        //待评价
        self.remindImageView.image = [UIImage imageNamed:@"待评价corner.png"];
        self.contentStateView.backgroundColor = RGBColor(255, 150, 24);
        self.contentStateTitle.text = @"待评价";
        self.contentStateTitle.textColor = RGBColor(255, 150, 24);
    }else if (myModel.reservationstate.integerValue == 7) {
        //已完成
        self.remindImageView.image = [UIImage imageNamed:@"完成corner.png"];
        self.contentStateView.backgroundColor =  RGBColor(17, 216, 136);
        self.contentStateTitle.text = @"已完成";
        self.contentStateTitle.textColor =  RGBColor(17, 216, 136);
    }
}
@end
