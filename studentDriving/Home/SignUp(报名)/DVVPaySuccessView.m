//
//  DVVPaySuccessView.m
//  studentDriving
//
//  Created by 大威 on 16/3/2.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVPaySuccessView.h"

@implementation DVVPaySuccessView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DVVPaySuccessView" owner:self options:nil];
        self = xibArray.firstObject;
        
        _promptLabel.textColor = YBNavigationBarBgColor;
        
        _schoolNameLabel.textColor = [UIColor grayColor];
        _classTypeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _actualPaymentLabel.textColor = [UIColor lightGrayColor];
        _havePayLabel.textColor = YBNavigationBarBgColor;
        _descLabel.textColor = [UIColor lightGrayColor];
        
        _numberLabel.textColor = [UIColor grayColor];
        _markTitleLabel.textColor = [UIColor grayColor];
        _markContentLabel.textColor = [UIColor lightGrayColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
