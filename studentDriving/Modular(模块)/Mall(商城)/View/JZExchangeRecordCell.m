//
//  JZExchangeRecordCell.m
//  studentDriving
//
//  Created by ytzhang on 16/4/11.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZExchangeRecordCell.h"

@interface JZExchangeRecordCell ()

@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *mallIconView;

@property (nonatomic, strong) UILabel *nameMallLabel;

@property (nonatomic, strong) UILabel *resultLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *timeLabel;



@property (nonatomic, strong) UIView *lineView;

@end

@implementation JZExchangeRecordCell

- (void)awakeFromNib {
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.mallIconView];
        [self.bgView addSubview:self.nameMallLabel];
        [self.bgView addSubview:self.resultLabel];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.timeLabel];
        [self.bgView addSubview:self.stateLabel];
        [self.bgView addSubview:self.lineView];
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
    }];
    [self.mallIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(16);
        make.left.mas_equalTo(self.bgView.mas_left).offset(16);
        make.height.mas_equalTo(@90);
         make.width.mas_equalTo(@90);
    }];
    [self.nameMallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(18);
        make.left.mas_equalTo(self.mallIconView.mas_right).offset(16);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.height.mas_equalTo(@14);
        
    }];
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameMallLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.nameMallLabel.mas_left);
        make.height.mas_equalTo(@14);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameMallLabel.mas_bottom).offset(22);
        make.left.mas_equalTo(self.resultLabel.mas_right).offset(5);
        make.height.mas_equalTo(@12);
        
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.resultLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.nameMallLabel.mas_left);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.height.mas_equalTo(@12);
        
    }];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).offset(-16);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@42);
        make.height.mas_equalTo(@14);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.height.mas_equalTo(@0.5);
        
    }];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    }
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}
- (UIImageView *)mallIconView{
    if (_mallIconView == nil) {
        _mallIconView = [[UIImageView alloc] init];
        
    }
    return _mallIconView;
}
- (UILabel *)nameMallLabel{
    if (_nameMallLabel == nil) {
        _nameMallLabel = [[UILabel alloc] init];
        _nameMallLabel.text = @"苹果6s";
        _nameMallLabel.font = [UIFont systemFontOfSize:14];
        _nameMallLabel.textColor = JZ_FONTCOLOR_DRAK;
    }
    return _nameMallLabel;
}
- (UILabel *)resultLabel{
    if (_resultLabel == nil) {
        _resultLabel = [[UILabel alloc] init];
        _resultLabel.text = @"160";
        _resultLabel.font = [UIFont systemFontOfSize:14];
        _resultLabel.textColor = YBNavigationBarBgColor;
    }
    return _resultLabel;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"积分";
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _titleLabel;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"兑换时间:2.1624555";
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _timeLabel;
}
- (UILabel *)stateLabel{
    if (_stateLabel == nil) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.text = @"未领取";
        _stateLabel.font = [UIFont systemFontOfSize:14];
        _stateLabel.textColor = YBNavigationBarBgColor;
    }
    return _stateLabel;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}
- (void)setRecordModel:(JZRecordOrdrelist *)recordModel{
    /*
     createtime = "2015-12-22";
     endtime = "2016-01-22";
     "is_confirmbyscan" = 0;
     merchantaddress = "\U5317\U4eac\U5e02\U5317\U4eac\U5e02\U4e1c\U57ce\U533a\U738b\U5e9c\U4e95\U5927\U8857\U7532131\U53f7";
     merchantid = 56c68d078de60b3d735b015a;
     merchantmobile = 15652305650;
     merchantname = "\U4e00\U6b65\U5b66\U8f66\U5546\U57ce";
     orderid = 5679033e5722040236190947;
     orderscanaduiturl = "http://123.57.63.15:8181/validation/ordervalidation?orderid=5679033e5722040236190947";
     orderstate = 1;
     productid = 564051bf262202041284256d;
     productimg = "http://7xnjg0.com1.z0.glb.clouddn.com/1460211708274.jpg";
     productname = "Rivl \U65e0\U7ebf\U9f20\U6807";
     productprice = 200;

     */
    [self.mallIconView sd_setImageWithURL:[NSURL URLWithString:recordModel.productimg] placeholderImage:nil];
    self.nameMallLabel.text = recordModel.productname;
    self.resultLabel.text = [NSString stringWithFormat:@"%lu",recordModel.productprice];
    self.timeLabel.text = [NSString stringWithFormat:@"兑换时间:%@",recordModel.createtime];
    
}
- (void)setIntegrtalMallModel:(YBIntegralMallModel *)integrtalMallModel{
    [self.mallIconView sd_setImageWithURL:[NSURL URLWithString:integrtalMallModel.productimg] placeholderImage:nil];
    self.nameMallLabel.text = integrtalMallModel.productname;
    self.resultLabel.text = [NSString stringWithFormat:@"%lu",integrtalMallModel.productprice];
    
    // 获取系统当前时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
     [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    self.timeLabel.text = [NSString stringWithFormat:@"兑换时间:%@",locationString];
}
@end
