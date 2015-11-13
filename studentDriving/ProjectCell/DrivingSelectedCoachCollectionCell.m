//
//  DrivingSelectedCoachCollectionCell.m
//  BlackCat
//
//  Created by bestseller on 15/9/30.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "DrivingSelectedCoachCollectionCell.h"
#import "ToolHeader.h"
#import "CoachModel.h"
@interface DrivingSelectedCoachCollectionCell ()
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *coachName;
@end
@implementation DrivingSelectedCoachCollectionCell

- (UIImageView *)headImageView {
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = MAINCOLOR;
    }
    return _headImageView;
}
- (UILabel *)coachName {
    
    if (_coachName == nil) {
        _coachName = [WMUITool initWithTextColor:[UIColor blackColor] withFont:    [UIFont systemFontOfSize:14]];
        _coachName.text = @"李文政";
    }
    return _coachName;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    
    [self addSubview:self.headImageView];
    [self addSubview:self.coachName];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(@60);
        make.width.mas_equalTo(@60);
    }];
    [self.coachName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(8);
    }];
}
- (void)receiveCoachMessage:(CoachModel *)coachModel {
    self.coachName.text = nil;
    self.coachName.text = coachModel.name;
    self.headImageView.image = nil;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:coachModel.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
}

@end
