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
    self.potraitView.backgroundColor = [UIColor redColor];
    [self addSubview:self.potraitView];
    
    // 当前学车进度
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:13.f];
    self.titleLabel.textColor = RGBColor(0x33, 0x33, 0x33);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.text = @"当前学车进度:科目二第4课时 侧方停车";
    [self addSubview:self.titleLabel];
    
    // 已约   官方学时
    self.subTitle = [[UILabel alloc] init];
    self.subTitle.textAlignment = NSTextAlignmentLeft;
    self.subTitle.font = [UIFont systemFontOfSize:13.f];
    self.subTitle.textColor = [UIColor grayColor];
    self.subTitle.backgroundColor = [UIColor clearColor];
    self.subTitle.numberOfLines = 1;
    self.subTitle.text = @"已约25课时   官方学时23课时";
    [self addSubview:self.subTitle];
    
    // 漏课  剩余学时
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    self.detailLabel.font = [UIFont systemFontOfSize:13.f];
    self.detailLabel.textColor = [UIColor grayColor];
    self.detailLabel.backgroundColor = [UIColor clearColor];
    self.detailLabel.numberOfLines = 1;
    self.detailLabel.text = @"漏课10课时  剩余学时4课时";
    [self addSubview:self.detailLabel];
   
    // 分割线
    self.bottomLine = [self getOnelineView];
    [self addSubview:self.bottomLine];
    
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
- (void)setModel:(HMCourseModel *)model
{
    if (_model == model) {
        return;
    }
    
    _model = model;
    
    UIImage * defaultImage = [UIImage imageNamed:@"defoult_por"];
    self.potraitView.imageView.image = defaultImage;
    NSString * imageStr = _model.studentInfo.porInfo.originalpic;
    if(imageStr)
        [self.potraitView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage];
    
    self.titleLabel.text = @"nameTitle";
    
    self.subTitle.text = @"subTitle";
    
    self.detailLabel.text = @"detailLabel";

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
