//
//  YBAppointmentListCell.m
//  studentDriving
//
//  Created by 大威 on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointmentListCell.h"
#import "YBObjectTool.h"
#import "UIImageView+DVVWebImage.h"

@implementation YBAppointmentListCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBAppointmentListCell" owner:self options:nil];
        self = xibArray.firstObject;
        [self setRestorationIdentifier:reuseIdentifier];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.lineImageView];
        
        [_iconImageView.layer setMasksToBounds:YES];
        [_iconImageView.layer setCornerRadius:19];
        
        // 字体颜色
        _statusLabel.textColor = YBNavigationBarBgColor;
        _nameLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _schoolLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
        _timeLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _subjectLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGFloat minX = CGRectGetMinX(_nameLabel.frame);
    _lineImageView.frame = CGRectMake(minX, size.height - 0.5, size.width - minX - 8, 0.5);
}

- (IBAction)qrCodeButtonAction:(UIButton *)sender {
    
    NSLog(@"点击了二维码");
    
    
}


#pragma mark 刷新数据

- (void)refreshData:(HMCourseModel *)model
    appointmentTime:(NSUInteger)appointmentTime {
    
    if (_model == model) {
        return;
    }
    _model = model;
    
    // 如果是今天的预约，检查是否可以签到
    if (0 == appointmentTime) {
        [self checkSignIn];
    }else {
        NSString *MMString = [self getLocalDateFormateUTCDate:_model.courseBeginTime format:@"MM"];
        NSString *ddString = [self getLocalDateFormateUTCDate:_model.courseBeginTime format:@"dd"];
        // 将后台传回的时间转化为HH:mm格式的
        NSString *format = @"HH:mm";
        NSString *beginString = [self getLocalDateFormateUTCDate:_model.courseBeginTime format:format];
        
        NSString *endString = [self getLocalDateFormateUTCDate:_model.courseEndtime format:format];
        
        _timeLabel.text = [NSString stringWithFormat:@"%@/%@ %@-%@", MMString, ddString, beginString, endString];
    }
    
    NSString * imageStr = _model.userModel.headportrait.originalpic;
    [_iconImageView dvv_downloadImage:imageStr placeholderImage:[UIImage imageNamed:@"coach_man_default_icon"]];
    
    _statusLabel.text = [_model getStatueString];
    
    _nameLabel.text = _model.userModel.name;
    
    _subjectLabel.text = _model.courseprocessdesc;
    
    _schoolLabel.text = _model.courseTrainInfo.address;
}


/**
 *   检查是否可以签到
 */
- (void)checkSignIn {
    
    // 将后台传回的时间转化为HH:mm格式的
    NSString *format = @"HH:mm";
    NSString *beginString = [self getLocalDateFormateUTCDate:_model.courseBeginTime format:format];
    
    NSString *endString = [self getLocalDateFormateUTCDate:_model.courseEndtime format:format];
    
    _timeLabel.text = [NSString stringWithFormat:@"今天 %@-%@", beginString, endString];
    
    // 判断当前的时间是否可以签到
    NSString *currentHH = [self dateFromLocalWithFormatString:@"HH"];
    NSString *currentMM = [self dateFromLocalWithFormatString:@"mm"];
    NSString *beginHH = [beginString substringToIndex:2];
    NSString *endHH = [endString substringToIndex:2];
    
    BOOL flage = NO;
    // 在开始前的15分钟之内
    if ([currentHH integerValue] < [beginHH integerValue]) {
        if (1 == ([beginHH integerValue] - [currentHH integerValue])) {
            
            if (60 - [currentMM integerValue] <= 15) {
                flage = YES;
            }
        }
    }
    
    NSLog(@"%@---%@---%@", currentHH, beginHH, endHH);
    // 学车过程中
    if ([currentHH integerValue] <= [endHH integerValue] && [currentHH integerValue] >= [beginHH integerValue]) {
        flage = YES;
    }
    
    if (flage) {
        _qrCodeButton.userInteractionEnabled = YES;
        _qrCodeImageView.image = [UIImage imageNamed:@"YBAppointMentDetailscode_on"];
        _qrCodeMarkLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
    }else {
        _qrCodeButton.userInteractionEnabled = NO;
        _qrCodeImageView.image = [UIImage imageNamed:@"YBAppointMentDetailscode_off"];
        _qrCodeMarkLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
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
