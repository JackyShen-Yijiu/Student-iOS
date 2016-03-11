//
//  YBForceEvaluateViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBForceEvaluateViewController.h"
#import "RatingBar.h"
#import "ShowWarningMessageView.h"

@interface YBForceEvaluateViewController ()<UITextViewDelegate>

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIView *alertBgView;

@property (nonatomic,strong) UIView *alertView;
// 车标头像
@property (nonatomic, strong) UIImageView *carImagView;

// 顶部文字
@property (nonatomic, strong) UILabel *topTitleLabel;

// 描述文字
@property (nonatomic, strong) UILabel *desLabel;

// 教练文字
@property (nonatomic, strong) UILabel *coachTitleLabel;

// 头像
@property (nonatomic,strong) UIImageView *iconImgView;

// 教练姓名
@property (nonatomic, strong) UILabel *coachNameLabel;

// 评价多少字
@property (nonatomic,strong) UILabel *commentCountLabel;


// 分割线
@property (nonatomic,strong) UIView *delive;

// 分割竖线
@property (nonatomic, strong) UIView *verticalLineView;

// 更多选项
@property (nonatomic,strong) UIButton *moreBtn;

// 提交评价
@property (nonatomic,strong) UIButton *commitBtn;

@end

@implementation YBForceEvaluateViewController

- (UIView *)bgView
{
    if (_bgView==nil) {
        _bgView = [[UIView alloc] initWithFrame:self.view.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.5;
    }
    return _bgView;
}

- (UIView *)alertBgView
{
    if (_alertBgView==nil) {
        // 540 446
        CGFloat width = 540/2;
        CGFloat height = 600;
        CGFloat X = kSystemWide/2-width/2;
        _alertBgView = [[UIView alloc] initWithFrame:CGRectMake(X, 0, width, height)];
        _alertBgView.backgroundColor = [UIColor blackColor];
    }
    return _alertBgView;
}

- (UIView *)alertView
{
    if (_alertView==nil) {
        _alertView = [[UIView alloc] initWithFrame:self.alertBgView.bounds];
        _alertView.backgroundColor = RGBColor(250, 250, 250);
    }
    return _alertView;
}
// 汽车头像
- (UIImageView *)carImagView
{
    if (_carImagView==nil) {
        _carImagView = [[UIImageView alloc] init];
        _carImagView.backgroundColor = YBNavigationBarBgColor;
        _carImagView.frame = CGRectMake(self.alertView.width/2-40/2, 20, 40, 40);
        
    }
    return _carImagView;
}
// 顶部文字
- (UILabel *)topTitleLabel
{
    if (_topTitleLabel==nil) {
        CGFloat width = 14 * 10;
        CGFloat height = 14;
        _topTitleLabel = [[UILabel alloc] init];
        _topTitleLabel.text = @"上次练车练的怎么样?";
        _topTitleLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _topTitleLabel.font = [UIFont systemFontOfSize:14];
        _topTitleLabel.textAlignment = NSTextAlignmentCenter;
        _topTitleLabel.frame = CGRectMake(self.alertView.width/2 - width/2, CGRectGetMaxY(self.carImagView.frame)+20, width, height);
        
    }
    return _topTitleLabel;
}
// 描述文字
- (UILabel *)desLabel
{
    if (_desLabel==nil) {
        CGFloat width = 14 * 7;
        CGFloat height = 14;
        _desLabel = [[UILabel alloc] init];
        _desLabel.text = @"先来评价一下~";
        _desLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _desLabel.font = [UIFont systemFontOfSize:14];
        _desLabel.textAlignment = NSTextAlignmentCenter;
        _desLabel.frame = CGRectMake(self.alertView.width/2 - width/2, CGRectGetMaxY(self.topTitleLabel.frame)+10, width, height);
        
    }
    return _desLabel;
}
// 描述文字
- (UILabel *)coachTitleLabel
{
    if (_coachTitleLabel==nil) {
        CGFloat width = 12 * 2;
        CGFloat height = 12;
        _coachTitleLabel = [[UILabel alloc] init];
        _coachTitleLabel.text = @"教练";
        _coachTitleLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
        _coachTitleLabel.font = [UIFont systemFontOfSize:12];
        _coachTitleLabel.textAlignment = NSTextAlignmentCenter;
        _coachTitleLabel.frame = CGRectMake(self.alertView.width/2 - width/2, CGRectGetMaxY(self.desLabel.frame)+40, width, height);
        
    }
    return _coachTitleLabel;
}


// 头像
- (UIImageView *)iconImgView
{
    if (_iconImgView==nil) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.backgroundColor = YBNavigationBarBgColor;
        _iconImgView.frame = CGRectMake(self.alertView.width/2-40/2, CGRectGetMaxY(self.coachTitleLabel.frame)+10, 40, 40);
        _iconImgView.layer.masksToBounds = YES;
        _iconImgView.layer.cornerRadius = 20;
    }
    return _iconImgView;
}
// 教练姓名
- (UILabel *)coachNameLabel
{
    if (_coachNameLabel==nil) {
        CGFloat width = 12 * 8;
        CGFloat height = 12;
        _coachNameLabel = [[UILabel alloc] init];
        _coachNameLabel.text = @"######";
        _coachNameLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
        _coachNameLabel.font = [UIFont systemFontOfSize:12];
        _coachNameLabel.textAlignment = NSTextAlignmentCenter;
        _coachNameLabel.frame = CGRectMake(self.alertView.width/2 - width/2, CGRectGetMaxY(self.iconImgView.frame)+10, width, height);
        
    }
    return _coachNameLabel;
}

// 用户星级
- (RatingBar *)starBar
{
    if (_starBar==nil) {
        CGFloat width = 150;
        CGFloat height = 30;
        _starBar = [[RatingBar alloc] initWithFrame:CGRectMake(self.alertView.width/2-width/2, CGRectGetMaxY(self.coachNameLabel.frame)+20, width, height)];
        [_starBar setUpRating:0.0];
        [_starBar setImageDeselected:@"YBStarNomalImg.png" halfSelected:nil fullSelected:@"YBStarSelectImg.png" andDelegate:nil];
    }
    return _starBar;
}
// 请输入原因
- (UITextView *)reasonTextView
{
    if (_reasonTextView==nil) {
        CGFloat height = 50;
        CGFloat margin = 18;
        _reasonTextView = [[UITextView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.starBar.frame)+10, self.alertView.width-2*margin, height)];
        _reasonTextView.textColor = [UIColor blackColor];
        _reasonTextView.font = [UIFont systemFontOfSize:13];
        _reasonTextView.backgroundColor = [UIColor clearColor];
        _reasonTextView.delegate = self;
        [_reasonTextView becomeFirstResponder];
        _reasonTextView.layer.borderColor = [[UIColor colorWithHexString:@"6e6e6e"]CGColor];
        _reasonTextView.layer.borderWidth = 1.0;
        _reasonTextView.layer.cornerRadius = 4.0f;
        [_reasonTextView.layer setMasksToBounds:YES];
        
        
    }
    return _reasonTextView;
}
// 评价多少字
- (UILabel *)commentCountLabel
{
    if (_commentCountLabel==nil) {
        _commentCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.reasonTextView.frame)-100, CGRectGetMaxY(self.reasonTextView.frame)-22, 100, 25)];
        _commentCountLabel.text = @"0/40";
        _commentCountLabel.textAlignment = NSTextAlignmentRight;
        _commentCountLabel.font = [UIFont systemFontOfSize:12];
        _commentCountLabel.textColor = [UIColor lightGrayColor];
    }
    return _commentCountLabel;
}

// 分割线
- (UIView *)delive
{
    if (_delive==nil) {
        _delive = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.reasonTextView.frame)+10, self.alertView.width, 0.5)];
        _delive.backgroundColor = [UIColor lightGrayColor];
        _delive.alpha = 0.5;
    }
    return _delive;
}
// 更多选项
- (UIButton *)moreBtn
{
    if (_moreBtn==nil) {
        _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.delive.frame), self.alertView.width/2, 50)];
        [_moreBtn setTitle:@"更多选项" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:RGBColor(114, 114, 114) forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_moreBtn addTarget:self action:@selector(moreBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}
// 提交评价
- (UIButton *)commitBtn
{
    if (_commitBtn==nil) {
        _commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.moreBtn.frame), self.moreBtn.frame.origin.y, self.alertView.width/2, 50)];
        [_commitBtn setTitle:@"提交评价" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:RGBColor(114, 114, 114) forState:UIControlStateNormal];
        [_commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_commitBtn addTarget:self action:@selector(commitBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        _commitBtn.enabled = NO;
    }
    return _commitBtn;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    // 更新UI
    [self setUpUI];
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_iconURL]] placeholderImage:[UIImage imageNamed:@"loginLogo"]];
    
}

- (void)setIconURL:(NSString *)iconURL
{
    _iconURL = iconURL;
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_iconURL]] placeholderImage:[UIImage imageNamed:@"loginLogo"]];

}

- (void)setUpUI
{
    
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.alertBgView];
    [self.alertBgView addSubview:self.alertView];
    
    // 汽车头像
    [self.alertView addSubview:self.carImagView];
    
    // 顶部文字
    [self.alertView addSubview:self.topTitleLabel];
    
    // 描述文字
    [self.alertView addSubview:self.desLabel];
    
    // 教练文字
    [self.alertView addSubview:self.coachTitleLabel];

    // 头像
    [self.alertView addSubview:self.iconImgView];
    
    // 教练姓名
    [self.alertView addSubview:self.coachNameLabel];
    
    // 用户星级
    [self.alertView addSubview:self.starBar];
    
    // 评价多少字
    [self.alertView addSubview:self.commentCountLabel];
    
    // 请输入原因
    [self.alertView addSubview:self.reasonTextView];
    
    // 分割线
    [self.alertView addSubview:self.delive];
    
    // 更多选项
    [self.alertView addSubview:self.moreBtn];
    
    // 提交评价
    [self.alertView addSubview:self.commitBtn];
    
//     更新尺寸
    CGRect alertBgF = self.alertBgView.frame;
    alertBgF.size.height = CGRectGetMaxY(self.commitBtn.frame);
    self.alertBgView.frame = alertBgF;
    self.alertView.frame = self.alertBgView.bounds;

}

- (void)moreBtnDidClick{
    NSLog(@"%s",__func__);
    self.moteblock();
}
- (void)commitBtnDidClick
{
    NSLog(@"%s",__func__);
    self.commitBlock();
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length]>40) {
        
        textView.text = [textView.text substringToIndex:40];
        return;
        
    }
    if (textView.text && [textView.text length]!=0) {
        _commitBtn.enabled = YES;
    }else{
        _commitBtn.enabled = NO;
    }
    _commentCountLabel.text = [NSString stringWithFormat:@"%lu/40",(unsigned long)[textView.text length]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
