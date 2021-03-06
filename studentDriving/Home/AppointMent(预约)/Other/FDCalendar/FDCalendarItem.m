//
//  FDCalendarItem.m
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "FDCalendarItem.h"
#import "YBObjectTool.h"

@interface FDCalendarCell : UICollectionViewCell

@property(nonatomic,assign) KCellStation station;

- (UIView *)selectView;
- (UILabel *)dayLabel;
//- (UILabel *)chineseDayLabel;
- (UILabel *)pointView;
- (UILabel *)restLabel;
- (UIView *)lineView;

@end

@implementation FDCalendarCell

{
    UIView *_selectView;
    UILabel *_dayLabel;
//    UILabel *_chineseDayLabel;
    UIView *_pointView;
    UIView * _lineView;
    UILabel *_restLabel;
}

// 日期
- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2-10, 5, 20, 15)];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_dayLabel];
    }
    return _dayLabel;
}
//// 农历
//- (UILabel *)chineseDayLabel {
//    if (!_chineseDayLabel) {
//        _chineseDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2-10, calendarItemH-10*2.5, 20, 10)];
//        _chineseDayLabel.textAlignment = NSTextAlignmentCenter;
//        _chineseDayLabel.font = [UIFont boldSystemFontOfSize:9];
//        _chineseDayLabel.textColor = [UIColor lightGrayColor];
//        [self addSubview:_chineseDayLabel];
//    }
//    return _chineseDayLabel;
//}
// 预约蓝色点
- (UIView *)pointView
{
    if (!_pointView) {
        _pointView = [[UIView alloc] init];
        _pointView.backgroundColor =  YBNavigationBarBgColor;
        _pointView.frame = CGRectMake(_dayLabel.center.x-2,calendarItemH-17-4, 4, 4);
        _pointView.layer.masksToBounds = YES;
        [_pointView setHidden:YES];
        _pointView.layer.cornerRadius = _pointView.size.width/2.f;
        [self addSubview:_pointView];
    }
    return _pointView;
}
// 休息
- (UILabel *)restLabel {
    
    if (!_restLabel) {
        _restLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2-15/2, calendarItemH-25-15, 15, 15)];
        _restLabel.textAlignment = NSTextAlignmentCenter;
        _restLabel.font = [UIFont systemFontOfSize:8];
        _restLabel.backgroundColor = [UIColor clearColor];
        _restLabel.textColor = [UIColor lightGrayColor];
        _restLabel.text = @"休";
        _restLabel.hidden = YES;
        [self addSubview:_restLabel];
    }
    return _restLabel;
}
// 选择的圈圈
- (UIView *)selectView
{
    if (!_selectView) {
        _selectView = [[UIView alloc] init];
        _selectView.frame = CGRectMake(self.width/2-25/2,0,25,25);
        _selectView.layer.masksToBounds = YES;
        _selectView.backgroundColor = YBNavigationBarBgColor;
        _selectView.layer.cornerRadius = _selectView.size.width/2.f;
        [self insertSubview:_selectView belowSubview:self.contentView];
    }
    return _selectView;
}

- (UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor colorWithRed:0xe6/255.f green:0xe6/255.f blue:0xe6/255.f alpha:1.f];
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (self.station) {
        case KCellStationCenter:
            self.lineView.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5f);
            break;
        case KCellStationLeft:
            self.lineView.frame = CGRectMake(-20, self.frame.size.height - 0.5, self.frame.size.width + 20, 0.5f);
            break;
        case KCellStationRight:
            self.lineView.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width + 20, 0.5f);
            break;
    }
   // self.maskView.center = CGPointMake(self.width/2.f, self.height/2.f);
    [self pointView].center = CGPointMake(self.width/2.f, self.height-17-2);
}

- (void)setIsSeletedDay:(BOOL)isSeletedDay curDay:(BOOL)isCurDay
{
    
    // 在此处判断是否需要显示红点
    // 如果是预约的就显示红点
    [[self pointView] setHidden:isCurDay];
    
    if (isCurDay) {
//        self.dayLabel.textColor = isCurDay ? RGB_Color(40, 121, 243) : [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.f];
//        if (isSeletedDay) {
//            [self.maskView setHidden:NO];
//            [[self pointView] setHidden:YES];
//            self.dayLabel.textColor = [UIColor whiteColor];
//        }else{
//            [self.maskView setHidden:YES];
//            [[self pointView] setHidden:NO];
//            self.dayLabel.textColor = RGB_Color(40, 121, 243);
//        }
    }else{
//        if (isSeletedDay) {
//            [self.maskView setHidden:NO];
//            [[self pointView] setHidden:YES];
//            self.dayLabel.textColor = [UIColor whiteColor];
//        }else{
//            [self.maskView setHidden:YES];
//            [[self pointView] setHidden:YES];
//            self.dayLabel.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.f];
//        }
        
    }
}

@end

#define CollectionViewHorizonMargin 5
#define CollectionViewVerticalMargin 5

#define ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
#define ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]

typedef NS_ENUM(NSUInteger, FDCalendarMonth) {
    FDCalendarMonthPrevious = 0,
    FDCalendarMonthCurrent = 1,
    FDCalendarMonthNext = 2,
};

@interface FDCalendarItem () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation FDCalendarItem

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupCollectionView];
        [self setFrame:CGRectMake(0, 0, DeviceWidth, calendarItemH)];
    }
    return self;
}

#pragma mark - Custom Accessors

//- (void)setDate:(NSDate *)date
//{
//    _date = date;
//    
//    [self.collectionView reloadData];
//    
//}

- (void)reloadData
{
    NSLog(@"reloadData.restArray:%@",self.restArray);
    NSLog(@"reloadData.bookArray:%@",self.bookArray);
    
    self.collectionView.contentOffset = CGPointMake([self getCurrentDataOffsetWithData:self.date], 0);
    
    [self.collectionView reloadData];
    
}

- (CGFloat)getCurrentDataOffsetWithData:(NSDate *)date
{
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"dd"];
   
    NSString *dateStr = [fomatter stringFromDate:date];
    
    if ([YBObjectTool compareMonthDateWithSelectDate:date]!=1) {
        return [dateStr integerValue] / 7 * self.collectionView.width;
    }else{
        return 0;
    }

}

//- (BOOL)isBelongCurrentMonthToData:(NSDate *)date
//{
//    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
//    [fomatter setDateFormat:@"yyyy-mm"];
//    
//    NSString *dataStr = [fomatter stringFromDate:date];
//    
//    NSDate *currentDate = [NSDate date];
//    NSString *currentDataStr = [fomatter stringFromDate:currentDate];
//    
//    if ([dataStr isEqualToString:currentDataStr]) {
//        return YES;
//    }else{
//        return NO;
//    }
//    
//}

#pragma mark - Public

// 获取date的下个月日期
- (NSDate *)nextMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return nextMonthDate;
}

// 获取date的上个月日期
- (NSDate *)previousMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    NSDate *previousMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return previousMonthDate;
}

#pragma mark - Private

// collectionView显示日期单元，设置其属性
- (void)setupCollectionView
{
    CGFloat itemWidth = (DeviceWidth - CollectionViewHorizonMargin * 2) / 7;
    CGFloat itemHeight = calendarItemH;
    
    UICollectionViewFlowLayout *flowLayot = [[UICollectionViewFlowLayout alloc] init];
    flowLayot.sectionInset = UIEdgeInsetsZero;
    flowLayot.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayot.minimumLineSpacing = 0;
    flowLayot.minimumInteritemSpacing = 0;
    //水平滑动
    flowLayot.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGRect collectionViewFrame = CGRectMake(CollectionViewHorizonMargin, CollectionViewVerticalMargin, DeviceWidth - CollectionViewHorizonMargin * 2, itemHeight);
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayot];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[FDCalendarCell class] forCellWithReuseIdentifier:@"CalendarCell"];
    [self addSubview:self.collectionView];

}

// 获取date当前月的第一天是星期几
- (NSInteger)weekdayOfFirstDayInDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    [components setDay:1];
    NSDate *firstDate = [calendar dateFromComponents:components];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDate];
    return firstComponents.weekday - 1;
}

// 获取date当前月的总天数
- (NSInteger)totalDaysInMonthOfDate:(NSDate *)date {
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

// 获取某月day的日期
- (NSDate *)dateOfMonth:(FDCalendarMonth)calendarMonth WithDay:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date;
    
    switch (calendarMonth) {
        case FDCalendarMonthPrevious:
            date = [self previousMonthDate];
            break;
        case FDCalendarMonthCurrent:
            date = self.date;
            break;
        case FDCalendarMonthNext:
            date = [self nextMonthDate];
            break;
        default:
            break;
    }
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:day];
    
    NSDate *dateOfDay = [calendar dateFromComponents:components];
    
    return dateOfDay;
    
}

// 获取date当天的农历
- (NSString *)chineseCalendarOfDate:(NSDate *)date {
    
    NSString *day;
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    if (components.day == 1) {
        day = ChineseMonths[components.month - 1];
    } else {
        day = ChineseDays[components.day - 1];
    }
    
    return day;
}

#pragma mark - UICollectionDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    // 最多有31天、 展示5列数据 x 7天
    return 35;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CalendarCell";
    FDCalendarCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.dayLabel.textColor = [UIColor lightGrayColor];
    cell.selectView.hidden = YES;
    cell.pointView.hidden = YES;
    cell.restLabel.hidden = YES;
    
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    NSInteger totalDaysOfMonth = [self totalDaysInMonthOfDate:self.date];
    NSInteger totalDaysOfLastMonth = [self totalDaysInMonthOfDate:[self previousMonthDate]];
    
    // cell点击变色
    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBGView.backgroundColor = [UIColor clearColor];
    // 点击选中的圆圈
    UIView *selVc = [[UIView alloc] initWithFrame:CGRectMake(cell.width/2-25/2,0,25,25)];
    selVc.layer.masksToBounds = YES;
    selVc.layer.cornerRadius = selVc.height / 2;
    BOOL isBook = [self isBook:self.bookArray day:[cell.dayLabel.text integerValue]];
    if (isBook) {
        selVc.backgroundColor = YBNavigationBarBgColor;
        cell.selectView.backgroundColor = YBNavigationBarBgColor;
    }else{
        selVc.backgroundColor = YBNavigationBarBgColor;
        cell.selectView.backgroundColor = [UIColor blackColor];
    }
    [selectedBGView addSubview:selVc];
    cell.selectedBackgroundView = selectedBGView;
    
    if (indexPath.row < firstWeekday) {// 小于这个月的第一天
        
        cell.dayLabel.textColor = [UIColor lightGrayColor];
        cell.dayLabel.text = nil;
        cell.pointView.hidden = YES;
//        cell.chineseDayLabel.hidden = YES;
        cell.restLabel.hidden = YES;
        cell.selectedBackgroundView = nil;

        //NSInteger day = totalDaysOfLastMonth - firstWeekday + indexPath.row + 1;
        //cell.dayLabel.text = [NSString stringWithFormat:@"%ld", day];
        //cell.dayLabel.textColor = [UIColor grayColor];
        //cell.chineseDayLabel.text = [self chineseCalendarOfDate:[self dateOfMonth:FDCalendarMonthPrevious WithDay:day]];
        
    } else if (indexPath.row >= totalDaysOfMonth + firstWeekday) {    // 大于这个月的最后一天
        
//        NSInteger day = indexPath.row - totalDaysOfMonth - firstWeekday + 1;
//        cell.dayLabel.text = [NSString stringWithFormat:@"%ld", day];
//        cell.dayLabel.textColor = [UIColor grayColor];
//        cell.chineseDayLabel.text = [self chineseCalendarOfDate:[self dateOfMonth:FDCalendarMonthNext WithDay:day]];
//
        cell.dayLabel.textColor = [UIColor whiteColor];
        cell.dayLabel.text = nil;
        cell.pointView.hidden = YES;
//        cell.chineseDayLabel.hidden = YES;
        cell.restLabel.hidden = YES;
        cell.selectedBackgroundView = nil;

    } else {// 属于当前选择的这个月
        
        NSInteger day = indexPath.row - firstWeekday + 1;
        cell.dayLabel.text= [NSString stringWithFormat:@"%ld", day];
//        cell.chineseDayLabel.hidden = NO;
        
        int compareDataNum = [YBObjectTool compareDateWithSelectDate:[self getCurrentData:indexPath]];
        if (compareDataNum==0) {// 当前
            
            cell.dayLabel.textColor = YBNavigationBarBgColor;
            cell.pointView.hidden = NO;

            BOOL isRest = [self isRest:self.restArray day:[cell.dayLabel.text integerValue]];
            if (isRest) {// 有休假
                cell.restLabel.hidden = NO;
                cell.pointView.hidden = YES;
            }else{// 未休假
                cell.restLabel.hidden = YES;
            }
            
        }else if (compareDataNum==1){// 大于当前日期
            
            cell.dayLabel.textColor = [UIColor blackColor];
            
        }else if (compareDataNum==-1){// 小于当前日期
            
            cell.dayLabel.textColor = [UIColor lightGrayColor];
            
        }
        
        // 判断当天是否和选中的日期一致
        if (day == [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self.date]) {// 当前日期和选中的日期一致
         
            NSLog(@"****************%ld",(long)day);

            if (day == [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]]) {// 选中的日期和当前日期一致
              
                // 当前日期和选中的日期一致
                NSLog(@"当前日期和选中的日期一致------------%ld",(long)day);
                cell.selectView.hidden = NO;
                cell.dayLabel.textColor = [UIColor whiteColor];
                
            }else{

                NSLog(@"+++++++++++++%ld",(long)day);
                cell.selectView.hidden = NO;
                cell.dayLabel.textColor = [UIColor whiteColor];
            }
            
        }else{// 当前日期和选中的日期不一致
            
            NSLog(@"=================%ld",(long)day);
            
        }

        // 如果日期和当期日期同年同月不同天, 注：第一个判断中的方法是iOS8的新API, 会比较传入单元以及比传入单元大得单元上数据是否相等，亲测同时传入Year和Month结果错误
        if ([[NSCalendar currentCalendar] isDate:[NSDate date] equalToDate:self.date toUnitGranularity:NSCalendarUnitMonth] && ![[NSCalendar currentCalendar] isDateInToday:self.date]) {
            
            // 将当前日期的那天高亮显示
            if (day == [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]]) {
                
            }else{
                
            }
            
        }else{
            
        }
        
//        cell.chineseDayLabel.text = [self chineseCalendarOfDate:[self dateOfMonth:FDCalendarMonthCurrent WithDay:day]];
//        cell.chineseDayLabel.hidden = YES;// 隐藏农历
        
        if (compareDataNum!=0) {// 不是当前
            
            // 根据服务器返回数据判断是否休假
            if (self.restArray && [self.restArray count]!=0) {
                cell.restLabel.hidden = ![self isRest:self.restArray day:[cell.dayLabel.text integerValue]];
            }
            
        }
        
        // 红点
//        NSDate *curDate = [self dateOfMonth:FDCalendarMonthCurrent WithDay:day];
//        BOOL isSelectedData = [self isEnqual:curDate :self.seletedDate];
//        [cell setIsSeletedDay:isSelectedData curDay:[self isEnqual:curDate :[NSDate date]]];
//        
        // 根据服务器返回数据判断是否预约
//        if (self.bookArray && [self.bookArray count]!=0) {
//            cell.pointView.hidden = ![self isBook:self.bookArray day:[cell.dayLabel.text integerValue]];
//        }
        
    }
    
    if (indexPath.row % 7 == 0) {
        cell.station = KCellStationLeft;
    }else if (indexPath.row % 7 == 6){
        cell.station = KCellStationRight;
    }else{
        cell.station = KCellStationCenter;
    }
    
    return cell;
}

- (BOOL)isRest:(NSArray *)restArray day:(NSInteger)day
{
    
    if (restArray && restArray.count>0) {// 休假
        
        return [restArray containsObject:@(day)];
        
    }else{// 未休假
        
        return NO;
        
    }
    
}

- (BOOL)isBook:(NSArray *)bookArray day:(NSInteger)day
{
    
    if (bookArray && bookArray.count>0) {// 有预约
        
       return [bookArray containsObject:@(day)];
        
    }else{// 没有预约
        
        return NO;
        
    }
    
}


// 根据item获取日期
- (NSDate *)getCurrentData:(NSIndexPath *)indexPath
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    
    [components setDay:indexPath.row - firstWeekday + 1];
    
    NSDate *selectedDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return selectedDate;
    
}

- (BOOL)isEnqual:(NSDate *)date1 :(NSDate *)date2
{
    if(!date1 || !date2) return NO;
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date1];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date2];
    return (components1.year == components2.year) && (components1.month == components2.month) && (components1.day == components2.day);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    
    [components setDay:indexPath.row - firstWeekday + 1];
    
    NSDate *selectedDate = [[NSCalendar currentCalendar] dateFromComponents:components];
//    self.date = selectedDate;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarItem:didSelectedDate:)]) {
        [self.delegate calendarItem:self didSelectedDate:selectedDate];
    }

}


@end
