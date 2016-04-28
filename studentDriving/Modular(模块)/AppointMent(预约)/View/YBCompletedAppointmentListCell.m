//
//  YBCompletedAppointmentListCell.m
//  studentDriving
//
//  Created by 大威 on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBCompletedAppointmentListCell.h"
#import "UIImageView+DVVWebImage.h"

@implementation YBCompletedAppointmentListCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBCompletedAppointmentListCell" owner:self options:nil];
        self = xibArray.firstObject;
        [self setRestorationIdentifier:reuseIdentifier];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
       
        
        [self.contentView addSubview:self.lineImageView];
        
        [_iconImageView.layer setMasksToBounds:YES];
        [_iconImageView.layer setCornerRadius:19];
        
        // 字体颜色
        _statusLabel.textColor = JZ_FONTCOLOR_LIGHT;
        _nameLabel.textColor = [UIColor colorWithHexString:@"2f2f2f"];
        _schoolLabel.textColor = JZ_FONTCOLOR_LIGHT;
        _timeLabel.textColor = JZ_FONTCOLOR_LIGHT;
        _subjectLabel.textColor = [UIColor colorWithHexString:@"2f2f2f"];
        _subjectIntroductionLabel.textColor = JZ_FONTCOLOR_LIGHT;
        _signInTimeLabel.textColor = YBNavigationBarBgColor;
        
        if (YBIphone6Plus) {
            // 头像
            _iconImageView.width = 38 * YB_1_5_Ratio;
            _iconImageView.height = 38 * YB_1_5_Ratio;
            CGFloat fontSizeBig = 14;
            CGFloat fontSizeSmall = 12;
            CGFloat margin = 10 * YB_Height_Ratio;
            
            // 漏课状态
            _statusLabel.font = [UIFont systemFontOfSize:fontSizeSmall * YBRatio];
            
            // 姓名
            _nameLabel.font = [UIFont systemFontOfSize:fontSizeBig * YBRatio];
            
            // 所属驾校
            _schoolLabel.font = [UIFont systemFontOfSize:fontSizeSmall * YBRatio];
            
            // 时间
            _timeLabel.font = [UIFont systemFontOfSize:fontSizeSmall * YBRatio];
            
            // 科目课时
            _subjectLabel.font = [UIFont systemFontOfSize:fontSizeBig * YBRatio];
            
            // 教练确认状态
            _subjectIntroductionLabel.font = [UIFont systemFontOfSize:fontSizeSmall * YBRatio];
            
        }
        
        
        
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGFloat minX = CGRectGetMinX(_nameLabel.frame);
    _lineImageView.frame = CGRectMake(minX, size.height - 0.5, size.width - minX, 0.5);
    
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


- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }
    return _lineImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
