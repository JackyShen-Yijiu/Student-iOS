//
//  courseSummaryDayCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CourseSummaryDayCell.h"
#import "PortraitView.h"
#import "HMTrainaddressModel.h"
#import "YBObjectTool.h"

@interface CourseSummaryDayCell ()

@property(nonatomic,strong)PortraitView * potraitView;
@property(nonatomic,strong)UILabel * stateLabel;
@property(nonatomic,strong)UILabel * nameTitle;
@property(nonatomic,strong)UILabel * subTitle;
@property(nonatomic,strong)UILabel * placeLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UIView * bottomLine;

@end

@implementation CourseSummaryDayCell
+ (CGFloat)cellHeight
{
    return 88;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    self.potraitView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.potraitView];
    
    // 状态
    self.stateLabel = [self getOnePropertyLabel];
    self.stateLabel.textColor = RGBColor(219, 68, 55);
    self.stateLabel.text = @"订单状态";
    [self.contentView addSubview:self.stateLabel];
    
    // 姓名
    self.nameTitle = [[UILabel alloc] init];
    self.nameTitle.textAlignment = NSTextAlignmentLeft;
    self.nameTitle.font = [UIFont systemFontOfSize:15.f];
    self.nameTitle.textColor = RGBColor(0x33, 0x33, 0x33);
    self.nameTitle.backgroundColor = [UIColor clearColor];
    self.nameTitle.numberOfLines = 1;
    self.nameTitle.text = @"姓名";
    [self.contentView addSubview:self.nameTitle];
    
    // 科目二 第5课时
    self.subTitle = [[UILabel alloc] init];
    self.subTitle.textAlignment = NSTextAlignmentLeft;
    self.subTitle.font = [UIFont systemFontOfSize:13.f];
    self.subTitle.textColor = [UIColor blackColor];
    self.subTitle.backgroundColor = [UIColor clearColor];
    self.subTitle.numberOfLines = 1;
    self.subTitle.text = @"subTitle";
    [self.contentView addSubview:self.subTitle];
    
    // 地址
    self.placeLabel = [[UILabel alloc] init];
    self.placeLabel.textAlignment = NSTextAlignmentLeft;
    self.placeLabel.font = [UIFont systemFontOfSize:13.f];
    self.placeLabel.textColor = [UIColor grayColor];
    self.placeLabel.backgroundColor = [UIColor clearColor];
    self.placeLabel.numberOfLines = 1;
    self.placeLabel.text = @"placeLabel";
    [self.contentView addSubview:self.placeLabel];
    
    // 时间
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.font = [UIFont systemFontOfSize:10.f];
    self.timeLabel.textColor = RGBColor(219, 68, 55);
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.numberOfLines = 1;
    self.timeLabel.text = @"timeLabel";
    [self.contentView addSubview:self.timeLabel];
    
    // 分割线
    self.bottomLine = [self getOnelineView];
    [self.contentView addSubview:self.bottomLine];
    
    [self updateConstraints];
    
}

#pragma mark Layout
- (void)updateConstraints
{
    [super updateConstraints];
    
    [self.potraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40.f));
        make.left.equalTo(@15);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];

    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.top.equalTo(self.potraitView.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.potraitView.mas_centerX);
    }];

    [self.nameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.potraitView.mas_right).offset(10);
        make.top.mas_equalTo(@17);
        make.height.mas_equalTo(@20);
    }];

    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameTitle.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(self.nameTitle.mas_height);
    }];

    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameTitle.mas_bottom).offset(5);
        make.left.mas_equalTo(self.nameTitle.mas_left);
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameTitle.mas_left);
        make.top.mas_equalTo(self.placeLabel.mas_bottom).offset(5);
    }];

    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom).offset(-HM_LINE_HEIGHT);
        make.height.equalTo(@(HM_LINE_HEIGHT));
        make.left.equalTo(self.nameTitle.mas_left);
        make.right.equalTo(@0);
    }];

   
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    self.contentView.backgroundColor = highlighted ? HM_HIGHTCOLOR : [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    self.contentView.backgroundColor = selected ? [UIColor colorWithWhite:0.9 alpha:1]  : [UIColor whiteColor];
}

#pragma mark - Data
- (void)setModel:(HMCourseModel *)model
{
    if (_model == model) {
        return;
    }

    _model = model;
    
    UIImage * defaultImage = [UIImage imageNamed:@"defoult_por"];
    self.potraitView.imageView.image = defaultImage;
    NSString * imageStr = _model.userModel.headportrait.originalpic;
    if(imageStr)
        [self.potraitView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage];
    
    self.stateLabel.text = [_model getStatueString];
    
    self.nameTitle.text = _model.userModel.name;
    
    self.subTitle.text = _model.courseprocessdesc;
    
    self.placeLabel.text = _model.courseTrainInfo.address;
    
    self.timeLabel.text = _model.courseTime;
    
    int compareDataNum = [YBObjectTool compareDateWithSelectDateStr:[NSString getYearLocalDateFormateUTCDate:_model.courseBeginTime]];
    
    if (compareDataNum==0) {// 当前
        self.timeLabel.textColor = RGBColor(219, 68, 55);
    }else{
        self.timeLabel.textColor = [UIColor grayColor];
    }
    
}

#pragma mark - Common

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


@end
