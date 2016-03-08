//
//  AppointmentCollectionViewCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "AppointmentCollectionViewCell.h"

#import "AppointmentCoachTimeInfoModel.h"
@interface AppointmentCollectionViewCell ()
@property (strong, nonatomic) UIView *selectedAppView;
@end
@implementation AppointmentCollectionViewCell
- (UIView *)selectedAppView {
    if (_selectedAppView == nil) {
        _selectedAppView = [[UIView alloc] init];
        _selectedAppView.layer.borderWidth = 1;
        _selectedAppView.layer.borderColor = MAINCOLOR.CGColor;
    }
    return _selectedAppView;
}
- (UILabel *)startTimeLabel {
    if (_startTimeLabel == nil) {
        _startTimeLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont boldSystemFontOfSize:18]];
        _startTimeLabel.text = @"8:00";
    }
    return _startTimeLabel;
}
- (UILabel *)finalTimeLabel {
    if (_finalTimeLabel == nil) {
        _finalTimeLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:12]];
        _finalTimeLabel.text = @"9:00结束";
    }
    return _finalTimeLabel;
}
- (UILabel *)remainingPersonLabel {
    if (_remainingPersonLabel == nil) {
        _remainingPersonLabel = [WMUITool initWithTextColor:TEXTGRAYCOLOR withFont:[UIFont systemFontOfSize:11]];
        _remainingPersonLabel.text = @"剩余1个名额";
    }
    return _remainingPersonLabel;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectedBackgroundView = self.selectedAppView;
        
        [self addSubview:self.startTimeLabel];
        [self addSubview:self.finalTimeLabel];
        [self addSubview:self.remainingPersonLabel];
        
        [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).offset(15);
        }];
        [self.finalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.startTimeLabel.mas_bottom).offset(5);
        }];
        [self.remainingPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.finalTimeLabel.mas_bottom).offset(0);
        }];
    }
    return self;
}

- (void)receiveCoachTimeInfoModel:(AppointmentCoachTimeInfoModel *)coachTimeInfo {
    self.userInteractionEnabled = NO;
    
    self.isModifyCoach = NO;
    self.startTimeLabel.text = nil;
    self.finalTimeLabel.text = nil;
    self.remainingPersonLabel.text = nil;
    self.startTimeLabel.textColor = [UIColor blackColor];
    self.finalTimeLabel.textColor = [UIColor blackColor];
    self.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
    self.coachTimeInfo = coachTimeInfo;
    
    BOOL is_CotainMySelf = NO;
    
    for (NSString *string in coachTimeInfo.courseuser) {
        DYNSLog(@"string = %@",string);
        if ([string isEqualToString:[AcountManager manager].userid]) {
            is_CotainMySelf = YES;
        }
    }
    if (is_CotainMySelf){
        self.startTimeLabel.textColor = [UIColor blackColor];
        self.finalTimeLabel.textColor = [UIColor blackColor];
        self.remainingPersonLabel.textColor = MAINCOLOR;
        
    }else if (coachTimeInfo.coursestudentcount.intValue - coachTimeInfo.selectedstudentcount.intValue == 0) {
        self.startTimeLabel.textColor = TEXTGRAYCOLOR;
        self.finalTimeLabel.textColor = TEXTGRAYCOLOR;
        self.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
    }else  {
        self.userInteractionEnabled = YES;

    }
    //coursedate = "2016-01-04T00:00:00.000Z";
    NSLog(@"%@",coachTimeInfo.coursedate);
    NSLog(@"%@",coachTimeInfo.coursetime.begintime);
    
    self.startTimeLabel.text = [self dealStringWithTime:coachTimeInfo.coursetime.begintime];
    self.finalTimeLabel.text = [self dealStringWithTime:coachTimeInfo.coursetime.endtime];
    
    // 此方法判断当前时间是否大于预约的时间；
    [self isCellCanClick:coachTimeInfo.coursedate startTimeStr:coachTimeInfo.coursetime.begintime];
    
    if (is_CotainMySelf) {
        
       self.remainingPersonLabel.text = @"您已经预约";
        
    }else{
        
        NSInteger shengyuCount = coachTimeInfo.coursestudentcount.intValue - coachTimeInfo.selectedstudentcount.intValue;
        if (shengyuCount>0) {
            self.remainingPersonLabel.text = [NSString stringWithFormat:@"剩余%ld个名额",(long)shengyuCount];
            self.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
        }else{
            self.userInteractionEnabled = YES;
            self.remainingPersonLabel.text = @"换同时段教练";
            self.remainingPersonLabel.textColor = [UIColor blackColor];
            self.isModifyCoach = YES;
        }
        
    }
    
}

- (void)isCellCanClick:(NSString *)couresebegintimeStr startTimeStr:(NSString *)startTimeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *nowtimeStr = [formatter stringFromDate:datenow];//当前的时间 YYYY-MM-dd HH:mm:ss
    NSRange range = NSMakeRange(0, 10);
    NSString *nowTimeStr = [nowtimeStr substringWithRange:range];//当前的时间 YYYY-MM-dd
    NSString *appointTimeStr = [couresebegintimeStr substringWithRange:range];//预约课程的时间 YYYY-MM-dd
    if ([appointTimeStr isEqualToString:nowTimeStr]) {
        NSArray *indexArray= [startTimeStr componentsSeparatedByString:@":"];//课程开始的时间 hh:mm
        NSString *indexString = indexArray.firstObject;
        NSInteger startTime = indexString.integerValue;
        NSRange range = NSMakeRange(11,8);
        NSString *subNowTimeStr = [nowtimeStr substringWithRange:range];//现在的时间 HH:mm:ss
        NSArray *nowTimeArray= [subNowTimeStr componentsSeparatedByString:@":"];//课程开始的时间 hh:mm
        NSString *nowTimeStr = nowTimeArray.firstObject;
        NSInteger nowTime = nowTimeStr.integerValue;
        
        if (startTime <= nowTime) {
            
            self.startTimeLabel.textColor = TEXTGRAYCOLOR;
            self.finalTimeLabel.textColor = TEXTGRAYCOLOR;
            
            self.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
           
//            NSInteger shengyuCount = coachTimeInfo.coursestudentcount.intValue - coachTimeInfo.selectedstudentcount.intValue;
//            if (shengyuCount>0) {
//                self.remainingPersonLabel.text = [NSString stringWithFormat:@"剩余%ld个名额",(long)shengyuCount];
//                self.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
//            }else{
//                self.remainingPersonLabel.text = @"换同时段教练";
//                self.remainingPersonLabel.textColor = [UIColor blueColor];
//            }
            
            self.userInteractionEnabled = NO;
            
        }
    }
}

- (NSString *)dealStringWithTime:(NSString *)value {
    NSUInteger lenth = value.length;
    NSUInteger lastLenth = lenth-3;
    NSString *resultString = [value substringWithRange:NSMakeRange(0, lastLenth)];
    return resultString;
}
@end
