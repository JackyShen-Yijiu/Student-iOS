//
//  JGAppointMentCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JGAppointMentCell.h"

#import "YBAppointData.h"
#import "YBAppointCoursedata.h"
#import "YBAppointCoursetime.h"

#import "YBObjectTool.h"
#import "YBAppointMentCoachModel.h"

@interface JGAppointMentCell ()

@property (strong, nonatomic) UIView *selectedAppView;
@property (strong, nonatomic) UIView *delive;
@property (nonatomic,strong) UIImageView *stateImgview;

@end

@implementation JGAppointMentCell

- (UIView *)selectedAppView {
    if (_selectedAppView == nil) {
        _selectedAppView = [[UIView alloc] init];
//        _selectedAppView.backgroundColor = YBNavigationBarBgColor;
        _selectedAppView.layer.borderWidth = 1;
        _selectedAppView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _selectedAppView;
}
- (UILabel *)startTimeLabel {
    if (_startTimeLabel == nil) {
        _startTimeLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont boldSystemFontOfSize:14]];
        _startTimeLabel.text = @"8:00";
    }
    return _startTimeLabel;
}
- (UILabel *)finalTimeLabel {
    if (_finalTimeLabel == nil) {
        _finalTimeLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont boldSystemFontOfSize:12]];
        _finalTimeLabel.text = @"可约1人已约4人";
    }
    return _finalTimeLabel;
}
- (UILabel *)remainingPersonLabel {
    if (_remainingPersonLabel == nil) {
        _remainingPersonLabel = [WMUITool initWithTextColor:TEXTGRAYCOLOR withFont:[UIFont boldSystemFontOfSize:12]];
        _remainingPersonLabel.text = @"签到4人";
    }
    return _remainingPersonLabel;
}
- (UIView *)delive
{
    if (_delive == nil) {
        _delive = [[UIView alloc] init];
        _delive.backgroundColor = [UIColor lightGrayColor];
        _delive.alpha = 0.3;
    }
    return _delive;
}
- (UIImageView *)stateImgview
{
    if (_stateImgview==nil) {
        _stateImgview = [[UIImageView alloc] init];
        _stateImgview.backgroundColor = [UIColor clearColor];
    }
    return _stateImgview;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
//        self.selectedBackgroundView = self.selectedAppView;
        
        [self.contentView addSubview:self.startTimeLabel];
        
        [self.contentView addSubview:self.finalTimeLabel];
        
        [self.contentView addSubview:self.remainingPersonLabel];
        
        [self.contentView addSubview:self.delive];
        
        [self.contentView addSubview:self.stateImgview];
        
        [self.stateImgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(@0);
            make.right.mas_equalTo(@0);
            make.width.mas_equalTo(@41);
            make.height.mas_equalTo(@41);
        }];
        
        [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).offset(15);
        }];
        [self.finalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.startTimeLabel.mas_bottom);
        }];
        [self.remainingPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.finalTimeLabel.mas_bottom).offset(0);
        }];
        [self.delive mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@0);
            make.right.mas_equalTo(@0);
            make.height.mas_equalTo(@0.5);
            make.top.mas_equalTo(self.mas_bottom).offset(-0.5);
        }];
        
    }
    return self;
}

- (void)setAppointInfoModel:(YBAppointData *)appointInfoModel
{
    _appointInfoModel = appointInfoModel;
    
    self.startTimeLabel.text = nil;
    self.startTimeLabel.textColor = [UIColor lightGrayColor];
    self.finalTimeLabel.text = nil;
    self.finalTimeLabel.textColor = [UIColor lightGrayColor];
    self.remainingPersonLabel.text = nil;
    self.remainingPersonLabel.textColor = [UIColor lightGrayColor];
    self.stateImgview.hidden = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    
    NSLog(@"_appointInfoModel.begintime:%@ _appointInfoModel.endtime:%@ _appointInfoModel.isRest:%ld _appointInfoModel.isOutofdate:%ld _appointInfoModel.isReservation:%ld",_appointInfoModel.begintime,_appointInfoModel.endtime,(long)_appointInfoModel.is_rest,(long)_appointInfoModel.is_outofdate,(long)_appointInfoModel.is_reservation);
    
    // 时间
    self.startTimeLabel.text = [NSString getHourLocalDateFormateDate:_appointInfoModel.begintime];
    
    // 14点结束
    NSString *newendtime = [NSString getHourLocalDateFormateDate:_appointInfoModel.endtime];
    self.finalTimeLabel.text = [NSString stringWithFormat:@"%@结束",newendtime];
    
    if (_appointInfoModel.is_outofdate) {// 正常，未过期
        
        // 判断是否休息 0休息  1不休息
        if (_appointInfoModel.is_rest==0) {// 休息
            
            self.stateImgview.hidden = NO;
            self.stateImgview.image = [UIImage imageNamed:@"YBAppointstatus_rest"];
            self.remainingPersonLabel.text = [NSString stringWithFormat:@"%ld个其他教练可预约",(long)_appointInfoModel.coachcount];
            
            if (_appointInfoModel.coachcount!=0) {// 有可预约教练
                self.isModifyCoach = YES;
                self.remainingPersonLabel.text = [NSString stringWithFormat:@"%ld个其他教练可预约",(long)_appointInfoModel.coachcount];
                self.remainingPersonLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
            }else{// 无可预约教练
                self.userInteractionEnabled = NO;
                self.backgroundColor = RGBColor(247, 247, 247);
                self.startTimeLabel.textColor = [UIColor lightGrayColor];
                self.finalTimeLabel.textColor = [UIColor lightGrayColor];
            }

        }else{// 不休息
            
            // 判断是否有课程安排，是否已满
            if (_appointInfoModel.coursedata) {// 有课程安排
                
                NSInteger count = _appointInfoModel.coursedata.coursestudentcount - _appointInfoModel.coursedata.selectedstudentcount;
                if (count==0) {// 已满
                    self.stateImgview.hidden = NO;
                    self.stateImgview.image = [UIImage imageNamed:@"YBAppointstatus_full"];
                    if (_appointInfoModel.coachcount!=0) {// 有可预约教练
                        self.remainingPersonLabel.text = [NSString stringWithFormat:@"%ld个其他教练可预约",(long)_appointInfoModel.coachcount];
                        self.remainingPersonLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
                        self.isModifyCoach = YES;
                    }else{// 无可预约教练
                        self.userInteractionEnabled = NO;
                        self.backgroundColor = RGBColor(247, 247, 247);
                        self.startTimeLabel.textColor = [UIColor lightGrayColor];
                        self.finalTimeLabel.textColor = [UIColor lightGrayColor];
                    }
                   
                }else{// 未满
                    
                }
                
                // 判断是否已约 0没有预约  1已经预约
                if (_appointInfoModel.is_reservation) {// 已经预约
                    
                    self.userInteractionEnabled = NO;
                    
                    // 判断是否是已约的当前选中教练
                    if ([_appointInfoModel.coursedata.coachid isEqualToString:_appointCoach.coachid]) {// 已约的是当前选中的教练
                        self.stateImgview.hidden = NO;
                        self.stateImgview.image = [UIImage imageNamed:@"YBAppointstatus_date_red"];
                        self.remainingPersonLabel.text = @"已约该教练";
                        self.remainingPersonLabel.textColor = YBNavigationBarBgColor;
                        self.startTimeLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
                        self.finalTimeLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
                    }else{// 已约的其他教练
                        self.stateImgview.hidden = NO;
                        self.stateImgview.image = [UIImage imageNamed:@"YBAppointstatus_date_blue"];
                        self.remainingPersonLabel.text = [NSString stringWithFormat:@"已约%@教练",_appointInfoModel.coursedata.coachname];
                        self.remainingPersonLabel.textColor = [UIColor colorWithHexString:@"5b8efb"];
                    }
                    
                }else{// 没有预约
                    
                    if (count!=0) {// 不满
                        
                        self.startTimeLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
                        self.finalTimeLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
                        self.remainingPersonLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
                        self.remainingPersonLabel.text = [NSString stringWithFormat:@"剩余%ld个名额",(long)count];

                    }
                    
                }
                
            }else{// 无课程安排
                
                self.startTimeLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
                self.finalTimeLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
                self.remainingPersonLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
                self.remainingPersonLabel.text = [NSString stringWithFormat:@"剩余%ld个名额",(long)_appointInfoModel.coachcount];
                
            }
            
        }
        
    }else{// 已过期
        
        self.userInteractionEnabled = NO;
        self.backgroundColor = RGBColor(247, 247, 247);
        self.startTimeLabel.textColor = [UIColor lightGrayColor];
        self.finalTimeLabel.textColor = [UIColor lightGrayColor];
        
    }
   
    // 选中的
    if (_appointInfoModel.is_selected) {
        self.startTimeLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
        self.finalTimeLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
        self.remainingPersonLabel.textColor = [UIColor whiteColor];//MAINCOLOR;
        self.contentView.backgroundColor = YBNavigationBarBgColor;
    }
    
}

//- (void)isRiChengCellCanClick:(NSString *)coursedate startTimeStr:(NSString *)startTimeStr
//{
//    
//    self.userInteractionEnabled = YES;
//    self.isModifyCoach = NO;
//    self.startTimeLabel.textColor = [UIColor lightGrayColor];
//    self.finalTimeLabel.textColor = [UIColor lightGrayColor];
//    self.remainingPersonLabel.textColor = [UIColor lightGrayColor];
//    
//    // 当前时间
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
//   
//    NSDate *datenow = [NSDate date];
//    NSString *nowtimeymdStr = [formatter stringFromDate:datenow];
//    
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSString *nowtimeymdhmsStr = [formatter stringFromDate:datenow];
//
////    NSRange range = NSMakeRange(0, 10);
////    NSString *nowTimeStr = [nowtimeStr substringWithRange:range];//当前的时间 YYYY-MM-dd
//    NSString *appointTimeStr = [NSString getYearLocalDateFormateUTCDate:coursedate];//预约课程的时间 YYYY-MM-dd
//    
//    
//    int lessThan = [YBObjectTool compareDateWithSelectDate:self.selectDate];
//    NSLog(@"lessThan:%d",lessThan);
//    // 1:大于当前日期 -1:小于当前时间 0:等于当前时间
//    if (lessThan==-1){// 预约时间小于当前时间
//        
//        self.userInteractionEnabled = NO;
//        
//        NSLog(@"------------------------");
//        self.startTimeLabel.textColor = [UIColor lightGrayColor];
//        self.finalTimeLabel.textColor = [UIColor lightGrayColor];
//        self.remainingPersonLabel.textColor = [UIColor lightGrayColor];
//        
//    }else{
//        
//        NSArray *indexArray= [startTimeStr componentsSeparatedByString:@":"];//课程开始的时间 hh:mm
//        NSString *indexString = indexArray.firstObject;
//        NSInteger startTime = indexString.integerValue;
//        NSRange range = NSMakeRange(11,8);
//        NSString *subNowTimeStr = [nowtimeymdhmsStr substringWithRange:range];//现在的时间 HH:mm:ss
//        NSArray *nowTimeArray= [subNowTimeStr componentsSeparatedByString:@":"];//课程开始的时间 hh:mm
//        NSString *nowTimeStr = nowTimeArray.firstObject;
//        NSInteger nowTime = nowTimeStr.integerValue;
//        
//        if (lessThan==1) {// 大于今天
//            
//            NSInteger shengyuCount = _appointInfoModel.coursestudentcount.intValue - _appointInfoModel.selectedstudentcount.intValue;
//            
//            if (shengyuCount>0) {// 可预约
//                
//                self.startTimeLabel.textColor = [UIColor blackColor];
//                self.finalTimeLabel.textColor = [UIColor blackColor];
//                
//            }else{// 不可预约
//                
//                self.startTimeLabel.textColor = [UIColor lightGrayColor];
//                self.finalTimeLabel.textColor = [UIColor lightGrayColor];
//                self.remainingPersonLabel.textColor = [UIColor blackColor];
//                self.remainingPersonLabel.text = @"换同时段其他教练";
//                self.isModifyCoach = YES;
//                
//            }
//            
//        }else{// 今天
//           
//            if (startTime <= nowTime) {// 开始时间小于当前时间
//                
//                self.userInteractionEnabled = NO;
//                
//                self.startTimeLabel.textColor = [UIColor lightGrayColor];
//                self.finalTimeLabel.textColor = [UIColor lightGrayColor];
//                self.remainingPersonLabel.textColor = [UIColor lightGrayColor];
//                
//            }else{// 开始时间大于当前时间
//                
//                NSInteger shengyuCount = _appointInfoModel.coursestudentcount.intValue - _appointInfoModel.selectedstudentcount.intValue;
//                
//                if (shengyuCount>0) {// 可预约
//                    
//                    self.startTimeLabel.textColor = [UIColor blackColor];
//                    self.finalTimeLabel.textColor = [UIColor blackColor];
//                    
//                }else{// 不可预约
//                    
//                    self.startTimeLabel.textColor = [UIColor lightGrayColor];
//                    self.finalTimeLabel.textColor = [UIColor lightGrayColor];
//                    self.remainingPersonLabel.textColor = [UIColor blackColor];
//                    self.remainingPersonLabel.text = @"换同时段其他教练";
//                    self.isModifyCoach = YES;
//
//                }
//                
//            }
//            
//        }
//        
//       
//        
//    }
//        
//}

- (NSString *)dealStringWithTime:(NSString *)value {
    NSUInteger lenth = value.length;
    NSUInteger lastLenth = lenth-3;
    NSString *resultString = [value substringWithRange:NSMakeRange(0, lastLenth)];
    return resultString;
}
@end
