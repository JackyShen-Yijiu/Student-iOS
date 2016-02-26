//
//  YBMyWalletViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/26.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBMyWalletViewController.h"
#import "YBStudyTableView.h"
#import "YBToolBarView.h"
#import "YBJianglijifenTableView.h"
#import "YBBaoMingDuiHuanQuanTableView.h"

#define topViewH 175
#define toolBarHeight 40

@interface YBMyWalletViewController ()<UIScrollViewDelegate>
{
    UIImageView*navBarHairlineImageView;
    YBStudyProgress studyProgress;
}

@property (nonatomic,strong)UIView *topView;

@property (nonatomic, strong) YBToolBarView *dvvToolBarView;

@property (nonatomic, strong) UIView *toolBarBottomLineView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) YBJianglijifenTableView *jianglijifenTableView;
@property (nonatomic, strong) YBBaoMingDuiHuanQuanTableView *baomingduihuanquanTableView;
@property (nonatomic, strong) YBJianglijifenTableView *kequxianjinedu;

@property (nonatomic, strong) NSMutableArray *kemuyiArray;
@property (nonatomic, strong) NSMutableArray *kemuerArray;
@property (nonatomic, strong) NSMutableArray *kequxianjineduArray;

@end

@implementation YBMyWalletViewController

- (NSMutableArray *)kemuyiArray
{
    if (_kemuyiArray==nil) {
        _kemuyiArray = [NSMutableArray array];
    }
    return _kemuyiArray;
}
- (NSMutableArray *)kemuerArray
{
    if (_kemuerArray==nil) {
        _kemuerArray = [NSMutableArray array];
    }
    return _kemuerArray;
}
- (NSMutableArray *)kequxianjineduArray
{
    if (_kequxianjineduArray==nil) {
        _kequxianjineduArray = [NSMutableArray array];
    }
    return _kequxianjineduArray;
}
#pragma mark - lazy load
- (YBToolBarView *)dvvToolBarView {
    if (!_dvvToolBarView) {
        _dvvToolBarView = [YBToolBarView new];
        _dvvToolBarView.titleArray = @[ @"奖励积分", @"报名兑换券", @"可取现金额度" ];
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
- (UIView *)topView
{
    if (_topView==nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, topViewH)];
        _topView.backgroundColor = YBNavigationBarBgColor;
        
        // 标题
        // 数量
        
        // 顶部segment
        [_topView addSubview:self.dvvToolBarView];
        // 分割线
        [_topView addSubview:self.toolBarBottomLineView];
        
    }
    return _topView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    
    // 更新数据
    [self reloadData];
    
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

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"钱包";
    
    // 顶部view
    [self.view addSubview:self.topView];
    
    // 滚动视图
    [self.view addSubview:self.scrollView];
    
    [_scrollView addSubview:self.jianglijifenTableView];
    [_scrollView addSubview:self.baomingduihuanquanTableView];
    [_scrollView addSubview:self.kequxianjinedu];
    
    [self configUI];
    
    // 请求数据
    [self setUpData];
    
}

- (void)setUpData
{
    // JSON文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"YBStudyData.json" ofType:nil];
    
    // 加载JSON文件
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    // 将JSON数据转为NSArray或者NSDictionary
    NSDictionary *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"dictArray:%@",dictArray);
    
    NSArray *dataArray = [dictArray objectForKey:@"data"];
    
    NSLog(@"dataArray:%@",dataArray);
    
    for (NSDictionary *dict in dataArray[0]) {
        [self.kemuyiArray addObject:dict];
    }
    for (NSDictionary *dict in dataArray[1]) {
        [self.kemuerArray addObject:dict];
    }
    for (NSDictionary *dict in dataArray[2]) {
        [self.kequxianjineduArray addObject:dict];
    }
    
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
    
    NSLog(@"tag:%lu",(unsigned long)tag);
    
    studyProgress = tag;
    
    // 更新数据
    [self reloadData];
    
}

- (void)reloadData
{
    
    if (studyProgress==0) {
        
        self.jianglijifenTableView.dataArray = [self.kemuyiArray mutableCopy];
        [self.jianglijifenTableView reloadData];
        
    }else if (studyProgress == 1){
        
        self.baomingduihuanquanTableView.dataArray = [self.kemuerArray mutableCopy];
        [self.baomingduihuanquanTableView reloadData];
        
    }else if (studyProgress == 2){
        
        self.kequxianjinedu.dataArray = [self.kequxianjineduArray mutableCopy];
        [self.kequxianjinedu reloadData];
        
    }
    
}

#pragma mark - configUI
- (void)configUI {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    _dvvToolBarView.frame = CGRectMake(0, topViewH-toolBarHeight, screenSize.width, toolBarHeight);
    
    _toolBarBottomLineView.frame = CGRectMake(0, CGRectGetMaxY(_dvvToolBarView.frame), screenSize.width, 1);
    
    _scrollView.frame = CGRectMake(0, topViewH, screenSize.width, screenSize.height - topViewH-64);
    _scrollView.contentSize = CGSizeMake(screenSize.width * 3, 0);
    
    _jianglijifenTableView.frame = CGRectMake(0, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    _baomingduihuanquanTableView.frame = CGRectMake(screenSize.width, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    _kequxianjinedu.frame = CGRectMake(screenSize.width * 2, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    
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
- (YBJianglijifenTableView *)jianglijifenTableView {
    if (!_jianglijifenTableView) {
        _jianglijifenTableView = [YBJianglijifenTableView new];
        _jianglijifenTableView.parentViewController = self;
    }
    return _jianglijifenTableView;
}
- (YBBaoMingDuiHuanQuanTableView *)baomingduihuanquanTableView {
    if (!_baomingduihuanquanTableView) {
        _baomingduihuanquanTableView = [YBBaoMingDuiHuanQuanTableView new];
        _baomingduihuanquanTableView.parentViewController = self;
    }
    return _baomingduihuanquanTableView;
}
- (YBJianglijifenTableView *)kequxianjinedu {
    if (!_kequxianjinedu) {
        _kequxianjinedu = [YBJianglijifenTableView new];
        _kequxianjinedu.parentViewController = self;
    }
    return _kequxianjinedu;
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
