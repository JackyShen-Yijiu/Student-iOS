//
//  BaseContainViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/15.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "BaseContainViewController.h"
#import "UIView+CalculateUIView.h"
#import <SVProgressHUD.h>
#import "SignUpListViewController.h"
#import "LoginViewController.h"
@interface BaseContainViewController ()<UIScrollViewDelegate>
@property (copy, nonatomic) NSArray *items;
@property (strong, nonatomic) UIScrollView *scrollview;
@end

@implementation BaseContainViewController


- (UIScrollView *)scrollview {
    if (_scrollview == nil) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.calculateFrameWithWide, self.view.calculateFrameWithHeight)];
        _scrollview.pagingEnabled = YES;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.delegate = self;
        _scrollview.userInteractionEnabled = YES;
    }
    return _scrollview;
}
- (id)initWIthChildViewControllerItems:(NSArray *)itemsVc {
    if (self = [super init]) {
        _items = itemsVc;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self createScrollview];
   
    [self addChildVc];
    
    
}
- (void)addChildVc {
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = (UIViewController *)obj;
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
    }];
    
    UIViewController *vc = self.childViewControllers.firstObject;
    vc.view.frame = CGRectMake(0, 0, self.scrollview.calculateFrameWithWide, self.scrollview.calculateFrameWithHeight-64);
    [self.scrollview addSubview:vc.view];
}
- (void)createScrollview {
    self.scrollview.contentSize = CGSizeMake(self.view.calculateFrameWithWide*_items.count, self.view.calculateFrameWithHeight);
    [self.view addSubview:self.scrollview];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  //TODO
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x > self.view.calculateFrameWithWide && ![AcountManager isLogin]) {
        DYNSLog(@"scrollview");
        scrollView.contentOffset = CGPointMake(kSystemWide, 0);
        LoginViewController *login = [[LoginViewController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];        return;
    
    }
    if ([[AcountManager manager].userApplystate isEqualToString:@"0"] && scrollView.contentOffset.x > self.view.calculateFrameWithWide) {
        scrollView.contentOffset = CGPointMake(kSystemWide, 0);

        SignUpListViewController *signUpList = [[SignUpListViewController alloc] init];
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [nav pushViewController:signUpList animated:YES];
        return;
    }
    
    NSUInteger index = scrollView.contentOffset.x/self.view.calculateFrameWithWide;

    UIViewController *vc = self.childViewControllers[index];
    
    
    
    if ([_delegate respondsToSelector:@selector(horizontalScrollPageIndex:)]) {
        [_delegate horizontalScrollPageIndex:index];
    }
    if (vc.view.superview) {
        return;
    }else {
//        vc.view.frame = CGRectMake(self.scrollview.calculateFrameWithX+(index*self.view.calculateFrameWithWide), -self.view.calculateFrameWithHeight, self.scrollview.calculateFrameWithWide, self.scrollview.calculateFrameWithHeight-64);
//        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            vc.view.frame = CGRectMake(self.scrollview.calculateFrameWithX+(index*self.view.calculateFrameWithWide), 0, self.scrollview.calculateFrameWithWide, self.scrollview.calculateFrameWithHeight-64);
//        } completion:nil];
    }
    [self.scrollview addSubview:vc.view];
}
- (void)replaceVcWithIndex:(NSUInteger)index {
    if (index >= 2 && ![AcountManager isLogin]) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];        return;
    }
    
    if ([[AcountManager manager].userApplystate isEqualToString:@"0"] && index >= 2) {
        SignUpListViewController *signUpList = [[SignUpListViewController alloc] init];
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [nav pushViewController:signUpList animated:YES];
        return;
    }
    
    [self.scrollview setContentOffset:CGPointMake(index*self.scrollview.calculateFrameWithWide, 0) animated:YES];
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
