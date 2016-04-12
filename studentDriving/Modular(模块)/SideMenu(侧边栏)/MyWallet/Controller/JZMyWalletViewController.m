//
//  JZMyWalletViewController.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletViewController.h"
#import "JZMyWalletHeaderView.h"
#import "JZMyWalletJiFenView.h"
#import "JZMyWalletXianJinView.h"

#define kLKSize [UIScreen mainScreen].bounds.size

@interface JZMyWalletViewController ()<UIScrollViewDelegate>
///  头部视图
@property (nonatomic, weak)JZMyWalletHeaderView  *jiFenHeaderView;
///  滚动父视图
@property (nonatomic, weak) UIScrollView *contentScrollView;
///  积分的视图
@property (nonatomic, weak) JZMyWalletJiFenView *jiFenView;

///  现金的视图
@property (nonatomic, weak) JZMyWalletXianJinView *xianJinView;

@end

@implementation JZMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    self.title = @"我的钱包";
    
    [self setUI];
    
    
    
}
#pragma mark - 界面控件搭建
-(void)setUI {
    JZMyWalletHeaderView *jiFenHeaderView = [[JZMyWalletHeaderView alloc]initWithFrame:CGRectMake(0, 0, kLKSize.width, 238)];
    
    self.jiFenHeaderView = jiFenHeaderView;
    
    [self.view addSubview:jiFenHeaderView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 238, kLKSize.width, kLKSize.height - 238)];
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.bounces = NO;
    contentScrollView.contentSize = CGSizeMake(kLKSize.width * 3, kLKSize.height - 238);
    contentScrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:contentScrollView];
    
    self.contentScrollView = contentScrollView;
    
    self.contentScrollView.delegate = self;
    
    JZMyWalletJiFenView *jiFenView = [[JZMyWalletJiFenView alloc]initWithFrame:CGRectMake(0, 0, kLKSize.width, kLKSize.height - 238)];
    self.jiFenView = jiFenView;
    [self.contentScrollView addSubview:jiFenView];
    

    JZMyWalletXianJinView *xianJinView = [[JZMyWalletXianJinView alloc]initWithFrame:CGRectMake(kLKSize.width * 2, 0, kLKSize.width, kLKSize.height - 238)];
    
    self.xianJinView = xianJinView;
    
    [self.contentScrollView addSubview:xianJinView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - scrollowVie的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"%f",scrollView.contentOffset.x);
}



@end
