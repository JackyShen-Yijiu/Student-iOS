//
//  HelpCell.m
//  studentDriving
//
//  Created by zyt on 16/2/22.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "HelpCell.h"

@interface HelpCell ()
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *groundLabel;

@property (nonatomic, strong) UIView *lineBottom;


@end
@implementation HelpCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.iconImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.groundLabel];
    [self addSubview:self.lineBottom];

    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@50);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(20);
        make.height.mas_equalTo(@14);
        make.right.mas_equalTo(self.mas_right).offset(0);
    }];
    [self.groundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(20);
        make.height.mas_equalTo(@14);
        make.right.mas_equalTo(self.mas_right).offset(0);
    }];
    [self.lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.groundLabel.mas_bottom).offset(23);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(20);
        make.height.mas_equalTo(@1);
        make.right.mas_equalTo(self.mas_right).offset(0);
    }];

    
}
- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        [_iconImageView.layer setMasksToBounds:YES];
        [_iconImageView.layer setCornerRadius:25];
        _iconImageView.backgroundColor = [UIColor cyanColor];
    }
    return _iconImageView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"李荣华";
        _nameLabel.textColor = [UIColor colorWithHexString:@"212121"];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _nameLabel;
}
- (UILabel *)groundLabel{
    if (_groundLabel == nil) {
        _groundLabel = [[UILabel alloc] init];
        _groundLabel.text = @"一步驾校第一训练场";
        _groundLabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _groundLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _groundLabel;
}
- (UIView *)lineBottom{
    
    if (_lineBottom == nil) {
        _lineBottom = [[UIView alloc] init];
        _lineBottom.backgroundColor= [UIColor colorWithHexString:@"bdbdbd"];
    }
    return _lineBottom;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setStrDic:(NSDictionary *)strDic{
    /*
     "icon" : "NewS_hands",
     "title" : "新手上路",
     "description" : "菜鸟变老手的经验池"
     */
    self.iconImageView.image = [UIImage imageNamed:strDic[@"icon"]];
    self.nameLabel.text = strDic[@"title"];
    self.groundLabel.text = strDic[@"description"];
    
    
    
}
@end
