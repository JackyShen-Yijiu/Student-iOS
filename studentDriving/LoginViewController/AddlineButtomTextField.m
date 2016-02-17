//
//  AddlineButtomTextField.m
//  studentDriving
//
//  Created by ytzhang on 16/1/25.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "AddlineButtomTextField.h"
@interface AddlineButtomTextField()

@property (nonatomic, strong) UIImageView *lineImageView;

@end
@implementation AddlineButtomTextField
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return self;
}
- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor colorWithHexString:@"bdbdbd"];
        _lineImageView.layer.shadowColor = [UIColor whiteColor].CGColor;
        _lineImageView.layer.shadowOffset = CGSizeMake(0, 1);
        _lineImageView.layer.shadowOpacity = 0.3;
        _lineImageView.layer.shadowRadius = 1;
    }
    return _lineImageView;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self setValue:[UIColor colorWithHexString:@"999999"] forKeyPath:@"_placeholderLabel.textColor"];
    [self setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [self addSubview:self.lineImageView];
    CGRect rect = self.bounds;
    CGFloat height = 1;
    self.lineImageView.frame = CGRectMake(0, rect.size.height - 1, rect.size.width, height);
}

@end
