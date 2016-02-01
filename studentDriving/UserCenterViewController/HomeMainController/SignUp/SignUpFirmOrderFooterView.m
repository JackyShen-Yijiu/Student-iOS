//
//  SignUpFirmOrderFooterView.m
//  studentDriving
//
//  Created by ytzhang on 16/1/29.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SignUpFirmOrderFooterView.h"

@interface SignUpFirmOrderFooterView ()
@property (nonatomic, strong) NSString *discountMoneyStr;
@property (nonatomic, strong) NSString *realMoneyStr;
@property (nonatomic, strong) NSString *schoolNameStr;

@property (nonatomic, strong) UILabel *remindLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *lineView;
//@property (nonatomic, strong) UILabel *discountLabel;
//@property (nonatomic, strong) UILabel *realPayLabel;
//@property (nonatomic, strong) UILabel *discountPayLabel;
@end

@implementation SignUpFirmOrderFooterView
- (UIView *)initWithFrame:(CGRect)frame Discount:(NSString *)discountMoney realMoney:(NSString *)realMoney schoolName:(NSString *)schoolName{
    if (self = [super initWithFrame:frame]) {
        _discountMoneyStr = discountMoney;
        _realMoneyStr = realMoney;
        _schoolNameStr = schoolName;
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.remindLabel];
    [self addSubview:self.textView];
    [self addSubview:self.lineView];
    [self addSubview:self.discountLabel];
    [self addSubview:self.realPayLabel];
    [self addSubview:self.discountPayLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(15);
        make.left.mas_equalTo(self.mas_left).with.offset(13);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.remindLabel.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.mas_left).with.offset(15);
        make.width.mas_equalTo(350);
        make.height.mas_equalTo(100);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.mas_left).with.offset(15);
        NSNumber *lineViewW = [[NSNumber alloc] initWithFloat:self.frame.size.width - 30];
        make.width.mas_equalTo(lineViewW);
        make.height.mas_equalTo(1);
    }];
    [self.discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).with.offset(20);
        make.left.mas_equalTo(self.mas_left).with.offset(15);
        NSNumber *lineViewW = [[NSNumber alloc] initWithFloat:self.frame.size.width - 30];
        make.width.mas_equalTo(lineViewW);
        make.height.mas_equalTo(15);
    }];
    [self.realPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.discountLabel.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.mas_left).with.offset(15);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(15);
    }];
    [self.discountPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.realPayLabel.mas_bottom).with.offset(15);
        make.left.mas_equalTo(self.mas_left).with.offset(15);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
}
- (UILabel *)remindLabel{
    if (_remindLabel == nil) {
        _remindLabel  = [[UILabel alloc] init];
        _remindLabel.text = @"温馨提示:";
        _remindLabel.textColor = [UIColor redColor];
        
    }
    return _remindLabel;
}
- (UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.selectable = NO;
        _textView.editable = NO;
        _textView.scrollEnabled = NO;
        _textView.text = @"本业务暂不提供发票,请谅解。\n本业务针对合作驾校参与优惠。\n如有疑问请拨打客服400-6288-7255\n最终解释权归北京一步科技有限公司";
        _textView.textColor = [UIColor colorWithHexString:@"999999"];
        
    }
    return _textView;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"999999"];
        
    }
    return _lineView;
}
- (UILabel *)discountLabel{
    if (_discountLabel == nil) {
        _discountLabel = [[UILabel alloc] init];
        _discountLabel.text = @"一步现金可折扣100元";
        _discountLabel.font = [UIFont systemFontOfSize:14];
        _discountLabel.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _discountLabel;
}
- (UILabel *)realPayLabel{
    if (_realPayLabel == nil) {
        _realPayLabel = [[UILabel alloc] init];
        _realPayLabel.text = @"应付:3288元 (一步互联网驾校)";
        _realPayLabel.textColor = [UIColor blackColor];
        
    }
    return _realPayLabel;
}
- (UILabel *)discountPayLabel{
    if (_discountPayLabel == nil) {
        _discountPayLabel = [[UILabel alloc] init];
        _discountPayLabel.text = @"实付:3288元";
        _discountPayLabel.textColor = [UIColor blackColor];
        
    }
    return _discountPayLabel;
}

@end
