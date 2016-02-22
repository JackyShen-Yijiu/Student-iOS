//
//  SideMenuSignUpCell.m
//  studentDriving
//
//  Created by zyt on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "SideMenuSignUpCell.h"

@interface SideMenuSignUpCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *signLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *groundLabel;

@property (nonatomic, strong) UILabel *timeSignLabel;

@property (nonatomic, strong) UIView *lineBottom;

@end
@implementation SideMenuSignUpCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.iconImageView];
    [self addSubview:self.signLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.groundLabel];
    [self addSubview:self.timeSignLabel];
    [self addSubview:self.lineBottom];
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@50);
    }];
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(@10);
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
    [self.timeSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.groundLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(20);
        make.height.mas_equalTo(@14);
        make.right.mas_equalTo(self.mas_right).offset(0);
    }];
    [self.lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeSignLabel.mas_bottom).offset(23);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(20);
        make.height.mas_equalTo(@1);
        make.right.mas_equalTo(self.mas_right).offset(0);
    }];


    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
- (UILabel *)signLabel{
    if (_signLabel == nil) {
        _signLabel = [[UILabel alloc] init];
        _signLabel.text = @"已签到";
        _signLabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _signLabel.font = [UIFont systemFontOfSize:10];
        _signLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _signLabel;
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
- (UILabel *)timeSignLabel{
    if (_timeSignLabel == nil) {
        _timeSignLabel = [[UILabel alloc] init];
        _timeSignLabel.text = @"今天13:00 - 14:00";
        _timeSignLabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _timeSignLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _timeSignLabel;
}
- (UIView *)lineBottom{
    
    if (_lineBottom == nil) {
        _lineBottom = [[UIView alloc] init];
        _lineBottom.backgroundColor= [UIColor colorWithHexString:@"bdbdbd"];
    }
    return _lineBottom;
}
- (void)setDataModel:(SignInDataModel *)dataModel{
    /*
     @property (nonatomic, copy) NSString *ID;
     @property (nonatomic, copy) NSString *beginTime;
     @property (nonatomic, copy) NSString *endTime;
     @property (nonatomic, copy) NSString *courseProcessDesc;
     
     @property (nonatomic, strong) SignInCoachDataModel *coachDataModel;
     
     // 签到的状态
     @property (nonatomic, assign) BOOL signInStatus;

     */
    if (dataModel.signInStatus) {
        self.timeSignLabel.textColor = [UIColor colorWithHexString:@"bd4437"];
        self.signLabel.textColor = [UIColor colorWithHexString:@"bd4437"];
        self.signLabel.text = @"可签到";
    }else{
        self.signLabel.text = @"不可签到";
    }
    
    self.nameLabel.text = dataModel.coachDataModel.name;
    self.timeSignLabel.text = [NSString stringWithFormat:@"今天 %@-%@", dataModel.beginTime, dataModel.endTime];
    
}
@end
