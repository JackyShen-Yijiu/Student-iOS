//
//  YBMyComplaintListCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "YBMyComplaintListCell.h"
#import "CoachDetail.h"
#import "JGTeachingNewsChangDiView.h"
#import "GBTagListView.h"

#define JGMargin 16

@interface YBMyComplaintListCell ()

// title
@property (strong, nonatomic) UILabel *titleLabel;
// 详情
@property (strong, nonatomic) UILabel *countentLabel;
// 时间
@property (strong, nonatomic) UILabel *timeLabel;
// 底部分割线
@property (strong, nonatomic) UIView *footView;

/// 第一张图片
@property (nonatomic, strong) UIImageView *firstImageView;
/// 第二张图片
@property (nonatomic, strong) UIImageView *secondImageView;



@end

@implementation YBMyComplaintListCell


- (UILabel *)titleLabel {
    
    if (_titleLabel == nil) {
        _titleLabel = [WMUITool initWithTextColor:[UIColor grayColor] withFont:[UIFont boldSystemFontOfSize:14]];
        _titleLabel.text = @"投诉教练";
    }
    return _titleLabel;
}

- (UILabel *)countentLabel {
    
    if (_countentLabel == nil) {
        _countentLabel = [WMUITool initWithTextColor:[UIColor lightGrayColor] withFont:[UIFont boldSystemFontOfSize:14]];
        _countentLabel.text = @"投诉教练内容投诉教练内容投诉教练内容投诉教练内容投诉教练内容投诉教练内容投诉教练内容";
        _countentLabel.numberOfLines = 0;
    }
    return _countentLabel;
}

- (UILabel *)timeLabel {
    
    if (_timeLabel == nil) {
        _timeLabel = [WMUITool initWithTextColor:[UIColor lightGrayColor] withFont:[UIFont boldSystemFontOfSize:12]];
        _timeLabel.text = @"2016年02月21日";
    }
    return _timeLabel;
}

// 底部分割线
- (UIView *)footView
{
    if (_footView == nil) {
        _footView = [[UIView alloc] init];
        _footView.backgroundColor = [UIColor lightGrayColor];
        _footView.alpha = 0.3;
    }
    return _footView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.countentLabel];
    
    [self.contentView addSubview:self.timeLabel];
    
    // 底部分割线
    [self.contentView addSubview:self.footView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(18);//
        make.left.equalTo(self.contentView.mas_left).offset(JGMargin);
        make.height.equalTo(@14);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-JGMargin);
        make.top.mas_equalTo(self.titleLabel.mas_top);
        make.height.mas_equalTo(@12);
    }];
    
    [self.countentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(JGMargin);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(12);//
        make.right.mas_equalTo(self.timeLabel.mas_right);
    }];
    
    // 分割线
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countentLabel.mas_bottom).offset(18);//
        make.left.equalTo(@0);
        make.height.equalTo(@0.5);
        make.width.equalTo(@(kSystemWide));
    }];
    
}

- (void)setDetailModel:(NSDictionary *)detailModel
{
    _detailModel = detailModel;

    self.titleLabel.text = [NSString stringWithFormat:@"投诉教练:%@",_detailModel[@"coachid"][@"name"]];
    
    self.timeLabel.text = [NSString getYearLocalDateFormateUTCDate:[NSString stringWithFormat:@"%@",_detailModel[@"complaint"][@"complainttime"]]];
    
    self.countentLabel.text = [NSString stringWithFormat:@"%@",_detailModel[@"complaint"][@"complaintcontent"]];
    
}

+ (CGFloat)heightWithModel:(NSDictionary *)model
{
    
    YBMyComplaintListCell *cell = [[YBMyComplaintListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBMyComplaintListCell"];
    
    cell.detailModel = model;
    
    [cell layoutIfNeeded];
    
    return cell.titleLabel.height+cell.countentLabel.height+18+12+18+0.5;
    
}
@end
