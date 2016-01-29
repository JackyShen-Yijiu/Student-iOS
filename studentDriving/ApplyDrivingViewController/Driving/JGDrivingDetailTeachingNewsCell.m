//
//  JGDrivingDetailTeachingNewsCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JGDrivingDetailTeachingNewsCell.h"
#import "CoachDetail.h"
#import "JGTeachingNewsChangDiView.h"

#define JGMargin 10

@interface JGDrivingDetailTeachingNewsCell ()

// 授课信息title
@property (strong, nonatomic) UILabel *titleLabel;
// 所属驾校
@property (strong, nonatomic) UILabel *suoshujiaxiaoLabel;
// 练车场地
@property (strong, nonatomic) UILabel *lianchechangdiLabel;
// 场地图片
@property (strong, nonatomic) JGTeachingNewsChangDiView *photosView;
// 分割线
@property (strong, nonatomic) UIView *midDelive;
// 个性标签标题
@property (strong, nonatomic) UILabel *gexingbiaoqianTitleLabel;
// 个性标签内容
@property (strong, nonatomic) UIView *gexingbiaoqianView;
// 底部分割线
@property (strong, nonatomic) UIView *footView;

@end

@implementation JGDrivingDetailTeachingNewsCell

// 授课信息title
- (UILabel *)titleLabel {
    
    if (_titleLabel == nil) {
        _titleLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont boldSystemFontOfSize:13]];
        _titleLabel.text = @"授课信息";
        _titleLabel.textColor = MAINCOLOR;
    }
    return _titleLabel;
}

// 所属驾校
- (UILabel *)suoshujiaxiaoLabel {
    
    if (_suoshujiaxiaoLabel == nil) {
        _suoshujiaxiaoLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:13]];
        _suoshujiaxiaoLabel.text = @"所属驾校";
        _suoshujiaxiaoLabel.textColor = [UIColor blackColor];
        _suoshujiaxiaoLabel.numberOfLines = 1;
    }
    return _suoshujiaxiaoLabel;
}

// 练车场地
- (UILabel *)lianchechangdiLabel {
    
    if (_lianchechangdiLabel == nil) {
        _lianchechangdiLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:13]];
        _lianchechangdiLabel.text = @"练车场地";
        _lianchechangdiLabel.textColor = [UIColor blackColor];
        _lianchechangdiLabel.numberOfLines = 1;
    }
    return _lianchechangdiLabel;
}

// 场地图片
- (UIView *)photosView
{
    if (_photosView== nil) {
        _photosView = [[JGTeachingNewsChangDiView alloc] init];
    }
    return _photosView;
}

// 分割线
- (UIView *)midDelive
{
    if (_midDelive== nil) {
        _midDelive = [[UIView alloc] init];
        _midDelive.backgroundColor = [UIColor lightGrayColor];
        _midDelive.alpha = 0.3;
    }
    return _midDelive;
}
// 个性标签标题
- (UILabel *)gexingbiaoqianTitleLabel {
    
    if (_gexingbiaoqianTitleLabel == nil) {
        _gexingbiaoqianTitleLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:13]];
        _gexingbiaoqianTitleLabel.text = @"个性标签:";
        _gexingbiaoqianTitleLabel.textColor = [UIColor blackColor];
        _gexingbiaoqianTitleLabel.numberOfLines = 1;
    }
    return _gexingbiaoqianTitleLabel;
}

// 个性标签内容
- (UIView *)gexingbiaoqianView
{
    if (_gexingbiaoqianView== nil) {
        _gexingbiaoqianView = [[UIView alloc] init];
        _gexingbiaoqianView.backgroundColor = [UIColor redColor];
    }
    return _gexingbiaoqianView;
}

// 底部分割线
- (UIView *)footView
{
    if (_footView == nil) {
        _footView = [[UIView alloc] init];
        _footView.backgroundColor = RGBColor(245, 247, 250);
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
    
    // 授课信息title
    [self.contentView addSubview:self.titleLabel];
    
    // 所属驾校
    [self.contentView addSubview:self.suoshujiaxiaoLabel];

    // 练车场地
    [self.contentView addSubview:self.lianchechangdiLabel];

    // 场地图片
    [self.contentView addSubview:self.photosView];

    // 分割线
    [self.contentView addSubview:self.midDelive];

    // 个性标签标题
    [self.contentView addSubview:self.gexingbiaoqianTitleLabel];

    // 个性标签内容
    [self.contentView addSubview:self.gexingbiaoqianView];

    // 底部分割线
    [self.contentView addSubview:self.footView];

    // 授课信息title
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(JGMargin);
        make.height.equalTo(@20);
    }];
    
    // 所属驾校
    [self.suoshujiaxiaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(JGMargin/2);//
        make.left.equalTo(self.contentView.mas_left).offset(JGMargin);
        make.height.equalTo(@20);
    }];
    
    // 练车场地
    [self.lianchechangdiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.suoshujiaxiaoLabel.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(JGMargin);
        make.height.equalTo(@20);
    }];
    
    // 场地图片
    [self.photosView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lianchechangdiLabel.mas_bottom).offset(JGMargin/2);//
        make.left.equalTo(self.contentView.mas_left).offset(JGMargin);
        make.height.equalTo(@70);
        make.width.equalTo(@(kSystemWide-JGMargin*2));
    }];
    
    // 分割线
    [self.midDelive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photosView.mas_bottom).offset(JGMargin);//
        make.left.equalTo(self.contentView.mas_left).offset(JGMargin);
        make.height.equalTo(@0.5);
        make.width.equalTo(@(kSystemWide-0.5));
    }];
    
    // 个性标签标题
    [self.gexingbiaoqianTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.midDelive.mas_bottom).offset(JGMargin);//
        make.left.equalTo(self.contentView.mas_left).offset(JGMargin);
        make.height.equalTo(@20);
        make.width.equalTo(@(60));
    }];
    
    // 个性标签内容
    [self.gexingbiaoqianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gexingbiaoqianTitleLabel.mas_top);
        make.left.equalTo(self.gexingbiaoqianTitleLabel.mas_right).offset(JGMargin/2);
        make.width.equalTo(@(kSystemWide-60-JGMargin*2.5));
        make.height.equalTo(@50);
    }];
    
    // 灰色底部
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.gexingbiaoqianView.mas_bottom).offset(JGMargin);//
        make.height.mas_equalTo(JGMargin);
        make.width.mas_equalTo(self.contentView);
    }];
}


- (void)setDetailModel:(CoachDetail *)detailModel
{
    _detailModel = detailModel;
    
    // 所属驾校
    self.suoshujiaxiaoLabel.text = [NSString stringWithFormat:@"所属驾校:%@",_detailModel.driveschoolinfo.name];

    // 练车场地
    if (_detailModel.trainFieldInfo.name) {
        self.lianchechangdiLabel.text = [NSString stringWithFormat:@"练车场地:%@",_detailModel.trainFieldInfo.name];
    }else{
        self.lianchechangdiLabel.text = @"暂无训练场地";
    }

    // 场地图片  自定制
//    @property (strong, nonatomic) UIView *photosView;
    self.photosView.detailModel = _detailModel;
    
    // 个性标签内容 自定制
//    @property (strong, nonatomic) UIView *gexingbiaoqianView;
    
    
}

+ (CGFloat)heightWithModel:(CoachDetail *)model
{
    
    JGDrivingDetailTeachingNewsCell *cell = [[JGDrivingDetailTeachingNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTwo"];
    
    cell.detailModel = model;
    
    [cell layoutIfNeeded];
    
    return cell.titleLabel.frame.size.height + cell.suoshujiaxiaoLabel.frame.size.height+cell.lianchechangdiLabel.frame.size.height+cell.photosView.frame.size.height+cell.gexingbiaoqianView.frame.size.height+cell.footView.frame.size.height+JGMargin*4;
    
}
@end
