//
//  JGDrivingDetailPersonalNoteCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/29.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JGDrivingDetailPersonalNoteCell.h"
#import "ToolHeader.h"
#import "CoachDetail.h"

#define JGMargin 10

@interface JGDrivingDetailPersonalNoteCell ()

// 个人说明
@property (strong, nonatomic) UILabel *titleLabel;
// 更多
@property (nonatomic,strong) UIButton *moreBtn;
// 内容
@property (strong, nonatomic) UILabel *countLabel;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *footView;

@end

@implementation JGDrivingDetailPersonalNoteCell

// 个人说明
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [WMUITool initWithTextColor:MAINCOLOR withFont:[UIFont boldSystemFontOfSize:14]];
        _titleLabel.text = @"个人说明";
    }
    return _titleLabel;
}
// 更多
- (UIButton *)moreBtn {
    if (_moreBtn == nil) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn setTitle:@"更多" forState:UIControlStateHighlighted];
        _moreBtn.titleLabel.textColor = [UIColor lightGrayColor];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _moreBtn.backgroundColor = [UIColor redColor];
        [_moreBtn addTarget:self action:@selector(moreBtnDidClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _moreBtn;
}
// 内容
- (UILabel *)countLabel {
    if (_countLabel == nil) {
        _countLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _countLabel.text = @"个人说明个人说明个人说明个人说明个人说明个人说明个人说明个人说明个人说明个人说明个人说明个人说明个人说明个人说明个人说明个人说明个人说明个人说明";
        _countLabel.numberOfLines = 0;
    }
    return _countLabel;
}
- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = RGBColor(245, 247, 250);
    }
    return _topView;
}
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

    // 顶部灰色
    [self.contentView addSubview:self.topView];

    // 个人说明
    [self.contentView addSubview:self.titleLabel];

    // 更多
    [self.contentView addSubview:self.moreBtn];

    // 内容
    [self.contentView addSubview:self.countLabel];

    // 底部灰色
    [self.contentView addSubview:self.footView];

    // 顶部灰色
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
        make.height.mas_equalTo(JGMargin);
        make.width.mas_equalTo(self.contentView);
    }];
    
    // 个人说明
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(JGMargin);//
        make.left.mas_equalTo(self.topView.mas_left).offset(JGMargin);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@100);
    }];
    
    // 更多
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-JGMargin);
        make.height.mas_equalTo(self.titleLabel.mas_height);
        make.width.mas_equalTo(@50);
    }];
    
    // 内容 (展开、收起)
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(JGMargin);//
        make.left.mas_equalTo(JGMargin);
        make.width.mas_equalTo(self.contentView.mas_width).offset(-JGMargin*2);
    }];
    
    // 底部灰色
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.countLabel.mas_bottom).offset(JGMargin);//
        make.height.mas_equalTo(JGMargin);
        make.width.mas_equalTo(self.contentView.mas_width);
    }];
    
}


- (void)setDetailModel:(CoachDetail *)detailModel
{
    _detailModel = detailModel;
    
    self.countLabel.text = _detailModel.introduction;

    // 内容 (展开、收起)
    if (_detailModel.isMore) {
        
        [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(JGMargin);//
            make.left.mas_equalTo(JGMargin);
            make.width.mas_equalTo(self.contentView.mas_width).offset(-JGMargin*2);
        }];
        
    }else{
        
        [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(JGMargin);//
            make.left.mas_equalTo(JGMargin);
            make.width.mas_equalTo(self.contentView.mas_width).offset(-JGMargin*2);
            make.height.mas_equalTo(@20);
        }];
        
    }
    
}

- (void)moreBtnDidClick
{
    if ([self.delegate respondsToSelector:@selector(JGDrivingDetailPersonalNoteCellWithMoreBtnDidClick:)]) {
        [self.delegate JGDrivingDetailPersonalNoteCellWithMoreBtnDidClick:self];
    }
}

+ (CGFloat)heightWithModel:(CoachDetail *)model indexPath:(NSIndexPath *)indexPath
{
    
    JGDrivingDetailPersonalNoteCell *cell = [[JGDrivingDetailPersonalNoteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellThree"];
    
    cell.detailModel = model;
    
    [cell layoutIfNeeded];
    
    return cell.topView.frame.size.height+cell.titleLabel.frame.size.height+cell.countLabel.frame.size.height+cell.footView.frame.size.height+0.5+JGMargin*3;
    
}

@end
