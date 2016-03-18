//
//  JZShuttleBusMainCell.m
//  studentDriving
//
//  Created by ytzhang on 16/3/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZShuttleBusMainCell.h"



@interface JZShuttleBusMainCell ()

@property (nonatomic, strong) UILabel *lineNameLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *lineView;

@end
@implementation JZShuttleBusMainCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self.contentView addSubview:self.lineNameLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.lineView];
}
- (void)layoutSubviews{
    [self.lineNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(11);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.height.mas_equalTo(@12);
        make.width.mas_equalTo(@150);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(11);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@30);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.height.mas_equalTo(@0.5);
       
    }];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UILabel *)lineNameLabel{
    if (_lineNameLabel == nil) {
        _lineNameLabel = [[UILabel alloc] init];
        _lineNameLabel.text = @"昌平线";
        _lineNameLabel.font = [UIFont systemFontOfSize:12];
        _lineNameLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
    }
    return _lineNameLabel;
}
- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@""];
    }
    return _arrowImageView;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
        
    }
    return _lineView;
}
@end
