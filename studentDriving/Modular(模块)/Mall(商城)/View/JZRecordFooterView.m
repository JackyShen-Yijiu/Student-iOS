//
//  JZRecordFooterView.m
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZRecordFooterView.h"

static NSString *const knumber = @"create_qrcode";

@interface JZRecordFooterView ()

@property (nonatomic, strong) JZRecordOrdrelist *recordOrderModel;

@property (nonatomic, strong) YBIntegralMallModel *integraMallModel;

@property (nonatomic, assign) BOOL formMall;  // 区分订单和兑换成功

@property (nonatomic, strong) NSString *codeStr;

@end




@implementation JZRecordFooterView

- (instancetype)initWithFrame:(CGRect)frame recordOrderModel:(JZRecordOrdrelist *)recordOrderModel{
    if (self = [super initWithFrame:frame]) {
        _recordOrderModel = recordOrderModel;
        [self initUI];
        [self initData];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame integralMallModel:(YBIntegralMallModel *)integralMallModel formMall:(BOOL)formMall codeStr:(NSString *)codeStr{
    if (self = [super initWithFrame:frame]) {
        _integraMallModel = integralMallModel;
        _formMall = formMall;
        _codeStr = codeStr;
        [self initUI];
        [self initData];
    }
    return self;
}

- (void)initUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.titleLable];
    [self addSubview:self.addressLabel];
    [self addSubview:self.codeImageView];
    [self addSubview:self.stateLable];
}
- (void)initData{
    NSString *resultStr = [NSString stringWithFormat:BASEURL,knumber];
    NSString *str = @"?text=";
    NSString *lastStr = @"&size=174";
    if (_formMall) {
        NSString *finishResultStr = [NSString stringWithFormat:@"%@%@%@%@",resultStr,str,_codeStr,lastStr];
        [self refreshDataWith:finishResultStr];

    }else{
        NSString *finishResultStr = [NSString stringWithFormat:@"%@%@%@%@",resultStr,str,_recordOrderModel.orderscanaduiturl,lastStr];
        [self refreshDataWith:finishResultStr];
    }
    

}
- (void)refreshDataWith:(NSString *)str{
    NSURL *url = [NSURL URLWithString:str];
    [_codeImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"code_null"]];

}
- (void)layoutSubviews{
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(14);
        
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLable.mas_bottom).offset(12);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(14);
        
    }];
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressLabel.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(174);
        make.width.mas_equalTo(174);
        
    }];
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeImageView.mas_bottom).offset(12);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(16);
        
    }];

}
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.text = @"请出示二维码 扫码领取";
        _titleLable.font = [UIFont systemFontOfSize:14];
        _titleLable.textColor = JZ_FONTCOLOR_DRAK;
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}
- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] init];
        if (_formMall) {
             _addressLabel.text = [NSString stringWithFormat:@"领取地点:%@",self.integraMallModel.address];
        }else{
            _addressLabel.text = [NSString stringWithFormat:@"领取地点:%@",self.recordOrderModel.merchantaddress];
        }
        
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = JZ_FONTCOLOR_DRAK;
        _addressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _addressLabel;
}
- (UIImageView *)codeImageView{
    if (_codeImageView == nil) {
        _codeImageView = [[UIImageView alloc] init];
        _codeImageView.backgroundColor = [UIColor clearColor];
    }
    return _codeImageView;
}
- (UILabel *)stateLable{
    if (_stateLable == nil) {
        _stateLable = [[UILabel alloc] init];
        if (_formMall) {
            _stateLable.text = @"未领取";
            _stateLable.textColor = YBNavigationBarBgColor;
        }else{
            if (self.recordOrderModel.orderstate == 5) {
                _stateLable.text = @"已领取";
                _stateLable.textColor = JZ_BlueColor;
            }else{
                _stateLable.text = @"未领取";
                _stateLable.textColor = YBNavigationBarBgColor;
            }

        }
        _stateLable.font = [UIFont systemFontOfSize:16];
        _stateLable.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLable;
}


@end
