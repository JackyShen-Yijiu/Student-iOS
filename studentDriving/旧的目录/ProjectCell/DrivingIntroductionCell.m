//
//  DrivingIntroductionCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/30.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "DrivingIntroductionCell.h"
#import "ToolHeader.h"
@interface DrivingIntroductionCell ()
@property (strong, nonatomic) UIView *backGroundView;

@property (strong, nonatomic) UILabel *drivingTitleLabel;
@end
@implementation DrivingIntroductionCell
- (UILabel *)drivingIntroductionDetail {
    if (_drivingIntroductionDetail == nil) {
        _drivingIntroductionDetail = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:14]];
        _drivingIntroductionDetail.text = @"个人评价阿里圣诞节佛啊解释道佛哦OS鉴定符个人评价阿里圣诞节佛啊解释道佛哦OS鉴定符个人评价阿里圣诞节佛啊解释道佛哦OS鉴定符";
        _drivingIntroductionDetail.numberOfLines = 0;
    }
    return _drivingIntroductionDetail;
}
- (UILabel *)drivingTitleLabel {
    if (_drivingTitleLabel == nil) {
        _drivingTitleLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont boldSystemFontOfSize:14]];
        _drivingTitleLabel.text = @"驾校简介";
    }
    return _drivingTitleLabel;
}
- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 105)];
    }
    return _backGroundView;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    
    [self.contentView addSubview:self.backGroundView];
    [self.backGroundView addSubview:self.drivingTitleLabel];
    [self.backGroundView addSubview:self.drivingIntroductionDetail];
    
    [self.drivingTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.top.mas_equalTo(self.backGroundView.mas_top).offset(18);
    }];
    
    [self.drivingIntroductionDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.drivingTitleLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        NSNumber *wide = [NSNumber numberWithFloat:kSystemWide-30];
        make.width.mas_equalTo(wide);
    }];
    [self.drivingIntroductionDetail sizeToFit];
    
   
}
@end
