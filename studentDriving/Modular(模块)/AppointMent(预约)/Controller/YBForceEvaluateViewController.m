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
#import "APCommentViewController.h"


@interface YBForceEvaluateViewController ()<UITextViewDelegate>

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIView *alertBgView;

@property (nonatomic,strong) UIView *alertView;

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


- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    // 更新UI
    [self setUpUI];
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_iconURL]] placeholderImage:[UIImage imageNamed:@"loginLogo"]];
    self.coachNameLabel.text = self.nameStr;
    
}

- (void)setUpUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
   

    [self.view addSubview:self.bgView];
    [self.view addSubview:self.alertBgView];
    [self.alertBgView addSubview:self.alertView];
    
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
    // 分割竖线
    [self.alertView addSubview:self.verticalLineView];
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
    // 更多选项的点击事件
    if (self.moteblock) {
        self.moteblock();
    }
        APCommentViewController *apcVC = [[APCommentViewController alloc] init];
        [self.view addSubview:apcVC.view];

}
- (void)commitBtnDidClick
{
    NSLog(@"%s",__func__);
    
    // 提交评价的点击事件
    if (self.commitBlock) {
            self.commitBlock();
    }

}
#pragma mark --- UITextView Delegate
- (void)textViewDidChange:(UITextView *)textView
{
    YBTextView *ybTextView = (YBTextView *)textView;
    if (ybTextView.text.length == 0) {
        ybTextView.placeholderLabel.hidden = NO;
    }
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
#pragma mark --- 加载数据
// 加载教练头像
- (void)setIconURL:(NSString *)iconURL
{
    _iconURL = iconURL;
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_iconURL]] placeholderImage:[UIImage imageNamed:@"loginLogo"]];
    
}
// 加载教练姓名
- (void)setNameStr:(NSString *)nameStr{
    self.coachNameLabel.text = nameStr;
}
#pragma mark --- Lazy 加载
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
        CGFloat width = (kSystemWide - 24 * 2 );
        CGFloat height = 600;
        CGFloat X = 24 ;
        _alertBgView = [[UIView alloc] initWithFrame:CGRectMake(X, 64 + 22, width, height)];
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
// 顶部文字
- (UILabel *)topTitleLabel
{
    if (_topTitleLabel==nil) {
        CGFloat width = 16 * 10;
        CGFloat height = 16;
        _topTitleLabel = [[UILabel alloc] init];
        _topTitleLabel.text = @"上次练车练的怎么样?";
        _topTitleLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _topTitleLabel.font = [UIFont systemFontOfSize:16];
        _topTitleLabel.textAlignment = NSTextAlignmentCenter;
        _topTitleLabel.frame = CGRectMake(self.alertView.width/2 - width/2, 36, width, height);
        
    }
    return _topTitleLabel;
}
// 描述文字
- (UILabel *)desLabel
{
    if (_desLabel==nil) {
        CGFloat width = 16 * 7;
        CGFloat height = 16;
        _desLabel = [[UILabel alloc] init];
        _desLabel.text = @"先来评价一下~";
        _desLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _desLabel.font = [UIFont systemFontOfSize:16];
        _desLabel.textAlignment = NSTextAlignmentCenter;
        _desLabel.frame = CGRectMake(self.alertView.width/2 - width/2, CGRectGetMaxY(self.topTitleLabel.frame)+16, width, height);
        
    }
    return _desLabel;
}
// 教练文字
- (UILabel *)coachTitleLabel
{
    if (_coachTitleLabel==nil) {
        CGFloat width = 14 * 2;
        CGFloat height = 14;
        _coachTitleLabel = [[UILabel alloc] init];
        _coachTitleLabel.text = @"教练";
        _coachTitleLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
        _coachTitleLabel.font = [UIFont systemFontOfSize:14];
        _coachTitleLabel.textAlignment = NSTextAlignmentCenter;
        _coachTitleLabel.frame = CGRectMake(self.alertView.width/2 - width/2, CGRectGetMaxY(self.desLabel.frame)+24, width, height);
        
    }
    return _coachTitleLabel;
}


// 头像
- (UIImageView *)iconImgView
{
    if (_iconImgView==nil) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.backgroundColor = YBNavigationBarBgColor;
        _iconImgView.frame = CGRectMake(self.alertView.width/2-60/2, CGRectGetMaxY(self.coachTitleLabel.frame)+10, 60, 60);
        _iconImgView.layer.masksToBounds = YES;
        _iconImgView.layer.cornerRadius = 30;
    }
    return _iconImgView;
}
// 教练姓名
- (UILabel *)coachNameLabel
{
    if (_coachNameLabel==nil) {
        CGFloat width = 14 * 8;
        CGFloat height = 14;
        _coachNameLabel = [[UILabel alloc] init];
        _coachNameLabel.text = @"######";
        _coachNameLabel.textColor = [UIColor colorWithHexString:@"b7b7b7"];
        _coachNameLabel.font = [UIFont systemFontOfSize:14];
        _coachNameLabel.textAlignment = NSTextAlignmentCenter;
        _coachNameLabel.frame = CGRectMake(self.alertView.width/2 - width/2, CGRectGetMaxY(self.iconImgView.frame)+12, width, height);
        
    }
    return _coachNameLabel;
}

// 用户星级
- (RatingBar *)starBar
{
    if (_starBar==nil) {
        CGFloat width = 90;
        CGFloat height = 30;
        _starBar = [[RatingBar alloc] initWithFrame:CGRectMake(self.alertView.width/2-width/2, CGRectGetMaxY(self.coachNameLabel.frame)+20, width, height)];
        [_starBar setUpRating:0.0];
        [_starBar setImageDeselected:@"starUnSelected.png" halfSelected:nil fullSelected:@"starSelected.png" andDelegate:nil];
    }
    return _starBar;
}
// 请输入原因
- (YBTextView *)reasonTextView
{
    if (_reasonTextView==nil) {
        CGFloat height = 50;
        CGFloat margin = 18;
        _reasonTextView = [[YBTextView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.starBar.frame)+25, self.alertView.width-2*margin, height) withPlaceholder:@"我来说两句" ];
        _reasonTextView.placeholderLabel.font = [UIFont systemFontOfSize:12];
        _reasonTextView.textColor = [UIColor blackColor];
        _reasonTextView.font = [UIFont systemFontOfSize:13];
        _reasonTextView.backgroundColor = [UIColor clearColor];
        _reasonTextView.delegate = self;
        _reasonTextView.layer.borderColor = [[UIColor colorWithHexString:@"b7b7b7"]CGColor];
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
        _delive = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.reasonTextView.frame)+40, self.alertView.width, 0.5)];
        _delive.backgroundColor = HM_LINE_COLOR;
        _delive.alpha = 0.5;
    }
    return _delive;
}
// 更多选项
- (UIButton *)moreBtn
{
    if (_moreBtn==nil) {
        _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.delive.frame), self.alertView.width/2, 48)];
        [_moreBtn setTitle:@"更多选项" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:RGBColor(114, 114, 114) forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_moreBtn addTarget:self action:@selector(moreBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}
// 分割竖线
- (UIView *)verticalLineView{
    if (_verticalLineView == nil) {
        _verticalLineView = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.alertView.frame) - 0.5) / 2, CGRectGetMidY(self.delive.frame) + 5, 1, 40)];
        _verticalLineView.backgroundColor = HM_LINE_COLOR;
    }
    return _verticalLineView;
}
// 提交评价
- (UIButton *)commitBtn
{
    if (_commitBtn==nil) {
        _commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.moreBtn.frame), self.moreBtn.frame.origin.y, self.alertView.width/2, 48)];
        [_commitBtn setTitle:@"提交评价" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:YBNavigationBarBgColor forState:UIControlStateNormal];
        [_commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_commitBtn addTarget:self action:@selector(commitBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        _commitBtn.enabled = NO;
    }
    return _commitBtn;
}

@end
