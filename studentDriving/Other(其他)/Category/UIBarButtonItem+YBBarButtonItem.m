//
//  UIBarButtonItem+YBBarButtonItem.m
//  studentDriving
//
//  Created by JiangangYang on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "UIBarButtonItem+YBBarButtonItem.h"

@implementation UIBarButtonItem (YBBarButtonItem)
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:14]];
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,size.width,30)];
    [rightButton setTitle:title forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    return rightItem;
}
@end
