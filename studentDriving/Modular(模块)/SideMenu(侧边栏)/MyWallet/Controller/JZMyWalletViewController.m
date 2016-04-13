//
//  JZMyWalletViewController.m
//  studentDriving
//
//  Created by 雷凯 on 16/4/12.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "JZMyWalletViewController.h"
#import "JZMyWalletHeaderView.h"
#define kLKSize [UIScreen mainScreen].bounds.size

@interface JZMyWalletViewController ()
@property (nonatomic, weak)JZMyWalletHeaderView  *jiFenHeaderView;
@end

@implementation JZMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YBMainViewControlerBackgroundColor;
    self.title = @"我的钱包";
    
    JZMyWalletHeaderView *jiFenHeaderView = [[JZMyWalletHeaderView alloc]initWithFrame:CGRectMake(0, 0, kLKSize.width, 238)];
    
    self.jiFenHeaderView = jiFenHeaderView;
    
    [self.view addSubview:jiFenHeaderView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
