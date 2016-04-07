//
//  DVVFilterView.m
//  studentDriving
//
//  Created by 大威 on 16/1/6.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVFilterView.h"

@implementation DVVFilterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.leftButton];
        [self addSubview:self.toolBarView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    if (!_titleArray.count) {
        return ;
    }
//    CGFloat leftButtonWidth = viewWidth / (_titleArray.count + 1);
    CGFloat leftButtonWidth = 120;
    _leftButton.frame = CGRectMake(0, 0, leftButtonWidth, viewHeight);
    _toolBarView.frame = CGRectMake(leftButtonWidth, 0, viewWidth - leftButtonWidth, viewHeight);
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    self.toolBarView.titleArray = _titleArray;
}
- (void)setLeftButtonTitleString:(NSString *)leftButtonTitleString {
    _leftButtonTitleString = leftButtonTitleString;
    [self.leftButton setTitle:_leftButtonTitleString forState:UIControlStateNormal];
}

#pragma mark - lazy load
- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton new];
        [_leftButton setTitle:@"左侧按钮" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _leftButton;
}
- (DVVToolBarView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [DVVToolBarView new];
        _toolBarView.selectButtonInteger = 0;
        _toolBarView.followBarHeight = YES;
    }
    return _toolBarView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
