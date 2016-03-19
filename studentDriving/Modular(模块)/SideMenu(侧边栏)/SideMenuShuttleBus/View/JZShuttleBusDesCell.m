//
//  JZShuttleBusDesCell.m
//  studentDriving
//
//  Created by ytzhang on 16/3/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZShuttleBusDesCell.h"

@interface JZShuttleBusDesCell ()




@end
@implementation JZShuttleBusDesCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self.contentView addSubview:self.titleImageView];
    [self.contentView addSubview:self.stationLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.bottomView];
}
- (void)layoutSubviews{
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(18);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@12);
    }];
    [self.stationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(18);
        make.left.mas_equalTo(self.titleImageView.mas_right).offset(14);
        make.right.mas_equalTo(self.contentView.mas_right).offset(32);
        make.height.mas_equalTo(@14);
       
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImageView.mas_bottom).offset(4);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@1);
        
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stationLabel.mas_bottom).offset(6);
        make.left.mas_equalTo(self.titleImageView.mas_right).offset(14);
        make.right.mas_equalTo(self.contentView.mas_right).offset(32);
        make.height.mas_equalTo(@12);
        
    }];

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (UIImageView *)titleImageView{
    if (_titleImageView == nil) {
        _titleImageView = [[UIImageView alloc] init];
        _titleImageView.image = [UIImage imageNamed:@"bus_red"];
    }
    return _titleImageView;
}

- (UILabel *)stationLabel{
    if (_stationLabel == nil) {
        _stationLabel = [[UILabel alloc] init];
        _stationLabel.text = @"昌平线昌平线昌平线昌平线昌平线";
        _stationLabel.font = [UIFont systemFontOfSize:14];
        _stationLabel.textColor = [UIColor colorWithHexString:@"e6e6e6"];
    }
    return _stationLabel;
}
- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIImageView alloc] init];
        _bottomView.backgroundColor = YBNavigationBarBgColor;
    }
    return _bottomView;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"昌平线昌平线昌平线昌平线昌平线";
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
    }
    return _timeLabel;
}
- (void)setDetailStationModel:(JZBusDetailStationModel *)detailStationModel{
    self.stationLabel.text = detailStationModel.stationname;
    
     NSArray  *array = [detailStationModel.time componentsSeparatedByString:@"/"];
    NSString *timestr = @"";
    for (NSString *str in array) {
        timestr = [NSString stringWithFormat:@"%@  %@",timestr,str];
    }
    NSLog(@"%@",timestr);
    
    self.timeLabel.text = [NSString stringWithFormat:@"到站时间  %@",timestr];
}
@end
