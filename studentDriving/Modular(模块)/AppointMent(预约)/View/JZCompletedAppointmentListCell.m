//
//  JZCompletedAppointmentListCell.m
//  studentDriving
//
//  Created by ytzhang on 16/4/28.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZCompletedAppointmentListCell.h"
#import "UIImageView+DVVWebImage.h"

@implementation JZCompletedAppointmentListCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.iconImageView];
    [self addSubview:self.statusLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.schoolLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.subjectLabel];
    [self addSubview:self.subjectIntroductionLabel];
    [self addSubview:self.lineView];
    
}
- (void)layoutSubviews{
    
    CGFloat Height = 10;
    if (YBIphone6Plus) {
        Height = 10 * YB_Height_Ratio;
    }
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(15);
         make.left.mas_equalTo(self.mas_left).offset(16);
        
        CGFloat iconImgeW = 38;
        CGFloat iconImgeH = 38;
        if (YBIphone6Plus) {
             iconImgeW = 38 * YB_1_5_Ratio;
           iconImgeH = 38 * YB_1_5_Ratio;
        }
        
        make.height.mas_equalTo(iconImgeH);
        make.width.mas_equalTo(iconImgeW);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(Height);
        make.height.mas_equalTo(@12);
        make.width.mas_equalTo(@64);
        make.centerX.mas_equalTo(self.iconImageView.mas_centerX);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.mas_equalTo(self.mas_top).offset(16);
         make.left.mas_equalTo(self.iconImageView.mas_right).offset(16);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@100);
        
    }];
    [self.schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(Height);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.height.mas_equalTo(@12);
        
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.schoolLabel.mas_bottom).offset(Height);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.height.mas_equalTo(@12);
        
    }];
    [self.subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(18);
        make.right.mas_equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(@12);
        
    }];
    [self.subjectIntroductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.subjectLabel.mas_bottom).offset(Height);
        make.right.mas_equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(@12);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@0.5);
        
    }];



}
#pragma mark 刷新数据

- (void)refreshData:(HMCourseModel *)model {
    
    if (_model == model) {
        return;
    }
    _model = model;
    
    NSString *MMString = [self getLocalDateFormateUTCDate:_model.courseBeginTime format:@"MM"];
    NSString *ddString = [self getLocalDateFormateUTCDate:_model.courseBeginTime format:@"dd"];
    // 将后台传回的时间转化为HH:mm格式的
    NSString *format = @"HH:mm";
    NSString *beginString = [self getLocalDateFormateUTCDate:_model.courseBeginTime format:format];
    
    NSString *endString = [self getLocalDateFormateUTCDate:_model.courseEndtime format:format];
    
    _timeLabel.text = [NSString stringWithFormat:@"%@/%@ %@-%@", MMString, ddString, beginString, endString];
    
    NSString * imageStr = _model.userModel.headportrait.originalpic;
    [_iconImageView dvv_downloadImage:imageStr placeholderImage:[UIImage imageNamed:@"coach_man_default_icon"]];
    
    _statusLabel.text = [_model getStatueString];
    
    _nameLabel.text = _model.userModel.name;
    
    _subjectLabel.text = _model.courseprocessdesc;
    
    _schoolLabel.text = _model.courseTrainInfo.address;
    
    _subjectIntroductionLabel.text = _model.learningcontent ? _model.learningcontent : @"教练未确认";
    
    NSLog(@"_model.sigintime:%@",_model.sigintime);
    
    if (_model.sigintime && _model.sigintime.length) {
        _signInTimeLabel.text = [NSString stringWithFormat:@"签到时间 %@", [self getLocalDateFormateUTCDate:_model.sigintime format:@"HH:mm"]];
    }else{
        _signInTimeLabel.text = @"";
        //        _subjectIntroductionLabel.text = @"";
    }
    
}

- (NSString *)dateFromLocalWithFormatString:(NSString *)formatString {
    
    NSDate *localDate = [NSDate new];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter stringFromDate:localDate];
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
- (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate format:(NSString *)formatString {
    //    NSLog(@"utc = %@",utcDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:formatString];
    //    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 19;
        if (YBIphone6Plus) {
            _iconImageView.layer.cornerRadius = 19 * YB_1_5_Ratio;
        }
        
    }
    return _iconImageView;
}
- (UILabel *)statusLabel{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = JZ_FONTCOLOR_LIGHT;
        CGFloat fontSize = 12;
        if (YBIphone6Plus) {
            fontSize = 12 * YBRatio;
        }
        
        _statusLabel.font = [UIFont systemFontOfSize:fontSize];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = JZ_FONTCOLOR_DRAK;
        CGFloat fontSize = 14;
        if (YBIphone6Plus) {
            fontSize = 14 * YBRatio;
        }
        _nameLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    return _nameLabel;
}
- (UILabel *)schoolLabel{
    if (_schoolLabel == nil) {
        _schoolLabel = [[UILabel alloc] init];
        _schoolLabel.textColor = JZ_FONTCOLOR_LIGHT;
        CGFloat fontSize = 12;
        if (YBIphone6Plus) {
            fontSize = 12 * YBRatio;
        }
        _schoolLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    return _schoolLabel;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = JZ_FONTCOLOR_LIGHT;
        CGFloat fontSize = 12;
        if (YBIphone6Plus) {
            fontSize = 12 * YBRatio;
        }
        _timeLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    return _timeLabel;
}
- (UILabel *)subjectLabel{
    if (_subjectLabel == nil) {
        _subjectLabel = [[UILabel alloc] init];
        _subjectLabel.textColor = JZ_FONTCOLOR_DRAK;
        CGFloat fontSize = 12;
        if (YBIphone6Plus) {
            fontSize = 12 * YBRatio;
        }
        _subjectLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    return _subjectLabel;
}
- (UILabel *)subjectIntroductionLabel{
    if (_subjectIntroductionLabel == nil) {
        _subjectIntroductionLabel = [[UILabel alloc] init];
        _subjectIntroductionLabel.textColor = JZ_FONTCOLOR_LIGHT;
        CGFloat fontSize = 12;
        if (YBIphone6Plus) {
            fontSize = 12 * YBRatio;
        }
        _subjectIntroductionLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    return _subjectIntroductionLabel;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}
@end
