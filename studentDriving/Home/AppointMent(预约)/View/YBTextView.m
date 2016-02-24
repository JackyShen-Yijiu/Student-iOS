//
//  YBTextView.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/24.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBTextView.h"

@implementation YBTextView

- (UILabel *)placeholderLabel {
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.textColor = RGBColor(189, 189, 195);
        _placeholderLabel.font = [UIFont systemFontOfSize:15];
    }
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame withPlaceholder:(NSString *)placeholder{
    
    if (self = [super initWithFrame:frame]) {
        
        self.placeholderLabel.text = placeholder;
        [self addSubview:self.placeholderLabel];
        [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(10);
            make.left.mas_equalTo(self.mas_left).offset(10);
        }];
        
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
