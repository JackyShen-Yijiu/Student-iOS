//
//  JZOrderMallNumberCell.m
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZOrderMallNumberCell.h"

@interface JZOrderMallNumberCell ()


@property (nonatomic, strong) UILabel *numberMallLabel;

@property (nonatomic, strong) UIButton *reduceButton;

@property (nonatomic, strong) UILabel *resultLabel;

@property (nonatomic, strong) UIButton *addButton;




@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, assign) NSUInteger numberMall;


@end
@implementation JZOrderMallNumberCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _numberMall = 1;
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.addButton.userInteractionEnabled = YES;
    self.reduceButton.userInteractionEnabled = YES;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.numberMallLabel];
    [self.contentView addSubview:self.reduceButton];
    [self.contentView addSubview:self.resultLabel];
    [self.contentView addSubview:self.addButton];
    [self.contentView addSubview:self.lineView];
}
- (void)layoutSubviews{
    [self.numberMallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@14);
        
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.height.mas_equalTo(@24);
        make.width.mas_equalTo(@24);
        
    }];
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.addButton.mas_left).offset(0);
        make.height.mas_equalTo(@12);
        make.width.mas_equalTo(@36);
        
    }];
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.resultLabel.mas_left).offset(0);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(@24);
        make.height.mas_equalTo(@24);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@0.5);
        
    }];
    
}
#pragma mark ---Action
- (void)numberChanage:(UIButton *)btn{
    if (btn.tag == 500) {
        // 点击添加数量
        
        
        // 获取商品的单价
        if ( _integrtalMallModel.productprice * (_numberMall + 1) <= [AcountManager manager].integrationNumber) {
            ++_numberMall;
            [self.reduceButton setBackgroundImage:[UIImage imageNamed:@"quantity_subtract_on"] forState:UIControlStateNormal];
            self.reduceButton.userInteractionEnabled = YES;
            self.resultLabel.text = [NSString stringWithFormat:@"%lu",_numberMall];
        }else{
            self.resultLabel.text = [NSString stringWithFormat:@"%lu",_numberMall];
            [self.addButton setBackgroundImage:[UIImage imageNamed:@"quantity_add_off"] forState:UIControlStateNormal];
            self.addButton.userInteractionEnabled = NO;
        }

        
        
        
    }
    if (btn.tag == 501) {
        // 点击减少数量
        if (_numberMall == 1) {
            self.resultLabel.text = [NSString stringWithFormat:@"%lu",_numberMall];
            [self.reduceButton setBackgroundImage:[UIImage imageNamed:@"quantity_subtract_off"] forState:UIControlStateNormal];
            self.reduceButton.userInteractionEnabled = NO;
        }else{
            self.addButton.userInteractionEnabled = YES;
            [self.addButton setBackgroundImage:[UIImage imageNamed:@"quantity_add_on"] forState:UIControlStateNormal];
            --_numberMall;
            self.resultLabel.text = [NSString stringWithFormat:@"%lu",_numberMall];
        }
        
    }
    
    // 把选的商品数量返回到控制器
    if ([self.JZMallNumberDelegate respondsToSelector:@selector(mallNumberWith:)]) {
        [self.JZMallNumberDelegate mallNumberWith:_numberMall];
    }
}

- (UILabel *)numberMallLabel{
    if (_numberMallLabel == nil) {
        _numberMallLabel = [[UILabel alloc] init];
        _numberMallLabel.text = @"兑换数量:";
        _numberMallLabel.font = [UIFont systemFontOfSize:14];
        _numberMallLabel.textColor = JZ_FONTCOLOR_DRAK;
    }
    return _numberMallLabel;
}
- (UIButton *)addButton{
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"quantity_add_on"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(numberChanage:) forControlEvents:UIControlEventTouchUpInside];
        _addButton.tag = 500;
        _addButton.userInteractionEnabled = YES;
        
    }
    return _addButton;
}
- (UIButton *)reduceButton{
    if (_reduceButton == nil) {
        _reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceButton setBackgroundImage:[UIImage imageNamed:@"quantity_subtract_off"] forState:UIControlStateNormal];
        [_reduceButton addTarget:self action:@selector(numberChanage:) forControlEvents:UIControlEventTouchUpInside];
        _reduceButton.tag = 501;
        _reduceButton.userInteractionEnabled = NO;
        
    }
    return _reduceButton;
}

- (UILabel *)resultLabel{
    if (_resultLabel == nil) {
        _resultLabel = [[UILabel alloc] init];
        _resultLabel.text = @"1";
        _resultLabel.font = [UIFont systemFontOfSize:14];
        _resultLabel.textColor = JZ_FONTCOLOR_DRAK;
        _resultLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _resultLabel;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
