//
//  JZAppiontMessageBottomCell.m
//  studentDriving
//
//  Created by ytzhang on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZAppiontMessageBottomCell.h"

@interface JZAppiontMessageBottomCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *lineView;



@end

@implementation JZAppiontMessageBottomCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.lineView];
    
}
- (void)layoutSubviews{
    
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
         make.bottom.mas_equalTo(self.contentView.mas_bottom);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
        make.height.mas_equalTo(@0.5);
        
    }];
    
    
}
- (void)timeChange:(UIDatePicker *)picker {
    
    
    
    
    
    NSDate *date = picker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串  yyyy-MM-dd
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *startDate = [dateFormatter stringFromDate:date];
    DYNSLog(@"tag = %ld",picker.tag);
    if (picker.tag == 600) {
        // 开始时间
        self.textField.text = startDate;
        
    }
    if (picker.tag == 602) {
        // 结束时间
        self.textField.text = startDate;
    }
    if ([self.JZAppointTimeBackDelegate respondsToSelector:@selector(initWithTime:timeTag:)]) {
        [self.JZAppointTimeBackDelegate  initWithTime:startDate timeTag:picker.tag];
    }
    
}

- (UIDatePicker *)timePicker {
    if (_timePicker == nil) {
        _timePicker = [[UIDatePicker alloc] init];
        // 初始化信息
        _timePicker.date = [NSDate date]; // 设置初始时间
        _timePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"]; // 设置时区，中国在东八区
        _timePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:0]; // 设置最小时间
        _timePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60 * 30 * 6]; // 设置最大时间
        _timePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [_timePicker addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
        _timePicker.tag = _pickTag;
    }
    return _timePicker;
}
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"开始时间";
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.inputView = self.timePicker;
        _textField.delegate = self;
        _textField.textAlignment = NSTextAlignmentCenter;
    }
    return _textField;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}


@end
