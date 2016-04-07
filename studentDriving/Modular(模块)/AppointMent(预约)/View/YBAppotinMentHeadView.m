//
//  YBAppotinMentHeadView.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppotinMentHeadView.h"
#import "PortraitView.h"

@interface YBAppotinMentHeadView ()
@property(nonatomic,strong)PortraitView * potraitView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * subTitle;
@property(nonatomic,strong)UILabel * detailLabel;
@property(nonatomic,strong)UIView * bottomLine;

@end

@implementation YBAppotinMentHeadView

+ (CGFloat)height
{
    return 88;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.frame = CGRectMake(0, 0, kSystemWide, 88);
        
        [self initUI];
        
    }
    return self;
}

- (void)initUI
{
    
    self.backgroundColor = RGBColor(250, 250, 250);
    
    // 头像
    self.potraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.potraitView.layer.cornerRadius = 20.f;
    self.potraitView.layer.shouldRasterize = YES;
    self.potraitView.backgroundColor = YBNavigationBarBgColor;
    [self addSubview:self.potraitView];
    
    // 当前学车进度
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:13.f];
    self.titleLabel.textColor = RGBColor(0x33, 0x33, 0x33);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.text = @"暂无数据";
    [self addSubview:self.titleLabel];
    
    // 已约   官方学时
    self.subTitle = [[UILabel alloc] init];
    self.subTitle.textAlignment = NSTextAlignmentLeft;
    self.subTitle.font = [UIFont systemFontOfSize:13.f];
    self.subTitle.textColor = [UIColor grayColor];
    self.subTitle.backgroundColor = [UIColor clearColor];
    self.subTitle.numberOfLines = 1;
    self.subTitle.text = @"暂无数据";
    [self addSubview:self.subTitle];
    
    // 漏课  剩余学时
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    self.detailLabel.font = [UIFont systemFontOfSize:13.f];
    self.detailLabel.textColor = [UIColor grayColor];
    self.detailLabel.backgroundColor = [UIColor clearColor];
    self.detailLabel.numberOfLines = 1;
    self.detailLabel.text = @"暂无数据";
    [self addSubview:self.detailLabel];
   
    // 分割线
    self.bottomLine = [self getOnelineView];
    [self addSubview:self.bottomLine];
    
    // 添加数据
    [self setUpData];

    [self updateConstraints];
    
}

#pragma mark Layout
- (void)updateConstraints
{
    [super updateConstraints];
    
    [self.potraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40.f));
        make.left.equalTo(@15);
        make.centerY.equalTo(self.mas_centerY);
    }];
   
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.potraitView.mas_right).offset(10);
        make.top.mas_equalTo(@17);
//        make.height.mas_equalTo(@20);
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.titleLabel.mas_left);
//        make.height.mas_equalTo(self.titleLabel.mas_height);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.subTitle.mas_bottom).offset(5);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(-HM_LINE_HEIGHT);
        make.height.equalTo(@(HM_LINE_HEIGHT));
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
    
}

#pragma mark - Data
- (void)setUpData
{
    
    NSString * imageStr = nil;
    
    if ([AcountManager manager].subjecttwo.progress) {
        imageStr = [NSString stringWithFormat:@"YBStudyPregressTwo"];
        self.titleLabel.text = [NSString stringWithFormat:@"当前学车进度:%@",[AcountManager manager].subjecttwo.progress];
    }
    if ([AcountManager manager].subjectthree.progress) {
        imageStr = [NSString stringWithFormat:@"YBStudyPregressThree"];
        self.titleLabel.text = [NSString stringWithFormat:@"当前学车进度:%@",[AcountManager manager].subjectthree.progress];
    }
    
    if (imageStr) {
        self.potraitView.imageView.image = [UIImage imageNamed:imageStr];
    }
    
    
    
    NSMutableString *subStr = [NSMutableString string];
    if ([AcountManager manager].subjecttwo.reservation && [AcountManager manager].subjecttwo.finishcourse) {
        NSInteger yiyuexueshiCount = [[AcountManager manager].subjecttwo.reservation integerValue] + [[AcountManager manager].subjecttwo.finishcourse integerValue];

        [subStr appendString:[NSString stringWithFormat:@"已约学时:%ld课时",(long)yiyuexueshiCount]];
        
        NSString *officiahours = [NSString stringWithFormat:@"%@",[AcountManager manager].subjecttwo.officialhours];
        if (officiahours&&![officiahours isEqualToString:@"0"]) {
            [subStr appendString:[NSString stringWithFormat:@"    官方学时:%@课时",[AcountManager manager].subjecttwo.officialhours]];
        }

    }else if ([AcountManager manager].subjectthree.reservation && [AcountManager manager].subjectthree.finishcourse) {
        NSInteger yiyuexueshiCount = [[AcountManager manager].subjectthree.reservation integerValue] + [[AcountManager manager].subjectthree.finishcourse integerValue];
        NSLog(@"yiyuexueshiCount:%lu",yiyuexueshiCount);

        [subStr appendString:[NSString stringWithFormat:@"已约学时:%ld课时",(long)yiyuexueshiCount]];
        
        NSString *officiahours = [NSString stringWithFormat:@"%@",[AcountManager manager].subjectthree.officialhours];
        if (officiahours&&![officiahours isEqualToString:@"0"]) {
            [subStr appendString:[NSString stringWithFormat:@"    官方学时:%@课时",[AcountManager manager].subjectthree.officialhours]];
        }
        
    }
    if (subStr && [subStr length]!=0) {
        self.subTitle.text = subStr;
    }
    
    NSMutableString *detailStr = [NSMutableString string];
    if ([AcountManager manager].subjecttwo.missingcourse) {
        
        NSInteger loukeCount = [[AcountManager manager].subjecttwo.missingcourse integerValue];;
        NSLog(@"loukeCount:%ld",(long)loukeCount);
        [detailStr appendString:[NSString stringWithFormat:@"漏课:%ld课时",(long)loukeCount]];

    }else if ([AcountManager manager].subjectthree.missingcourse) {
        
        NSInteger loukeCount = [[AcountManager manager].subjectthree.missingcourse integerValue];
        NSLog(@"loukeCount:%ld",(long)loukeCount);
        [detailStr appendString:[NSString stringWithFormat:@"漏课:%ld课时",(long)loukeCount]];

    }
    
    
    if ([AcountManager manager].userSubject.subjectId.integerValue == 2) {
        
        NSInteger doneCourse = [AcountManager manager].subjecttwo.finishcourse.integerValue;
        NSInteger appointCourse = [AcountManager manager].subjecttwo.reservation.integerValue;
        NSInteger totalCourse = [AcountManager manager].subjecttwo.totalcourse.integerValue;
        NSInteger restCourse = totalCourse - doneCourse - appointCourse;
        
//        _appointDetailLabel.text = [NSString stringWithFormat:@"您已完成%zd课时，总共预约了%zd课时,科目二的可预约课时剩余%zd课时。",doneCourse,appointCourse,restCourse];
        
        [detailStr appendString:[NSString stringWithFormat:@"       剩余学时:%ld课时",(long)restCourse]];

    }else if ([AcountManager manager].userSubject.subjectId.integerValue == 3) {
        
        NSInteger doneCourse = [AcountManager manager].subjectthree.finishcourse.integerValue;
        NSInteger appointCourse = [AcountManager manager].subjectthree.reservation.integerValue;
        NSInteger totalCourse = [AcountManager manager].subjectthree.totalcourse.integerValue;
        NSInteger restCourse = totalCourse - doneCourse - appointCourse;
//        _appointDetailLabel.text = [NSString stringWithFormat:@"您已完成%zd课时，总共预约了%zd课时,科目三的可预约课时剩余%zd课时。",doneCourse,appointCourse,restCourse];
        
        [detailStr appendString:[NSString stringWithFormat:@"       剩余学时:%ld课时",(long)restCourse]];

    }
    
    if (detailStr&&[detailStr length]!=0) {
        self.detailLabel.text = detailStr;
    }


}


- (UIView *)getOnelineView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = HM_LINE_COLOR;
    return view;
}

- (UILabel *)getOnePropertyLabel
{
    UILabel * label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:10.f];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
