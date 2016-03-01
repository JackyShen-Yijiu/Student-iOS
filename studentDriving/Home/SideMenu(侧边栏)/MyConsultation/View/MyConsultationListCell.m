//
//  MyConsultationListCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MyConsultationListCell.h"
#import "PortraitView.h"

#define JGMargin 16

@interface MyConsultationListCell ()

// 问头像
@property(nonatomic,strong)PortraitView * askPotraitView;
// 答头像
@property(nonatomic,strong)PortraitView * replyPotraitView;

// 问姓名
@property(nonatomic,strong)UILabel * askNameTitle;
// 答姓名
@property(nonatomic,strong)UILabel * replyNameTitle;

// 问时间
@property(nonatomic,strong)UILabel * askTimeLabel;
// 答时间
@property(nonatomic,strong)UILabel * replyTimeLabel;

// 问内容
@property(nonatomic,strong)UILabel * askSubTitle;
// 答内容
@property(nonatomic,strong)UILabel * replySubTitle;

// 中间分割线
@property(nonatomic,strong)UIView * delive;

@property(nonatomic,strong)UIView * footView;

@end

@implementation MyConsultationListCell

// 问头像
- (PortraitView *)askPotraitView
{
    if (_askPotraitView==nil) {
        _askPotraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _askPotraitView.layer.cornerRadius = 20.f;
        _askPotraitView.layer.shouldRasterize = YES;
        _askPotraitView.backgroundColor = [UIColor clearColor];
        _askPotraitView.imageView.image = [UIImage imageNamed:@"coach_man_default_icon"];
    }
    return _askPotraitView;
}
// 答头像
- (PortraitView *)replyPotraitView
{
    if (_replyPotraitView==nil) {
        _replyPotraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _replyPotraitView.layer.cornerRadius = 20.f;
        _replyPotraitView.layer.shouldRasterize = YES;
        _replyPotraitView.backgroundColor = [UIColor clearColor];
        _replyPotraitView.imageView.image = [UIImage imageNamed:@"coach_man_default_icon"];
    }
    return _replyPotraitView;
}

// 问姓名
- (UILabel *)askNameTitle
{
    if (_askNameTitle==nil) {
        _askNameTitle = [[UILabel alloc] init];
        _askNameTitle.textAlignment = NSTextAlignmentLeft;
        _askNameTitle.font = [UIFont systemFontOfSize:15.f];
        _askNameTitle.textColor = [UIColor lightGrayColor];
        _askNameTitle.backgroundColor = [UIColor clearColor];
        _askNameTitle.numberOfLines = 1;
        _askNameTitle.text = @"askNameTitle";
    }
    return _askNameTitle;
}
// 答姓名
- (UILabel *)replyNameTitle
{
    if (_replyNameTitle==nil) {
        _replyNameTitle = [[UILabel alloc] init];
        _replyNameTitle.textAlignment = NSTextAlignmentLeft;
        _replyNameTitle.font = [UIFont systemFontOfSize:15.f];
        _replyNameTitle.textColor = [UIColor lightGrayColor];
        _replyNameTitle.backgroundColor = [UIColor clearColor];
        _replyNameTitle.numberOfLines = 1;
        _replyNameTitle.text = @"replyNameTitle";
    }
    return _replyNameTitle;
}

// 问时间
- (UILabel *)askTimeLabel
{
    if (_askNameTitle==nil) {
        _askTimeLabel = [[UILabel alloc] init];
        _askTimeLabel.textAlignment = NSTextAlignmentRight;
        _askTimeLabel.font = [UIFont systemFontOfSize:10.f];
        _askTimeLabel.textColor = [UIColor lightGrayColor];
        _askTimeLabel.backgroundColor = [UIColor clearColor];
        _askTimeLabel.numberOfLines = 1;
        _askTimeLabel.text = @"askTimeLabel";
    }
    return _askNameTitle;
}
// 答时间
- (UILabel *)replyTimeLabel
{
    if (_replyTimeLabel==nil) {
        _replyTimeLabel = [[UILabel alloc] init];
        _replyTimeLabel.textAlignment = NSTextAlignmentRight;
        _replyTimeLabel.font = [UIFont systemFontOfSize:10.f];
        _replyTimeLabel.textColor = [UIColor lightGrayColor];
        _replyTimeLabel.backgroundColor = [UIColor clearColor];
        _replyTimeLabel.numberOfLines = 1;
        _replyTimeLabel.text = @"replyTimeLabel";
    }
    return _replyTimeLabel;
}
// 问内容
- (UILabel *)askSubTitle
{
    if (_askSubTitle==nil) {
        _askSubTitle = [[UILabel alloc] init];
        _askSubTitle.textAlignment = NSTextAlignmentLeft;
        _askSubTitle.font = [UIFont systemFontOfSize:13.f];
        _askSubTitle.textColor = [UIColor grayColor];
        _askSubTitle.backgroundColor = [UIColor clearColor];
        _askSubTitle.numberOfLines = 0;
        _askSubTitle.text = @"askSubTitleaskSubTitleaskSubTitleaskSubTitleaskSubTitleaskSubTitleaskSubTitle";
    }
    return _askSubTitle;
}
// 答内容
- (UILabel *)replySubTitle
{
    if (_replySubTitle==nil) {
        _replySubTitle = [[UILabel alloc] init];
        _replySubTitle.textAlignment = NSTextAlignmentLeft;
        _replySubTitle.font = [UIFont systemFontOfSize:13.f];
        _replySubTitle.textColor = [UIColor grayColor];
        _replySubTitle.backgroundColor = [UIColor clearColor];
        _replySubTitle.numberOfLines = 0;
        _replySubTitle.text = @"replySubTitlereplySubTitlereplySubTitlereplySubTitlereplySubTitlereplySubTitle";
    }
    return _replySubTitle;
}
// 中间分割线
- (UIView *)delive
{
    if (_delive == nil) {
        _delive = [[UIView alloc] init];
        _delive.backgroundColor = [UIColor lightGrayColor];
        _delive.alpha = 0.3;
    }
    return _delive;
}

// 中间分割线
- (UIView *)footView
{
    if (_footView == nil) {
        _footView = [[UIView alloc] init];
        _footView.backgroundColor = RGBColor(216, 216, 216);
    }
    return _footView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = RGBColor(255, 255, 255);
        
        // 问头像
        [self.contentView addSubview:self.askPotraitView];
        
        // 答头像
        [self.contentView addSubview:self.replyPotraitView];
        
        // 问姓名
        [self.contentView addSubview:self.askNameTitle];
        
        // 答姓名
        [self.contentView addSubview:self.replyNameTitle];
        
        // 问时间
        [self.contentView addSubview:self.askTimeLabel];
        
        // 答时间
        [self.contentView addSubview:self.replyTimeLabel];
        
        // 问内容
        [self.contentView addSubview:self.askSubTitle];
        
        // 答内容
        [self.contentView addSubview:self.replySubTitle];
        
        // 中间分割线
        [self.contentView addSubview:self.delive];
        
        [self.contentView addSubview:self.footView];
        
        [self updateConstraints];
        
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    // 问头像
    [self.askPotraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40.f));
        make.left.equalTo(@15);
        make.top.equalTo(@16);//
    }];
    
    // 问姓名
    [self.askNameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.askPotraitView.top);
        make.left.mas_equalTo(self.askPotraitView.mas_right).offset(16);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@100);
    }];
    
    // 问时间
    [self.askTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.left.mas_equalTo(self.askNameTitle.mas_left).offset(20);
        make.top.mas_equalTo(self.askNameTitle.mas_top);
    }];
    
    // 问内容
    [self.askSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.askNameTitle.mas_bottom).offset(8);//
        make.left.equalTo(self.askNameTitle.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
    }];
    
    // 中间分割线
    [self.delive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.askSubTitle.mas_bottom).offset(16);//
        make.left.mas_equalTo(self.askNameTitle.mas_left);
        make.height.mas_equalTo(@1);//
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
    }];
    
    // 答头像
    [self.replyPotraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40.f));
        make.left.equalTo(@15);
        make.top.mas_equalTo(self.delive.mas_bottom).offset(16);//
    }];
    
    // 答姓名
    [self.replyNameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.askNameTitle.mas_left);
        make.top.mas_equalTo(self.replyPotraitView.mas_top);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@100);
    }];
    
    // 答时间
    [self.replyTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.left.mas_equalTo(self.replyNameTitle.mas_left).offset(20);
        make.top.mas_equalTo(self.replyNameTitle.mas_top);
    }];
    
    // 答内容
    [self.replySubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.replyNameTitle.mas_bottom).offset(8);//
        make.left.equalTo(self.replyNameTitle.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
    }];
    
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.top.mas_equalTo(self.replySubTitle.mas_bottom).offset(16);
        make.height.mas_equalTo(@10);
    }];
    
}

- (void)setDetailModel:(NSDictionary *)detailModel
{
    _detailModel = detailModel;
    // 问头像
    [self.askPotraitView.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:@"coach_man_default_icon"]];
    
    // 答头像
    [self.replyPotraitView.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:@"coach_man_default_icon"]];

    // 问姓名
    self.askNameTitle.text = @"askNameTitle";
    
    // 答姓名
    self.replyNameTitle.text = @"replyNameTitle";
    
    // 问时间
    self.askTimeLabel.text = @"askTimeLabel";
    
    // 答时间
    self.replyTimeLabel.text = @"replyTimeLabel";
    
    // 问内容
    self.askSubTitle.text = @"askSubTitle";
    
    // 答内容
    self.replySubTitle.text = @"replySubTitle";
    
//    self.titleLabel.text = [NSString stringWithFormat:@"投诉教练:%@",_detailModel[@"coachid"][@"name"]];
//    
//    self.timeLabel.text = [NSString getYearLocalDateFormateUTCDate:[NSString stringWithFormat:@"%@",_detailModel[@"complaint"][@"complainttime"]]];
//    
//    self.countentLabel.text = [NSString stringWithFormat:@"%@",_detailModel[@"complaint"][@"complaintcontent"]];
    
}

+ (CGFloat)heightWithModel:(NSDictionary *)model
{
    
    MyConsultationListCell *cell = [[MyConsultationListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyConsultationListCell"];
    
//    cell.detailModel = model;
    
    [cell layoutIfNeeded];
    
    return cell.askNameTitle.height+cell.askSubTitle.height+cell.replyNameTitle.height+cell.replySubTitle.height+16+8+16+16+8+16+cell.footView.height;
    
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

@end
