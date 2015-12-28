//
//  DVVSideMenuFooterView.m
//  DVVSideMenu
//
//  Created by 大威 on 15/12/22.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "DVVSideMenuFooterView.h"

@implementation DVVSideMenuFooterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.contactUsLabel];
        [self addSubview:self.markLabel];
//        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGFloat selfWidth = rect.size.width;
    _contactUsLabel.frame = CGRectMake(15, 0, selfWidth - 15, 20);
    _markLabel.frame = CGRectMake(15, 20, selfWidth - 15, 20);
}

#pragma mark - lazy load
- (UILabel *)contactUsLabel {
    if (!_contactUsLabel) {
        _contactUsLabel = [UILabel new];
        _contactUsLabel.font = [UIFont systemFontOfSize:12];
        _contactUsLabel.textColor = [UIColor colorWithWhite:1 alpha:0.4];
        _contactUsLabel.backgroundColor = [UIColor clearColor];
        _contactUsLabel.text = @"联系我们：400-6269-255";
    }
    return _contactUsLabel;
}
- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [UILabel new];
        _markLabel.font = [UIFont systemFontOfSize:12];
        _markLabel.textColor = [UIColor colorWithWhite:1 alpha:0.4];
        _markLabel.backgroundColor = [UIColor clearColor];
        _markLabel.text = @"如有疑问，请致电，谢谢您！";
    }
    return _markLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
