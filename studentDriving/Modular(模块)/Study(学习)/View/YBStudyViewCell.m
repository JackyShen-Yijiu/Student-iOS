
//
//  YBStudyViewCell.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/17.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBStudyViewCell.h"

@interface YBStudyViewCell ()

@property (strong, nonatomic)  UIImageView *iconImgView;

@property (strong, nonatomic)  UILabel *titleLabel;

@property (strong, nonatomic)  UILabel *descriptionLabel;

@property (nonatomic, strong) UIView *lineView;

@end



@implementation YBStudyViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.descriptionLabel];
        [self.contentView addSubview:self.lineView];
}
- (void)layoutSubviews{
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.left.equalTo(self.contentView.mas_left).offset(26);
        make.height.equalTo(@28);
         make.width.equalTo(@28);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.left.equalTo(self.iconImgView.mas_right).offset(26);
         make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.equalTo(@16);
        
        
    }];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.equalTo(@14);
        
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(24);
        make.right.equalTo(self.contentView.mas_right).offset(-24);
        make.height.equalTo(@0.5);
        
        
    }];


}
- (void)setDictModel:(NSDictionary *)dictModel
{
    _dictModel = dictModel;
    
    self.iconImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_dictModel[@"icon"]]];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",_dictModel[@"title"]];
    
    self.descriptionLabel.text = [NSString stringWithFormat:@"%@",_dictModel[@"description"]];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView *)iconImgView{
    if (_iconImgView == nil) {
        _iconImgView = [[UIImageView alloc] init];
        
    }
    return _iconImgView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = JZ_FONTCOLOR_DRAK;
    }
    return _titleLabel;
}
- (UILabel *)descriptionLabel{
    if (_descriptionLabel == nil) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:14];
        _descriptionLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _descriptionLabel;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}
@end
