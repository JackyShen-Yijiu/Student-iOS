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
// 问内容
@property(nonatomic,strong)UILabel * askSubTitle;
// 答内容
@property(nonatomic,strong)UILabel * replySubTitle;

// 底部下线
@property (nonatomic, strong) UIView *lineView;


@end

@implementation MyConsultationListCell

// 问头像
- (PortraitView *)askPotraitView
{
    if (_askPotraitView==nil) {
        _askPotraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 14, 14)];
//        _askPotraitView.layer.cornerRadius = 5.f;
        _askPotraitView.layer.shouldRasterize = YES;
        _askPotraitView.backgroundColor = [UIColor clearColor];
        _askPotraitView.imageView.image = [UIImage imageNamed:@"Q"];
    }
    return _askPotraitView;
}
// 答头像
- (PortraitView *)replyPotraitView
{
    if (_replyPotraitView==nil) {
        _replyPotraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 14, 14)];
//        _replyPotraitView.layer.cornerRadius = 5.f;
        _replyPotraitView.layer.shouldRasterize = YES;
        _replyPotraitView.backgroundColor = [UIColor clearColor];
        _replyPotraitView.imageView.image = [UIImage imageNamed:@"A"];
    }
    return _replyPotraitView;
}


// 问内容
- (UILabel *)askSubTitle
{
    if (_askSubTitle==nil) {
        _askSubTitle = [[UILabel alloc] init];
        _askSubTitle.textAlignment = NSTextAlignmentLeft;
        _askSubTitle.font = [UIFont systemFontOfSize:13.f];
        _askSubTitle.textColor = [UIColor colorWithHexString:@"2f2f2f"];
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
        _replySubTitle.textColor = JZ_FONTCOLOR_LIGHT;
        _replySubTitle.backgroundColor = [UIColor clearColor];
        _replySubTitle.numberOfLines = 0;
        _replySubTitle.text = @"驾校回复中...";
    }
    return _replySubTitle;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = RGBColor(251, 251, 251);
        
        // 问头像
        [self.contentView addSubview:self.askPotraitView];
        
        // 答头像
        [self.contentView addSubview:self.replyPotraitView];
        
        // 问内容
        [self.contentView addSubview:self.askSubTitle];
        
        // 答内容
        [self.contentView addSubview:self.replySubTitle];
        
        [self.contentView addSubview:self.lineView];
        
        
        [self updateConstraints];
        
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    // 问头像
    [self.askPotraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14.f));
        make.left.equalTo(@16);
        make.top.equalTo(@16);//
    }];
    
    // 问内容
    [self.askSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.askPotraitView.mas_top);//
        make.left.equalTo(self.askPotraitView.mas_right).offset(12);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-26);
    }];
    
    
    // 答头像
    [self.replyPotraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14.f));
        make.left.equalTo(@16);
        make.top.mas_equalTo(self.askPotraitView.mas_bottom).offset(12);//
    }];
    
    // 答内容
    [self.replySubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.replyPotraitView.mas_top);//
        make.left.equalTo(self.askSubTitle.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-26);
    }];
   
    // 答内容
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);//
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@0.5);
    }];
    
    
}

- (void)setDetailModel:(NSDictionary *)detailModel
{
    _detailModel = detailModel;
    // 问内容
    self.askSubTitle.text = [NSString stringWithFormat:@"%@",_detailModel[@"content"]];
    
    // 答内容
    if (_detailModel[@"replycontent"] && [_detailModel[@"replycontent"] length]!=0) {
        self.replySubTitle.text = [NSString stringWithFormat:@"%@",_detailModel[@"replycontent"]];
    }
    
}

+ (CGFloat)heightWithModel:(NSDictionary *)model
{
    
    MyConsultationListCell *cell = [[MyConsultationListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyConsultationListCell"];
    
    cell.detailModel = model;
    NSLog(@"model =========== ============== ================%@",model);
    
    [cell layoutIfNeeded];
    
    return cell.askSubTitle.height+cell.replySubTitle.height+16+12 + 16;
    
}

- (UIView *)getOnelineView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor cyanColor] ;
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
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}
@end
