//
//  ComplaintCoachView.m
//  studentDriving
//
//  Created by zyt on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBComplaintCoachView.h"
#import "AddlineButtomTextField.h"

@interface YBComplaintCoachView ()

@property (nonatomic, strong) UIButton *anonymousButton; // 匿名投诉

@property (nonatomic, strong) UIButton *realNameButton;

@property (nonatomic, strong) UIView *lintComlaintView;

@property (nonatomic, strong) UIView *BgoachNameView; // 添加手势，跳转教练列表页面

@property (nonatomic, strong) UILabel *titlieNameCoachLabel;

@property (nonatomic, strong) UILabel *nameCoachLabel;

@property (nonatomic, strong) UIView *lineNameView;

@property (nonatomic, strong) UILabel *phontView; // 投诉人联系电话

@property (nonatomic, strong) AddlineButtomTextField *phontTextField;

@property (nonatomic, strong) UILabel *complaintContentLabel; // 投诉内容

@property (nonatomic, strong) AddlineButtomTextField *complaintTextField;

@property (nonatomic, strong)  UIView *bottomBG; // 底部试图

@property (nonatomic, strong) UILabel *bottomCoachName;

@property (nonatomic, strong)  UIButton *commintButton;


@end
@implementation YBComplaintCoachView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.anonymousButton];
    [self addSubview:self.realNameButton];
    [self addSubview:self.lintComlaintView];
    [self addSubview:self.BgoachNameView];
    [self addSubview:self.titlieNameCoachLabel];
    [self addSubview:self.nameCoachLabel];
    [self addSubview:self.lineNameView];
}
#pragma mark --- ActionTagart
// 匿名投诉
- (void)didclickAnonymous:(UIButton *)btn{
    
}
// 实名投诉
- (void)didclickReal:(UIButton *)btn{
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.anonymousButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(24);
    }];
    [self.realNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.anonymousButton.mas_right).offset(100);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(24);
    }];
    [self.lintComlaintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.anonymousButton.mas_bottom).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(1);
    }];
    [self.BgoachNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lintComlaintView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.height.mas_equalTo(73);
        make.right.mas_equalTo(self.mas_right).offset(0);
    }];
    [self.titlieNameCoachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.BgoachNameView.mas_top).offset(16);
        make.left.mas_equalTo(self.anonymousButton.mas_right).offset(20);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(10);
    }];
    [self.nameCoachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titlieNameCoachLabel.mas_bottom).offset(16);
        make.left.mas_equalTo(self.anonymousButton.mas_right).offset(20);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(14);
    }];
    [self.lineNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameCoachLabel.mas_bottom).offset(16);
        make.left.mas_equalTo(self.anonymousButton.mas_right).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(1);
    }];

}
#pragma mark --- Lazy加载

- (UIButton *)anonymousButton{
    if (_anonymousButton == nil) {
        
        _anonymousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_anonymousButton setTitle:@"匿名投诉" forState:UIControlStateNormal];
        [_anonymousButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
        [_anonymousButton setTitleColor:[UIColor colorWithHexString:@"bd4437"] forState:UIControlStateSelected];
        [_anonymousButton setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_anonymousButton setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        _anonymousButton.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,_anonymousButton.frame.size.width - 24);
        _anonymousButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _anonymousButton.titleEdgeInsets = UIEdgeInsetsMake(5, 29, 5, 0);
        _anonymousButton.selected = YES;
        [_anonymousButton addTarget:self action:@selector(didclickAnonymous:) forControlEvents:UIControlEventTouchUpInside];
        _anonymousButton.backgroundColor = [UIColor cyanColor]
        ;
        
    }
    return _anonymousButton;
    
    
}
- (UIButton *)realNameButton{
    if (_realNameButton == nil) {
        
        _realNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_realNameButton setTitle:@"实名投诉" forState:UIControlStateNormal];
        [_realNameButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
        [_realNameButton setTitleColor:[UIColor colorWithHexString:@"bd4437"] forState:UIControlStateSelected];
        [_realNameButton setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_realNameButton setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        _realNameButton.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,_anonymousButton.bounds.size.width - 24);
        _realNameButton.titleEdgeInsets = UIEdgeInsetsMake(5, 29, 5, 0);
        
        [_anonymousButton addTarget:self action:@selector(didclickReal:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _realNameButton;
    
    
}
- (UIView *)lintComlaintView{
    if (_lineNameView == nil) {
        _lineNameView = [[UIView alloc] init];
        _lineNameView.backgroundColor  = [UIColor colorWithHexString:@"bdbdbd"];
        
    }
    return _lineNameView;
}
- (UIView *)BgoachNameView{
    if (_BgoachNameView == nil) {
        _BgoachNameView = [[UIView alloc] init];
        _BgoachNameView.backgroundColor = [UIColor clearColor];
        
    }
    return _BgoachNameView;
}
- (UILabel *)titlieNameCoachLabel{
    if (_titlieNameCoachLabel == nil) {
        _titlieNameCoachLabel = [[UILabel alloc] init];
        _titlieNameCoachLabel.text = @"投诉教练姓名";
        _titlieNameCoachLabel.textColor = [UIColor colorWithHexString:@"bdbdbd"];
        _titlieNameCoachLabel.font = [UIFont systemFontOfSize:10];
        
        
    }
    return _titlieNameCoachLabel;
}

- (UILabel *)nameCoachLabel{
    if (_nameCoachLabel == nil) {
        _nameCoachLabel = [[UILabel alloc] init];
        _nameCoachLabel.text = @"周华健";
        _nameCoachLabel.textColor = [UIColor blackColor];
        _nameCoachLabel.font = [UIFont systemFontOfSize:14];
        
        
    }
    return _nameCoachLabel;
}
- (UIView *)lineNameView{
    if (_lineNameView == nil) {
        _lineNameView = [[UIView alloc] init];
        _lineNameView.backgroundColor  = [UIColor colorWithHexString:@"bdbdbd"];
        
    }
    return _lineNameView;
}

@end
