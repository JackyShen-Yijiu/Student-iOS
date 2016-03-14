//
//  YBAppointMentUserCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "YBAppointMentUserCell.h"

#import "AppointmentCoachTimeInfoModel.h"

@interface YBAppointMentUserCell ()
@end

@implementation YBAppointMentUserCell

- (UIImageView *)iconImageView
{
    if (_iconImageView==nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"coach_man_default_icon"];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 22;
    }
    return _iconImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.iconImageView];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@0);
            make.right.mas_equalTo(@0);
            make.top.mas_equalTo(@0);
            make.bottom.mas_equalTo(@0);
        }];
        
    }
    return self;
}


@end
