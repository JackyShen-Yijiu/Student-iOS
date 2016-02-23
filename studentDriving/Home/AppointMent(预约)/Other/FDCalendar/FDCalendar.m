//
//  FDCalendar.m
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "FDCalendar.h"
#import "FDCalendarItem.h"
#import "UIViewController+Method.h"

#define Weekdays @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"]

static NSDateFormatter *dateFormattor;

@interface FDCalendar () <UIScrollViewDelegate, FDCalendarItemDelegate>
{
    CGFloat startContentOffsetX;
    CGFloat willEndContentOffsetX;
    CGFloat endContentOffsetX;
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) FDCalendarItem *leftCalendarItem;
@property (strong, nonatomic) FDCalendarItem *centerCalendarItem;
@property (strong, nonatomic) FDCalendarItem *rightCalendarItem;

@property(nonatomic,strong)NSDateFormatter *dateFormattor;

@property (nonatomic,copy) NSString *coachID;

@property (strong, nonatomic) NSDate *seletedDate;

@end

@implementation FDCalendar

- (instancetype)initWithData:(NSDate *)date{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.seletedDate = date;
        
        // 星期
        [self setupWeekHeader];
        
        // 滚动视图、三个日历
        [self setupCalendarItems];
        
        // 设置滚动视图
        [self setupScrollView];
        
        [self setFrame:CGRectMake(0, 0, DeviceWidth, CGRectGetMaxY(self.scrollView.frame))];
        
        [self setCurrentDate:self.seletedDate coachID:self.coachID];

    }
    return self;
}

#pragma mark - Private

- (NSString *)stringFromDate:(NSDate *)date {
    if (!dateFormattor) {
        dateFormattor = [[NSDateFormatter alloc] init];
        [dateFormattor setDateFormat:@"yyyy年M月"];
    }
    return [dateFormattor stringFromDate:date];
}

// 设置星期文字的显示
- (void)setupWeekHeader {
    
    UIView *weekTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, ITEMHEIGTH)];
    weekTitleView.backgroundColor = YBNavigationBarBgColor;
    [self addSubview:weekTitleView];
    
    NSInteger count = [Weekdays count];
    
    CGFloat offsetX = 0.f;
    CGFloat width  = (DeviceWidth - offsetX * 2)/ count;
    
    for (int i = 0; i < count; i++) {
        
        UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 0, width, ITEMHEIGTH)];
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        weekdayLabel.text = Weekdays[i];
        weekdayLabel.font = [UIFont systemFontOfSize:10.f];
        weekdayLabel.textColor = [UIColor whiteColor];
        weekdayLabel.backgroundColor = YBNavigationBarBgColor;
        
        [weekTitleView addSubview:weekdayLabel];
        offsetX += weekdayLabel.frame.size.width;
        
    }
    
}

// 设置包含日历的item的scrollView
- (void)setupScrollView
{
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.scrollView setFrame:CGRectMake(0, ITEMHEIGTH, DeviceWidth, self.centerCalendarItem.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(3 * self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    [self addSubview:self.scrollView];
    
    UIView *delive = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame)-0.5, self.scrollView.width, 0.5)];
    delive.backgroundColor = [UIColor lightGrayColor];
    delive.alpha = 0.3;
    [self addSubview:delive];
    
}

// 设置3个日历的item
- (void)setupCalendarItems {
    
    self.scrollView = [[UIScrollView alloc] init];
    
    self.leftCalendarItem = [[FDCalendarItem alloc] init];
    self.leftCalendarItem.parentViewController = self.parentViewController;
    self.leftCalendarItem.backgroundColor = RGBColor(238, 238, 238);
    [self.scrollView addSubview:self.leftCalendarItem];
    
    self.centerCalendarItem = [[FDCalendarItem alloc] init];
    self.centerCalendarItem.parentViewController = self.parentViewController;
    CGRect itemFrame = self.leftCalendarItem.frame;
    itemFrame.origin.x = DeviceWidth;
    self.centerCalendarItem.frame = itemFrame;
    self.centerCalendarItem.delegate = self;
    self.centerCalendarItem.backgroundColor = RGBColor(238, 238, 238);
    [self.scrollView addSubview:self.centerCalendarItem];
    
    self.rightCalendarItem = [[FDCalendarItem alloc] init];
    self.rightCalendarItem.parentViewController = self.parentViewController;
    itemFrame.origin.x = DeviceWidth * 2;
    self.rightCalendarItem.frame = itemFrame;
    self.rightCalendarItem.backgroundColor = RGBColor(238, 238, 238);
    [self.scrollView addSubview:self.rightCalendarItem];
    
}

// 设置当前日期，初始化
- (void)setCurrentDate:(NSDate *)date coachID:(NSString *)coachID
{
    NSLog(@"设置当前日期，初始化");
    
    self.coachID = coachID;
    self.seletedDate = date;
    
    self.centerCalendarItem.date = date;
    
    self.leftCalendarItem.date = [self.centerCalendarItem previousMonthDate];
    
    self.rightCalendarItem.date = [self.centerCalendarItem nextMonthDate];
 
    // 设置当前月份的预约
    [self loadCurrentCalendarData:date];
    
    // 设置选中的月份的教练休假信息
    if (coachID&&[coachID length]!=0) {
        [self loadCurrentMonthStateWithData:date coachID:coachID];
    }
    
}

// 设置当前日期，初始化
- (void)loadCurrentDate:(NSDate *)date coachID:(NSString *)coachID
{
    NSLog(@"设置当前日期，初始化");
    
    self.centerCalendarItem.date = date;
    
    self.leftCalendarItem.date = [self.centerCalendarItem previousMonthDate];
    
    self.rightCalendarItem.date = [self.centerCalendarItem nextMonthDate];
    
    // 设置顶部标题
//    [self.titleLabel setText:[self stringFromDate:self.centerCalendarItem.date]];
    if ([_delegate respondsToSelector:@selector(fdCalendar:didSelectedDate:)]) {
        [_delegate fdCalendar:self didSelectedDate:self.centerCalendarItem.date];
    }
    
    // 设置当前月份的预约
    [self loadCurrentCalendarData:date];
    
    // 设置选中的月份的教练休假信息
    [self loadCurrentMonthStateWithData:date coachID:coachID];

}

// 获取教练每个月的休假安排
- (void)loadCurrentMonthStateWithData:(NSDate *)date coachID:(NSString *)coachID
{
    NSLog(@"设置当前月份的休假 网络请求 date.description:%@",date.description);
    
    if (!self.dateFormattor) {
        self.dateFormattor = [[NSDateFormatter alloc] init];
    }
    // 年
    [self.dateFormattor setDateFormat:@"yyyy"];
    NSString * yearStr = [self.dateFormattor stringFromDate:date];
    // 月
    [self.dateFormattor setDateFormat:@"M"];
    NSString * monthStr = [self.dateFormattor stringFromDate:date];
    
    WS(ws);
    [NetWorkEntiry getCoachInfoWithUserId:coachID yearTime:yearStr monthTime:monthStr success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"刷新日历：responseObject:%@",responseObject);
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        
        if (type == 1) {
            
            NSDictionary *array = responseObject[@"data"];
            
            // 休假
            NSArray *leaveoff = [array objectForKey:@"leaveoff"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                ws.centerCalendarItem.restArray = leaveoff;
                
                [ws.centerCalendarItem reloadData];
                
            });
            
        }else{
            
            NSLog(@"%@",responseObject[@"msg"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [ws.centerCalendarItem reloadData];
        
    }];
    
}

// 获取用户预约数据
- (void)loadCurrentCalendarData:(NSDate *)date
{
    NSLog(@"设置当前月份的预约、休假 网络请求 date.description:%@",date.description);
    
    /*
     
    if (!self.dateFormattor) {
        self.dateFormattor = [[NSDateFormatter alloc] init];
    }
    // 年
    [self.dateFormattor setDateFormat:@"yyyy"];
    NSString * yearStr = [self.dateFormattor stringFromDate:date];
    // 月
    [self.dateFormattor setDateFormat:@"M"];
    NSString * monthStr = [self.dateFormattor stringFromDate:date];
    
    WS(ws);
    
    [NetWorkEntiry getAppointMentWithyearTime:yearStr monthTime:monthStr success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"刷新日历：responseObject:%@",responseObject);
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        
        if (type == 1) {
            
            NSDictionary *array = responseObject[@"data"];

            // 预约
            NSArray *reservationapply = [array objectForKey:@"reservationapply"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                ws.centerCalendarItem.bookArray = reservationapply;
                
                [ws.centerCalendarItem reloadData];
                
            });
            
        }else{
            
            NSLog(@"%@",responseObject[@"msg"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [ws.centerCalendarItem reloadData];

    }];
     
     */

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{//拖动前的起始坐标
    
    startContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{    //将要停止前的坐标
    
    willEndContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    endContentOffsetX = scrollView.contentOffset.x;
    
    if (endContentOffsetX < willEndContentOffsetX && willEndContentOffsetX < startContentOffsetX) { // 画面从右往左移动，前一页
        [self setPreviousMonthDate];
        NSLog(@"画面从右往左移动，前一页");
    } else if (endContentOffsetX > willEndContentOffsetX && willEndContentOffsetX > startContentOffsetX) {// 画面从左往右移动，后一页
        [self setNextMonthDate];
        NSLog(@"画面从左往右移动，后一页");
    }
    
    // 重置
    self.scrollView.contentOffset = CGPointMake(self.scrollView.width, 0);
    
}

#pragma mark - UIScrollViewDelegate

#pragma mark - SEL
// 跳到上一个月
- (void)setPreviousMonthDate
{
    [self loadCurrentDate:[self.centerCalendarItem previousMonthDate] coachID:self.coachID];
}
// 跳到下一个月
- (void)setNextMonthDate {
    [self loadCurrentDate:[self.centerCalendarItem nextMonthDate] coachID:self.coachID];
}

#pragma mark - FDCalendarItemDelegate
- (void)calendarItem:(FDCalendarItem *)item didSelectedDate:(NSDate *)date
{
    
    NSLog(@"%s",__func__);
    
    self.seletedDate = date;
    self.centerCalendarItem.date = date;
    self.leftCalendarItem.date = date;
    self.rightCalendarItem.date = date;
    
    // 刷新控制器底部数据
    if ([_delegate respondsToSelector:@selector(fdCalendar:didSelectedDate:)]) {
        [_delegate fdCalendar:self didSelectedDate:self.seletedDate];
    }
    
}

@end
