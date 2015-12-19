//
//  SignSuccessView.m
//  chooseView
//
//  Created by 胡东苑 on 15/12/13.
//  Copyright © 2015年 胡东苑. All rights reserved.
//

#import "SignSuccessView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface SignSuccessView ()

@property (nonatomic, strong) UILabel     *successLb;
@property (nonatomic, strong) UILabel     *successContentLb;
@property (nonatomic, strong) UILabel     *barCodeLb;
@property (nonatomic, strong) UILabel     *orderNumLb;
@property (nonatomic, strong) UILabel     *dataExplainLb;
@property (nonatomic, strong) UILabel     *dataExplainContentLb;
@property (nonatomic, strong) UILabel     *barCodeUseExplainLb;
@property (nonatomic, strong) UILabel     *barCodeUseExplainContentLb;
@property (nonatomic, strong) UIImageView *barCodeView;
@property (nonatomic, strong) NSString     *imageStr;
@property (nonatomic, strong) NSString    *orderNumStr;
@property (nonatomic, strong) NSString    *timeStr;
@property (nonatomic, strong) NSString    *explainStr;

@end

@implementation SignSuccessView

- (instancetype)initWithFrame:(CGRect)frame imageStr:(NSString *)imageStr orderNumStr:(NSString *)orderNumStr timeStr:(NSString *)timeStr CarrydataExplainContentLb:(NSString *)explainStr
{
    self = [super initWithFrame:frame];
    if (self) {
        _timeStr = timeStr;
        _orderNumStr = orderNumStr;
        _imageStr = imageStr;
        _explainStr = explainStr;
        [self addUI];
        [self configeUI];
        [self setupUI];
    }
    return self;
}

- (void)addUI {
    _successLb = [[UILabel alloc] init];
    _successContentLb = [[UILabel alloc] init];
    _barCodeLb = [[UILabel alloc] init];
    _barCodeView = [[UIImageView alloc] init];
    _orderNumLb = [[UILabel alloc] init];
    _dataExplainLb = [[UILabel alloc] init];
    _dataExplainContentLb = [[UILabel alloc] init];
    _barCodeUseExplainLb = [[UILabel alloc] init];
    _barCodeUseExplainContentLb = [[UILabel alloc] init];
    [self addSubview:_successLb];
    [self addSubview:_successContentLb];
    [self addSubview:_barCodeLb];
    [self addSubview:_barCodeView];
    [self addSubview:_orderNumLb];
    [self addSubview:_dataExplainLb];
    [self addSubview:_dataExplainContentLb];
    [self addSubview:_barCodeUseExplainLb];
    [self addSubview:_barCodeUseExplainContentLb];
    
}

- (void)configeUI {
    _successLb.text = @"恭喜，报名成功!";
    _successLb.textColor = [UIColor redColor];
    _successContentLb.text = [NSString stringWithFormat:@"请您于%@之间内携带资料前往您所报名的驾校确认报名信息，并支付报名费用",_timeStr];
    [_barCodeView sd_setImageWithURL:[NSURL URLWithString:_imageStr]];
    _barCodeLb.text = @"您的报名订单二维码";
    _barCodeLb.textColor = [UIColor redColor];
    _barCodeView.backgroundColor = [UIColor grayColor];
    _orderNumLb.text = [NSString stringWithFormat:@"您的报名订单编码为:%@",_orderNumStr];
    _orderNumLb.textColor = [UIColor redColor];
    _dataExplainLb.text = @"携带资料说明:";
    _dataExplainLb.textColor = [UIColor redColor];
    _dataExplainContentLb.text = _explainStr;
    _barCodeUseExplainLb.text = @"订单二维码使用说明:";
    _barCodeUseExplainLb.textColor = [UIColor redColor];
    _barCodeUseExplainContentLb.text = @"       在确认订单信息时，只需将此二维码提供给驾校工作人员即可，由工作人员扫描二维码，确认报名信息。";
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.font = [UIFont systemFontOfSize:12];
            label.numberOfLines = 0;
        }
    }
}

- (void)setupUI {
    __weak typeof(self) weakSelf = self;
    [_successLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
    }];
    [_successLb sizeToFit];
    
    [_successContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(_successLb.mas_bottom).offset(11);
        make.width.mas_equalTo(weakSelf.frame.size.width -30);
    }];
    [_successContentLb sizeToFit];
    
    [_barCodeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(_successContentLb.mas_bottom).offset(20);
    }];
    [_barCodeLb sizeToFit];
    
    [_barCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(_barCodeLb.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    
    [_orderNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(_barCodeView.mas_bottom).offset(20);
    }];
    [_orderNumLb sizeToFit];
    
    [_dataExplainLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(_orderNumLb.mas_bottom).offset(21);
    }];
    [_dataExplainLb sizeToFit];
    
    [_dataExplainContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(_dataExplainLb.mas_bottom).offset(11);
        make.width.mas_equalTo(weakSelf.frame.size.width -30);
    }];
    [_dataExplainContentLb sizeToFit];
    
    [_barCodeUseExplainLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(_dataExplainContentLb.mas_bottom).offset(15);
    }];
    [_barCodeUseExplainLb sizeToFit];
    
    [_barCodeUseExplainContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(_barCodeUseExplainLb.mas_bottom).offset(11);
        make.width.mas_equalTo(weakSelf.frame.size.width -30);
    }];
}


@end
