//
//  UIView+LKView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/19.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "UIView+LKView.h"

@implementation UIView (LKView)
+ (void)showBigImageStr:(NSString *)imagestr {
    
    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeBigImg:)];
    [bgView addGestureRecognizer:tapGes];
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0;
    UIImageView *imageView = [UIImageView new];
    imageView.bounds = CGRectMake(0, 0, 0, 0);
    imageView.center = bgView.center;
    [imageView sd_setImageWithURL:[NSURL URLWithString:imagestr] placeholderImage:[UIImage imageNamed:@"pic_load"]];
    [bgView addSubview:imageView];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        bgView.alpha = 1;
        imageView.bounds = CGRectMake(0, 0, kSystemWide, kSystemWide*0.7);
        
    } completion:^(BOOL finished) {
        
    }];
}
+ (void)closeBigImg:(UITapGestureRecognizer *)tagGes {
    
    UIView *view = tagGes.view;
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [tagGes.view removeFromSuperview];
    }];
}
@end
