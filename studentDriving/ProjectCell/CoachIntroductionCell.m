//
//  CoachIntroductionCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/29.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "CoachIntroductionCell.h"
#import "ToolHeader.h"

@interface CoachIntroductionCell ()
@property (strong, nonatomic) UIView *backGroundView;

@property (strong, nonatomic) UILabel *coachTitleLabel;

@property (strong, nonatomic) UIView *lineView;
@end
@implementation CoachIntroductionCell

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGBColor(230, 230, 230);
    }
    return _lineView;
}
- (UILabel *)coachIntroductionDetail {
    if (_coachIntroductionDetail == nil) {
        _coachIntroductionDetail = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
//        _coachIntroductionDetail.text = @"个人评价阿里圣诞节佛啊解释道佛哦OS鉴定符个人评价阿里圣诞节佛啊解释道佛哦OS鉴定符个人评价阿里圣诞节佛啊解释道佛哦OS鉴定符";
        _coachIntroductionDetail.numberOfLines = 2;
    }
    return _coachIntroductionDetail;
}
- (UILabel *)coachTitleLabel {
    if (_coachTitleLabel == nil) {
        _coachTitleLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont boldSystemFontOfSize:14]];
        _coachTitleLabel.text = @"个人评价";
    }
    return _coachTitleLabel;
}
- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 105)];
    }
    return _backGroundView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    
    [self.contentView addSubview:self.backGroundView];
    [self.backGroundView addSubview:self.coachTitleLabel];
    
    [self.backGroundView addSubview:self.coachIntroductionDetail];
    
    [self.backGroundView addSubview:self.lineView];
    [self.coachTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(18);
    }];
    
    [self.coachIntroductionDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coachTitleLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide-30];
        make.width.mas_equalTo(wide);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.backGroundView.mas_bottom).offset(-1);
        make.height.mas_equalTo(@1);
    }];
}
@end
