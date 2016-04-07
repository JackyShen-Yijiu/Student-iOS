//
//  YBAppointmentDetailHeaderView.m
//  studentDriving
//
//  Created by 大威 on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBAppointmentDetailHeaderView.h"
#import "NSString+Helper.h"

#define DescString @"签到须知：签到开放时间为预约学车开始前15分钟到预约结束时间，请及时签到。如未签到，将影响您的学车进度及教练的工时记录。"

@implementation YBAppointmentDetailHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBAppointmentDetailHeaderView" owner:self options:nil];
        self = xibArray.firstObject;

        _statusLabel.textColor = YBNavigationBarBgColor;
        [self addSubview:self.imageMarkLabel];
        [self addSubview:self.markLabel];
        _imageMarkLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _markLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
        
        NSMutableAttributedString *descString = [[NSMutableAttributedString alloc] initWithString:DescString];
        [descString addAttribute:NSForegroundColorAttributeName
                           value:YBNavigationBarBgColor
                           range:NSMakeRange(0, 5)];
        _markLabel.attributedText = descString;
    }
    return self;
}


- (CGFloat)siginTextHeight {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 16*2;
    return [NSString autoHeightWithString:DescString width:width font:[UIFont systemFontOfSize:12]];
}

- (UILabel *)imageMarkLabel {
    if (!_imageMarkLabel) {
        _imageMarkLabel = [UILabel new];
        _imageMarkLabel.font = [UIFont systemFontOfSize:14];
        _imageMarkLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _imageMarkLabel.numberOfLines = 0;
        _imageMarkLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _imageMarkLabel;
}

- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [UILabel new];
        _markLabel.font = [UIFont systemFontOfSize:12];
        _markLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
        _markLabel.numberOfLines = 0;
//        _markLabel.textAlignment = NSTextAlignmentCenter;
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
