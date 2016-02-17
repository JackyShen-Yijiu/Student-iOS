//
//  YBStudyViewController.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/16.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBStudyViewController.h"
#import "YBToolBarView.h"
#import "YBStudyTableView.h"
#import "YBStudeyProgressView.h"
#import "YBStudyTool.h"

@interface YBStudyViewController ()<UIScrollViewDelegate>
{
    UIImageView*navBarHairlineImageView;
    YBStudyProgress studyProgress;
}
@property (nonatomic, strong) YBToolBarView *dvvToolBarView;

@property (nonatomic,strong) YBStudeyProgressView *progressView;

@property (nonatomic, strong) UIView *toolBarBottomLineView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) YBStudyTableView *kemuyiView;
@property (nonatomic, strong) YBStudyTableView *kemuerView;
@property (nonatomic, strong) YBStudyTableView *kemusanView;
@property (nonatomic, strong) YBStudyTableView *kemusiView;

@property (nonatomic, strong) NSMutableArray *kemuyiArray;
@property (nonatomic, strong) NSMutableArray *kemuerArray;
@property (nonatomic, strong) NSMutableArray *kemusanArray;
@property (nonatomic, strong) NSMutableArray *kemusiArray;

@end

@implementation YBStudyViewController

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
- (NSMutableArray *)kemusanArray
{
    if (_kemusanArray==nil) {
        _kemusanArray = [NSMutableArray array];
    }
    return _kemusanArray;
}
- (NSMutableArray *)kemusiArray
{
    if (_kemusiArray==nil) {
        _kemusiArray = [NSMutableArray array];
    }
    return _kemusiArray;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    
    // 更新进度
    [self reloadProgress];
    [self reloadData];

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
    
    // 顶部segment
    [self.view addSubview:self.dvvToolBarView];
    
    // 分割线
    [self.view addSubview:self.toolBarBottomLineView];
    
    // 进度条
    [self.view addSubview:self.progressView];
    
    // 滚动视图
    [self.view addSubview:self.scrollView];
    
    [_scrollView addSubview:self.kemuyiView];
    [_scrollView addSubview:self.kemuerView];
    [_scrollView addSubview:self.kemusanView];
    [_scrollView addSubview:self.kemusiView];

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
        [self.kemusanArray addObject:dict];
    }
    for (NSDictionary *dict in dataArray[3]) {
        [self.kemusiArray addObject:dict];
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
    
    // 更新进度
    [self reloadProgress];
    
    // 更新数据
    [self reloadData];
}

- (void)reloadData
{
    if (studyProgress==0) {
        
        self.kemuyiView.studyProgress = studyProgress;
        self.kemuyiView.dataArray = [self.kemuyiArray mutableCopy];
        [self.kemuyiView reloadData];
        
    }else if (studyProgress == 1){
        
        self.kemuerView.studyProgress = studyProgress;
        self.kemuerView.dataArray = [self.kemuerArray mutableCopy];
        [self.kemuerView reloadData];
        
    }else if (studyProgress == 2){

        self.kemusanView.studyProgress = studyProgress;
        self.kemusanView.dataArray = [self.kemusanArray mutableCopy];
        [self.kemusanView reloadData];
        
    }else if (studyProgress == 3){
       
        self.kemusiView.studyProgress = studyProgress;
        self.kemusiView.dataArray = [self.kemusiArray mutableCopy];
        [self.kemusiView reloadData];
        
    }
}

- (void)reloadProgress
{
    if (studyProgress==0) {
        
        NSString *topStr = [NSString stringWithFormat:@"科一：模拟考试2次   官方学时0"];
        [_progressView setUpProgressDataWithTop:topStr progress:0.2];
        
    }else if (studyProgress == 1){
        
        NSString *topStr = [NSString stringWithFormat:@"科二：模拟考试2次   官方学时0"];
        [_progressView setUpProgressDataWithTop:topStr progress:0.5];
        
    }else if (studyProgress == 2){
        
        NSString *topStr = [NSString stringWithFormat:@"科三：模拟考试2次   官方学时0"];
        [_progressView setUpProgressDataWithTop:topStr progress:0.7];
        
    }else if (studyProgress == 3){
        
        NSString *topStr = [NSString stringWithFormat:@"科四：模拟考试2次   官方学时0"];
        [_progressView setUpProgressDataWithTop:topStr progress:1.0];
        
    }
}


#pragma mark - configUI
- (void)configUI {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat toolBarHeight = 40;
    
    _dvvToolBarView.frame = CGRectMake(0, 0, screenSize.width, toolBarHeight);
    
    _toolBarBottomLineView.frame = CGRectMake(0, CGRectGetMaxY(_dvvToolBarView.frame), screenSize.width, 1);
    
    _progressView.frame = CGRectMake(0, CGRectGetMaxY(self.dvvToolBarView.frame), screenSize.width, 47);
    
    _scrollView.frame = CGRectMake(0, CGRectGetMaxY(_progressView.frame), screenSize.width, screenSize.height - CGRectGetMaxY(_progressView.frame));
    _scrollView.contentSize = CGSizeMake(screenSize.width * 4, 0);
    
    _kemuyiView.frame = CGRectMake(0, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    _kemuerView.frame = CGRectMake(screenSize.width, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    _kemusanView.frame = CGRectMake(screenSize.width * 2, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
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
- (YBStudeyProgressView *)progressView
{
    if (_progressView==nil) {
        _progressView = [[YBStudeyProgressView alloc]  init];
    }
    return _progressView;
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
- (YBStudyTableView *)kemuyiView {
    if (!_kemuyiView) {
        _kemuyiView = [YBStudyTableView new];
        _kemuyiView.parentViewController = self;
    }
    return _kemuyiView;
}
- (YBStudyTableView *)kemuerView {
    if (!_kemuerView) {
        _kemuerView = [YBStudyTableView new];
        _kemuerView.parentViewController = self;
    }
    return _kemuerView;
}
- (YBStudyTableView *)kemusanView {
    if (!_kemusanView) {
        _kemusanView = [YBStudyTableView new];
        _kemusanView.parentViewController = self;

    }
    return _kemusanView;
}
- (YBStudyTableView *)kemusiView {
    if (!_kemusiView) {
        _kemusiView = [YBStudyTableView new];
        _kemusiView.parentViewController = self;
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
