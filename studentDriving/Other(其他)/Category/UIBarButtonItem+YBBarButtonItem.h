//
//  UIBarButtonItem+YBBarButtonItem.h
//  studentDriving
//
//  Created by JiangangYang on 16/3/10.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YBBarButtonItem)
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end
