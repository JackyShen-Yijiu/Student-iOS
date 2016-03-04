//
//  YBComplaintController.m
//  studentDriving
//
//  Created by zyt on 16/2/18.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBComplaintController.h"
#import "AddlineButtomTextField.h"
#import "YBComplaintCoachView.h"
#import "ComplaintSchoolView.h"
#import "CoachListController.h"
#import "YBMyComplaintListController.h"

@interface YBComplaintController ()<UIScrollViewDelegate,complaintPushCoachDetail>
{
    UIImageView*navBarHairlineImageView;
}

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIButton *coachButton; // 投诉方式

@property (nonatomic, strong) UIButton *shchoolButton;

@property (nonatomic, strong) UIView *lineFollowView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) YBComplaintCoachView *coachView;
@property (nonatomic, strong) ComplaintSchoolView *drivingView;





@end

@implementation YBComplaintController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    
}
- (void)initUI{
    self.title = @"投诉";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = RGBColor(249, 249, 249);
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.coachButton];
    [self.view addSubview:self.shchoolButton];
    [self.view addSubview:self.lineFollowView];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.coachView];
    [self.scrollView addSubview:self.drivingView];
    self.scrollView.delegate = self;
    self.coachView.complaintPushCoachDetailDelegate = self;
    self.coachView.superController = self;
    self.drivingView.superController = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的投诉" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarDidClick)];
    [self.navigationItem.rightBarButtonItem
     setTitleTextAttributes:[NSDictionary
                             dictionaryWithObjectsAndKeys:[UIFont
                                                           boldSystemFontOfSize:14], NSFontAttributeName,nil] forState:UIControlStateNormal];
    
}

- (void)rightBarDidClick
{
    YBMyComplaintListController *vc = [[YBMyComplaintListController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
//    navBarHairlineImageView.hidden = NO;

}
- (void)viewDidDisappear:(BOOL)animated{
//    navBarHairlineImageView.hidden=NO;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
#pragma mark --- ActionButton
- (void)didClickCoach:(UIButton *)btn{
    if (!btn.selected) {
        btn.selected = YES;
        _shchoolButton.selected = NO;
        //获取frame
        CGRect rect = CGRectMake(0, self.lineFollowView.frame.origin.y, self.view.frame.size.width / 2, 2);
        
        //动画
        [UIButton animateWithDuration:0.3 animations:^{
            self.lineFollowView.frame = rect;
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }];
  
    }

}
- (void)didClickSchool:(UIButton *)btn{
    if (!btn.selected) {
        btn.selected = YES;
        _coachButton.selected = NO;
        //获取frame
        CGRect rect = CGRectMake(btn.frame.origin.x, self.lineFollowView.frame.origin.y, self.view.frame.size.width / 2, 2);
        
        //动画
        [UIButton animateWithDuration:0.3 animations:^{
            self.lineFollowView.frame = rect;
            self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
        }];

    }
}
#pragma mark -- UIScrollerView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat systemX = self.view.frame.size.width;
    if (scrollView.contentOffset.x == 0) {
        // 选中相关按钮
        [self didClickCoach:self.coachButton];
    }
    if ( scrollView.contentOffset.x == systemX) {
        // 选中相关按钮
        [self didClickSchool:self.shchoolButton];
    }
}
#pragma mark -- 教练详情的代理方法
- (void)initWithComplaintPushCoachDetail{
    // 教练详情
    CoachListController *listVC = [CoachListController new];
    listVC.schoolID = [AcountManager manager].applyschool.infoId;
    listVC.type = 1;
    listVC.complaintCoachNameLabel = self.coachView.nameCoachLabel;
    listVC.complaintCoachNameLabelBottom = self.coachView.bottomCoachName;
    [self.navigationController pushViewController:listVC animated:YES];
}
#pragma mark --- Lazy加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        _bgView.backgroundColor = YBNavigationBarBgColor;
        
    }
    return _bgView;
}
- (UIButton *)coachButton{
    if (_coachButton == nil) {
        _coachButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _coachButton.frame = CGRectMake(0, 0, self.view.frame.size.width / 2, 48);
        _coachButton.backgroundColor = [UIColor clearColor];
        [_coachButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_coachButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateSelected];
        [_coachButton setTitle:@"投诉教练" forState:UIControlStateNormal];
        _coachButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _coachButton.selected = YES;
        [_coachButton addTarget:self action:@selector(didClickCoach:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _coachButton;
}
- (UIButton *)shchoolButton{
    if (_shchoolButton == nil) {
        _shchoolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shchoolButton.frame = CGRectMake(self.view.frame.size.width / 2, 0, self.view.frame.size.width / 2, 48);
        _shchoolButton.backgroundColor = [UIColor clearColor];
        [_shchoolButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_shchoolButton setTitleColor:[UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateSelected];
        [_shchoolButton setTitle:@"投诉驾校" forState:UIControlStateNormal];
         _shchoolButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_shchoolButton addTarget:self action:@selector(didClickSchool:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shchoolButton;
}
- (UIView *)lineFollowView{
    if (_lineFollowView == nil) {
        _lineFollowView = [[UIView alloc] initWithFrame:CGRectMake(0, 48, self.view.frame.size.width / 2, 2)];
        _lineFollowView.backgroundColor = [UIColor yellowColor];
    }
    return _lineFollowView;
}
- (YBComplaintCoachView *)coachView {
    if (!_coachView) {
        CGSize size = self.view.bounds.size;
         _coachView = [[YBComplaintCoachView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - 50 - 64)];
    }
    return _coachView;
}
- (ComplaintSchoolView *)drivingView {
    if (!_drivingView) {
        CGSize size = self.view.bounds.size;
        _drivingView = [[ComplaintSchoolView alloc] initWithFrame:CGRectMake(size.width, 0, size.width, size.height - 50 - 64)];
//        _drivingView.backgroundColor = [UIColor cyanColor];
    }
    return _drivingView;
}
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50 - 64)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
        
    }

    return _scrollView;
}
@end
