//
//  JZYListCell.m
//  studentDriving
//
//  Created by ytzhang on 16/3/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZYListCell.h"

@interface JZYListCell ()

@property (nonatomic, strong) UIImageView *bgImgView;

@property (nonatomic, strong) UILabel *shareLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *YTitleLabel;

@property (nonatomic, strong) UILabel *YNameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@end
@implementation JZYListCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.contentView.backgroundColor = RGBColor(226, 226, 233);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.bgImgView];
    [self.bgImgView addSubview:self.shareLabel];
    [self.bgImgView addSubview:self.nameLabel];
    [self.bgImgView addSubview:self.YTitleLabel];
    [self.bgImgView addSubview:self.YNameLabel];
    [self.bgImgView addSubview:self.timeLabel];

    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(@120);
        
    }];
//    [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.bgImgView.mas_top).offset(20);
//        make.left.mas_equalTo(self.bgImgView.mas_left).offset(20);
//        make.width.mas_equalTo(@36);
//        make.height.mas_equalTo(@12);
//        
//    }];
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.bgImgView.mas_top).offset(18);
//        make.left.mas_equalTo(self.shareLabel.mas_right).offset(5);
//        make.width.mas_equalTo(@36);
//        make.height.mas_equalTo(@14);
//        
//    }];
//    [self.YTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.shareLabel.mas_bottom).offset(10);
//        make.left.mas_equalTo(self.shareLabel.mas_left);
//        make.width.mas_equalTo(@32);
//        make.height.mas_equalTo(@16);
//        
//    }];
//    [self.YNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.nameLabel.mas_top).offset(10);
//        make.left.mas_equalTo(self.YTitleLabel.mas_right).offset(5);
//        make.width.mas_equalTo(@150);
//        make.height.mas_equalTo(@16);
//        
//    }];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.YTitleLabel.mas_bottom).offset(10);
//        make.left.mas_equalTo(self.YTitleLabel.mas_left);
//        make.width.mas_equalTo(@150);
//        make.height.mas_equalTo(@12);
//        
//    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView *)bgImgView{
    if (_bgImgView == nil) {
        _bgImgView.backgroundColor = [UIColor clearColor];
        _bgImgView.image = [UIImage imageNamed:@"quan"];
    }
    return _bgImgView;
}
- (UILabel *)shareLabel{
    if (_shareLabel == nil) {
        _shareLabel = [[UILabel alloc] init];
        _shareLabel.text = @"分享者";
        _shareLabel.font = [UIFont systemFontOfSize:12];
        _shareLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
    }
    return _shareLabel;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"分享者";
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorWithHexString:@"e6e6e6"];
    }
    return _nameLabel;
}
- (UILabel *)YTitleLabel{
    if (_YTitleLabel == nil) {
        _YTitleLabel = [[UILabel alloc] init];
        _YTitleLabel.text = @"Y码";
        _YTitleLabel.font = [UIFont systemFontOfSize:16];
        _YTitleLabel.textColor = [UIColor colorWithHexString:@"e6e6e6"];
    }
    return _YTitleLabel;
}
- (UILabel *)YNameLabel{
    if (_YNameLabel == nil) {
        _YNameLabel = [[UILabel alloc] init];
        _YNameLabel.text = @"FSHSKKKKKKK";
        _YNameLabel.font = [UIFont systemFontOfSize:15];
        _YNameLabel.textColor = RGBColor(74, 118, 250);
    }
    return _YNameLabel;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"有限期至:2026/02/29";
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textColor = RGBColor(74, 118, 250);
    }
    return _timeLabel;
}

@end
