//
//  EditorDetailSexCell.m
//  studentDriving
//
//  Created by zyt on 16/2/23.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "EditorDetailSexCell.h"

@interface EditorDetailSexCell ()
@property (nonatomic, strong) UIButton *anonymousButton; // 匿名投诉

@property (nonatomic, strong) UIButton *realNameButton;


@property (nonatomic, strong) UIView *lineBottom;

@end
@implementation EditorDetailSexCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.anonymousButton];
    [self addSubview:self.realNameButton];
    [self addSubview:self.lineBottom];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark --- ActionTagart
// 男
- (void)didclickAnonymous:(UIButton *)btn{
    if (!btn.selected) {
        btn.selected = YES;
        _realNameButton.selected = NO;
        _complaintWay = 0;
        if (!_sexWayBlock) {
            _sexWayBlock(self.complaintWay);
        }
        
    }
}
// 女
- (void)didclickReal:(UIButton *)btn{
    if (!btn.selected) {
        btn.selected = YES;
        _anonymousButton.selected = NO;
        _complaintWay = 1;
        if (_sexWayBlock) {
            _sexWayBlock(self.complaintWay);
        }
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.anonymousButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(28);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(24);
    }];
    [self.realNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(28);
        make.left.mas_equalTo(self.anonymousButton.mas_right).offset(20);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(24);
    }];
    [self.lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.anonymousButton.mas_bottom).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@1);
    }];

}
- (UIButton *)anonymousButton{
    if (_anonymousButton == nil) {
        
        _anonymousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_anonymousButton setTitle:@"男" forState:UIControlStateNormal];
        [_anonymousButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
        [_anonymousButton setTitleColor:[UIColor colorWithHexString:@"bd4437"] forState:UIControlStateSelected];
        [_anonymousButton setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_anonymousButton setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        [_anonymousButton setImageEdgeInsets:UIEdgeInsetsMake(0,-25,0,0)];
        _anonymousButton.titleEdgeInsets = UIEdgeInsetsMake(5, -20, 5, 0);
        if ([[AcountManager manager].userGender isEqualToString:@"男"]) {
             _anonymousButton.selected = YES;
            _complaintWay = 0;
        }
       
        //        _anonymousButton.backgroundColor = [UIColor orangeColor];
        [_anonymousButton addTarget:self action:@selector(didclickAnonymous:) forControlEvents:UIControlEventTouchUpInside];
        _anonymousButton.titleLabel.font = [UIFont systemFontOfSize:14];
        //        _anonymousButton.backgroundColor = [UIColor cyanColor]
        ;
        
    }
    return _anonymousButton;
    
    
}
- (UIButton *)realNameButton{
    if (_realNameButton == nil) {
        _realNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_realNameButton setTitle:@"女" forState:UIControlStateNormal];
        [_realNameButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
        [_realNameButton setTitleColor:[UIColor colorWithHexString:@"bd4437"] forState:UIControlStateSelected];
        [_realNameButton setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_realNameButton setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        [_realNameButton setImageEdgeInsets:UIEdgeInsetsMake(0,-25,0,0)];
        _realNameButton.titleEdgeInsets = UIEdgeInsetsMake(5, -20, 5, 0);
        if ([[AcountManager manager].userGender isEqualToString:@"女"]) {
            _realNameButton.selected = YES;
            _complaintWay = 1;
        }
        [_realNameButton addTarget:self action:@selector(didclickReal:) forControlEvents:UIControlEventTouchUpInside];
        _realNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _realNameButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    }
    return _realNameButton;
    
    
}
- (UIView *)lineBottom{
    if (_lineBottom == nil) {
        _lineBottom = [[UIView alloc] init];
        _lineBottom.backgroundColor = [UIColor colorWithHexString:@"bdbdbd"];
    }
    return _lineBottom;
}

@end
