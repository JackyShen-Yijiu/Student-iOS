//
//  Created by Dmitry Ivanenko on 15.04.14.
//  Copyright (c) 2014 Dmitry Ivanenko. All rights reserved.
//

#import "DIDatepickerDateView.h"
#import "YBObjectTool.h"

const CGFloat kDIDatepickerItemWidth = 46.;
const CGFloat kDIDatepickerSelectionLineWidth = 51.;

@interface DIDatepickerDateView ()

@property (strong, nonatomic) UILabel *weekLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (nonatomic, strong) UIView *selectionView;

@end


@implementation DIDatepickerDateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;

    [self setupViews];

    return self;
}

- (void)setupViews
{
    [self addTarget:self action:@selector(dateWasSelected) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setDate:(NSDate *)date
{
    _date = date;

    NSLocale *locale = [NSLocale systemLocale];
    
    // 周
    // 几号
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 周几
    [dateFormatter setDateFormat:@"EEE"];
    NSString *dayInWeekFormattedString = [[dateFormatter stringFromDate:date] uppercaseStringWithLocale:locale];
    
    int compareDay = [YBObjectTool compareDateWithSelectDate:_date];
    if (compareDay==0) {
        dayInWeekFormattedString = @"今天";
    }
    
    // 几号
    [dateFormatter setDateFormat:@"dd"];
    NSString *dayFormattedString = [dateFormatter stringFromDate:date];
    NSLog(@"dayFormattedString:%@",dayFormattedString);
    
//    [dateFormatter setDateFormat:@"MMMM"];
//    NSString *monthFormattedString = [[dateFormatter stringFromDate:date] uppercaseString];

    NSMutableAttributedString *dateString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [dayInWeekFormattedString uppercaseString],dayFormattedString]];

    [dateString addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:15],
                                NSForegroundColorAttributeName: [UIColor lightGrayColor]
                                }
                        range:NSMakeRange(0, dayFormattedString.length)];

    [dateString addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:13],
                                NSForegroundColorAttributeName: [UIColor grayColor]
                                }
                        range:NSMakeRange(dayFormattedString.length + 1, dayInWeekFormattedString.length)];

//    [dateString addAttributes:@{
//                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:8],
//                                NSForegroundColorAttributeName: [UIColor colorWithRed:153./255. green:153./255. blue:153./255. alpha:1.]
//                                }
//                        range:NSMakeRange(dateString.string.length - monthFormattedString.length, monthFormattedString.length)];

//    if ([self isWeekday:date]) {
//        [dateString addAttribute:NSFontAttributeName
//                           value:[UIFont fontWithName:@"HelveticaNeue-Medium" size:8]
//                           range:NSMakeRange(dayFormattedString.length + 1, dayInWeekFormattedString.length)];
//    }
    NSLog(@"dateString:%@",dateString.mutableString);
//    self.dateLabel.attributedText = dateString;
    
    self.weekLabel.text = [NSString stringWithFormat:@"%@",[dayInWeekFormattedString uppercaseString]];
    self.dateLabel.text = [NSString stringWithFormat:@"%@",dayFormattedString];
    
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;

    self.selectionView.alpha = (int)_isSelected;
    
    if (isSelected) {
        self.dateLabel.textColor = [UIColor whiteColor];
    }else{
        self.dateLabel.textColor = [UIColor grayColor];
    }
    
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height/2-5, self.width, self.height/2)];
        _dateLabel.font = [UIFont systemFontOfSize:13];
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}

- (UILabel *)weekLabel
{
    if (!_weekLabel) {
        _weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height/2)];
        _weekLabel.textAlignment = NSTextAlignmentCenter;
        _weekLabel.font = [UIFont systemFontOfSize:15];
        _weekLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_weekLabel];
    }
    return _weekLabel;
}

- (UIView *)selectionView
{
    if (!_selectionView) {
        // CGRectMake((self.frame.size.width - 51) / 2, self.frame.size.height - 3, 51, 3)
        _selectionView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-25/2, self.frame.size.height - 25 - 5, 25, 25)];
        _selectionView.alpha = 0;
        _selectionView.layer.masksToBounds = YES;
        _selectionView.layer.cornerRadius = _selectionView.width/2;
        _selectionView.backgroundColor = [UIColor colorWithRed:242./255. green:93./255. blue:28./255. alpha:1.];
        [self insertSubview:_selectionView belowSubview:self.dateLabel];
    }

    return _selectionView;
}

- (void)setItemSelectionColor:(UIColor *)itemSelectionColor
{
    self.selectionView.backgroundColor = itemSelectionColor;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.selectionView.alpha = self.isSelected ? 1 : .5;
//        self.dateLabel.textColor = self.isSelected ? [UIColor whiteColor] : YBNavigationBarBgColor;
    } else {
        self.selectionView.alpha = self.isSelected ? 1 : 0;
        //self.dateLabel.textColor = self.isSelected ? [UIColor whiteColor] : YBNavigationBarBgColor;
    }
}


#pragma mark Other methods

- (BOOL)isWeekday:(NSDate *)date
{
    NSInteger day = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday];

    const NSInteger kSunday = 1;
    const NSInteger kSaturday = 7;

    BOOL isWeekdayResult = day == kSunday || day == kSaturday;

    return isWeekdayResult;
}

- (void)dateWasSelected
{
    self.isSelected = YES;

    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
