//
//  YBStudyViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBStudyViewController.h"
#import "YBToolBarView.h"
#import "DVVSendMessageToStudentView.h"

@interface YBStudyViewController ()<UIScrollViewDelegate>
{
    UIImageView*navBarHairlineImageView;
}
@property (nonatomic, strong) YBToolBarView *dvvToolBarView;

@property (nonatomic, strong) UIView *toolBarBottomLineView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) DVVSendMessageToStudentView *theoreticalView;
@property (nonatomic, strong) DVVSendMessageToStudentView *drivingView;
@property (nonatomic, strong) DVVSendMessageToStudentView *licensingView;
@property (nonatomic, strong) DVVSendMessageToStudentView *kemusiView;

@property (nonatomic, strong) NSArray *theoreticalArray;
@property (nonatomic, strong) NSArray *drivingArray;
@property (nonatomic, strong) NSArray *licensingArray;
@property (nonatomic, strong) NSArray *kemusiArray;

@end

@implementation YBStudyViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    navBarHairlineImageView.hidden=NO;
    
}

- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView*subview in view.subviews) {
        UIImageView*imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"学习";
    
    [self.view addSubview:self.dvvToolBarView];
    
    [self.view addSubview:self.toolBarBottomLineView];
    
    [self.view addSubview:self.scrollView];
    
    [_scrollView addSubview:self.theoreticalView];
    [_scrollView addSubview:self.drivingView];
    [_scrollView addSubview:self.licensingView];
    [_scrollView addSubview:self.kemusiView];

    [self configUI];
    
    // 请求数据
    [_theoreticalView beginNetworkRequest];
    [_drivingView beginNetworkRequest];
    [_licensingView beginNetworkRequest];
    [_kemusiView beginNetworkRequest];

}

#pragma mark - action
- (void)theoreticalSelectButtonAction:(UIButton *)sender mobileArray:(NSArray *)array {
    NSLog(@"1===%@", array);
    self.theoreticalArray = array;
}
- (void)drivingSelectButtonAction:(UIButton *)sender mobileArray:(NSArray *)array {
    NSLog(@"2===%@", array);
    self.drivingArray = array;
}
- (void)licensingSelectButtonAction:(UIButton *)sender mobileArray:(NSArray *)array {
    NSLog(@"3===%@", array);
    self.licensingArray = array;
}
- (void)kemusiSelectButtonAction:(UIButton *)sender mobileArray:(NSArray *)array {
    NSLog(@"4===%@", array);
    self.kemusiArray = array;
}
- (void)toolBarItemSelectedAction:(UIButton *)sender {
    [self changeScrollViewOffSetX:sender.tag];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSUInteger tag = scrollView.contentOffset.x / CGRectGetWidth(_scrollView.frame);
    [self changeScrollViewOffSetX:tag];
    [_dvvToolBarView selectItem:tag];
}

#pragma mark - public
- (void)changeScrollViewOffSetX:(NSUInteger)tag {
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame) * tag, 0);
    }];
}

#pragma mark - configUI
- (void)configUI {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat toolBarHeight = 40;
    
    _dvvToolBarView.frame = CGRectMake(0, 0, screenSize.width, toolBarHeight);
    
    _toolBarBottomLineView.frame = CGRectMake(0, CGRectGetMaxY(_dvvToolBarView.frame), screenSize.width, 1);
    
    _scrollView.frame = CGRectMake(0, 64 + toolBarHeight + 1, screenSize.width, screenSize.height - 64 - toolBarHeight);
    _scrollView.contentSize = CGSizeMake(screenSize.width * 4, 0);
    
    _theoreticalView.frame = CGRectMake(0, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    _drivingView.frame = CGRectMake(screenSize.width, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    _licensingView.frame = CGRectMake(screenSize.width * 2, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    _kemusiView.frame = CGRectMake(screenSize.width * 3, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    
}

#pragma mark - lazy load
- (YBToolBarView *)dvvToolBarView {
    if (!_dvvToolBarView) {
        _dvvToolBarView = [YBToolBarView new];
        _dvvToolBarView.titleArray = @[ @"科目一", @"科目二", @"科目三" ,@"科目四"];
        _dvvToolBarView.titleNormalColor = [UIColor lightGrayColor];
        _dvvToolBarView.titleSelectedColor = [UIColor whiteColor];
        _dvvToolBarView.buttonNormalColor = YBNavigationBarBgColor;
        _dvvToolBarView.buttonSelectedColor = YBNavigationBarBgColor;
        __weak typeof(self) ws = self;
        [_dvvToolBarView dvvSetItemSelectedBlock:^(UIButton *button) {
            [ws toolBarItemSelectedAction:button];
        }];
        _dvvToolBarView.backgroundColor = YBNavigationBarBgColor;
    }
    return _dvvToolBarView;
}
- (UIView *)toolBarBottomLineView {
    if (!_toolBarBottomLineView) {
        _toolBarBottomLineView = [UIView new];
        _toolBarBottomLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _toolBarBottomLineView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.bounces = NO;
    }
    return _scrollView;
}
- (DVVSendMessageToStudentView *)theoreticalView {
    if (!_theoreticalView) {
        _theoreticalView = [DVVSendMessageToStudentView new];
        _theoreticalView.studentType = 1;
        __weak typeof(self) ws = self;
        [_theoreticalView setSelectButtonTouchUpInsideBlock:^(UIButton *button, NSArray *mobileArray) {
            [ws theoreticalSelectButtonAction:button mobileArray:mobileArray];
        }];
    }
    return _theoreticalView;
}
- (DVVSendMessageToStudentView *)drivingView {
    if (!_drivingView) {
        _drivingView = [DVVSendMessageToStudentView new];
        _drivingView.studentType = 2;
        __weak typeof(self) ws = self;
        [_drivingView setSelectButtonTouchUpInsideBlock:^(UIButton *button, NSArray *mobileArray) {
            [ws drivingSelectButtonAction:button mobileArray:mobileArray];
        }];
    }
    return _drivingView;
}
- (DVVSendMessageToStudentView *)licensingView {
    if (!_licensingView) {
        _licensingView = [DVVSendMessageToStudentView new];
        _licensingView.studentType = 3;
        __weak typeof(self) ws = self;
        [_licensingView setSelectButtonTouchUpInsideBlock:^(UIButton *button, NSArray *mobileArray) {
            [ws licensingSelectButtonAction:button mobileArray:mobileArray];
        }];
    }
    return _licensingView;
}
- (DVVSendMessageToStudentView *)kemusiView {
    if (!_kemusiView) {
        _kemusiView = [DVVSendMessageToStudentView new];
        _kemusiView.studentType = 4;
        __weak typeof(self) ws = self;
        [_kemusiView setSelectButtonTouchUpInsideBlock:^(UIButton *button, NSArray *mobileArray) {
            [ws kemusiSelectButtonAction:button mobileArray:mobileArray];
        }];
    }
    return _kemusiView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
