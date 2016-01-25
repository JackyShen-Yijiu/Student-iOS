//
//  UINavigationBar+DVVNavigationBar.m
//  DVVSideMenu
//
//  Created by 大威 on 15/12/22.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "UINavigationBar+DVVNavigationBar.h"
#import "UIColor+Extension.h"

@implementation UINavigationBar (DVVNavigationBar)

+ (void)load {
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    // 返回按钮的图片
    //    [bar setBackIndicatorImage:[UIImage imageNamed:@"navigationBar_back"]];
    //    [bar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"navigationBar_back"]];
    [bar setBackIndicatorImage:[UIImage imageNamed:@"navi_back"]];
    [bar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"navi_back"]];
    
    // 背景色 393f4b
    [bar setBarTintColor:[UIColor colorWithHexString:@"393f4b"]];
    [bar setBackgroundColor:[UIColor colorWithHexString:@"393f4b"]];
    // 返回按钮颜色
    [bar setTintColor:[UIColor whiteColor]];
    
    // 标题字体颜色
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} forState:UIControlStateNormal];
}

@end
