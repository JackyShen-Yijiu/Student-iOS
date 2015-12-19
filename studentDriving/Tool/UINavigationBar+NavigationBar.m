//
//  UINavigationBar+NavigationBar.m
//  TestNavi
//
//  Created by 大威 on 15/12/19.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "UINavigationBar+NavigationBar.h"
#import "UIColor+Hex.h"

@implementation UINavigationBar (NavigationBar)

+ (void)load {
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    // 返回按钮的图片
//    [bar setBackIndicatorImage:[UIImage imageNamed:@"navigationBar_back"]];
//    [bar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"navigationBar_back"]];
    [bar setBackIndicatorImage:[UIImage imageNamed:@"back"]];
    [bar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back"]];
    
    // 背景色
    [bar setBarTintColor:[UIColor colorWithHexString:@"3E3E64"]];
    // 返回按钮颜色
    [bar setTintColor:[UIColor whiteColor]];
    
    // 标题字体颜色
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont italicSystemFontOfSize:16]}];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} forState:UIControlStateNormal];
}

@end
