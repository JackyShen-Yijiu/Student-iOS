//
//  YBAppointMentDetailsCancleView.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointMentDetailsCancleView.h"
#import "PortraitView.h"
#import "HMCourseModel.h"

@interface YBAppointMentDetailsCancleView ()

@property(nonatomic,strong)PortraitView * potraitView;

@property(nonatomic,strong)UILabel * stateLabel;
@property(nonatomic,strong)UILabel * nameTitle;
@property(nonatomic,strong)UILabel * detailLabel;

@end

@implementation YBAppointMentDetailsCancleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBColor(236, 236, 236);
        
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
    [self addSubview:self.potraitView];
    
    // 状态
    self.stateLabel = [self getOnePropertyLabel];
    self.stateLabel.textColor = RGBColor(219, 68, 55);
    self.stateLabel.text = @"订单状态";
    [self addSubview:self.stateLabel];
    
    // 姓名
    self.nameTitle = [[UILabel alloc] init];
    self.nameTitle.textAlignment = NSTextAlignmentLeft;
    self.nameTitle.font = [UIFont systemFontOfSize:15.f];
    self.nameTitle.textColor = RGBColor(0x33, 0x33, 0x33);
    self.nameTitle.backgroundColor = [UIColor clearColor];
    self.nameTitle.numberOfLines = 1;
    self.nameTitle.text = @"姓名";
    [self addSubview:self.nameTitle];

    // 时间
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    self.detailLabel.font = [UIFont systemFontOfSize:10.f];
    self.detailLabel.textColor = RGBColor(219, 68, 55);
    self.detailLabel.backgroundColor = [UIColor clearColor];
    self.detailLabel.numberOfLines = 1;
    self.detailLabel.text = @"detailLabel";
    [self addSubview:self.detailLabel];
    
    [self updateConstraints];
    
}

#pragma mark Layout
- (void)updateConstraints
{
    [super updateConstraints];
    
    [self.potraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40.f));
        make.left.equalTo(@15);
        make.top.equalTo(@10);
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.top.equalTo(self.potraitView.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.potraitView.mas_centerX);
    }];
    
    [self.nameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.potraitView.mas_right).offset(10);
        make.right.mas_equalTo(@20);
        make.top.mas_equalTo(@17);
        make.height.mas_equalTo(@20);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameTitle.mas_left);
        make.top.mas_equalTo(self.nameTitle.mas_bottom);
        make.right.mas_equalTo(@20);
        make.height.mas_equalTo(@20);
    }];
    
}

#pragma mark - Data
- (void)setCourseModel:(HMCourseModel *)courseModel
{
    
    _courseModel = courseModel;
    
    UIImage * defaultImage = [UIImage imageNamed:@"defoult_por"];
    self.potraitView.imageView.image = defaultImage;
    NSString * imageStr = _courseModel.userModel.headportrait.originalpic;
    if(imageStr)
        [self.potraitView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage];
    
    self.stateLabel.text = [_courseModel getStatueString];
    
    self.nameTitle.text = [NSString stringWithFormat:@"取消原因:%@",_courseModel.cancelreason[@"reason"]];
    
    self.detailLabel.text = [NSString stringWithFormat:@"%@",_courseModel.cancelreason[@"cancelcontent"]];

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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
